Copilot can generate a working stored procedure in seconds, and it often looks correct and runs cleanly in development. But how quickly a script is generated tells you nothing about whether it's safe to deploy. Every Copilot-generated script needs to pass the same standards check you'd apply to any script written by a team member or an outside vendor. You, not Copilot, are signing off on it before it reaches production.

## The DBA validation gate

Copilot output is a first draft. It's a fast, useful first draft, but it isn't production-ready by default. Apply the same review you'd give any script submitted by a team member or an external vendor:

- **Does it run correctly against the actual schema?** Incorrect object references are rare but possible. Table names, column names, and data types should match your actual objects. Run every generated script in a nonproduction environment first.
- **Does it apply least-privilege?** Copilot may generate `GRANT CONTROL` or `GRANT ALTER` when `GRANT EXECUTE` is sufficient. Check every permission statement before you accept it.
- **Does it follow your naming conventions?** Prefixes, schemas, and casing matter for maintainability. Copilot adapts to your current editor context, but naming can drift, especially in larger scripts.
- **Does it have a performance baseline?** For any query or procedure that runs in production, capture execution metrics in development before you deploy.

This gate isn't a critique of Copilot. It's the same discipline you apply to any code change. The speed advantage of Copilot comes from how quickly it gets you to the gate, not from skipping it.

## Least-privilege check

Permission grants are the most common place where Copilot over-provisions. When Copilot doesn't have full context about your access model, it tends to grant at the broadest scope that satisfies the stated requirement.

Consider a scenario where Copilot generates a stored procedure that a monitoring service account calls to collect database health metrics. Copilot includes a permission grant to the monitoring service account:

```sql
-- Copilot-generated (too broad):
GRANT EXECUTE ON SCHEMA::dbo TO MonitoringServiceAccount;
```

Before you read on, decide for yourself: what's the smallest permission that still lets the monitoring account collect its metrics? Name the scope you'd grant instead, then compare it to the correction below.

That grant gives `MonitoringServiceAccount` execute permission on every procedure in the `dbo` schema, including procedures it should never touch. The correct form grants execute on the specific object:

```sql
-- Corrected (least-privilege):
GRANT EXECUTE ON OBJECT::dbo.usp_CollectHealthMetrics TO MonitoringServiceAccount;
```

Apply the smallest scope that satisfies the requirement. Grant on the object, not the schema, unless schema-level access is explicitly required and documented. The same principle applies to database roles. Don't add a service account to `db_owner` when `db_executor` or a custom role covers the actual need.

## Performance baseline comparison

Copilot doesn't know your data distribution or your workload characteristics. An index suggestion that looks optimal on a 10,000-row development table may behave differently against 200 million rows in production with skewed key values. Always capture a baseline before you deploy.

For any Copilot-generated query or stored procedure:

1. Run the query in nonproduction with `SET STATISTICS IO ON; SET STATISTICS TIME ON;` enabled.
2. Record the logical reads, CPU time, and elapsed time.
3. Compare against your existing baseline if you're replacing a known query.
4. If no baseline exists, this run becomes your baseline. Document it in your change record.

> [!TIP]
> For any Copilot-generated index recommendation, test the index against your real production data distribution in a nonproduction copy before you apply it. Estimated impact shown by DMVs like `sys.dm_db_missing_index_details` is based on cached plan statistics, not a simulation of your full workload.

When you review execution plans for Copilot-generated queries, look for table scans, implicit type conversions in predicates, and parameter sniffing behavior if the query uses parameters. Copilot can't see your statistics, but you can.

## Security review

Check every Copilot-generated script for these security risks before it moves to production:

1. **No hardcoded credentials or connection strings.** Copilot sometimes includes placeholder connection strings in generated scripts. Those placeholders can be committed to source control accidentally. If you see a connection string in generated output, remove it before saving.

2. **No unparameterized dynamic SQL.** If Copilot generates `EXEC ('SELECT * FROM ' + @tableName)`, flag it for SQL injection risk. The correct pattern uses [`sp_executesql`](/sql/relational-databases/system-stored-procedures/sp-executesql-transact-sql?azure-portal=true) with a parameterized statement. Dynamic SQL is sometimes necessary, but it must always be parameterized.

3. **No `NOLOCK` hints on write-sensitive tables.** Copilot occasionally adds `WITH (NOLOCK)` to improve query performance. Before you accept that hint, verify that dirty reads are acceptable for the specific query. `NOLOCK` on financial or audit data is rarely appropriate.

4. **No [`xp_cmdshell`](/sql/database-engine/configure-windows/xp-cmdshell-server-configuration-option?azure-portal=true) usage.** Copilot shouldn't generate `xp_cmdshell` calls for DBA tasks. If it does, reject the output and reframe your prompt to use PowerShell or Azure CLI as the execution surface instead.

> [!IMPORTANT]
> Never apply a Copilot-generated script to production without reviewing it line by line. The review takes two minutes; a production incident takes two days.

## What to never accept blindly

Some Copilot outputs require extra scrutiny regardless of how confident the suggestion appears:

- `DROP` or `TRUNCATE` statements in any context. Confirm the intent and scope explicitly.
- Permission grants broader than the stated requirement. Always narrow to the minimum scope.
- Changes to database-level or server-level configuration settings such as `MAXDOP`, `cost threshold for parallelism`, or `max degree of parallelism`. These settings affect the entire workload.
- Scripts that touch `msdb` system tables directly. Prefer the documented system stored procedures (`sp_add_job`, `sp_add_schedule`, and so on) rather than direct table modifications.
- Suggestions to disable or modify Transparent Data Encryption, Azure SQL Auditing, or Microsoft Defender for SQL policies. These changes require a formal security change process, not a quick script.

When you see any of these in Copilot output, pause and verify the intent before proceeding.

In the next unit, you apply this validation gate in a hands-on exercise: a slow stored procedure, a Copilot-generated fix, and the full review cycle before production deployment.
