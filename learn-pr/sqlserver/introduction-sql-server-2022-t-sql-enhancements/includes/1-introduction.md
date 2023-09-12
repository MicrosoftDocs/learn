---
ms.custom:
  - build-2023
---
SQL Server 2022 introduces a range of new features and enhancements, providing powerful tools and capabilities that optimize performance and offer better control on SQL object creation. This module explores some of the key T-SQL features included in the latest release, such as resumable constraints, low priority options, `SELECT WINDOW` functions, new `JSON` functions, and more. With these new features, database administrators and developers can better manage database operations, improve efficiency, and adapt to the evolving needs of modern data management.

In this module, we cover the following topics:

- **Resumable constraints**: Learn how to execute online operations for adding primary key and unique constraints to large tables, allowing for pausing, resuming, and recovering from failures.
- **Low priority options**: Discover how to manage lock contention during online index operations and minimize how they affect other queries and transactions.
- **SELECT WINDOW functions**: Understand how to perform advanced windowing and analytical tasks using the `WINDOWS` predicate of the `SELECT` statement.
- **IS DISTINCT FROM and IS NOT DISTINCT FROM**: Explore these operators that compare values, accounting for `NULL` values in a more concise and intuitive way.
- **New date and time functions**: Get familiar with `DATETRUNC`, `DATE_BUCKET`, and other functions that manipulate and analyze date and time data.
- **String and comparison functions**: Dive into `LTRIM`, `RTRIM`, `TRIM`, `STRING_SPLIT`, `GREATEST`, `LEAST`, and more to efficiently process and compare string data.
- **JSON functions**: Learn about `JSON_OBJECT`, `ISJSON`, `JSON_PATH_EXISTS`, and `JSON_ARRAY`, which enable powerful JSON data manipulation and querying capabilities.
- **Approximate percentile functions**: Understand how to use `APPROX_PERCENTILE_DISC` and `APPROX_PERCENTILE_CONT` for efficient percentile calculations.
- **Bit manipulation functions**: Explore `GET_BIT`, `BIT_COUNT`, `LEFT_SHIFT`, `RIGHT_SHIFT`, and `SET_BIT` for working with bit-level data.

## Learning objectives

Upon completing this module, you should be able to:

- Understand the new and enhanced T-SQL features in SQL Server 2022.
- Utilize new functions and capabilities to optimize database performance and maintainability.
- Adapt to the evolving needs of modern database administrators and developers.

## Prerequisites

- SQL Server 2022
- Basic working knowledge of SQL Server and query processing
- Fundamental knowledge of the Transact-SQL (T-SQL) language
- Familiarity with SQL Server functions and operators
