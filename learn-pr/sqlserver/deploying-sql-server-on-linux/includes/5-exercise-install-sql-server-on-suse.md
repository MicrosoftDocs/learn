You are a database administrator at the wholesale company WorldWide Importers and want to benefit from SQL Server without having to change the server operating systems. You have decided to deploy SQL Server on a SUSE server and will configure the SQL Server package and install command line tools so that SQL Server is ready to be used by your developers.

In this tutorial, you will see how to deploy SQL Server on SUSE, install command-line tools, and create a database on SQL Server.

## Start the lab

Start by logging into the database server:

<!--TODO: This link must be corrected when we know where the lab is hosted.-->
1. Open a new web browser tab and navigate to https://labondemand.com/AuthenticatedLaunch/47218?providerId=4.
1. Sign with a Microsoft account, or create a new account.
1. To log on, type **student**, and then press Enter.
1. Type **Pa55w.rd**, and then press Enter.

## Install the SQL Server package

SQL Server needs to be installed and then configured. The first task is installation.

1. Download the Microsoft SLES repository configuration file by typing the following command and pressing Enter:

    ```bash
    sudo zypper addrepo -fc https://packages.microsoft.com/config/sles/12/mssql-server-2017.repo
    ```

1. If requested for a password, type your password, and press Enter.
1. Register the Microsoft SQL Server Ubuntu repository by typing the following command and pressing Enter:

    ```bash
    sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
    ```

1. Refresh your repositories by typing the following command and pressing Enter:

    ```bash
    sudo zypper --gpg-auto-import-keys refresh
    ```

1. Install SQL Server by typing the following command and pressing Enter:

    ```bash
    sudo zypper install mssql-server
    ```

1. Type **2** to continue with the install (a later version of OpenSSL is already installed)

## Configure SQL Server

Before you use SQL Server, you must specify the edition that you want and specify the system administrator password.

1. Type the following command and pressing Enter:

    ```bash
    sudo /opt/mssql/bin/mssql-conf setup
    ```

1. If prompted for your password, type your password, and press Enter.
1. Select the Evaluation edition by pressing 1 and pressing Enter.
1. Type **Yes** and press Enter to accept the license terms.
1. Type type your password and press Enter to set the system administrator password.
1. Type type your password and press Enter to confirm the password.

## Install SQL Server tools

SQL Server is now installed, but you will now install tools to work with SQL Server.

1. To add the Microsoft SQL Server tools repository to **zypper**, type the following command and press Enter:

    ```bash
    sudo zypper addrepo -fc https://packages.microsoft.com/config/sles/12/prod.repo
    sudo zypper --gpg-auto-import-keys refresh
    ```

1. Install SQL Server command-line tools by typing the following command and pressing Enter:

    ```bash
    sudo zypper install -y mssql-tools unixODBC-devel
    ```

1. Type **yes** and press Enter to accept the ODBC license terms.
1. Type **yes** and press Enter to accept the license terms.
1. Add the tools to the **PATH** environment variable by typing the following command and pressing Enter:

    ```bash
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    source ~/.bashrc
    ```

### Create a database

Now, you can used the newly-installed **sqlcmd** tool to create a database. Follow these steps:

1. Type the following command and press Enter to connect to SQL Server:

    ```bash
    sqlcmd -S localhost -U sa -P '[type your password here]'
    ```

1. Type the following command, and then and press Enter:

    ```bash
    CREATE DATABASE WorldWide1
    ```

1. To run the previous command, type the following command, and then and press Enter:

    ```bash
    GO
    ```

1. To verify that the database was created, type the following command, and then and press Enter:

    ```bash
    SELECT * FROM sys.databases WHERE name = 'WorldWide1'
    ```