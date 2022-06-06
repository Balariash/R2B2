from gpiozero import PWMOutputDevice as POD
from gpiozero.pins.pigpio import PiGPIOFactory
import gpiozero
from time import sleep
from motor import Motor


class Actions(Motor):
    """
    orders
    Jordi Muñoz 2021-10-31

    Aquesta clase defineix el moviment del robot.

    Els pins s'han de introduir en el següent ordre:
      1. Motor vertical esquerra
      2. Motor vertical dreta
      3. Motor horitzontal esquerra
      4. Motor horitzontal dreta

    """
    def __init__(self, *pins):
        self.motorVE = Motor(pins[0])
        self.motorVD = Motor(pins[1])
        self.motorHE = Motor(pins[2])
        self.motorHD = Motor(pins[3])
    
    def up(self, spd_l=0, spd_r=0):
        self.motorVE.horari(spd_l)
        self.motorVD.antihorari(spd_r)

    def down(self, spd_l=0, spd_r=0):
        self.motorVE.antihorari(spd_l)
        self.motorVD.horari(spd_r)
                      
    def forward(self, spd_l, spd_r):
        self.motorHE.horari(spd_l)
        self.motorHD.antihorari(spd_r)

    def backward(self, spd_l, spd_r):
        self.motorHE.antihorari(spd_l)
        self.motorHD.horari(spd_r)

    def turn_right(self, spd):
        self.motorHE.horari(spd)
        self.motorHD.horari(spd)

    def turn_left(self, spd):
        self.motorHE.antihorari(spd)
        self.motorHD.antihorari(spd)
    
    def stop_all(self):
        """
        Atura tots els motors.
        """
        self.motorVE.stop()
        self.motorVD.stop()
        self.motorHE.stop()
        self.motorHD.stop()


    def _off(self):
        """
        Apaga tots els motors.
        """
        self.motorVE.off()
        self.motorVD.off()
        self.motorHE.off()
        self.motorHD.off()
        


