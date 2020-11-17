When doing performance tuning in Azure SQL, understanding the importance of statistics is critical. 

Statistics are stored in the user database as binary large objects (blobs). These blobs contain statistical information about the distribution of data values in one or more columns of a table or indexed view.

Statistics contain information about the distribution of data values within a column. The query optimizer uses column and index statistics in order to determine cardinality, which is the number of rows a query is expected to return. Cardinality estimates are then used by the query optimizer to generate the execution plan. Cardinality estimates also help the optimizer determine what type of operation (for example, index seek or scan) to use to retrieve the data requested.
