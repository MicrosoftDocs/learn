Your company uses exclusively Linux servers, but you want to benefit from the functionality of SQL Server. Some of your servers run the SUSE distribution of Linux and you want to learn how to deploy SQL Server to SUSE to get the benefits of SQL Server while remaining on Linux.

## Hardware and software requirements

To install SQL Server 2017 on Ubuntu it must meet the following requirements:

* SLES v12 SP2. Later versions are likely to be supported, but are not fully tested at time of writing.
* At least 2GB of memory.
* XFS or EXT4 file system.
* 6GB of disk space.
* x64 processor with two or more cores and a speed of at least 2 GHz.

## Install SQL Server on SUSE

To install SQL Server on SUSE, follow these steps:

1. Download the Microsoft repository configuration file.
1. Refresh your repositories.
1. Install SQL Server.

> [!NOTE]
> If you need to update SQL Server to the latest version, you can repeat the **apt-get update** and **apt-get install mssql-server** commands.

## Configure SQL Server on SUSE

Configure SQL Server by running the **/opt/mssql/bin/msssql-conf setup** command and specifying the edition of SQL Server that you require and the SQL Server system administrator (sa) password.

## Install SQL Server tools

To install SQL Server command line tools, use **zypper** to install **mssql-tools** and **unixODBC-devel**.