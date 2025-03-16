# Joining Tables

## INNER JOIN

```sql
SELECT Orders.OrderID, Customers.CustomerName, Employees.FirstName, Employees.LastName 
FROM Sales.Orders AS Orders 
INNER JOIN Sales.Customers AS Customers ON Orders.CustomerID = Customers.CustomerID 
INNER JOIN Sales.Employees AS Employees ON Orders.EmployeeID = Employees.EmployeeID;
```

This retrieves order information along with the customer and employee names.

## LEFT JOIN

```sql
SELECT Customers.CustomerName, Orders.OrderID 
FROM Sales.Customers AS Customers 
LEFT JOIN Sales.Orders AS Orders ON Customers.CustomerID = Orders.CustomerID;
```

This retrieves all customers and their associated orders (if any). Customers without orders will still be listed.

## RIGHT JOIN

```sql
SELECT Customers.CustomerName, Orders.OrderID 
FROM Sales.Customers AS Customers 
RIGHT JOIN Sales.Orders AS Orders ON Customers.CustomerID = Orders.CustomerID;
```

This retrieves all orders and their associated customers (if any). Orders without customers will still be listed.

## FULL OUTER JOIN

```sql
SELECT Customers.CustomerName, Orders.OrderID 
FROM Sales.Customers AS Customers 
FULL OUTER JOIN Sales.Orders AS Orders ON Customers.CustomerID = Orders.CustomerID;
```

This retrieves all customers and all orders. If there is no match on either side of the join, nulls are returned.
