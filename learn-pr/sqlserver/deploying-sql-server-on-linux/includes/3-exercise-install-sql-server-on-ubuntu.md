To install SQL Server on Ubuntu, you use the `apt-get` tool.

You are a database administrator at the wholesale company Wide World Importers. You want to benefit from SQL Server without having to change the server operating systems. You have decided to deploy SQL Server on an Ubuntu server and will configure the SQL Server package and install command-line tools so that SQL Server is ready to be used by your developers.

Here, you will see how to  deploy SQL Server on Ubuntu, install command-line tools and Azure Data Studio, and create a database on SQL Server.

## Start the lab

Start by logging into the database server:

<!--TODO: This link must be corrected when we know where the lab is hosted.-->
1. Open a new web browser tab and navigate to https://labondemand.com/AuthenticatedLaunch/47218?providerId=4.
1. Sign with a Microsoft account, or create a new account.
1. To sign in, type **student**, and then press Enter.
1. Type **Pa55w.rd**, and then press Enter.

## Install the SQL Server package

Now, let's install and configure SQL Server:

1. Click **Show Applications**, and then click **Terminal**.

    ![Ubuntu Terminal](../media/ubuntu_terminal.PNG "Terminal")

1. To install Curl, type the following command, and then press Enter:

    ```bash
    sudo apt install -y curl
    ```

1. To install the Microsoft repository GPG key, type the following command, and then press Enter:

    ```bash
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    ```

1. To register the Microsoft SQL Server Ubuntu repository, type the following command, and then press Enter:

    ```bash
    sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
    ```

1. To get an updated package list, type the following command, and then press Enter:

    ```bash
    sudo apt-get update
    ```

1. To install the **libcurl3** URL transfer library, type the following, and then press Enter:

    ```bash
    sudo apt-get install -y libcurl3
    ```

1. To install SQL Server, type the following command, and then press Enter:

    ```bash
    sudo apt-get install -y mssql-server
    ```

1. To restart SQL Server, type the following command, and then press Enter:

    ```bash
    systemctl restart mssql-server.service
    ```

1. If authentication is required, type your password and click **Authenticate**.

## Configure SQL Server

Before you use SQL Server, you must specify the edition that you want and the system administrator password:

1. To configure SQL Server, in the Terminal window, type the following command, and then press Enter:

    ```bash
    sudo /opt/mssql/bin/mssql-conf setup
    ```

1. If prompted for your password, type your password and press Enter.
1. To select the **Evaluation edition**, press 1, and then press Enter.
1. Type **Yes** and press Enter to accept the license terms.
1. Type your new SQL Server administrator password and press Enter.
1. Type your new SQL Server administrator password and press Enter.

## Install SQL Server tools

SQL Server is now installed. Next, install tools to work with SQL Server.

1. To register the repository for the Microsoft SQL Server tools package, type the following command, and then press Enter:

    ```bash
    sudo add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list)"
    ```

1. To get an updated package list, type the following command, and then press Enter:

    ```bash
    sudo apt-get update
    ```

1. To install SQL Server command-line tools, type the following command, and then press Enter:

   ```bash
   sudo apt-get install -y mssql-tools unixodbc-dev
   ```

1. Press Tab and Enter to accept the license terms.
1. Press Tab and Enter to accept the ODBC license terms.
1. To add the tools to the **PATH** environment variable, type the following command, and then press Enter:

    ```bash
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    source ~/.bashrc
    ```

### Install Azure Data Studio

Next, install the Azure Data Studio tool:

1. To download the Azure Data Studio package, type the following command, and then press Enter:

    ```bash
    cd ~
    yum install ./Downloads/azuredatastudio-linux-<version string>.rpm
    ```

1. To install missing dependencies, type the following command, and then press Enter:

    ```bash
    sudo apt -y --fix-broken-install
    ```

1. To install `git`, type the following command, and then press Enter:

    ```bash
    sudo apt-get install -y git
    ```

### Create a database

Now, you can use the Azure Data Studio to create and query a database:

1. Click **Show Applications**, and click **Azure Data Studio**.
1. Press Ctrl + G and then click **New Connection**.

    ![New Connection](../media/new_connection.PNG "New Connection")

1. In **Server**, type **localhost**.
1. In **User name**, type **sa**, and then in **Password**, type your SQL Server administrator password.
1. Click **Connect**.
1. Click **New Query**. In the query window, type the following command, and then click **Run**:

    ![Create Database](../media/create_database.PNG "Create Database")

1. Expand **Databases** and observe that the new database has been created.

    ![Databases](../media/databases.PNG "Databases")