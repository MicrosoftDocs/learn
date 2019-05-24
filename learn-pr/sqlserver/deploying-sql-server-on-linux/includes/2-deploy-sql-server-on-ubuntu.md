Your company uses exclusively Linux servers, but you want to benefit from the functionality of SQL Server. Some of your servers run the Ubuntu distribution of Linux and you want to learn how to deploy SQL Server to Ubuntu to get the benefits of SQL Server while remaining on Linux.

## Hardware and software requirements

To install SQL Server 2017 on Ubuntu it must meet the following requirements:

- Ubuntu 16.04. Later versions are likely to be supported, but are not fully tested at time of writing.
- At least 2GB of memory.
- XFS or EXT4 file system.
- 6GB of disk space.
- x64 processor with two or more cores and a speed of at least 2 GHz.

## Install SQL Server on Ubuntu

To install SQL Server on Ubuntu, follow these steps:

1. Install Curl.
1. Install the Microsoft repository GPG key.
1. Register the Microsoft SQL Server Ubuntu repository.
1. Install any necessary libraries.
1. Install SQL Server.

> [!NOTE]
> If you need to update SQL Server to the latest version, you can repeat the **apt-get update** and **apt-get install mssql-server** commands.

## Configure SQL Server on Ubuntu

Configure SQL Server by running the **/opt/mssql/bin/msssql-conf setup** command and specifying the edition of SQL Server that you require and the SQL Server system administrator (sa) password.

## Install SQL Server tools

Install SQL Server command line tools, use **apt-get install** to install **mssql-tools** and **unixODBC-devel**.
