In this unit, you'll set up the development environment for the module. You'll also gain an understanding of the resulting project.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Set up development environment

Run the following command in the command shell. Be patient, as setup can take a few minutes to complete.

::: zone pivot="pg"

```bash
. <(wget -q -O - https://raw.githubusercontent.com/MicrosoftDocs/mslearn-aspnet-core/live/modules/persist-data-ef-core/setup/setup-pg.sh)
```

::: zone-end

::: zone pivot="sql"

```bash
. <(wget -q -O - https://raw.githubusercontent.com/MicrosoftDocs/mslearn-aspnet-core/live/modules/persist-data-ef-core/setup/setup-sql.sh)
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

The app, *ContosoPets.Ui*, is a user interface to product data stored and managed by the API.

<!-- TODO: Diagram depicting starter app architecture and discussion -->

Your team makes the following technical decisions:

* yada
* yada
* yada

## Review ASP.NET Core Identity architecture

<!-- TODO: Diagram depicting Identity architecture and discussion -->

## Verify database connectivity

Run the following command:

::: zone pivot="pg"

```bash
# psql command goes here
```

<!-- TODO: talk database stuff like with SQL -->

::: zone-end

::: zone pivot="sql"

```bash
db -Q "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' ORDER BY TABLE_NAME" -Y 25
```

The script created a `db` alias. The alias corresponds to `sqlcmd` with `-U` (username), `-P` (password), `-S` (server hostname), and `-d` (database name) options. [sqlcmd](https://docs.microsoft.com/sql/tools/sqlcmd-utility) is a cross-platform command-line tool for administering and querying SQL Server databases. The preceding command retrieves a list of tables from the Azure SQL Database that was created earlier.

As expected, the list is empty because there are no tables in the database's `dbo` schema.

```console
TABLE_NAME
-------------------------

(0 rows affected)
```

::: zone-end