To install SQL Server on Ubuntu, use the `apt-get` tool.

You're a database administrator at the wholesale company Wide World Importers. You want to benefit from SQL Server without having to change the server operating systems. Now you've decided to deploy SQL Server on an Ubuntu server. So that SQL Server is ready to be used by your developers, configure the SQL Server package and install command-line tools.

In this exercise, you see how to deploy SQL Server on Ubuntu, install command-line tools, and create a database on SQL Server.

## Create an Ubuntu virtual machine

Start by creating an Ubuntu virtual machine (VM) in Azure. Later, install SQL Server 2019 on that VM.

1. Using the Cloud Shell sandbox, enter Azure CLI commands to create an Ubuntu 18.04 LTS server. The [az vm create](/cli/azure/vm#az-vm-create) command can take a couple of minutes to complete.

    ```azurecli
    export UBUNTUPASSWORD=$(openssl rand -base64 32)
    az vm create \
        --name UbuntuServer \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --admin-username ubuntuadmin \
        --admin-password $UBUNTUPASSWORD \
        --image "Canonical:UbuntuServer:18.04-LTS:latest" \
        --nsg-rule SSH \
        --public-ip-sku Standard \
        --size Standard_D2s_v3   
    ```

1. Store the public IP address of your server, and display the password.

    ```bash
    export IPADDRESS=$(az vm show -d \
        --name UbuntuServer \
        --query publicIps --output tsv \
        --resource-group <rgn>[sandbox resource group name]</rgn>)
    echo $UBUNTUPASSWORD
    ```

## Connect to the Ubuntu VM

Now you have an Ubuntu VM, you're ready to install SQL Server. Connect to the VM by using Secure Shell (SSH):

1. In the Cloud Shell, run this command.

    ```bash
    ssh ubuntuadmin@$IPADDRESS
    ```

1. When asked if you're sure, type *yes*.
1. For the password, enter the displayed password from the earlier command, and then press **Enter**. SSH connects to the VM and shows a bash shell.

## Install the SQL Server package

Now install and configure SQL Server.

1. To install the Microsoft repository GPG key, run the following command:

    ```bash
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    ```

1. To register the Microsoft SQL Server Ubuntu repository, run the following command:

    ```bash
    sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list)"
    ```

1. To get an updated package list, run the following command:

    ```bash
    sudo apt-get update
    ```

1. To install SQL Server, run the following command:

    ```bash
    sudo apt-get install -y mssql-server
    ```

    The installation might take a couple of minutes.

## Configure SQL Server

Before you start SQL Server, you must specify the edition you want and the system administrator password:

1. To configure SQL Server, in the terminal window, run the following command:

    ```bash
    sudo /opt/mssql/bin/mssql-conf setup
    ```

1. To select the **Evaluation edition**, enter *1*.
1. Type *Yes* to accept the license terms.
1. For the system administrator password, type *Pa$$w0rd*. Confirm the password.
1. To confirm that SQL Server 2019 is running, run this command:

    ```bash
    systemctl status mssql-server --no-pager
    ```

## Install SQL Server tools

SQL Server is now installed. Next, install tools to work with SQL Server.

1. To register the repository for the Microsoft SQL Server tools package, run the following command:

    ```bash
    sudo add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list)"
    ```

1. To get an updated package list, run the following command:

    ```bash
    sudo apt-get update
    ```

1. To install SQL Server command-line tools, run the following command:

   ```bash
   sudo apt-get install -y mssql-tools unixodbc-dev
   ```

1. Press **Tab** and **Enter** to accept the license terms.
1. Press **Tab** and **Enter** to accept the ODBC license terms.
1. To add the tools to the `PATH` environment variable, run the following command:

    ```bash
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    source ~/.bashrc
    ```

## Create a database

Finally, create a database in SQL Server.

1. To check whether SQL Server is running, run this command:

    ```bash
    systemctl status mssql-server
    ```

1. If SQL Server isn't active, run this command to start the server:

    ```bash
    sudo systemctl start mssql-server
    ```

1. To start the `sqlcmd` tool, run this command:

    ```bash
    sqlcmd -S localhost -U sa -P 'Pa$$w0rd'
    ```

1. To create a database, run these commands:

    ```sql
    CREATE DATABASE WideWorld1
    GO
    ```

1. To verify that the database was created, run these commands:

    ```sql
    SELECT name, database_id, create_date FROM sys.databases WHERE name = 'WideWorld1'
    GO
    ```

1. To exit the `sqlcmd` tool and SSH, run the command *exit* twice.
