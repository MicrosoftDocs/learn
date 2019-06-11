When an organization runs SQL Server on Windows servers, the principal administration tool is SQL Server Management Studio. This tool does not run on Linux. 

For the Wide World Importers database migration, you want to learn how a Linux administrator configures, queries, and maintains SQL Server. You know that Linux servers often do not run a graphical user interface and provide only a command-line shell.

Here, you will learn about the command-line tools that you can execute on Linux.

## Native Linux tools

SQL Server on Linux supports tools and methods that are familiar to Linux administrators. Software installation and upgrades are performed using **apt**, **zypper**, or **yum**, depending on the Linux distribution. **systemd** is used to control services and can start or stop the SQL Server service. You can use **Pacemaker** to set up highly available clusters of SQL Server instances and Linux POSIX file paths have support in both the graphical tools and Transact-SQL statements.

## SQL Server command-line tools

Microsoft provides a set of command-line tools that you can use to administer and develop databases on SQL Server on Linux:

- **mssql-cli** provides Transact-SQL IntelliSense syntax highlighting, formatted query results, and a multi-line edit mode.
- **mssql-conf** is a set of scripts that you run after installation, and at later times, to configure SQL Server on Linux. For example, you can use these scripts to enable SQL Server Agent, or set up a High Availability Group.
- **mssql-tools** is a package that contains **sqlcmd** and **bcp** commands, which perform the same functions as on Windows.

## Azure Data Studio

Azure Data Studio is a free, graphical, cross-platform SQL Server administration and development application for Linux, Windows, or Mac. You can run this tool on any Linux client or server that includes an X Windows graphical interface. The core functionality is limited, but it can be expanded by adding extensions created by Microsoft or third-party authors.
