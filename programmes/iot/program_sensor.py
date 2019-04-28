# !/usr/bin/python3
# -*- coding: utf-8 -*-

from time import sleep
from gpiozero import LightSensor, Buzzer

ldr = LightSensor(4) # Lit le port 4
while True:
    calcul = 100-ldr.value*100 # convertie la valeur de ldr en une valeur qui va de 100Ãa 0,
			       # 0 etant la valeur ou il n'y a pas de lumiere.
    print(calcul)
    sleep(2)
