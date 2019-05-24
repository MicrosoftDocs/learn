Your company uses exclusively Linux servers, but you want to benefit from the functionality of SQL Server. Some of your servers run the Red Hat Enterprise Linux (RHEL) distribution of Linux and you want to learn how to deploy SQL Server to RHEL to get the benefits of SQL Server while remaining on Linux.

## Hardware and software requirements

To install SQL Server 2017 on Red Hat Enterprise Linux it must meet the following requirements:

- SLES v12 SP2. Later versions are likely to be supported, but are not fully tested at time of writing.
- At least 2GB of memory.
- XFS or EXT4 file system.
- 6GB of disk space.
- x64 processor with two or more cores and a speed of at least 2 GHz.

## Install SQL Server on Red Hat Enterprise Linux

To install SQL Server on RHEL, follow these steps:

1. Download the Microsoft repository configuration file.
1. Install SQL Server.

## Configure SQL Server on RHEL

Configure SQL Server by running the **/opt/mssql/bin/msssql-conf setup** command and specifying the edition of SQL Server that you require and the SQL Server system administrator (sa) password.

## Install SQL Server tools

To install SQL Server command line tools, use yum to install **mssql-tools** and **unixODBC-devel**.
