<!-- 1. Topic sentences ----------------------------------------------------------------------------------

    Goal: Briefly summarize the concepts that this unit teaches.

    Heading: None

    Example: "In addition to tables, a relational database can contain other structures that help to
             optimize data organization, encapsulate programmatic actions, and improve the speed of access."

    Detailed guidance: `https://review.learn.microsoft.com/help/learn/id-guidance-introductions?branch=main#learning-unit-introduction`
-->
PostgreSQL supports a wide range of data types. Here are some of the most commonly used ones.

## Numeric Types

* INTEGER (INT): A signed four-byte integer
* SMALLINT: A signed two-byte integer
* BIGINT: A signed eight-byte integer
* DECIMAL(precision, scale) / NUMERIC(precision, scale): Exact numeric type with user-specified precision (total number of digits) and scale (number of digits after the decimal point). Example DECIMAL(10,2) can store numbers like 12345678.90
* REAL: A single-precision floating-point number (4 bytes) 
* DOUBLE PRECISION: A double-precision floating point number (8 bytes) 

## Serial Types

* SERIAL / BIGSERIAL / SMALLSERIAL: Auto-incrementing integer types. SERIAL is equivalent to INTEGER with a sequence and BIGSERIAL is equivalent to BIGINT with a sequence

There are a few ways to create an ID column with auto-incrementing behavior (similar to AUTO_INCREMENT in MySQL) in PostgreSQL. The most common and recommended approach is using the SERIAL or BIGSERIAL data types. 

```sql

CREATE TABLE my_table ( 

Id SERIAL PRIMARY KEY, 

other_data TEXT 

); 

```

This single line does several things:
* Id SERIAL: This creates an integer column named id and automatically creates a sequence object associated with it. This sequence is what generates the incrementing values. The SERIAL type is equivalent to INTEGER with a default NOT NULL constraint and a default value from the associated sequence.
* PRIMARY KEY: This adds a primary key constraint on the id column, ensuring uniquencess and indexing for efficient lookups.

You can achieve the same result by explicitly creating a sequence using nextval() in a DEFAULT constraint

```sql 

CREATE SEQUENCE my_table_id_seq; 

CREATE TABLE my_table ( 

Id INTEGER PRIMARY KEY DEFAULT nextval(‘my_table_id_seq’), 

other_data TEXT 

); 

ALTER SEQUENCE my_table_id_seq OWNED BY my_table; --Important: Tie sequence to the column 

```

## Character Types

* VARCHAR(n): Variable length string with a maximum length of n characters 

* CHAR(n): Fixed-length string of n characters, padded with space if the string you store is shorter

```sql

CREATE TABLE example_table ( 

fixed_length_column CHAR(10) 

); 

INSERT INTO example_table (fixed_length_column) VALUES ('Hello'); 

```

In this example, the fixed_length_column is defined as CHAR(10), meaning it will store strings of exactly 10 characters. When you insert the string 'Hello', it will be padded with spaces to make up the length, resulting in 'Hello '.

* TEXT: Variable-length string with no specified limit

## Date/Time Types  

* DATE: Stores only data values (year, month, day)
* TIME: Stores only tie values (hour, minute, second)
* TIMESTAMP: Stores both data and time values
* TIMESTAMPTZ: Stores both data and time values with time zone
* INTERVAL: Represents a time duration

## Boolean Type

* BOOLEAN: Stores true or false values

## Array Type

Allows you to define a column as a variable-length multidimensional array. This means you can store arrays of any built-in or user-defined base type, enum type, composite type, range type, or domain. For example, you can create a table with an array of integers or an array of text values. The array elements are enclosed in curly braces {} and separated by commas. You can also use the ARRAY constructor to create arrays.

## Other Types

* UUID: Universally Unique Identifiers
* JSON / JSONB: Stores JSON data. JSONB stores data in a binary format, allowing for indexing and more efficient querying
* BYTEA: Stores binary data (byte arrays)