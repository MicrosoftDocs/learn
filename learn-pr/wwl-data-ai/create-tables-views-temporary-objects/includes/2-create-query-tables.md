You can use Transact-SQL to make tables for your databases, to populate them, and fetch data from them.

## Create tables

Use Transact-SQL statements to create tables for your databases so that you can store and query your data. To create a table, you perform the following steps:

1. Point to your database. For example, to point to a database named **OnlineShop**, you'd run the following statement in your chosen query editor window:

    ```sql
    USE OnlineShop;
    ```

1. You can then use CREATE TABLE to create your table in your chosen database. For example, to create a Products table, you can run the following statement:

    ```sql
    CREATE TABLE Products  
   (ProductID int PRIMARY KEY NOT NULL,  
   ProductName varchar(50) NOT NULL,  
   ProductDescription varchar(max) NOT NULL);
    ```

    This creates a table with the following columns:

    |Column  |Description  |
    |---------|---------|
    |ProductID|A product ID column with **int** type. It is also the primary key for the table.|
    |ProductName|A column for the name of each product of type **varchar** with limit of up to 50 characters. NOT NULL means the column can't be empty. |
    |ProductDescription|A column for the description of each product. Also of type **varchar**.|

To successfully create a table, you must provide a name for your table, the names of the columns for your table, and the data type for each column.

> [!NOTE]
> You must have the CREATE TABLE and ALTER SCHEMA permissions to create tables.

## Insert and read data from a table 

Once you've created your table, you'll want to populate it with data. You can do this with Transact-SQL using the INSERT statement. For example, to add a product to a **Products** table, you could run the following statement:

```sql
INSERT Products (ProductID, ProductName, ProductDescription)  
    VALUES (1, 'The brown fox and the yellow bear', 'A popular book for children.');
```

To read data from your table, you use the SELECT statement. For instance, to fetch the names and descriptions for all the products in your **Products** table, you'd run the following statement:

```sql
SELECT ProductName, ProductDescription
    FROM Products;
```
