-- 1. Display the Name, Continent, and Population of all countries located in Asia.
USE world;
SELECT Name, Continent, Population
FROM country
WHERE continent = 'Asia';

-- 2. Display the Name, Population, and LifeExpectancy of all countries.
--    Sort the results by Population in descending order.

SELECT Name, LifeExpectancy, Population
FROM country
ORDER BY Population DESC;

-- 3. Display the Name, Continent, and Population of countries that:
--    belong to Europe, AND have a population greater than 20,000,000.
--    Sort the results alphabetically by country name.

SELECT  Name, continent, population
FROM country
WHERE   continent = 'Europe'
        AND Population > 20000000
ORDER BY Name ASC;

-- 4. Display the Name, Region, and SurfaceArea of countries that are located in either:
--    North America, OR South America. Sort the results by region.

SELECT Name, Region, SurfaceArea
FROM Country
WHERE Continent IN ('North America', 'South America')
ORDER BY Region ASC;

-- 5. Display the Name, Continent, and Population of all countries that are NOT located in Africa.
--    Sort the results by country name.

SELECT Name, Continent, Population
FROM Country
WHERE Continent != 'Africa'
ORDER BY Name ASC;

-- 6. Display the Name, Population, and GovernmentForm of countries whose population is between 10,000,000 and 50,000,000.
--    Sort the results by population.

SELECT  Name, Population, GovernmentForm
FROM Country
WHERE Population BETWEEN 10000000 AND 50000000
ORDER BY Population DESC;


-- 7. Display the Name, Capital, and Population of countries whose continent is one of the following: Asia, Europe, Oceania

SELECT Name, Capital, Population
FROM country
WHERE
Continent = 'Asia' OR 'Europe' OR 'Oceania';

-- 8. Display the Name, Region, and Population of countries whose names start with the letter 'A'.
--    Sort the results alphabetically.

SELECT Name, Region, Population
FROM country
WHERE Name LIKE 'A%'
ORDER BY Name ASC;

-- 9. Display the Name, Continent, Population, and LifeExpectancy of countries that:
--    are in Asia OR Europe,
--    have a population greater than 50,000,000, AND
--    have a life expectancy greater than 70.
--    Sort the results by population in descending order.

SELECT Name, Continent, Population, LifeExpectancy
FROM country
WHERE Continent in ( 'Asia','Europe') 
  AND Population > 50000000
  AND LifeExpectancy > 70
ORDER BY Population DESC;

-- 10. Display the Name, Continent, Population, and GovernmentForm of countries that:
--     are NOT in Africa, have a population between 5,000,000 and 30,000,000,
--     and whose names contain the letter 'land'.
--     Sort the results alphabetically.

SELECT  Name, Continent, Population, GovernmentForm
FROM country
WHERE Continent != 'Africa'
  AND Population BETWEEN 5000000 AND 30000000
  AND Name LIKE '%land%'
ORDER BY Name ASC