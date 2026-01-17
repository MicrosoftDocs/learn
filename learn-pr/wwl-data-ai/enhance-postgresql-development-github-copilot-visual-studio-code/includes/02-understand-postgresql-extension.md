The PostgreSQL extension for Visual Studio Code provides a comprehensive set of tools for managing and developing PostgreSQL databases directly within the editor. It allows developers to connect to local or cloud-hosted PostgreSQL databases, explore database objects, write and execute SQL queries, and review query results without leaving Visual Studio Code. This integrated experience simplifies common database tasks and reduces the need to switch between separate tools.

Consider the Margie’s Travel scenario. The team works with Azure Database for PostgreSQL to store information such as reservations, listings, and customer data. By using the PostgreSQL extension inside Visual Studio Code, developers can connect to these databases, inspect tables and schemas, and validate SQL changes while continuing to work in the same development environment as their application code.

## Identify core capabilities

The PostgreSQL extension provides several core capabilities that support everyday PostgreSQL development and management tasks.

- **Connection management**  
  Developers can create and save connections to PostgreSQL databases using connection details or connection strings. The extension supports connections to local databases as well as cloud-hosted databases, including Azure Database for PostgreSQL. Saved connections appear in the extension sidebar, making it easy to reconnect during future sessions.

- **Object Explorer**  
  The Object Explorer presents a hierarchical view of database objects. Developers can expand a database to browse schemas, tables, views, functions, and stored procedures. This view makes it easier to understand database structure and locate the objects needed for development or troubleshooting.

- **Query Editor**  
  The Query Editor provides a dedicated space for writing and executing SQL queries. Features such as syntax highlighting and context-aware IntelliSense help developers write queries more accurately and efficiently. Developers can launch new queries directly from database objects in the Object Explorer.

- **Results Viewer**  
  Query results are displayed in the Results Viewer, where developers can search, filter, and sort returned data. Results can also be exported to formats such as CSV, JSON, or Excel for further analysis or sharing.

Together, these capabilities allow developers to move seamlessly from connecting to a database, to exploring its structure, to writing and validating SQL queries.

## Explore how developers use the extension

Developers install the PostgreSQL extension from the Visual Studio Code Extensions Marketplace and add a connection to a PostgreSQL database. Connections can be tested before saving, and successful connections are stored for reuse.

Once connected, developers use the Object Explorer to navigate database objects and understand how data is organized. From the Object Explorer, they can open a new query window, write SQL in the Query Editor, and execute the query against the connected database. Query results are immediately displayed in the Results Viewer, allowing developers to verify output or refine the query.

At Margie’s Travel, a developer might connect to the reservations database, expand the schemas to locate tables related to bookings, and run a query to confirm that recent updates were applied correctly. This workflow keeps database exploration, query execution, and result review within a single tool.

## Recognize workflow benefits

Using the PostgreSQL extension keeps database activities inside Visual Studio Code. Developers can connect to databases, explore objects, write SQL queries, execute them, and review results without switching to an external database client. This reduces context switching and supports a more focused development experience.

For Margie’s Travel, this integrated workflow helps developers validate changes more quickly, troubleshoot issues efficiently, and maintain consistency when working with both local PostgreSQL databases and Azure Database for PostgreSQL instances.

## What you’ve learned

You learned how the PostgreSQL extension supports PostgreSQL development in Visual Studio Code. You explored how developers connect to PostgreSQL databases, browse database objects, write and execute SQL queries, and review results using the extension’s built-in tools. These capabilities form the foundation for more advanced workflows, including GitHub Copilot integration in later units.
