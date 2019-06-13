It's easy to install SQL Server on SUSE by using the `zypper` tool.

You are a database administrator at the wholesale company Wide World Importers. You want to benefit from SQL Server without having to change the server operating systems. You have decided to deploy SQL Server on a SUSE server and will configure the SQL Server package and install command-line tools so that SQL Server is ready to be used by your developers.

In this exercise, you will see how to deploy SQL Server on SUSE, install command-line tools, and create a database on SQL Server.

## Start the lab

Start by logging into the SUSE server:

<!--YAML added to connect to https://labondemand.com/AuthenticatedLaunch/47218?providerId=4 -->
1. Sign into the VM with a Microsoft account, or create a new account.
1. Click **Commands**, click **CTRL+ALT+DEL**, and then login with the username **student**, and the password **Pa55w.rd**.
1. Close the Server Manager window.

## Install the SQL Server package

Let's install and configure SQL Server. The first task is installation:

1. To download the Microsoft SLES repository configuration file, run this command:

    ```bash
    sudo zypper addrepo -fc https://packages.microsoft.com/config/sles/12/mssql-server-2017.repo
    ```

1. If asked for a password, type your password, and then press Enter.
1. To register the Microsoft SQL Server Ubuntu repository, run this command:

    ```bash
    sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
    ```

1. To refresh your repositories, run this command:

    ```bash
    sudo zypper --gpg-auto-import-keys refresh
    ```

1. To install SQL Server, run this command:

    ```bash
    sudo zypper install mssql-server
    ```

1. Type **2** to continue with the install. A later version of OpenSSL is already installed.

## Configure SQL Server

Before you use SQL Server, you must specify the edition that you want and specify the system administrator password:

1. Type the following command and then press Enter:

    ```bash
    sudo /opt/mssql/bin/mssql-conf setup
    ```

1. If prompted, type your password, and then press Enter.
1. To select the Evaluation edition, press **1**, and then press Enter.
1. Type **Yes** and press Enter to accept the license terms.
1. Type type your password and press Enter to set the system administrator password.
1. Type type your password and press Enter to confirm the password.

## Install SQL Server tools

SQL Server is now installed. Let's install the administrative tools:

1. To add the Microsoft SQL Server tools repository to **zypper**, run this command:

    ```bash
    sudo zypper addrepo -fc https://packages.microsoft.com/config/sles/12/prod.repo
    sudo zypper --gpg-auto-import-keys refresh
    ```

1. To install SQL Server command-line tools, run this command:

    ```bash
    sudo zypper install -y mssql-tools unixODBC-devel
    ```

1. Type **yes** and press Enter to accept the ODBC license terms.
1. Type **yes** and press Enter to accept the license terms.
1. To add the tools to the **PATH** environment variable, run this command:

    ```bash
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    source ~/.bashrc
    ```

### Create a database

Now, you can use the newly installed **sqlcmd** tool to create a database. Follow these steps:

1. Type the following command and press Enter to connect to SQL Server:

    ```bash
    sqlcmd -S localhost -U sa -P '[type your password here]'
    ```

1. To create a database, type the following command, and then press Enter:

    ```bash
    CREATE DATABASE WideWorld1
    ```

1. To run the previous command, type the following command, and then press Enter:

    ```bash
    GO
    ```

1. To verify that the database was created, type the following command, and then press Enter:

    ```bash
    SELECT * FROM sys.databases WHERE name = 'WideWorld1'
    ```