[SQL Server](/sql/sql-server/sql-server-technical-documentation?azure-portal=true) provides several programmability objects that help you encapsulate logic, improve code reusability, and enforce business rules within your database. These objects—[views](/sql/relational-databases/views/views?azure-portal=true), [stored procedures](/sql/relational-databases/stored-procedures/stored-procedures-database-engine?azure-portal=true), [functions](/sql/relational-databases/user-defined-functions/user-defined-functions?azure-portal=true), and [triggers](/sql/relational-databases/triggers/dml-triggers?azure-portal=true)—each serve distinct purposes and offer unique capabilities for database development.

## Scenario

You're a database developer at a growing e-commerce company. Your team manages a SQL Server database that handles customer orders, inventory, and reporting. As the application grows more complex, you notice:

- Developers write the same `JOIN` queries repeatedly across different applications
- Business logic is scattered throughout application code, making it hard to maintain
- Some data modifications need automatic validation and logging
- Complex calculations appear in multiple queries, leading to inconsistencies

You decide to create specific SQL Server objects to centralize logic, improve maintainability, and enhance security across your database applications.

## What you'll learn

In this module, you'll explore the core programmability objects in SQL Server:

- **Views** - Virtual tables that simplify data access and provide security boundaries
- **Stored procedures** - Precompiled T-SQL code blocks for complex operations and data modifications
- **Scalar functions** - Reusable calculations that return single values
- **Table-valued functions** - Functions that return result sets for use in queries
- **Triggers** - Automatic responses to data modifications or database events

You'll also learn decision criteria for choosing the right programmability object based on your specific requirements.
