-- 1. Get the 3 most inexpensive souvenirs. Then get the 7 most expensive souvenirs. 
SELECT Top 3 SouvenirName, Price
FROM Souvenir
ORDER BY Price ASC

SELECT TOP 7 SouvenirName, Price
FROM Souvenir 
ORDER BY Price DESC

-- 2. List all mugs, ordered from heaviest to lightest. 
SELECT SouvenirName, Weight
FROM Souvenir
WHERE SouvenirName LIKE '%mug%'
ORDER BY Weight DESC

-- 3. Count the number of spoons in the collection.
SELECT COUNT(*) AS NumberofSpoons
FROM Souvenir
WHERE SouvenirName LIKE '%spoon%'

-- 4. Find the average weight, minimum weight, and maximum weight for each cateogry by name. USE meaningful alias names for the aggregates. 
SELECT DISTINCT CategoryName,
MIN([Weight]) AS MinWeight,
MAX([Weight]) AS MaxWeight,
AVG([Weight]) AS AvgWeight
FROM Souvenir
JOIN Category ON Souvenir.CategoryID = Category.id
GROUP BY CategoryName

-- 5. List all kitchenware souvenirs and their general location fields- including city name, region name, country name, longitude, and latitude - without duplication
SELECT DISTINCT City, Region, Country, Longitude, Latitude
FROM Souvenir
JOIN Category ON Souvenir.CategoryID = Category.id
JOIN Location ON Souvenir.LocationID = Location.id
WHERE CategoryName LIKE '%Kitchenware%'

-- 6. Find the earliest and latest obtained date for each owner, ordered by the earliest of the earliest dates to the latest of the earliest dates. 
SELECT Ownerid, OwnerName, 
 MIN(DateObtained) AS EarliestDate, 
 MAX(DateObtained) AS LatestDate
 FROM Souvenir
 JOIN Owner ON Souvenir.OwnerID = Owner.id
 GROUP BY OwnerName, Ownerid


-- 7. What is the most popular data for the souvenirs? Store this date in a variable. Find all souvenirs obtained on that date. 
DECLARE @MostPopularDate DATETIME2

SELECT TOP 1 @MostPopularDate = DateObtained
FROM Souvenir
GROUP BY DateObtained
ORDER BY COUNT(*) DESC

SELECT SouvenirName, DateObtained
FROM Souvenir
WHERE DateObtained = @MostPopularDate

-- 8. Find all souvenirs that do not have a latitude and longitude. 
SELECT SouvenirName, Latitude, Longitude
FROM Souvenir
JOIN Location ON Souvenir.LocationID = Location.id
WHERE Latitude IS NULL
 OR Longitude IS NULL

-- 9. Find all souvenirs that do not have city, region, and country. 
SELECT SouvenirName, City, Region, Country
FROM Souvenir
JOIN Location ON Souvenir.LocationID = Location.id
WHERE City  IS NULL 
AND Region  IS NULL 
AND Country IS NULL

-- 10. Find all souvenirs - name, city name, region name, country name, latitude, longitude, and weight
-- heavier than the average weight for all souvenirs. Use a subquery in a WHERE clause to achieve this. 
SELECT SouvenirName, City, Region, Country, Latitude, Longitude, Weight 
FROM Souvenir
JOIN Location ON Souvenir.LocationID = Location.id
WHERE Weight > (SELECT AVG(Weight) FROM Souvenir)
ORDER BY SouvenirName

-- 11. Find the most expensive and least expensive souvenir in each category. 
SELECT DISTINCT CategoryName,
MIN(Price) AS LeastExpensive,
MAX(Price) AS MostExpensive
FROM Souvenir
JOIN Category ON Souvenir.CategoryID = Category.id
GROUP BY CategoryName