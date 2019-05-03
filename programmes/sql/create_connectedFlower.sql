IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'CONNECTEDFLOWER')
DROP DATABASE [CONNECTEDFLOWER]
GO
CREATE DATABASE [CONNECTEDFLOWER]
GO
use [CONNECTEDFLOWER]
GO

CREATE TABLE catégorie (
    id_Catégorie INT IDENTITY(1,1) NOT NULL,
    catégorie varchar(50),
    PRIMARY KEY (id_Catégorie)
);
GO


CREATE TABLE espèceDePlante (
    id_espèceDePlante INT IDENTITY(1,1) NOT NULL,
    nom VARCHAR(50),
    description TEXT,
    humidité INT,
    temperature INT,
    luminosité INT,
    périodeFloraisonDébut VARCHAR(10),
    périodeFloraisonFin VARCHAR(10),
    id_Catégorie INT CONSTRAINT id_Categorie_FK REFERENCES catégorie,
    PRIMARY KEY (id_espèceDePlante)
);
GO

CREATE TABLE photos (
    id_Photos INT IDENTITY(1,1) NOT NULL,
    photo VARCHAR(50),
    id_espèceDePlante INT CONSTRAINT id_espèceDePlante_FK REFERENCES espèceDePlante,
    PRIMARY KEY (id_Photos)
);
GO

CREATE TABLE utilisateur (
    id_utilisateur INT IDENTITY(1,1) NOT NULL,
    nom_utilisateur VARCHAR(50), 
    PRIMARY KEY (id_utilisateur)
);
GO

CREATE TABLE planteConnectée (
    id_planteConnectée INT IDENTITY(1,1) NOT NULL,
    nom VARCHAR(50),
    id_espèceDePlante INT CONSTRAINT id_espèceDePlante_FK2 REFERENCES espèceDePlante,
    id_utilisateur INT CONSTRAINT id_utilisateur_FK REFERENCES Utilisateur,
    PRIMARY KEY (id_planteConnectée)
);
GO

CREATE TABLE relevé_plante (
    id_relevéPlante INT IDENTITY(1,1) NOT NULL,
    températureAtmoshérique_relevé INT,
    luminosité_relevé INT,
    humidité_relevé INT,
    dateHeure DATE,
    id_Plante INT CONSTRAINT id_Plante_FK REFERENCES EspèceDePlante,
    PRIMARY KEY (id_relevéPlante)
);
GO