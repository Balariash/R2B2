import cv2
import numpy as np
import math, random
import paho.mqtt.client as mqtt
from scipy import ndimage
from time import sleep
import json
from config import host, port

##################################################################

class Label():
    """
    Aquesta classe s'encarrega d'analizar la imatge binaria obtinguda
    de l'implementació de la funció cv2.connectedComponents i a partir
    d'ella determina quin es el grup de pixels més gran i de major interes
    i calcula en quin sector de la imatge es troba el seu centre
    """
    def __init__(self, labels, num_labels):
        self.labels = labels
        self.num_labels = num_labels
        self._group_size_cache = None

    def groups_size(self):
        """
        Analitza els diferents grups dins de labels per determinar
        quin es el grups de pixels més gran.
        
        Retorna el nombre del grup més gran i la quantitat de 
        pixels que inclou.

        """
        if self._group_size_cache is not None:
            return self._group_size_cache
        #
        unique, counts = np.unique(self.labels, return_counts=True)
        groups = np.asarray((unique, counts)).T
        #
        self._group_size_cache = max(groups, key=(lambda g: g[1] if g[0] else -1))
        return self._group_size_cache

    def find_center(self):
        """
        A partir del grup de pixels més gran, troba
        el centre de masses d'aquest.

        Retorna les coordenades enteres del centre.
        """
        group_num, pixels = self.groups_size()
        cy, cx = ndimage.measurements.center_of_mass(self.labels == group_num)
        return (round(cx), round(cy))

    def object_position(self):
        # Divideix la imatge en tres files i tres columnes definir en quina secció esta l'objecte
        # 00 01 02
        # 10 11 12
        # 20 21 22
        """
        Divideix la imatge en tres files i tres columnes per definir
        en quina secció esta l'objecte. (En format fila columna)
        00 01 02
        10 11 12
        20 21 22

        Retorna el número de fila, el número de columna i el percentatge de pixels
        de la imatge que conformen el grup.
        """
        x, y = self.find_center()
        height, width = self.labels.shape[0], self.labels.shape[1]
        return self.section(y, height), self.section(x, width), self.object_size()

    def section(self, y, height):
        """
        Donat la coordenada y del centre de l'objecte i l'alçada de 
        la imatge, divideix la imatge en tres files iguals i retorna 
        el número de la fila en la que es troba el centre.

        En cas de introduir la coordenada x del centre i l'amplada de
        la imatge, divideix la imatge en tres columnes iguals i retorna
        el número de la columna en la que es troba el centre.
        """
        if y < height/3:
            return 0
        elif y > 2*height/3:
            return 2
        else:
            return 1

    def object_size(self):
        """
        Determina el percentatge de pixels
        de la imatge que pertanyen al grup.

        Retorna el percentatge.
        """
        
        img_size = self.labels.size
        obj_size = self.groups_size()[1]
        return (obj_size/img_size)*100

################################################################
def on_connect(client, userdata, flags, rc):
    if rc == 0:
        client.connected_flag=True
        print("connected OK Returned code=",rc)
    else:
        print("Bad connection Returned code=",rc)
        client.bad_connection_flag=True

def connect_mqtt():
    client = mqtt.Client(client_id)
    client.username_pw_set(username, password)
    client.on_connect = on_connect
    client.connect(host, port)
    return client  
################################################################

#host = '169.254.10.124'
#port = 1883
client_id = "stalker"
username = "Stalker"
password = "password"
topic = "Motors"


msg_cache = None
#################################################################
client = connect_mqtt()
client.loop_start()

'''
HSV ranges:
Hue is 0 to 179
Saturarion is 0 to 255
Value is 0 to 255

Blau:     90 - 130
Vermell:  145 - 180, 0 - 10
Verd:     40 - 89
'''
lower_color = np.array([0,100,100])
upper_color = np.array([10,255,255])

lower_color2 = np.array([170, 100, 100])
upper_color2 = np.array([189, 255, 255])

while True:
    try:
        cap = cv2.VideoCapture("http://localhost:8090/?action=stream")
        _, img = cap.read()
        #img = cv2.resize(img, None, fx=0.5, fy=0.5, interpolation=cv2.INTER_AREA)
        
    except:
        cap = cv2.VideoCapture(0)
        _, img = cap.read()
        #img = cv2.resize(img, None, fx=0.5, fy=0.5, interpolation=cv2.INTER_AREA)


    img = cv2.rotate(img, cv2.ROTATE_180)
    hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    
    mask1 = cv2.inRange(hsv, lower_color, upper_color)
    mask2 = cv2.inRange(hsv, lower_color2, upper_color2)
    mask = mask1 + mask2
    
    num_labels, labels = cv2.connectedComponents(mask, connectivity=4)   
    l = Label(labels, num_labels)
    
    py, px, size = l.object_position()
    print(size)
    if px == 1 and py == 1 and size >= 6:
        msg = "stop"
        if msg != msg_cache:
            client.publish(topic, json.dumps([msg]))
            print("stop")

    elif px == 0:
        msg = "fwd"
        if msg != msg_cache:
            client.publish(topic, json.dumps([msg, 0.2, 0.4]))
            print("fwd-l")
        
    elif px == 1:
        if py == 0:
            msg = "up"
            if msg != msg_cache:
                client.publish(topic, json.dumps([msg]))
                print("up")
            
        elif py == 1:
            msg = "fwd"
            if msg != msg_cache:
                client.publish(topic, json.dumps([msg, 0.2, 0.2]))
                print("fwd")
            
        elif py == 2:
            msg = "dwn"
            if msg != msg_cache:
                client.publish(topic, json.dumps([msg]))
                print("dwn")
            
    elif px == 2:
        msg = "fwd"
        if msg != msg_cache:
            client.publish(topic, json.dumps([msg, 0.4, 0.2]))
            print("fwd-r")
    
    else:
        #msg = "stop"
        print("No troba res")

    msg_cache = msg
    sleep(2)
 


print("Aturat")
