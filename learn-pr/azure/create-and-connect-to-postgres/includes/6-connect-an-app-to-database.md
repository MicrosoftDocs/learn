Azure Database for PostgreSQL supports many different libraries and drivers that developers can use to develop applications. Most popular programming languages have libraries to connect and develop PostgreSQL databases.

Most language client libraries used to connect to PostgreSQL server are external projects and are distributed independently. The libraries listed below are supported on the Windows, Linux, and Mac platforms.

*Talking point: Developing with postgres*

::: zone pivot="csharp"
Npgsql is an open-source ADO.NET Data Provider for PostgreSQL, it allows programs written in C#, Visual Basic, F# to access the PostgreSQL database server. It is implemented in 100% C# code, is free and is open source.

Also, providers have been written for Entity Framework Core and for Entity Framework 6.x.
::: zone-end
::: zone pivot="java"
JDBC is a Type 4 JDBC driver. The PostgreSQL JDBC Driver (PgJDBC for short) allows Java programs to connect to a PostgreSQL database using standard, database independent Java code. Is an open-source JDBC driver written in Pure Java (Type 4), and communicates in the PostgreSQL native network protocol.
::: zone-end
::: zone pivot="node"
node-postgres is a Pure JavaScript non-blocking client and available as an npm package.

Features

* Pure JavaScript client and native libpq bindings share the same API
* Connection pooling
* Extensible JS ↔ PostgreSQL data-type coercion
* Supported PostgreSQL features
* Parameterized queries
* Named statements with query plan caching
* Async notifications with LISTEN/NOTIFY
* Bulk import & export with COPY TO/COPY FROM

::: zone-end
::: zone pivot="python"
Psycopg is the most popular PostgreSQL database adapter for the Python programming language. Its main features are the complete implementation of the Python DB API 2.0 specification and the thread safety (several threads can share the same connection). Psycopg is designed for heavily multi-threaded applications that create and destroy lots of cursors and make a large number of concurrent INSERTs or UPDATEs.

Psycopg 2 is mostly implemented in C as a libpq wrapper, resulting in being both efficient and secure. It features client-side and server-side cursors, asynchronous communication and notifications, COPY support. Many Python types are supported out-of-the-box and adapted to matching PostgreSQL data types. Adaptation can be extended and customized thanks to a flexible objects adaptation system.

Psycopg 2 is both Unicode and Python 3 friendly.
::: zone-end
::: zone pivot="ruby"
Pg is the Ruby interface to the PostgreSQL RDBMS. It works with PostgreSQL 9.2 and later.

::: zone-end
::: zone pivot="go"
Package pq is a pure Go Postgres driver for the database/sql package.

In most cases, clients will use the database/sql package instead of using this package directly.
::: zone-end
::: zone pivot="php"
php-pgsql is a database extension for php. To use PostgreSQL support, you need PostgreSQL 6.5 or later, PostgreSQL 8.0 or later to enable all PostgreSQL module features.
::: zone-end
::: zone pivot="odbc"
psqlODBC is the official PostgreSQL ODBC Driver. It is released under the Library General Public License, or LGPL.

The driver is currently maintained by a number of contributors to the PostgreSQL project.
::: zone-end
::: zone pivot="c"
libpq is the C application programmer's interface to PostgreSQL. libpq is a set of library functions that allow client programs to pass queries to the PostgreSQL backend server and to receive the results of these queries.
::: zone-end
::: zone pivot="cplus"
libpqxx is the official C++ client API for PostgreSQL, the enterprise-strength open-source relational database.

This library works on top of the C-level API library, libpq. It comes with postgres. You'll link your program with both libpqxx and libpq in that order.
::: zone-end