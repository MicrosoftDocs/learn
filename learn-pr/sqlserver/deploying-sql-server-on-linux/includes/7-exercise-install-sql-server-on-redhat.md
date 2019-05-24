You are a database administrator at the wholesale company WorldWide Importers and want to benefit from SQL Server without having to change the server operating systems. You have decided to deploy SQL Server on a Red Hat server and will configure the SQL Server package and install command line tools so that SQL Server is ready to be used by your developers.

In this exercise, you will deploy SQL Server on Red Hat, install command-line tools, and create a database on SQL Server.

## Start the lab

Start by logging into the database server:

SQL Server needs to be installed and then configured. The first task is installation.

<!--TODO: This link must be corrected when we know where the lab is hosted.-->
1. Open a new web browser tab and navigate to https://labondemand.com/AuthenticatedLaunch/47218?providerId=4.
1. Sign with a Microsoft account, or create a new account.
1. To log on, type **student**, and then press Enter.
1. Type **Pa55w.rd**, and then press Enter.

## Install the SQL Server package

SQL Server needs to be installed and then configured. The first task is installation.

1. To download the Microsoft SQL Server Red Hat repository configuration file, type the following command, and then press Enter:

    ```bash
    sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2017.repo
    ```

1. If requested for a password, type **Pa55w.rd** and press Enter.
1. To install SQL Server, type the following command, and then press Enter:

    ```bash
    sudo yum install -y mssql-server
    ```

## Configure SQL Server

Before you use SQL Server, you must specify the edition that you want and specify the system administrator password.

1. Type the following command, and then press Enter:

    ```bash
    sudo /opt/mssql/bin/mssql-conf setup
    ```

1. If prompted for your password, type **Pa55w.rd** and press Enter.
1. To select the Evaluation edition, type **1**, and then press Enter:
1. Type **Yes** and press Enter to accept the license terms.
1. Type **Pa55w.rd** and press Enter to set the system administrator password.
1. Type **Pa55w.rd** and press Enter to confirm the password.

## Install SQL Server tools

SQL Server is now installed, but you will now install tools to work with SQL Server.

1. To download the Microsoft SQL Server tools repository configuration file, type the following command, and then press Enter:

    ```bash
    sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo
    ```

1. To install SQL Server command-line tools, type the following command, and then press Enter:

    ```bash
    sudo yum install -y mssql-tools unixODBC-devel
    ```

1. Type **yes** and press Enter to accept the ODBC license terms.
1. Type **yes** and press Enter to accept the license terms.
1. To add the tools to the **PATH** environment variable, type the following command, and then press Enter:

    ```bash
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    source ~/.bashrc
    ```

## Create a database

You can now use the **sqlcmd** tool to create a database:

1. Type the following command, and then press Enter to connect to SQL Server:

    ```bash
    sqlcmd -S localhost -U sa -P 'Pa55w.rd'
    ```

1. Type the following command, and then and press Enter:

    ```bash
    CREATE DATABASE Worldwide1
    ```

1. To run the previous command, type the following command, and then and press Enter:

    ```bash
    GO
    ```

1. To verify that the database was created, type the following command, and then and press Enter:

    ```bash
    SELECT database_id, name FROM sys.databases WHERE name = 'Worldwide1'
    ```

1. Close the web browser tab.