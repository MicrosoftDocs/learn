SUSE is another good choice of OS for hosting SQL Servers.

Wide World Importers uses exclusively Linux servers, but you want to benefit from the functionality of SQL Server. Some of your servers run the SUSE distribution of Linux and you want to learn how to deploy SQL Server to SUSE to get the benefits of SQL Server while remaining on Linux.

Here, you will learn about the requirements and installation procedure.

## Hardware and software requirements

To install SQL Server 2017 on SUSE, you must meet the following requirements:

* SLES v12 SP2. Later versions are likely to be supported, but are not fully tested at time of writing.
* At least 2 GB of memory.
* XFS or EXT4 file system.
* 6 GB of disk space.
* x64 processor with two or more cores and a speed of at least 2 GHz.

## Install SQL Server on SUSE

To install SQL Server on SUSE, complete these tasks:

1. Download the Microsoft repository configuration file.
1. Refresh your repositories.
1. Install SQL Server.

> [!NOTE]
> If you need to update SQL Server to the latest version, you can use the `zypper update -t mssql-server` command.

You'll complete these tasks in the next exercise.

## Configure SQL Server on SUSE

Configure SQL Server by running the `/opt/mssql/bin/msssql-conf setup` command and specifying the edition of SQL Server that you require and the SQL Server system administrator (sa) password.

## Install SQL Server tools

To install SQL Server command-line tools, use **zypper** to install the **mssql-tools** and **unixODBC-devel** packages:

```bash
sudo zypper install -y mssql-tools unixODBC-devel
```