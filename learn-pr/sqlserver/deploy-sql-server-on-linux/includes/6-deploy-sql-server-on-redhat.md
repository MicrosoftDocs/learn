SQL Server is also supported on Red Hat Enterprise Linux (RHEL) servers.

Your company uses exclusively Linux servers, but you want to benefit from the functionality of SQL Server. Some of your servers run the RHEL distribution of Linux and you want to learn how to deploy SQL Server to RHEL to get the benefits of SQL Server while remaining on Linux.

Here, you will learn how to install and configure SQL Server on RHEL.

## Hardware and software requirements

If you want to install SQL Server 2017 on RHEL, the server must meet the following requirements:

- SLES v12 SP2. Later versions are likely to be supported, but are not fully tested at time of writing.
- At least 2 GB of memory.
- XFS or EXT4 file system.
- 6 GB of disk space.
- x64 processor with two or more cores and a speed of at least 2 GHz.

## Install SQL Server on Red Hat Enterprise Linux

To install SQL Server on RHEL, complete these tasks:

1. Download the Microsoft repository configuration file.
1. Use the `yum` command to install SQL Server.

> [!NOTE]
> If you need to update SQL Server to the latest version, you can use the **yum update mssql-server** command.

You'll complete these tasks in the next exercise.

## Configure SQL Server on RHEL

Configure SQL Server by running the **/opt/mssql/bin/msssql-conf setup** command and specifying the edition of SQL Server that you require and the SQL Server system administrator (sa) password.

## Install SQL Server tools

To install SQL Server command-line tools, use `yum` to install **mssql-tools** and **unixODBC-devel**.

```bash
sudo yum install -y mssql-tools unixODBC-devel
```
