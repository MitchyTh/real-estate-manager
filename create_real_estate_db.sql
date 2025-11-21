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

INSERT INTO Firm (id, name, address) VALUES
(101, 'Kanto Realty', 'Pallet Town'),
(102, 'Johto Homes', 'Goldenrod City'),
(103, 'Hoenn Properties', 'Slateport City'),
(104, 'Sinnoh Brokers', 'Jubilife City'),
(105, 'Unova Estates', 'Castelia City');

INSERT INTO Agent (agentId, name, phone, firmId, dateStarted) VALUES
(1, 'Ash Ketchum', '555-PIKA-001', 101, '2021-03-01'),
(2, 'Misty Waterflower', '555-STARM-002', 102, '2020-06-15'),
(3, 'Brock Harrison', '555-ONIX-003', 101, '2019-01-20'),
(4, 'May Maple', '555-TORC-004', 103, '2022-09-05'),
(5, 'Dawn Berlitz', '555-PIPL-005', 104, '2018-11-12'),
(6, 'Iris Drayden', '555-AXEW-006', 105, '2017-04-30');

INSERT INTO Property (address, ownerName, price) VALUES
('Viridian Forest Cabin', 'Professor Oak', 180000),
('Cerulean City Cottage', 'Nurse Joy', 240000),
('Pewter Gym Loft', 'Brock', 320000),
('Lavender Tower Flat', 'Mr. Fuji', 110000),
('Celadon Apartment', 'Erika', 225000),
('Saffron Office Plaza', 'Silph Co.', 450000),
('Goldenrod Storefront', 'Whitney', 375000),
('Slateport Office Park', 'Captain Stern', 520000),
('Castelia Gas Station', 'Team Plasma', 290000),
('Jubilife Business Center', 'Rowan', 150000);

INSERT INTO House (bedrooms, bathrooms, size, address) VALUES
(3, 2, 1600, 'Viridian Forest Cabin'),
(3, 2, 1800, 'Cerulean City Cottage'),
(4, 3, 2200, 'Pewter Gym Loft'),
(2, 1, 900,  'Lavender Tower Flat'),
(3, 2, 1500, 'Celadon Apartment');

INSERT INTO BusinessProperty (type, size, address) VALUES
('office space', 3000, 'Saffron Office Plaza'),
('store front', 1800, 'Goldenrod Storefront'),
('office space', 4200, 'Slateport Office Park'),
('gas station', 2500, 'Castelia Gas Station'),
('office space', 1200, 'Jubilife Business Center');

INSERT INTO Listings (mlsNumber, address, agentId, dateListed) VALUES
(5001, 'Viridian Forest Cabin', 1, '2024-10-01'),
(5002, 'Cerulean City Cottage', 2, '2024-09-15'),
(5003, 'Pewter Gym Loft', 3, '2024-11-02'),
(5004, 'Lavender Tower Flat', 4, '2024-08-21'),
(5005, 'Saffron Office Plaza', 5, '2024-10-10'),
(5006, 'Goldenrod Storefront', 2, '2024-07-30'),
(5007, 'Slateport Office Park', 6, '2024-11-05'),
(5008, 'Castelia Gas Station', 4, '2024-06-12');

INSERT INTO Buyer (id, name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice) VALUES
(201, 'Red', '555-CHAR-201', 'house', 3, 2, NULL, 100000, 250000),
(202, 'Blue', '555-BLAS-202', 'house', 4, 3, NULL, 300000, 400000),
(203, 'Green', '555-VENU-203', 'business', NULL, NULL, 'office space', 200000, 600000),
(204, 'Silver', '555-SNEA-204', 'business', NULL, NULL, 'store front', 100000, 400000),
(205, 'Gold', '555-TYPL-205', 'house', 2, 1, NULL, 80000, 180000),
(206, 'Crystal', '555-SUIC-206', 'business', NULL, NULL, 'office space', 100000, 300000);

INSERT INTO Works_With (buyerId, agentId) VALUES
(201, 1),
(202, 3),
(203, 6),
(204, 2),
(205, 4),
(206, 5),
(203, 5), 
(201, 3);
