CREATE DATABASE IF NOT EXISTS connectedFlower;
DROP DATABASE connectedFlower;
CREATE DATABASE connectedFlower;

USE connectedFlower;

CREATE TABLE categorie (
    id_categorie INT NOT NULL AUTO_INCREMENT,
    categoriePlante varchar(50),
    PRIMARY KEY (id_categorie)
);

CREATE TABLE especeDePlante (
    id_especeDePlante INT NOT NULL AUTO_INCREMENT ,
    nom VARCHAR(50),
    description TEXT,
    humidite INT,
    temperature INT,
    luminosite INT,
    periodeFloraisonDebut VARCHAR(10),
    periodeFloraisonFin VARCHAR(10),
    id_categorie INT,
    PRIMARY KEY (id_especeDePlante),
    FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie)
);

CREATE TABLE photos (
    id_Photos INT NOT NULL AUTO_INCREMENT NOT NULL,
    photo VARCHAR(50),
    id_especeDePlante INT,
    PRIMARY KEY (id_Photos),
    FOREIGN KEY (id_especeDePlante) REFERENCES especeDePlante(id_especeDePlante)
    
);

CREATE TABLE connectedFlower (
    id_connectedFlower INT AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50),
    id_especeDePlante INT,
    FOREIGN KEY (id_especeDePlante) REFERENCES especeDePlante(id_especeDePlante),
    PRIMARY KEY (id_connectedFlower)
);

CREATE TABLE relevePlante (
    id_relevePlante INT AUTO_INCREMENT NOT NULL,
    temperatureAtmosherique_releve INT,
    luminositeReleve INT,
    humiditeReleve INT,
    dateHeure DATE,
    id_especeDePlante INT,
    FOREIGN KEY (id_especeDePlante) REFERENCES especeDePlante(id_especeDePlante),
    PRIMARY KEY (id_relevePlante)
);