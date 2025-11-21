CREATE DATABASE IF NOT EXISTS RealEstateDB;
USE RealEstateDB;

--DROP STATEMENTS
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS House;
DROP TABLE IF EXISTS BusinessProperty;
DROP TABLE IF EXISTS Firm;
DROP TABLE IF EXISTS Agent;
DROP TABLE IF EXISTS Listing;
DROP TABLE IF EXISTS Buyer;
DROP TABLE IF EXISTS Works_With;

--CREATION
CREATE TABLE Property(
    address VARCHAR(50) NOT NULL,
    ownerName VARCHAR(30) NOT NULL,
    price INTEGER NOT NULL,
    PRIMARY KEY(address)
);

CREATE TABLE House(
    bedrooms INTEGER NOT NULL,
    bathrooms INTEGER NOT NULL,
    size INTEGER NOT NULL,
    address VARCHAR(50) NOT NULL,
    PRIMARY KEY (address),
    FOREIGN KEY (address) REFERENCES Property(address)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE BusinessProperty (
    type CHAR(20) NOT NULL,
    size INTEGER NOT NULL,
    address VARCHAR(50) NOT NULL,
    PRIMARY KEY (address),
    FOREIGN KEY (address) REFERENCES Property(address)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Firm (
    id INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    address VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Agent (
    agentId INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    phone CHAR(12) NOT NULL,
    firmId INTEGER NOT NULL,
    dateStarted DATE NOT NULL,
    PRIMARY KEY (agentId),
    FOREIGN KEY (firmId) REFERENCES Firm(id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Listing (
    mlsNumber INTEGER NOT NULL,
    address VARCHAR(50) NOT NULL,
    agentId INTEGER NOT NULL,
    dateListed DATE NOT NULL,
    PRIMARY KEY (mlsNumber),
    UNIQUE KEY uq_listings_address (address),
    FOREIGN KEY (address) REFERENCES Property(address)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (agentId) REFERENCES Agent(agentId)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Buyer (
    id INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    phone CHAR(12) NOT NULL,
    propertyType CHAR(20) NOT NULL, 
    bedrooms INTEGER NULL,          
    bathrooms INTEGER NULL,        
    businessPropertyType CHAR(20) NULL, 
    minimumPreferredPrice INTEGER NOT NULL,
    maximumPreferredPrice INTEGER NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT chk_price_range CHECK (minimumPreferredPrice <= maximumPreferredPrice)
);

CREATE TABLE Works_With (
    buyerId INTEGER NOT NULL,
    agentId INTEGER NOT NULL,
    PRIMARY KEY (buyerId, agentId),
    FOREIGN KEY (buyerId) REFERENCES Buyer(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (agentId) REFERENCES Agent(agentId)
    ON UPDATE CASCADE ON DELETE CASCADE
); 