USE master;
GO

ALTER DATABASE Souvenir SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

--Create and select database
DROP DATABASE IF EXISTS Souvenir
CREATE DATABASE Souvenir;
GO
USE Souvenir;
GO

DROP TABLE IF EXISTS Souvenir
DROP TABLE IF EXISTS Owner
DROP TABLE IF EXISTS Location 
DROP TABLE IF EXISTS Category

--Create Owner Table
CREATE TABLE Owner (
    Id            INTEGER        PRIMARY KEY IDENTITY(1,1),
    OwnerName     VARCHAR(100)       not null,
    CONSTRAINT unq_owner UNIQUE (OwnerName)
);
GO

--Create Location Table
CREATE TABLE Location (
    Id            INTEGER        PRIMARY KEY IDENTITY(1,1),
    City          VARCHAR(100)   null,
    Region        VARCHAR(100)   null,
    Country       VARCHAR(100)   null,
    Latitude      DECIMAL(8,5)   null,
    Longitude     DECIMAL(8,5)   null,
    CONSTRAINT unq_location UNIQUE (City,Region, Country, Latitude, Longitude)
);
GO

--Create Category Table
CREATE TABLE Category (
    Id               INTEGER           PRIMARY KEY IDENTITY(1,1), 
    CategoryName     VARCHAR(100)      not null,   
    CONSTRAINT unq_category UNIQUE (CategoryName)
);
GO

--Create Souvenir table
CREATE TABLE Souvenir (
   Id                            INTEGER         Primary key identity(1,1),
   SouvenirName                  VARCHAR(200)    not null,
   Price                         DECIMAL(12,2)   not null, 
   [Weight]                      DECIMAL(12,2)   null,
   DateObtained                  DATETIME2       not null,
   SouvenirDescription           VARCHAR(200)    null, 
   OwnerID                       INTEGER         not null, 
   LocationID                    INTEGER         null, 
   CategoryID                    INTEGER         not null, 
   CONSTRAINT unq_souvenir UNIQUE (SouvenirName, SouvenirDescription),
   CONSTRAINT fk_owner FOREIGN KEY (OwnerID) REFERENCES Owner(Id),
   CONSTRAINT fk_location FOREIGN KEY (LocationID) REFERENCES Location(Id),
   CONSTRAINT fk_category FOREIGN KEY (CategoryID) REFERENCES Category(Id)
);
GO



  