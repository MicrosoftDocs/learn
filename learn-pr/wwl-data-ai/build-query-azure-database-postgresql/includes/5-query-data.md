This unit covers PostgreSQL-specific query features and patterns that are essential for AI applications. The unit focuses on PostgreSQL's unique capabilities and advanced patterns for managing conversation history, processing state, and application metadata.

This unit assumes familiarity with standard SQL concepts like `SELECT`, `WHERE`, joins, and aggregation. If you need a refresher, the [Get started querying with Transact-SQL](/training/paths/get-started-querying-with-transact-sql/) learning path is a good resource.

## Query execution and alias scope

Even experienced SQL developers get tripped up by execution order, particularly when using column aliases. SQL statements execute in a specific logical order that differs from how you write them, and understanding this order helps you troubleshoot cryptic "column doesn't exist" errors.

| Order | Clause | Purpose |
|-------|--------|---------|
| 1 | `FROM` | Identify source tables |
| 2 | `WHERE` | Filter rows |
| 3 | `GROUP BY` | Group rows for aggregation |
| 4 | `HAVING` | Filter groups |
| 5 | `SELECT` | Choose columns and compute expressions |
| 6 | `ORDER BY` | Sort results |
| 7 | `LIMIT` / `OFFSET` | Restrict result count |

**Alias scope rule:** Column aliases defined in `SELECT` are only visible to clauses that execute *after* `SELECT`—namely `ORDER BY` and `LIMIT`/`OFFSET`. Clauses that execute earlier (`WHERE`, `GROUP BY`, `HAVING`) can't reference these aliases because they aren't defined yet.

This means you can't filter by an alias in `WHERE`, but you can sort by one in `ORDER BY`:

```sql
-- This FAILS: WHERE executes before SELECT, so 'msg_date' doesn't exist yet
SELECT DATE(created_at) AS msg_date, content
FROM messages
WHERE msg_date > '2024-01-01';  -- Error: column "msg_date" does not exist

-- This WORKS: repeat the expression in WHERE
SELECT DATE(created_at) AS msg_date, content
FROM messages
WHERE DATE(created_at) > '2024-01-01';

-- This also WORKS: ORDER BY executes after SELECT, so aliases are available
SELECT DATE(created_at) AS msg_date, content
FROM messages
WHERE DATE(created_at) > '2024-01-01'
ORDER BY msg_date;
```

## PostgreSQL-specific filtering

PostgreSQL extends standard SQL with operators that simplify common filtering tasks. These features are useful for AI applications that need flexible text search and structured metadata queries.

The `ILIKE` operator provides case-insensitive pattern matching without requiring functions like `LOWER()`. This is useful for user-facing search features where you want to match regardless of capitalization: `SELECT * FROM messages WHERE content ILIKE '%error%'`.

PostgreSQL lets you control where `NULL` values appear in sorted results using `NULLS FIRST` or `NULLS LAST`. By default, `NULL` values sort as if larger than any other value. Use `ORDER BY ended_at NULLS LAST` to keep incomplete conversations at the end, or `ORDER BY completed_at NULLS FIRST` to show unprocessed tasks first.

The `COALESCE` function returns the first non-null value from its arguments. Use it to provide default values in query results (`COALESCE(title, 'Untitled')`) or to handle nullable columns in expressions.

## Query JSONB data

PostgreSQL's JSONB type stores structured data that doesn't fit a fixed schema. AI applications commonly use JSONB for metadata, configuration, model parameters, and variable response structures. PostgreSQL provides specialized operators for extracting values, checking structure, and filtering based on JSON content.

Use `->` to extract a JSON element as JSON, or `->>` to extract it as text (for comparisons and display). For nested paths, use `#>` (returns JSON) or `#>>` (returns text). For example, `metadata->>'status'` extracts the status field as text, while `checkpoint_data#>>'{results,0,score}'` navigates a nested path to get a specific value.

Existence and containment operators enable efficient filtering. The `?` operator checks for key existence (`WHERE metadata ? 'priority'`), while `@>` tests containment (`WHERE checkpoint_data @> '{"status": "completed"}'`). These operators can use GIN indexes for efficient filtering on large tables.

When JSONB columns contain arrays, use `jsonb_array_elements` to expand them for filtering or aggregation:

```sql
-- Find conversations tagged with 'support'
SELECT DISTINCT c.*
FROM conversations c,
     jsonb_array_elements_text(c.metadata->'tags') AS tag
WHERE tag = 'support';
```

## Efficient pagination with keyset pagination

Traditional `OFFSET`-based pagination becomes slow on large tables because PostgreSQL must scan and discard all skipped rows. Page 1,000 with 20 rows per page requires scanning 20,000 rows and discarding 19,980. Keyset pagination (also called cursor-based pagination) uses `WHERE` clauses to skip rows, which performs consistently regardless of how deep you paginate.

Instead of tracking page numbers, track the last value you saw and filter from there. This approach requires a unique, sortable column (or combination of columns):

```sql
-- First page: get the 20 most recent messages
SELECT id, conversation_id, content, created_at
FROM messages
ORDER BY created_at DESC, id DESC
LIMIT 20;

-- Next page: filter by the last seen timestamp and id
SELECT id, conversation_id, content, created_at
FROM messages
WHERE (created_at, id) < ('2024-06-15 10:30:00', 12345)
ORDER BY created_at DESC, id DESC
LIMIT 20;
```

Including `id` in both the `ORDER BY` and `WHERE` clauses handles ties when multiple rows have the same timestamp. Your application stores the last row's sort values and passes them to the next query. For ascending order, change `<` to `>` and `DESC` to `ASC`.

## Common Table Expressions (CTEs)

CTEs define named temporary result sets that exist only during the execution of a query. They improve readability by letting you build complex queries step by step, and they enable recursive queries for hierarchical data.

Use CTEs to break complex queries into logical steps. Each CTE can reference previously defined CTEs, creating a pipeline of transformations:

```sql
WITH recent_conversations AS (
    SELECT id, user_id, started_at
    FROM conversations
    WHERE started_at > CURRENT_DATE - INTERVAL '7 days'
),
message_stats AS (
    SELECT conversation_id, COUNT(*) AS message_count, MAX(created_at) AS last_message_at
    FROM messages
    GROUP BY conversation_id
)
SELECT rc.user_id, rc.started_at, COALESCE(ms.message_count, 0) AS message_count
FROM recent_conversations rc
LEFT JOIN message_stats ms ON rc.id = ms.conversation_id;
```

Recursive CTEs query tree structures like task hierarchies, organizational charts, or threaded conversations. They consist of a base case (anchor) and a recursive case that references the CTE itself. Always include a depth limit or other termination condition to prevent infinite loops if your data contains cycles:

```sql
WITH RECURSIVE task_tree AS (
    -- Base case: start with the parent task
    SELECT id, parent_id, title, 1 AS depth
    FROM tasks WHERE id = 1
    UNION ALL
    -- Recursive case: find children of current level
    SELECT t.id, t.parent_id, t.title, tt.depth + 1
    FROM tasks t
    INNER JOIN task_tree tt ON t.parent_id = tt.id
    WHERE tt.depth < 10
)
SELECT * FROM task_tree ORDER BY depth, id;
```

AI applications often need to retrieve conversation threads where messages reference parent messages:

```sql
WITH RECURSIVE thread AS (
    -- Start with the root message
    SELECT id, parent_id, content, role, 0 AS depth
    FROM messages
    WHERE id = :root_message_id

    UNION ALL

    -- Get all replies
    SELECT m.id, m.parent_id, m.content, m.role, t.depth + 1
    FROM messages m
    INNER JOIN thread t ON m.parent_id = t.id
    WHERE t.depth < 50
)
SELECT * FROM thread ORDER BY depth, id;
```

## INSERT with RETURNING

PostgreSQL's `RETURNING` clause retrieves values from inserted, updated, or deleted rows in a single round trip. This is essential for getting autogenerated IDs, timestamps, or computed defaults without a separate query.

```sql
-- Get the generated ID after inserting a conversation
INSERT INTO conversations (user_id, session_id)
VALUES ('user123', 'sess_abc')
RETURNING id;

-- Get multiple generated values
INSERT INTO messages (conversation_id, role, content)
VALUES (1, 'user', 'Hello')
RETURNING id, created_at;

-- Use RETURNING with UPDATE
UPDATE tasks SET status = 'completed', completed_at = CURRENT_TIMESTAMP
WHERE id = 5
RETURNING id, status, completed_at;
```

## Upserts with ON CONFLICT

The `INSERT ... ON CONFLICT` clause handles unique constraint violations, enabling "upsert" operations that insert new rows or update existing ones. This pattern is valuable for idempotent operations and state management in AI applications.

When a conflict occurs on a unique constraint, you can update the existing row with new values using `DO UPDATE`. The `EXCLUDED` pseudo-table references the values that would have been inserted:

```sql
INSERT INTO user_preferences (user_id, preference_key, preference_value)
VALUES ('user123', 'theme', 'dark')
ON CONFLICT (user_id, preference_key)
DO UPDATE SET
    preference_value = EXCLUDED.preference_value,
    updated_at = CURRENT_TIMESTAMP;
```

Use `DO NOTHING` to silently skip rows that would violate constraints: `INSERT INTO tags (name) VALUES ('important') ON CONFLICT (name) DO NOTHING`.

You can add a `WHERE` clause to `DO UPDATE` for conditional logic, updating only when the new value differs from the existing one. Combine `ON CONFLICT` with `RETURNING` to know whether a row was inserted or updated—the expression `(xmax = 0)` returns `true` for newly inserted rows and `false` for updated rows.

## Practical patterns for AI applications

These patterns combine the features covered earlier into solutions for common AI application requirements. The following query retrieves conversation history with metadata for context building:

```sql
WITH conversation_context AS (
    SELECT c.id, c.session_id, c.metadata->>'model' AS model
    FROM conversations c
    WHERE c.session_id = :session_id AND c.ended_at IS NULL
)
SELECT cc.session_id, cc.model, m.role, m.content, m.created_at
FROM conversation_context cc
INNER JOIN messages m ON cc.id = m.conversation_id
ORDER BY m.created_at
LIMIT 50;
```

The following example shows recording task checkpoints with state management using upsert:

```sql
INSERT INTO task_checkpoints (task_id, step_number, checkpoint_data)
VALUES (:task_id, :step_number, :checkpoint_json::jsonb)
ON CONFLICT (task_id, step_number)
DO UPDATE SET checkpoint_data = EXCLUDED.checkpoint_data, updated_at = CURRENT_TIMESTAMP
RETURNING id, created_at, (xmax = 0) AS is_new;
```

The following example shows a paginated search with JSONB filters:

```sql
SELECT c.id, c.session_id, c.started_at, c.metadata->>'status' AS status
FROM conversations c
WHERE c.user_id = :user_id
  AND c.metadata @> :filter_json::jsonb
  AND (c.started_at, c.id) < (:last_started_at, :last_id)
ORDER BY c.started_at DESC, c.id DESC
LIMIT 20;
```

## Additional resources

- [PostgreSQL JSON functions and operators](https://www.postgresql.org/docs/current/functions-json.html)
- [PostgreSQL INSERT documentation](https://www.postgresql.org/docs/current/sql-insert.html)
- [PostgreSQL WITH queries (CTEs)](https://www.postgresql.org/docs/current/queries-with.html)
