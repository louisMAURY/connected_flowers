# !/usr/bin/env python3
# -*- coding: utf-8 -*-

# ============== Les Import ====================
from time import sleep

# Pour le capteur de luminosite
from gpiozero import LightSensor

# Pour le capteur de temperature
import smbus

# ============= Les Fonctions ==================
def cap_lumiere(port_number):
    ldr=LightSensor(port_number) # lit sur le port indique en parametre  de la fonction.

    calcul = 100-ldr.value*100 # convertie la valeur de ldr en une valeur qui va de 100 a 0,
                               # 0 etant la valeur ou il n'y a pas de lumiere.
    print("Le taux de luminosite est de : " + str(calcul))
    sleep(0.5)

def cap_temperature():
    bus_alim = 1 # Donne le bus d'alimentation
    bus = smbus.SMBus(bus_alim)

    address_icc = 0x48 # address_icc est l'adresse I2C du capteur tmp102
    tmp = bus.read_word_data(address_icc, 0x00) # L'adresse est sur 16 bits mais on en veut que 12

    msb = (tmp & 0x00ff) # Le bit de poids fort
    lsb = (tmp & 0xff00) >> 8 # Le bit de poids faible qu'on decale de 8 vers la droite

    if msb > 128:
        tmp = ~((high * 256 + lsb) - 1)
        msb = (tmp & 0xff00) >> 8 # on decale le msb de 8 vers la droite
        lsb = (tmp & 0x00ff)
        temperature = 0 - (((msb * 256) + lsb) >> 4) * 0.0625
    else:
        temperature = (((msb * 256) + lsb) >> 4)  * 0.0625
    sleep(0.5)
    print("La temperature est de : {} C".format(temperature))

def main():
    while True:
        cap_lumiere(8)
        cap_temperature()

if __name__ == "__main__":
    main()
