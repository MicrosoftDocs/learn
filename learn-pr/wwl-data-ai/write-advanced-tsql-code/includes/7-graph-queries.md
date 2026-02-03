Some data relationships are naturally represented as networks, including social connections, organizational hierarchies, product recommendations, and fraud detection patterns. While you can model these relationships using foreign keys and joins, graph queries using the `MATCH` operator provide a more intuitive and often more efficient way to traverse connected data.

In this unit, you'll learn how to create graph tables and write queries using the `MATCH` operator. You'll explore how graph patterns simplify complex relationship traversals that would otherwise require multiple self-joins.

## Visualize graph data structures

Before writing graph queries, it helps to visualize how graph data is organized. Consider a simple social network where people know each other and purchase products:

```
                    GRAPH DATA MODEL
    ┌─────────────────────────────────────────────────┐
    │                                                 │
    │     ┌─────────┐         ┌─────────┐            │
    │     │  Alice  │─KNOWS──▶│   Bob   │            │
    │     │(Person) │         │(Person) │            │
    │     └────┬────┘         └────┬────┘            │
    │          │                   │                 │
    │        KNOWS               KNOWS               │
    │          │                   │                 │
    │          ▼                   ▼                 │
    │     ┌─────────┐         ┌─────────┐            │
    │     │  Carol  │─KNOWS──▶│  David  │            │
    │     │(Person) │         │(Person) │            │
    │     └────┬────┘         └─────────┘            │
    │          │                                     │
    │      PURCHASED                                 │
    │          │                                     │
    │          ▼                                     │
    │     ┌─────────┐                                │
    │     │ Laptop  │                                │
    │     │(Product)│                                │
    │     └─────────┘                                │
    │                                                 │
    │  NODES: Person, Product (entities)             │
    │  EDGES: KNOWS, PURCHASED (relationships)       │
    └─────────────────────────────────────────────────┘
```

In this model:
- **Nodes** (boxes) represent entities like people and products
- **Edges** (arrows) represent relationships between nodes
- Arrow direction indicates the relationship direction (Alice knows Bob, not necessarily Bob knows Alice)

> [!NOTE]
> This diagram illustrates graph concepts. The code examples throughout this unit use similar but simplified data to focus on specific features.

## Understand graph capabilities

The graph feature extends the relational model with dedicated node and edge tables. Nodes represent entities (people, products, locations), while edges represent relationships between them (follows, purchased, located_in).

The key advantage of graph queries is pattern matching. Instead of writing complex multi-way joins, you express the pattern you're looking for using an ASCII-art style syntax:

```sql
-- Traditional relational approach (multiple joins)
SELECT p1.Name, p2.Name
FROM Person AS p1
INNER JOIN Friendship AS f ON p1.PersonID = f.Person1ID
INNER JOIN Person AS p2 ON f.Person2ID = p2.PersonID;

-- Graph approach (pattern matching)
SELECT Person1.Name, Person2.Name
FROM Person AS Person1, Friendship, Person AS Person2
WHERE MATCH(Person1-(Friendship)->Person2);
```

> [!NOTE]
> Graph tables are fully compatible with existing relational features. You can join graph tables with regular tables, use indexes, and apply all standard T-SQL operations.

## Create node tables

Node tables store entities in your graph. Create them using `CREATE TABLE` with the `AS NODE` clause:

```sql
-- Create a Person node table
CREATE TABLE dbo.Person (
    PersonID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(200),
    Department NVARCHAR(50)
) AS NODE;

-- Create a Product node table
CREATE TABLE dbo.Product (
    ProductID INT PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Category NVARCHAR(100),
    Price DECIMAL(10, 2)
) AS NODE;

-- Create a Location node table
CREATE TABLE dbo.Location (
    LocationID INT PRIMARY KEY,
    City NVARCHAR(100) NOT NULL,
    CountryRegion NVARCHAR(100) NOT NULL
) AS NODE;
```

SQL Server automatically adds a `$node_id` column to node tables that uniquely identifies each node. The system uses this column internally for graph relationships:

```sql
INSERT INTO dbo.Person (PersonID, Name, Email, Department)
VALUES 
    (1, 'Alice Johnson', 'alice@contoso.com', 'Engineering'),
    (2, 'Bob Smith', 'bob@contoso.com', 'Marketing'),
    (3, 'Carol Davis', 'carol@contoso.com', 'Engineering'),
    (4, 'David Lee', 'david@contoso.com', 'Sales');

SELECT $node_id, PersonID, Name FROM dbo.Person;
```

## Create edge tables

Edge tables represent relationships between nodes. Create them using `CREATE TABLE` with the `AS EDGE` clause:

```sql
-- Create a "reports to" relationship edge
CREATE TABLE dbo.ReportsTo (
    StartDate DATE,
    ReportType NVARCHAR(50)
) AS EDGE;

-- Create a "purchased" relationship edge
CREATE TABLE dbo.Purchased (
    PurchaseDate DATE NOT NULL,
    Quantity INT NOT NULL,
    TotalAmount DECIMAL(10, 2)
) AS EDGE;

-- Create a "knows" relationship edge (social connection)
CREATE TABLE dbo.Knows (
    ConnectionDate DATE,
    ConnectionStrength INT  -- 1-10 scale
) AS EDGE;
```

SQL Server automatically adds `$edge_id`, `$from_id`, and `$to_id` columns to edge tables. Insert edges by specifying the `$from_id` and `$to_id` values from the connected nodes:

```sql
-- Alice reports to Bob
INSERT INTO dbo.ReportsTo ($from_id, $to_id, StartDate, ReportType)
SELECT 
    (SELECT $node_id FROM dbo.Person WHERE Name = 'Alice Johnson'),
    (SELECT $node_id FROM dbo.Person WHERE Name = 'Bob Smith'),
    '2023-01-15',
    'Direct';

-- Create social connections
INSERT INTO dbo.Knows ($from_id, $to_id, ConnectionDate, ConnectionStrength)
SELECT 
    (SELECT $node_id FROM dbo.Person WHERE Name = 'Alice Johnson'),
    (SELECT $node_id FROM dbo.Person WHERE Name = 'Carol Davis'),
    '2022-06-01',
    8;
```

> [!TIP]
> Edge tables can store properties about the relationship itself, like dates, weights, or types. This is useful for temporal analysis or weighted graph algorithms.

## Query graphs with the MATCH clause

The `MATCH` clause uses a pattern syntax to specify the relationships you want to find. The basic pattern uses arrows to show relationship direction:

```sql
-- Find who reports to whom
SELECT 
    Employee.Name AS Employee,
    Manager.Name AS Manager,
    r.StartDate
FROM dbo.Person AS Employee, 
     dbo.ReportsTo AS r, 
     dbo.Person AS Manager
WHERE MATCH(Employee-(r)->Manager);
```

The arrow direction matters:
- `(Node1)-(Edge)->(Node2)`: Edge goes from Node1 to Node2
- `(Node1)<-(Edge)-(Node2)`: Edge goes from Node2 to Node1

Find all people who know Alice:

```sql
SELECT 
    Connector.Name AS PersonWhoKnowsAlice,
    k.ConnectionStrength
FROM dbo.Person AS Connector, 
     dbo.Knows AS k, 
     dbo.Person AS Target
WHERE MATCH(Connector-(k)->Target)
  AND Target.Name = 'Alice Johnson';
```

## Traverse multiple relationships

Chain multiple patterns to traverse deeper relationships. Find friends of friends:

```sql
-- Find friends of friends (2-hop connections)
SELECT DISTINCT
    Person1.Name AS Person,
    Person3.Name AS FriendOfFriend
FROM dbo.Person AS Person1,
     dbo.Knows AS k1,
     dbo.Person AS Person2,
     dbo.Knows AS k2,
     dbo.Person AS Person3
WHERE MATCH(Person1-(k1)->Person2-(k2)->Person3)
  AND Person1.Name = 'Alice Johnson'
  AND Person3.Name <> Person1.Name;  -- Exclude self
```

Combine different relationship types:

```sql
-- Find products purchased by people in the same department
SELECT DISTINCT
    p1.Name AS Person,
    p1.Department,
    prod.Name AS Product
FROM dbo.Person AS p1,
     dbo.Knows AS k,
     dbo.Person AS p2,
     dbo.Purchased AS pu,
     dbo.Product AS prod
WHERE MATCH(p1-(k)->p2-(pu)->prod)
  AND p1.Department = p2.Department;
```

> [!IMPORTANT]
> Each edge table alias can only appear once in a single `MATCH` pattern. To traverse the same edge type multiple times, use separate aliases.

## Use SHORTEST_PATH for variable-length traversals

`SHORTEST_PATH` finds the shortest connection between nodes across a variable number of hops. This is essential for scenarios like finding degrees of separation or shortest routes:

```sql
-- Find shortest connection path between two people
SELECT 
    StartPerson.Name AS StartPerson,
    STRING_AGG(ConnectedPerson.Name, ' -> ') 
        WITHIN GROUP (GRAPH PATH) AS ConnectionPath,
    LAST_VALUE(ConnectedPerson.Name) 
        WITHIN GROUP (GRAPH PATH) AS EndPerson,
    COUNT(ConnectedPerson.Name) 
        WITHIN GROUP (GRAPH PATH) AS Hops
FROM dbo.Person AS StartPerson,
     dbo.Knows FOR PATH AS k,
     dbo.Person FOR PATH AS ConnectedPerson
WHERE MATCH(SHORTEST_PATH(StartPerson(-(k)->ConnectedPerson)+))
  AND StartPerson.Name = 'Alice Johnson'
  AND LAST_VALUE(ConnectedPerson.Name) WITHIN GROUP (GRAPH PATH) = 'David Lee';
```

The `FOR PATH` keyword indicates that the table participates in variable-length pattern matching. The `+` modifier means "one or more" traversals.

Find all people within 3 hops of a starting person:

```sql
SELECT 
    StartPerson.Name,
    LAST_VALUE(ReachablePerson.Name) WITHIN GROUP (GRAPH PATH) AS ReachablePerson,
    COUNT(ReachablePerson.Name) WITHIN GROUP (GRAPH PATH) AS Distance
FROM dbo.Person AS StartPerson,
     dbo.Knows FOR PATH AS k,
     dbo.Person FOR PATH AS ReachablePerson
WHERE MATCH(SHORTEST_PATH(StartPerson(-(k)->ReachablePerson){1,3}))
  AND StartPerson.Name = 'Alice Johnson';
```

## Combine graph and relational queries

Graph tables work directly with regular relational tables and operations:

```sql
-- Join graph results with a regular table
-- Assumes a Departments table exists: CREATE TABLE dbo.Departments (DepartmentName NVARCHAR(50) PRIMARY KEY, DepartmentBudget DECIMAL(12,2));
SELECT 
    e.Name AS Employee,
    m.Name AS Manager,
    d.DepartmentBudget
FROM dbo.Person AS e,
     dbo.ReportsTo AS r,
     dbo.Person AS m,
     dbo.Departments AS d  -- Regular relational table
WHERE MATCH(e-(r)->m)
  AND e.Department = d.DepartmentName;

-- Use graph patterns in a CTE
WITH DirectReports AS (
    SELECT 
        Manager.PersonID AS ManagerID,
        Manager.Name AS ManagerName,
        COUNT(*) AS ReportCount
    FROM dbo.Person AS Employee,
         dbo.ReportsTo AS r,
         dbo.Person AS Manager
    WHERE MATCH(Employee-(r)->Manager)
    GROUP BY Manager.PersonID, Manager.Name
)
SELECT * FROM DirectReports
WHERE ReportCount >= 3;
```

## Choose between graph and relational approaches

Graph queries aren't always the best choice. Consider these guidelines when deciding between graph and traditional relational approaches:

**Use graph queries when:**
- Relationships are the primary focus of your queries
- You need to traverse variable or unknown depths (friends of friends of friends)
- The data naturally forms a network (social graphs, hierarchies, routes)
- Query patterns would require many self-joins in relational SQL
- You're performing path-finding or connectivity analysis

**Use relational queries when:**
- Relationships are simple and fixed-depth (parent-child with one level)
- You're primarily filtering and aggregating entity attributes
- The data model is mostly tabular with few relationships
- Performance is critical and indexes on foreign keys are sufficient
- Your team is more familiar with traditional SQL patterns

```sql
-- Relational: Good for simple, fixed-depth relationships
-- Find employees and their direct managers (1 level)
SELECT e.Name, m.Name AS Manager
FROM Employees e
INNER JOIN Employees m ON e.ManagerID = m.EmployeeID;

-- Graph: Better for variable-depth or complex traversals
-- Find all people connected to Alice within 5 hops
SELECT LAST_VALUE(p.Name) WITHIN GROUP (GRAPH PATH) AS Connected
FROM Person AS Start, Knows FOR PATH AS k, Person FOR PATH AS p
WHERE MATCH(SHORTEST_PATH(Start(-(k)->p){1,5}))
  AND Start.Name = 'Alice';
```

## Troubleshoot common graph query challenges

Graph queries have unique syntax requirements that can cause errors. Here are common challenges and how to resolve them.

### Wrong arrow direction

The arrow direction in your `MATCH` pattern must align with how you inserted the edge data. If the arrow points the wrong way, the query returns no results.

```sql
-- WRONG: Arrow direction doesn't match data
SELECT Employee.Name, Manager.Name
FROM Person AS Employee, ReportsTo AS r, Person AS Manager
WHERE MATCH(Employee<-(r)-Manager);  -- Looking for edges TO Employee

-- CORRECT: Match the direction edges were inserted
WHERE MATCH(Employee-(r)->Manager);  -- Edges go FROM Employee TO Manager
```

Always verify how edges were inserted. If you inserted `$from_id` as Employee and `$to_id` as Manager, the arrow must point from Employee to Manager.

### Reusing edge aliases in the same `MATCH`

Each edge alias can only appear once in a `MATCH` pattern. If you need to traverse the same edge type multiple times, create separate aliases for each traversal.

```sql
-- WRONG: Same edge alias 'k' used twice
SELECT p1.Name, p3.Name
FROM Person p1, Knows k, Person p2, Knows k, Person p3
WHERE MATCH(p1-(k)->p2-(k)->p3);

-- CORRECT: Use different aliases for each edge traversal
FROM Person p1, Knows k1, Person p2, Knows k2, Person p3
WHERE MATCH(p1-(k1)->p2-(k2)->p3);
```

### Forgetting `FOR PATH` with `SHORTEST_PATH`

When using `SHORTEST_PATH` for variable-length traversals, you must mark the edge and node tables with `FOR PATH`. Without this keyword, the query fails.

```sql
-- WRONG: Missing FOR PATH keywords
SELECT ...
FROM Person AS Start, Knows AS k, Person AS p
WHERE MATCH(SHORTEST_PATH(Start(-(k)->p)+));

-- CORRECT: Add FOR PATH to variable-length tables
FROM Person AS Start, Knows FOR PATH AS k, Person FOR PATH AS p
WHERE MATCH(SHORTEST_PATH(Start(-(k)->p)+));
```

### Missing `$node_id` in edge inserts

Edge tables require the internal `$node_id` values, not your business key columns. Inserting regular column values causes the edge to reference nonexistent nodes.

```sql
-- WRONG: Using regular column values instead of $node_id
INSERT INTO Knows ($from_id, $to_id)
VALUES (1, 2);  -- These are PersonID values, not $node_id

-- CORRECT: Select the $node_id from the node tables
INSERT INTO Knows ($from_id, $to_id)
SELECT 
    (SELECT $node_id FROM Person WHERE PersonID = 1),
    (SELECT $node_id FROM Person WHERE PersonID = 2);
```

> [!NOTE]
> Graph tables and the `MATCH` operator are available in SQL Server 2017 and later, and Azure SQL Database. The `SHORTEST_PATH` function requires SQL Server 2019 or later. Check your platform's documentation for specific feature availability.

For more information about graph features, see [Graph processing with SQL Server](/sql/relational-databases/graphs/sql-graph-overview?azure-portal=true) and [`MATCH` (Transact-SQL)](/sql/t-sql/queries/match-sql-graph?azure-portal=true).
