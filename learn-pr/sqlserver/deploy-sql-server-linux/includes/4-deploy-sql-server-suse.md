SUSE is another good choice of operating system for hosting SQL Servers.

Wide World Importers uses exclusively Linux servers, but you want to benefit from the functionality of SQL Server. Some of your servers run the SUSE distribution of Linux. You want to learn how to deploy SQL Server to SUSE to get the benefits of SQL Server while remaining on Linux.

In the following exercise, you learn about the requirements and installation procedure.

## Hardware and software requirements

To install SQL Server 2019 on SUSE, you must meet the following requirements:

* SLES v12 (SP2, SP3, SP4, or SP5) or v15 (SP1, SP2, or SP3)
* At least 2 GB of memory
* XFS or EXT4 file system
* 6 GB of disk space
* x64 processor with two or more cores and a speed of at least 2 GHz

## Install SQL Server on SUSE

To install SQL Server on SUSE, complete these tasks:

1. Download the Microsoft repository configuration file.
1. Refresh your repositories.
1. Install SQL Server.

> [!NOTE]
> If you need to update SQL Server to the latest version, you can use the `zypper update -t mssql-server` command.

Complete these tasks in the next exercise.

## Configure SQL Server on SUSE

Configure SQL Server by running the `/opt/mssql/bin/msssql-conf setup` command and specifying the edition of SQL Server that you require, and the SQL Server system administrator (sa) password.

## Install SQL Server tools

To install SQL Server command-line tools, use `zypper` to install the `mssql-tools` and `unixODBC-devel` packages:

```bash
sudo zypper install -y mssql-tools unixODBC-devel
```
