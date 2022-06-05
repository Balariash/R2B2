#!/usr/bin/python3
import paho.mqtt.client as mqtt
from time import sleep
import subprocess
import json
from gpiozero import PWMOutputDevice as POD
from gpiozero.pins.pigpio import PiGPIOFactory
import gpiozero
from motor import Motor
from orders import Actions
from config import host, port

#########################################################################

class NewProcess():
    """
    Aquesta classe s'utilitza per executar i aturar el mode de
    seguiment d'objectes per color.
    """
    def __init__(self, cmd, Proc: subprocess.Popen = None):
        self.cmd = cmd
        self.newProc = Proc

    def start(self):
        self.newProc = subprocess.Popen(self.cmd)

    def kill(self):
        self.newProc.kill()
        
########################################################################

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        client.connected_flag=True
        print("connected OK Returned code=",rc)
        #print(robot.show_values())
        #sleep(2)
    else:
        print("Bad connection Returned code=",rc)
        client.bad_connection_flag=True


def on_message(client, userdata, message):
    """
    Aquesta funcio analitza els topics i el contigut dels
    missatges rebuts i determina quines accions s'ha de 
    executar.
    """
    print("message received ", str(message.payload.decode("utf-8")))
    topic_ = str(message.topic)  
    if topic_ == "Motors":
        msg = json.loads(message.payload.decode())
        if msg[0] == "up":
            client.publish(topic, "UP")
            robot.up()
            
        elif msg[0] == "dwn":
            client.publish(topic, "DOWN")
            robot.down()
            
        elif msg[0] == "fwd":
            spd_l = float(msg[1])
            spd_r = float(msg[2])
            client.publish(topic, "Move forward")
            robot.forward(spd_l,spd_r)
            
        elif msg[0] == "bkd":
            spd_l = float(msg[1])
            spd_r = float(msg[2])
            client.publish(topic, "Move backward")
            robot.backward(spd_l, spd_r)
            
        elif msg[0] == "left":
            spd = float(msg[1])
            client.publish(topic, "Turn left")
            robot.turn_left(spd)
            
        elif msg[0] == "right":
            spd = float(msg[1])
            client.publish(topic, "Turn right")
            robot.turn_right(spd)
            
        elif msg[0] == "off":
            client.publish(topic, "OFF")
            robot._off()
            
        else:
            client.publish(topic, "STOP")
            robot.stop_all()

    elif topic_ == "Camera":
        try:
            subprocess.run(["python3", "take_photos.py"])
            client.publish(topic, "Fotografia feta")
        except:
            client.publish(topic, "Error")
            print("Error")
        
    elif topic_ == "Stream":
        msg = str(message.payload.decode("utf-8"))
        print("starting")
        if msg == "play":
            subprocess.Popen(["python3", "streaming.py"])
            client.publish(topic, "Start stream")
            
        elif msg == "pause":
            subprocess.run(["sudo", "killall", "mjpg_streamer"])
            client.publish(topic, "Stream finished")
        
    elif topic_ == "Follow":
        msg = str(message.payload.decode("utf-8"))
        if msg == "start":
            tracking.start()
            client.publish(topic, "Start tracking")
        elif msg == "stop":
            tracking.kill()
            client.publish(topic, "Stop trancking")

    elif topic_ == "Info":
        print(robot.value)
       

def connect_mqtt():
    client = mqtt.Client(client_id)
    client.username_pw_set(username, password)
    client.on_connect = on_connect
    client.connect(host, port)
    return client


def subscribe(client: mqtt):
    client.subscribe(topics)
    client.on_message = on_message


#######################################################################
mqtt.Client.connected_flag=False

client_id = "Nemo"
username = "Node"
password = "password"

topic = "Server"
topic2 = "Motors"
topic3 = "Camera"
topic4 = "Follow"
topic5 = "Stream"

topics = [(topic2,0), (topic3, 0), (topic4, 0), (topic5,0)]

cmd = ["python3", "tracking.py"]
tracking = NewProcess(cmd)

robot = Actions(18, 17, 23, 22)

###################################################################

client = connect_mqtt()
subscribe(client)
client.loop_forever()
