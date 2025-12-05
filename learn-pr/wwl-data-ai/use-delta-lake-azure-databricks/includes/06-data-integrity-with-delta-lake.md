Data integrity in Delta Lake is a critical aspect that ensures the accuracy, consistency, and reliability of data throughout its lifecycle. Delta Lake provides several mechanisms to uphold data integrity, especially in environments with complex data pipelines, and multiple concurrent users. We already covered ACID transactions, schema enforcement, evolution, time travel etc.

## Enforce Constraints

**Primary Key** (PK) and **Foreign Key** (FK) constraints in Databricks define relational structure and intended uniqueness and referential relationships between tables. A primary key constraint indicates that a column (or set of columns) *should* uniquely identify each row in the table (and typically that none of those columns are null). A foreign key constraint means that a column or set of columns in one table should match values in a primary or candidate key in another table, establishing referential integrity. However, it’s important to note that these constraints are **informational**, **not enforced** by the Databricks engine itself. They serve to document intended relationships and allow optimizations (especially if you mark them with the RELY option), but they don’t guarantee that the data actually satisfies them unless enforced upstream or validated manually.

Let's explore an example in SQL where we create a customers table (composite PK) and orders table (single PK + composite FK):

```sql
-- Dimension: customers (composite primary key)
CREATE TABLE customers (
  customer_id INT    NOT NULL,
  region_id   INT    NOT NULL,
  name        STRING NOT NULL,
  email       STRING,
  CONSTRAINT customers_pk PRIMARY KEY (customer_id, region_id)
);

-- Fact: orders (single-column primary key, plus a composite FK to customers)
CREATE TABLE orders (
  order_id    INT      NOT NULL PRIMARY KEY,
  customer_id INT,
  region_id   INT,
  order_date  DATE     NOT NULL,
  amount      DECIMAL(12,2) NOT NULL,
  CONSTRAINT orders_customer_fk
    FOREIGN KEY (customer_id, region_id) REFERENCES customers
);
```

> [!NOTE]
> - Primary key and foreign key constraints are available in Databricks Runtime 11.3 LTS and above, and are fully GA in Databricks Runtime 15.2 and above.
> - Primary key and foreign key constraints require Unity Catalog and Delta Lake.

Delta also supports **constraints**, such as `NOT NULL`, `CHECK`, and generated columns. These constraints are validated at write time to ensure that only valid data enters the table. The following example creates an employees table with primary key, `NOT NULL`, and `CHECK` constraints to enforce valid ages and dates, and then adds another `CHECK` constraint ensuring `employee_id` values stay within the range 1–99,999,999. Violating records are rejected, keeping the table consistent with business rules.

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name  STRING,
    last_name   STRING NOT NULL,
    age         INT,
    start_date  DATE,
    end_date    DATE,
    CONSTRAINT age_non_negative CHECK (age >= 0),
    CONSTRAINT valid_dates      CHECK (end_date > start_date)
);

ALTER TABLE employees ADD CONSTRAINT validIds CHECK (employee_id >= 1 and employee_id <= 99999999);
```

## Handle Concurrency

Concurrency is another integrity challenge, especially when multiple users or jobs write to the same table. Delta handles this with optimistic concurrency control (OCC). Each transaction reads the current snapshot and proposes changes; before committing, Delta checks whether other commits have modified the same data files. If a conflict is detected (for example, two jobs updating the same row), one transaction fails with a conflict error instead of silently overwriting the other’s changes. This ensures consistency without locking the entire table.

Let's go through an example. We have a table of employees:

```sql
CREATE TABLE employees (
  id INT,
  name STRING,
  age INT
);

INSERT INTO employees VALUES (1, 'Alice', 30), (2, 'Bob', 25);
```

Imagine Transaction A and Transaction B both start at the same time, each reading the same snapshot of the table (version 1).

**Transaction A (Session 1):**

```sql
-- Session 1: Try to update Bob
UPDATE employees
SET age = 26
WHERE id = 2;
```

**Transaction B (Session 2):**

```sql
-- Session 2: Try to update Bob differently
UPDATE employees
SET age = 27
WHERE id = 2;
```

Session 1 finishes and commits successfully, producing version 2 of the table where Bob’s age is updated to 26. When Session 2 attempts to commit, Delta compares the files it planned to modify against the current table state. It finds that those files have already been changed in version 2, so the commit is blocked and Session 2 fails with a conflict error.

## Define Expectations

Finally, Delta provides data quality tooling such as Lakeflow Declarative Pipelines expectations, which allow you to define data quality rules declaratively and track violations. 

They let you assert boolean conditions on records as data flows through ETL/streaming pipelines (materialized views or streaming tables), to validate that data meets specified constraints. For example, you might enforce that a column "age" is between 0 and 120, or that certain fields are not null. The conditions are expressed in SQL (or via Python decorators) and run per record. When a record violates the expectation, what happens next depends on the expectation’s configuration ("action on violation") — you can warn/log, drop the record, or fail the update.

There are three main parts to an expectation:

- **Expectation name** – a label identifying the rule (must be unique per dataset). Used for monitoring, metrics, and understanding which rule failed.

- **Constraint / Condition** – a SQL boolean condition that each record must satisfy. 

- **Action on violation** – what to do when a record violates the constraint. The options are:
  
  - *warn (default)*: keep invalid records, but log metrics.
  - *drop*: drop invalid records before writing them to the target table, logging how many dropped.
  - *fail*: abort the update/flow if any record violates the expectation.

We'll cover this in more detail in the next module.