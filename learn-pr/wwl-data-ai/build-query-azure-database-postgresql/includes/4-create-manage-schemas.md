Database schema design determines how effectively your application stores and retrieves data. A well-designed schema enforces data integrity through constraints, enables efficient queries through appropriate data types, and supports application evolution through thoughtful structure. For AI applications that store conversation history, task state, and metadata, schema design choices directly affect both performance and maintainability.

## Database and schema organization

PostgreSQL organizes objects in a hierarchy: a server instance contains databases, databases contain schemas, and schemas contain tables and other objects. Understanding this hierarchy helps you structure your application's data appropriately.

When you provision Azure Database for PostgreSQL, you create a server that can host multiple databases. Each database is an isolated container with its own tables, functions, and other objects. Connections target a specific database, and queries can't directly access objects in other databases on the same server. Within a database, schemas provide a namespace for organizing objects. The default schema is `public`, which contains objects when you don't specify a schema name. You can create more schemas to separate logical components of your application, isolate tenants in a multitenant application, or group related objects for easier permission management.

Use separate databases when you need complete isolation between datasets, when different applications share the same server but shouldn't access each other's data, or when you want independent backup and restore capabilities. Use separate schemas within a database when related objects need to reference each other through foreign keys, when you want to run queries that join data across the namespaces, or when you're implementing logical separation without full isolation. For most AI applications, a single database with the default `public` schema is sufficient.

## Create tables

Tables store your application's data in rows and columns. The `CREATE TABLE` statement defines the table structure, including column names, data types, and constraints.

A table definition specifies each column's name and data type, along with optional constraints that enforce data integrity rules. When you design tables for AI applications, consider what data you need to store, how you query that data, and what relationships exist between different entities:

```sql
CREATE TABLE conversations (
    id BIGSERIAL PRIMARY KEY,
    session_id UUID NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    started_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    ended_at TIMESTAMP WITH TIME ZONE,
    metadata JSONB DEFAULT '{}'::jsonb
);
```

This example creates a table for storing AI agent conversation sessions with an auto-incrementing primary key (`BIGSERIAL PRIMARY KEY`), required fields that can't be null, timestamp fields with automatic defaults, and a JSONB column for flexible metadata storage.

Every table should have a primary key that uniquely identifies each row. Serial columns auto-generate sequential integers (`SERIAL` for 32-bit, `BIGSERIAL` for 64-bit). UUID columns provide universally unique identifiers with `DEFAULT gen_random_uuid()`. Composite keys combine multiple columns when no single column is unique. For AI applications with high insert volumes, `BIGSERIAL` provides simple, sequential identifiers. Use UUIDs when you need to generate identifiers outside the database or merge data from multiple sources.

Constraints enforce rules about what data can be stored. `NOT NULL` prevents null values. `DEFAULT` provides a value when none is specified. `CHECK` validates values against a condition (like `CHECK (status IN ('pending', 'completed'))`). `UNIQUE` ensures no duplicate values. PostgreSQL checks these rules whenever you insert or update data, catching errors at the database level.

## Data types for AI applications

Choosing appropriate data types affects storage efficiency, query performance, and application flexibility. Several data types are relevant for AI workloads:

- **JSONB:** Stores JSON data in a binary format that supports indexing and efficient querying. Use JSONB when data structure varies between records, you need to store nested objects or arrays, or schema flexibility is more important than strict typing. You can query JSONB fields using PostgreSQL's JSON operators.

- **TEXT and VARCHAR:** Both store variable-length character strings. `TEXT` has no length limit, while `VARCHAR(n)` enforces a maximum. In PostgreSQL, there's no performance difference between `TEXT` and unconstrained `VARCHAR`. Use `VARCHAR(n)` when you want the database to enforce a maximum length.

- **TIMESTAMP WITH TIME ZONE:** Always use `TIMESTAMPTZ` for temporal data in applications that might operate across time zones. PostgreSQL stores timestamps in UTC and converts them based on the session's time zone setting when displaying.

- **BYTEA:** Stores binary data as a byte array. Use it for small binary objects that need to be stored alongside relational data. For large binary files, consider Azure Blob Storage with a reference in the database.

- **SERIAL and BIGSERIAL:** Pseudo-types that create auto-incrementing integer columns. PostgreSQL automatically creates a sequence and sets the default. Use `BIGSERIAL` for tables that might exceed two billion rows.

## Define relationships

Foreign keys establish relationships between tables and enforce referential integrity. When you define a foreign key, PostgreSQL ensures that values in the referencing column exist in the referenced table.

A one-to-many relationship connects a single row in one table to multiple rows in another. This pattern appears frequently in AI applications: one conversation has many messages; one user has many sessions; one task has many checkpoints. Implement this using a foreign key in the "many" table that references the primary key in the "one" table:

```sql
CREATE TABLE messages (
    id BIGSERIAL PRIMARY KEY,
    conversation_id BIGINT NOT NULL REFERENCES conversations(id),
    role VARCHAR(50) NOT NULL CHECK (role IN ('user', 'assistant', 'system')),
    content TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

Referential actions define what happens when you delete or update a referenced row. `RESTRICT` (the default) prevents the operation if referenced rows exist. `CASCADE` automatically deletes or updates all referencing rows. `SET NULL` sets the foreign key to NULL. `SET DEFAULT` sets it to the default value. Use `ON DELETE CASCADE` carefully—deleting a conversation automatically deletes all messages, which can remove more data than intended if relationships are complex.

Many-to-many relationships require a junction table that references both related tables. For example, conversations can have multiple tags, and tags can apply to multiple conversations:

```sql
CREATE TABLE conversation_tags (
    conversation_id BIGINT REFERENCES conversations(id) ON DELETE CASCADE,
    tag_id BIGINT REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (conversation_id, tag_id)
);
```

The composite primary key ensures each combination appears only once.

## Index basics

Indexes are data structures that speed up data retrieval at the cost of more storage and slower writes. PostgreSQL creates indexes automatically for primary keys and unique constraints. You create other indexes to optimize specific queries.

B-tree is the default index type and works well for equality and range comparisons on most data types. These indexes organize data in a sorted tree structure, enabling fast lookups for exact matches and range queries. Create indexes on columns that appear frequently in `WHERE` clauses, `JOIN` conditions, and `ORDER BY` clauses:

```sql
CREATE INDEX idx_messages_conversation_id ON messages(conversation_id);
CREATE INDEX idx_messages_created_at ON messages(created_at);
CREATE INDEX idx_messages_conversation_created ON messages(conversation_id, created_at);
```

The order of columns in a composite index matters. The index can satisfy queries that filter on the leading columns but not queries that filter only on trailing columns.

Indexes improve read performance but come with costs. Every index consumes disk space and adds overhead to inserts, updates, and deletes. For AI applications that write frequently (storing every message, for example), be selective about which indexes you create. Monitor query performance and add indexes when you identify slow queries that would benefit. Advanced indexing strategies, including GIN indexes for JSONB, partial indexes, and vector indexes, are covered in the "Optimize performance, indexing, and scaling" module.

## Schema management commands

As your application evolves, you need to modify table structures without losing existing data.

The `ALTER TABLE` command modifies existing tables. You can add columns (`ADD COLUMN`), add constraints (`ALTER COLUMN ... SET NOT NULL`), or remove columns (`DROP COLUMN`). Some operations acquire locks that block other operations, so plan schema changes carefully for production databases. Adding a column with a default value is efficient in PostgreSQL—the database stores the default in the system catalog rather than updating every existing row.

The `DROP TABLE` command permanently removes a table and all its data. This operation can't be undone outside of a transaction. PostgreSQL protects you from breaking relationships by preventing drops when other tables reference the target through foreign keys. Use `CASCADE` to automatically drop foreign key constraints, but do so carefully—it might affect tables you didn't intend to modify.

Wrap schema changes in transactions when you need to make multiple related changes atomically:

```sql
BEGIN;
ALTER TABLE conversations ADD COLUMN category VARCHAR(100);
CREATE INDEX idx_conversations_category ON conversations(category);
COMMIT;
```

If any statement fails, you can `ROLLBACK` to leave the schema unchanged. Most DDL statements in PostgreSQL are transactional, unlike some other databases.

## Additional resources

- [PostgreSQL data types documentation](https://www.postgresql.org/docs/current/datatype.html)
- [CREATE TABLE reference](https://www.postgresql.org/docs/current/sql-createtable.html)
- [Indexes in PostgreSQL](https://www.postgresql.org/docs/current/indexes.html)
