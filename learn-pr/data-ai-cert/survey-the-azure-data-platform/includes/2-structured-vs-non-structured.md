Microsoft Azure provides many data platform technologies to meet the needs of the wide varieties of data that are prevalent in the world today. However, it is worth reminding ourselves of the two broad types of data.

## Structured Data

In relational database systems like Microsoft SQL Server, Azure SQL Database and Azure SQL Data Warehouse, the structure of the data is defined at design-time in the form of tables, meaning it is designed before any information is loaded into the system.  The data structure includes the relational model, table structure, column width, and data types.

Relational systems are slow to react to changes in data requirements because the structural database needs to change every time a data requirement change.  When new columns are added to tables, the data may also require a bulk update to all existing records to populate the new column throughout the table.  Relational systems typically leverage a querying language such as Transact SQL (T-SQL).

## Non-structured Data

Non-structured data such as binary, audio or image files are stored in non-relational systems, commonly known as unstructured or NoSQL systems. In this paradigm, the data structure is not defined at design time, and data is typically loaded into these systems in its raw format. The structure of the data is only defined during the reading of the data; this gives the flexibility of using the same source data for different outputs. These systems can also support semi-structured such as JavaScript Object Notation (JSON). In the open source world, there are four types of No-SQL databases:

1. **Key-Value store**: Used to store key-value pairs of data in a table structure
1. **Document database**: Stores documents that are tagged with metadata to aid document searches
1. **Graph database**: A structure that's composed of vertices and edges to find relationships between data points
1. **Column base**: Provides column-based storage of data, rather than row based, and the columns can be defined at the runtime of a query giving flexibility in the data that is returned in a performant manner.

Now that we've reminded ourselves of the broad types of data; let's take a tour of the common data platform technologies used to facilitate the storage, processing, and querying of these different types of data.