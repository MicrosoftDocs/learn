When an organization runs SQL Server on Windows servers, the principal administration tool is SQL Server Management Studio (SSMS). This tool doesn't run on Linux, although you can connect it to a Linux SQL Server from a Windows computer.

For the Wide World Importers database migration, you want to learn how a Linux administrator configures, queries, and maintains SQL Server. Your Linux servers don't run graphical user interfaces (GUIs) and provide only a command-line shell, but you also have Linux laptops with GUIs. You want to find out about tools you can use to administer SQL Server, both from the command line and from the Linux laptops.

Here, you learn about the administration tools you can execute on Linux.

## Native Linux tools

Database administrators use many native Linux tools with which you're already familiar from other administration tasks.

Software installation and upgrades are done using **apt**, **zypper**, or **yum**, depending on the Linux distribution.

After SQL Server is installed, it runs as a Linux service, so you can use **systemd** to start, stop, or restart the database server. Also, it means that if you want to set up highly available clusters of SQL Server instances, you can use **Pacemaker** to do it.

> [!NOTE]  
> Linux POSIX file paths have support in both the graphical tools and Transact-SQL statements. <!-- this seems in the wrong place -->

## SQL Server administration tools

For database tasks such as configuration, schema creation, data population, and user management, you use tools that are written specifically to work with SQL Server.

If you have a Windows computer with SSMS installed on it, you can connect it to SQL Servers that run on Linux and administer them as you would any other SQL Server. Administrators in mixed Windows and Linux environments might prefer to work this way.

If you want to administer SQL Server from a Linux computer, then your choice of tool depends on whether you're running a GUI.

### Azure Data Studio

Azure Data Studio is a free, graphical, cross-platform SQL Server administration and development application that runs on Linux, Windows, or Mac. You can run this tool on any Linux client or server that includes an X Windows GUI. The core functionality is limited, but you can expand it by adding extensions created by Microsoft or third-party authors.

> [!NOTE]  
> Azure Data Studio is powerful and flexible, but doesn't include some of the advanced features found in SSMS. For example, the Data Discovery and Classification tool and the Vulnerability Assessment tool, which you learned about in the last unit, are only available in SSMS.

## SQL Server command-line tools

Microsoft provides a set of command-line tools you can use to administer and develop databases on SQL Server on Linux. You can use these command-line tools on any Linux machine, even machines without a GUI:

- **mssql-cli** provides Transact-SQL IntelliSense syntax highlighting, formatted query results, and a multi-line edit mode.

- **mssql-conf** is a set of scripts that you run after installation, and later, to configure SQL Server on Linux. For example, you use these scripts to enable SQL Server Agent, or set up a High Availability Group.

- **mssql-tools** is a package that contains the `sqlcmd` and `bcp` commands, which have the same functions as on Windows.
