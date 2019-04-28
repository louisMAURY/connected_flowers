# !/usr/bin/python3
# -*- coding: utf-8 -*-

# ==============Les Import ====================
from time import sleep

# Pour le capteur de luminosite
from gpiozero import LightSensor, Buzzer

# Pour le capteur de temperature
import smbus

# =============Les Fonctions ==================
def cap_lumiere(port_number):
    ldr=LightSensor(port_number) # lit sur le port indique en parametre  de la fonction.
    while True:
        calcul = 100-ldr.value*100 # convertie la valeur de ldr en une valeur qui va de 100Ãa 0,
			       # 0 etant la valeur ou il n'y a pas de lumiere.
        print("Le taux de luminosite est de : " + str(calcul))
        sleep(1)


bus = smbus.SMBus(1)
# I2C address for TMP102
adr = 0x48
tmp = bus.read_word_data(adr,0x00)

high = (tmp & 0x00ff)
low = (tmp & 0xff00) >> 8

if high > 128:
    tmp = ~((high * 256 + low) - 1)
    high = (tmp & 0xff00) >> 8
    low = (tmp & 0x00ff)
    temperature = 0 - (((high * 256) + low) >> 4) * 0.0625
else:
    temperature = (((high * 256) + low) >> 4)  * 0.0625
print(temperature)
