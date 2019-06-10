# !/usr/bin/env python3
# -*- coding: utf-8 -*-

# ============== Les Import ====================
from time import sleep

# Pour le capteur de luminosite
from gpiozero import LightSensor

# Pour le capteur de temperature
import smbus

# Pour le capteur d'humidte
import RPi.GPIO as GPIO

# Pour la base de donnée
import mysql.connector as mariadb
import datetime

# ============= Les Fonctions ==================

tempsCapture = 4

# ~~~~~~~~~Lumiere~~~~~~~~~
def cap_lumiere(port_number):
    ldr = LightSensor(port_number) # lit sur le port indique en parametre  de la fonction.

    calcul = ldr.value * 100 # convertie la valeur de ldr en une valeur qui va de 100Ãa 0,
			                   # 0 etant la valeur ou il n'y a pas de lumiere.
    return round(calcul)

# ~~~~~~~~~temperature~~~~~~~~
def cap_temperature():
    bus_alim = 1 # Donne le bus d'alimentation
    bus = smbus.SMBus(bus_alim)

    address_icc = 0x48 # address_icc est l'adresse I2C du capteur tmp102
    tmp = bus.read_word_data(address_icc, 0x00) # L'adresse est sur 16 bits mais on en veut que 12

    msb = (tmp & 0x00ff) # Le bit de poids fort
    lsb = (tmp & 0xff00) >> 8 # Le bit de poids faible qu'on decale de 8 vers la droite

    if msb > 128:
        tmp = ~((msb * 256 + lsb) - 1)
        msb = (tmp & 0xff00) >> 8 # on decale le msb de 8 vers la droite
        lsb = (tmp & 0x00ff)
        temperature = 0 - (((msb * 256) + lsb) >> 4) * 0.0625
    else:
        temperature = (((msb * 256) + lsb) >> 4)  * 0.0625
    return round(temperature)

# ~~~~~~~~~Humidite~~~~~~~~~
GPIO.setmode(GPIO.BCM)
GPIO.setup(20, GPIO.IN)
def cap_humidite():
    return GPIO.input(20)

# ~~~~~~~~~Base de donnee~~~~~~~~~
print("Écrivez le nom de votre plante connectée: ")
nameConnectedFlower = input()

def insertSQL():
    la_date = datetime.datetime.today().strftime('%d-%m-%Y %H:%M:%S')
    mariadb_connection = mariadb.connect(user='qlp', password='qlp', database='connectedFlower')
    cursor = mariadb_connection.cursor()
    cursor.execute("SELECT * FROM ConnectedFlower WHERE lower(name) = lower('{}')".format(nameConnectedFlower))
    for (id, d, f) in cursor:
        idConnectedFlower = id
    cursor.execute("INSERT INTO FlowerSummary (atmosphericTemperature, luminosity, humidity, dateHour, idConnectedFlower ) VALUES ({}, {}, {}, '{}', {})".format(cap_temperature(), cap_lumiere(4), cap_humidite(), la_date, idConnectedFlower))
    mariadb_connection.commit()
# ~~~~~~~~~fonction Main~~~~~~~~~
def main():
    print("Je relève les valeurs !")
    while True:
        insertSQL()
        sleep(tempsCapture)

if __name__ == "__main__":
    main()
