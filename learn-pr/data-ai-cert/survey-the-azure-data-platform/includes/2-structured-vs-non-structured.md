Azure provides many data platform technologies to meet the needs of common data varieties. It's worth reminding ourselves of the two broad types of data: structured data and nonstructured data.

## Structured data

In relational database systems like Microsoft SQL Server, Azure SQL Database, and Azure SQL Data Warehouse, data structure is defined at design time. Data structure is designed in the form of tables. This means it's designed before any information is loaded into the system. The data structure includes the relational model, table structure, column width, and data types.

Relational systems react slowly to changes in data requirements because the structural database needs to change every time a data requirement changes. When new columns are added, you might need to bulk-update all existing records to populate the new column throughout the table. 

Relational systems typically use a querying language such as Transact-SQL (T-SQL).

## Nonstructured data

Examples of nonstructured data include binary, audio, and image files. Nonstructured data is stored in nonrelational systems, commonly called unstructured or NoSQL systems. In nonrelational systems, the data structure isn't defined at design time, and data is typically loaded in its raw format. The data structure is defined only when the data is read. The difference in the definition point gives you flexibility to use the same source data for different outputs. Nonrelational systems can also support semistructured data such as JSON file formats. 

The open-source world offers four types of NoSQL databases:

1. **Key-value store**: Stores key-value pairs of data in a table structure.
1. **Document database**: Stores documents that are tagged with metadata to aid document searches.
1. **Graph database**: Finds relationships between data points by using a structure that's composed of vertices and edges.
1. **Column database**: Stores data based on columns rather than rows. Columns can be defined at the query's runtime, allowing flexibility in the data that's returned performantly.

Now that we've reviewed data types, let's look at common data platform technologies that facilitate the storage, processing, and querying of these data types.