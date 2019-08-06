In this unit, you'll set up the development environment for the module. You'll also gain an understanding of the resulting project.

ASP.NET Core Identity supports many data stores. This module focuses on just two of the possible data stores. Use the toggle above to select your preference.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Set up development environment

Run the following command in the command shell. The command reflects your data store choice in the toggle above. Be patient, as setup can take a few minutes to complete.

::: zone pivot="pg"

```bash
. <(wget -q -O - https://aka.ms/secure-aspnet-core-identity-setup) "pg"
```

::: zone-end

::: zone pivot="sql"

```bash
. <(wget -q -O - https://aka.ms/secure-aspnet-core-identity-setup) "sql"
```

::: zone-end

[!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

The preceding command retrieves and runs a setup script from a GitHub repository. The script completes the following steps:

* Clones the ASP.NET Core starter code from a GitHub repository.
* Builds and deploys an ASP.NET Core web API to supply the web app with data.
* Provisions a database to store Identity framework entities.
* Sets environment variables that are required for this module.
* Displays connection information for the Azure resources.
* Launches the Cloud Shell Editor to view the starter code.

## Review starter code

The app consists of a single ASP.NET Core Razor Pages project named *ContosoPets.Ui*. The project contains the user interface for viewing and managing product data. The product data is obtained via an external ASP.NET Core web API.

<!-- TODO: Diagram depicting starter app architecture and discussion -->

Your stakeholders have defined the following business requirements:

* There are three types of authenticated users for the system: employees and administrators.
* The identity solution must support logging in with two-factor authentication.
* Anonymous users can only view the product catalog.
* Administrators can modify products.

Your team makes the following technical decisions:

* The database tables supporting Identity should reside in an `auth` schema.
* Administrators will self-enroll using a single-use token.

<!-- TODO: add the database diagram showing existing tables -->

## Review ASP.NET Core Identity architecture

<!-- TODO: Diagram depicting Identity architecture and discussion -->

## Verify database connectivity

Run the following command:

::: zone pivot="pg"

```bash
db -c "SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema'"
```

The script created a `db` alias. The alias corresponds to `psql` with `--host` (server hostname), `--port` (port number), `--username`, and `--dbname` (database name) options. psql obtains the password from an environment variable named `PGPASSWORD`. [psql](http://postgresguide.com/utilities/psql.html) is a cross-platform command-line tool for administering and querying PostgreSQL databases. The preceding command retrieves a list of non-system tables from the PostgreSQL database that was created earlier.

As expected, the list is empty because the database only contains system tables.

```console
 tablename 
-----------
(0 rows)
```

::: zone-end

::: zone pivot="sql"

```bash
db -Q "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' ORDER BY TABLE_NAME" -Y 25
```

The script created a `db` alias. The alias corresponds to `sqlcmd` with `-U` (username), `-P` (password), `-S` (server hostname), and `-d` (database name) options. [sqlcmd](https://docs.microsoft.com/sql/tools/sqlcmd-utility) is a cross-platform command-line tool for administering and querying SQL Server databases. The preceding command retrieves a list of non-system tables from the Azure SQL Database that was created earlier.

As expected, the list is empty because there are no tables in the database's `dbo` schema.

```console
TABLE_NAME
-------------------------

(0 rows affected)
```

::: zone-end