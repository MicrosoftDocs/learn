---
ms.custom:
  - build-2023
---
In this module, you explored the new features and enhancements introduced in SQL Server 2022, learning how they optimize performance and offer better control on SQL object creation. You gained insights into the powerful T-SQL capabilities, such as resumable constraints, low priority options, `SELECT WINDOW` predicate, and more, which help database administrators and developers better manage database operations, improve efficiency, and adapt to the evolving needs of modern data management.

In this module, you learned about the following areas:

- **Resumable constraints**: You explored how to execute online operations for adding primary key and unique constraints to large tables, allowing for pausing, resuming, and recovering from failures.
- **Low priority options**: You discovered how to manage lock contention during create index online operations and minimize their load on other queries and transactions.
- **SELECT WINDOW functions**: You gained an understanding of how to perform advanced windowing and analytical tasks using the `WINDOWS` predicate of the `SELECT` statement.
- **IS DISTINCT FROM and IS NOT DISTINCT FROM**: You learned about these operators that compare values, accounting for `NULL` values in a more concise and intuitive way.
- **New date and time functions**: You became familiar with `DATETRUNC`, `DATE_BUCKET`, and other functions that manipulate and analyze date and time data.
- **String and comparison functions**: You dove into `LTRIM`, `RTRIM`, `TRIM`, `STRING_SPLIT`, `GREATEST`, `LEAST`, and more to efficiently process and compare string data.
- **JSON functions**: You learned about `JSON_OBJECT`, `ISJSON`, `JSON_PATH_EXISTS`, and `JSON_ARRAY`, which enable powerful JSON data manipulation and querying capabilities.
- **Approximate percentile functions**: You understood how to use `APPROX_PERCENTILE_DISC` and `APPROX_PERCENTILE_CONT` for efficient percentile calculations.
- **Bit manipulation functions**: You explored `GET_BIT`, `BIT_COUNT`, `LEFT_SHIFT`, `RIGHT_SHIFT`, and `SET_BIT` for working with bit-level data.

## Learn more

Use the following resource to learn more about SQL Server 2022:

- [What's new in SQL Server 2022 - Language](/sql/sql-server/what-s-new-in-sql-server-2022#language)
