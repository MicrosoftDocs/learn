# Creating Tables

To create a new table in the database, use the `CREATE TABLE` command. You define the table name and its columns, along with their data types and constraints.

```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) CHECK (price >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    product_uuid UUID DEFAULT gen_random_uuid()
);
```

- `TEXT` is used for potentially long descriptions.
- `DECIMAL(10, 2)` ensures prices are stored with two decimal places.
- `TIMESTAMP DEFAULT CURRENT_TIMESTAMP` sets the creation time automatically.
- `BOOLEAN DEFAULT TRUE` sets a default active status.
- `UUID DEFAULT gen_random_uuid()` generates a unique identifier for each product.

**TODO:** `CREATE TABLE categories`

# Altering Tables

The `ALTER TABLE` command is used to modify the structure of an existing table. You can add, drop, or modify columns.

## Add a Column

```sql
ALTER TABLE products ADD COLUMN category_id INTEGER;
```

## Modify a Column

```sql
ALTER TABLE products ALTER COLUMN description TYPE TEXT; -- no change needed here, just example
ALTER TABLE products ALTER COLUMN price TYPE NUMERIC(12, 4); -- increase precision
```

## Drop a Column

```sql
ALTER TABLE products DROP COLUMN description;
```

## Add a Constraint

```sql
ALTER TABLE products ADD CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(id);
```

## Drop a Constraint

```sql
ALTER TABLE products DROP CONSTRAINT fk_category;
```

# Renaming Tables and Columns

To rename a table or a column, use the `RENAME` clause.

## Rename a Table

```sql
ALTER TABLE old_table_name RENAME TO new_table_name;
```

**Example:**

```sql
ALTER TABLE employees RENAME TO staff;
```

## Rename a Column

```sql
ALTER TABLE table_name RENAME COLUMN old_column_name TO new_column_name;
```

**Example:**

```sql
ALTER TABLE staff RENAME COLUMN first_name TO given_name;
```

# Dropping Tables

To drop a table, use the `DROP TABLE` statement:

```sql
DROP TABLE table_name;
```

**Example:**

```sql
DROP TABLE staff;
```