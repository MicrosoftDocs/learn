SQL Server is also supported on Red Hat Enterprise Linux (RHEL) servers.

Your company uses exclusively Linux servers, but you want to benefit from the functionality of SQL Server. Some of your servers run the RHEL distribution of Linux. You want to learn how to deploy SQL Server to RHEL to get the benefits of SQL Server while remaining on Linux.

In the following exercise, you learn how to install and configure SQL Server on RHEL.

## Hardware and software requirements

If you want to install SQL Server 2019 on RHEL, the server must meet the following requirements:

- RHEL 7.7 - 7.9, or 8.0 - 8.6 Server
- At least 2 GB of memory
- XFS or EXT4 file system
- 6 GB of disk space
- x64 processor with two or more cores and a speed of at least 2 GHz

## Install SQL Server on Red Hat Enterprise Linux

To install SQL Server on RHEL, complete these tasks:

1. Download the Microsoft repository configuration file.
1. Use the `yum` command to install SQL Server.

> [!NOTE]
> If you need to update SQL Server to the latest version, use the `yum update mssql-server` command.

Complete these tasks in the next exercise.

## Configure SQL Server on RHEL

Configure SQL Server by running the `/opt/mssql/bin/msssql-conf setup` command. Specify the edition of SQL Server you require and the SQL Server system administrator (sa) password.

## Install SQL Server tools

To install SQL Server command-line tools, use `yum` to install `mssql-tools` and `unixODBC-devel`.

```bash
sudo yum install -y mssql-tools unixODBC-devel
```
