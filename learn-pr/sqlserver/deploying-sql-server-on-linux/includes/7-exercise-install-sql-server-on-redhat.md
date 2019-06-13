On Red Hat Enterprise Linux (RHEL) servers, use the `yum` tool to install SQL Server. 

You are a database administrator at the wholesale company Wide World Importers and want to benefit from SQL Server without having to change the server operating systems. You have decided to deploy SQL Server on a Red Hat server and will configure the SQL Server package and install command-line tools so that SQL Server is ready to be used by your developers.

In this exercise, you will deploy SQL Server on Red Hat, install command-line tools, and create a database on SQL Server.

## Start the lab

Start by logging into the database server:

<!--TODO: This link must be corrected when we know where the lab is hosted.-->
1. Open a new web browser tab and navigate to https://labondemand.com/AuthenticatedLaunch/47218?providerId=4.
1. Sign with a Microsoft account, or create a new account.
1. To sign in, type **student**, and then press Enter.
1. Type **Pa55w.rd**, and then press Enter.

## Install the SQL Server package

Let's install SQL Server. Before using `yum` to install, you must add a configuration file:

1. To download the Microsoft SQL Server Red Hat repository configuration file, run this command:

    ```bash
    sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2017.repo
    ```

1. If you are asked for a password, type **Pa55w.rd**, and then press Enter.
1. To install SQL Server, run this command:

    ```bash
    sudo yum install -y mssql-server
    ```

## Configure SQL Server

Before you use SQL Server, use the `mssql-conf` script to specify the edition that you want and the system administrator password:

1. Run this command:

    ```bash
    sudo /opt/mssql/bin/mssql-conf setup
    ```

1. If prompted for your password, type **Pa55w.rd** and press Enter.
1. To select the Evaluation edition, type **1**, and then press Enter:
1. Type **Yes**, and then press Enter to accept the license terms.
1. Type **Pa55w.rd**, and then press Enter to set the system administrator password.
1. Type **Pa55w.rd**, and then press Enter to confirm the password.

## Install SQL Server tools

SQL Server is now installed. Now you can install command-line tools to work with SQL Server:

1. To download the Microsoft SQL Server tools repository configuration file, run this command:

    ```bash
    sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo
    ```

1. To install SQL Server command-line tools, run this command:

    ```bash
    sudo yum install -y mssql-tools unixODBC-devel
    ```

1. Type **yes**, and then press Enter to accept the ODBC license terms.
1. Type **yes**, and then and press Enter to accept the license terms.
1. To add the tools to the **PATH** environment variable, run these commands:

    ```bash
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    source ~/.bashrc
    ```

## Create a database

You can now use the **sqlcmd** tool to create a database:

1. Run this command to connect to SQL Server:

    ```bash
    sqlcmd -S localhost -U sa -P 'Pa55w.rd'
    ```

1. To create a database called **WideWorld1**, run these SQL commands:

    ```bash
    CREATE DATABASE WideWorld1
    GO
    ```

1. To verify that the database was created, run this SQL query:

    ```bash
    SELECT database_id, name FROM sys.databases WHERE name = 'WideWorld1'
    ```