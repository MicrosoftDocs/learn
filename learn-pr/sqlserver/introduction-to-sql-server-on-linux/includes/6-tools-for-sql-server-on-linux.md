When an organization runs SQL Server on Windows servers, the prinicpal administration tool is SQL Server Management Studio. Since you know that this desktop Windows application does not run on Linux, you want to learn about the tools a Linux administrator can use to administer SQL Server.

## SQL Server on Linux Tools

SQL Server on Linux supports tools and methods that are familiar to Linux administrators. Software installation and upgrades are performed using **apt**, **zypper**, or **yum**, depending on the Linux distribution. **systemd** is used to control services and can start or stop the SQL Server service. You can use **Pacemaker** to set up highly available clusters of SQL Server instances and Linux POSIX file paths have support in both the graphical tools and Transact-SQL statements.

Native command-line tools can be used to administer, and develop, on SQL Server on Linux:

- **mssql-cli** provides Transact-SQL IntelliSense syntax highlighting, formatted query results, and a Multi-line edit mode.
- **mssql-conf** is a set of scripts that help in setting up and configuring SQL Server on Linux. For example, you can use these scripts to enable SQL Server Agent, or set up a High Availability Group.
- **mssql-tools** is a package that contains **sqlcmd** and **bcp** commands, which perform the same functions as on Windows.

In addition, Azure Data Studio is a free, graphical, cross-platform SQL Server administration and development application for Linux, Windows, or Mac. The core functionality is limited, but it can be expanded by adding extensions created by Microsoft or third-party authors.
