SQL Server offers a wide variety of data types to choose from, and your choice can affect performance in a number of ways. While SQL Server can convert some data types automatically (we call this an ‘implicit conversion’, conversion can be costly and can also negatively impact query plans. The alternative is an explicit conversion, where you use the CAST or CONVERT function in your code to force a data type conversion. Additionally, choosing data types that are much larger than needed can cause wasted space and require more pages than is necessary to be read. It is important to choose the right data types for a given set of data—which will reduce the total storage required for the database and improve the performance of queries executed. The image below indicates in which cases SQL Server can do an implicit conversion and in which cases you must explicitly convert datatypes in your code. 

> [!NOTE]
> In some cases, conversions are not possible at all. For example, a date cannot be converted to a bit. Conversions can negatively impact query performance by causing index scans where seeks would have been possible, and additional CPU overhead from the conversion itself.

:::image type="content" source="../media/module-55-optimize-queries-final-11.png" alt-text="Chart of Type Conversions in SQL Server and Azure SQL":::

SQL Server offers a set of system supplied data types for all data that can be used in your tables and queries. SQL Server allows the creation of user defined data types in either T-SQL or the .NET framework.
