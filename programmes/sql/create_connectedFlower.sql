CREATE DATABASE IF NOT EXISTS connectedFlower;
DROP DATABASE connectedFlower;
CREATE DATABASE connectedFlower;

USE connectedFlower;

CREATE TABLE Category (
    id INT NOT NULL AUTO_INCREMENT,
    categoryFlower varchar(50),
    PRIMARY KEY (id)
);

CREATE TABLE Flowerspecies (
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
    FOREIGN KEY (idCategory) REFERENCES category(id)
);

CREATE TABLE Pictures (
    id INT NOT NULL AUTO_INCREMENT NOT NULL,
    picture VARCHAR(50),
    idFlowerSpecies INT,
    PRIMARY KEY (id),
    FOREIGN KEY (idFlowerSpecies) REFERENCES flowerSpecies(id)
    
);

CREATE TABLE ConnectedFlower (
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(50),
    idflowerSpecies INT,
    FOREIGN KEY (idFlowerSpecies) REFERENCES flowerSpecies(id),
    PRIMARY KEY (id)
);

CREATE TABLE FlowerStatement (
    id INT AUTO_INCREMENT NOT NULL,
    atmosphericTemperature INT,
    luminosity INT,
    humidity INT,
    dateHour DATE,
    idConnectedFlower INT,
    FOREIGN KEY (idCOnnectedFlower) REFERENCES connectedFlower(id),
    PRIMARY KEY (id)
);
