USE Souvenir;
GO

-- --Inserting data into Owner table
INSERT INTO Owner (OwnerName)
SELECT DISTINCT Owner
FROM souvenirs_tmp

-- Select *
-- From Owner

--Inserting data into Location table
INSERT INTO Location (City, Region, Country, Latitude, Longitude)
SELECT DISTINCT City, Region, Country, Latitude, Longitude
FROM souvenirs_tmp

--Inserting data into Category table
INSERT INTO Category(CategoryName)
SELECT DISTINCT Category
FROM souvenirs_tmp

--Inserting data into Souvenir table
INSERT INTO Souvenir (SouvenirName, Price, [Weight], DateObtained, SouvenirDescription, OwnerID, LocationID, CategoryID)
SELECT SouvenirName, Price, [Weight], DateObtained, SouvenirDescription, o.id, l.id, c.id
FROM souvenirs_tmp st
JOIN Owner o ON st.[Owner] = o.OwnerName
JOIN Category c ON st.Category = c.CategoryName
LEFT JOIN Location l ON st.City = l.City
    OR st.Longitude = l.Longitude

GO

--Update: Videogames
INSERT INTO Category (CategoryName)
VALUES ('Video Game')

GO

UPDATE Souvenir 
SET CategoryID = 12
WHERE (SouvenirDescription) LIKE '%Video Game%'

--Update: Jewelry Boxes
UPDATE Souvenir
SET CategoryID = 8
WHERE (SouvenirName) LIKE '%Jewelry Box%'

--Update: Shamisen, Egyptian Drum, and Zuffolo
INSERT INTO Category (CategoryName)
VALUES ('Musical Instrument')

GO

UPDATE Souvenir 
SET CategoryID= 13
WHERE (SouvenirName) IN ('Shamisen', 'Egyptian Drum', 'Zuffolo')

--Delete: Souvenir that is the heaviest
DELETE from Souvenir
WHERE Souvenir.id= 97

--Delete: All souvenirs that are dirt or sand
DELETE from Souvenir
WHERE SouvenirName LIKE '%dirt%' or SouvenirName LIKE '%sand%' 

DROP TABLE souvenirs_tmp
DROP TABLE IF EXISTS souvenirs_tmp