DROP DATABASE connectedFlower;
CREATE DATABASE connectedFlower;

USE connectedFlower;

CREATE TABLE Category (
    id INT NOT NULL AUTO_INCREMENT,
    categoryFlower varchar(50),
    PRIMARY KEY (id)
);

CREATE TABLE FlowerSpecies (
    id INT NOT NULL AUTO_INCREMENT ,
    name VARCHAR(50),
    description TEXT,
    humidity INT,
    temperature INT,
    luminosity INT,
    blossomingPeriodStart VARCHAR(10),
    blossomingPeriodEnd VARCHAR(10),
    idCategory INT,
    PRIMARY KEY (id),
    FOREIGN KEY (idCategory) REFERENCES Category(id)
);

CREATE TABLE ConnectedFlower (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    idFlowerSpecies INT,
    FOREIGN KEY (idFlowerSpecies) REFERENCES FlowerSpecies(id),
    PRIMARY KEY (id)
);

CREATE TABLE FlowerSummary (
    id INT NOT NULL AUTO_INCREMENT,
    atmosphericTemperature INT,
    luminosity INT,
    humidity INT,
    dateHour VARCHAR(20),
    idConnectedFlower INT,
    FOREIGN KEY (idConnectedFlower) REFERENCES ConnectedFlower(id),
    PRIMARY KEY (id)
);
