--Database: Adventureworks2019
--Questions:
-- 1-List all the products in the "Product" table
SELECT * FROM Production.Product;
-- 2-Find all employees who have a job title of "Sales Representative".
SELECT * FROM HumanResources.Employee WHERE JobTitle = 'Sales Representative';
-- 3- Get all orders from the "SalesOrderHeader" table, sorted by order date in
-- descending order.
SELECT * FROM Sales.SalesOrderHeader ORDER BY OrderDate DESC;
-- 4- Show the product name and the product category for each product.
SELECT p.Name as Product_Name , pc.Name as Product_Category 
FROM Production.Product p
JOIN Production.ProductSubCategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON pc.ProductCategoryID = psc.ProductCategoryID;
-- 5- List the total number of products in each product category.
SELECT pc.Name as Product_Category , COUNT(p.ProductID) as Product_Count  
FROM Production.Product p
JOIN Production.ProductSubCategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON pc.ProductCategoryID = psc.ProductCategoryID
GROUP BY pc.Name;
-- 6- Retrieve the next 5 products after skipping the first 10 products,
-- sorted by product name in ascending order.
SELECT * FROM Production.Product p
order by p.Name ASC
OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;
-- 7- List all possible combinations of product names and sales territory
-- names
SELECT p.Name as Product_Name , st.Name as Sales_Territory_Name
FROM Production.Product p
CROSS JOIN Sales.SalesTerritory st;
-- 8- Find all orders with a total due between $50000 and $100000.
SELECT * FROM Sales.SalesOrderHeader WHERE TotalDue BETWEEN 50000 AND 100000;
-- 9- Find all products whose names start with 'Bike'.
SELECT * FROM Production.Product WHERE Name LIKE 'Bike%';
-- 10- Find products with a list price less than $100.
SELECT * FROM Production.Product WHERE ListPrice < 100;
-- 11- Retrieve all sales orders along with the salesperson's name, even if
-- some orders were not handled by a salesperson
SELECT soh.SalesOrderID , per.FirstName as SalesPerson_FirstName , per.LastName as SalesPerson_LastName
FROM Sales.SalesOrderHeader soh
LEFT JOIN HumanResources.Employee e ON soh.SalesPersonID = e.BusinessEntityID
JOIN Person.Person per ON e.BusinessEntityID = per.BusinessEntityID;
-- 12- Retrieve the top 5 most expensive products sorted by list price in
-- descending order
SELECT TOP 5 * FROM Production.Product ORDER BY ListPrice DESC;
-- 13- Calculate total sales, average sales, the maximum and minimum sales
-- order amounts, and the total number of sales orders from the
-- "SalesOrderHeader" table
SELECT SUM(TotalDue) as Total_Sales, 
AVG(TotalDue) as Average_Sales, 
MAX(TotalDue) as Maximum_Sales, 
MIN(TotalDue) as Minimum_Sales, 
COUNT(SalesOrderID) as Total_Sales_Orders
FROM Sales.SalesOrderHeader;
-- 14- Determine the average line total amount for all the items sold in each
-- product category
SELECT pc.Name as Product_Category, AVG(sod.LineTotal) as Average_LineTotal
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
JOIN Production.ProductSubCategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON pc.ProductCategoryID = psc.ProductCategoryID
GROUP BY pc.Name;

