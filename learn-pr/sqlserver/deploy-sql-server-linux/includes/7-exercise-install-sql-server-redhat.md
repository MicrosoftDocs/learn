Use the `yum` tool to install SQL Server on Red Hat Enterprise Linux (RHEL) servers. 

You're a database administrator at the wholesale company Wide World Importers, and want to benefit from SQL Server without having to change the server operating systems. After you deploy SQL Server on a Red Hat server, configure the SQL Server package and install command-line tools. SQL Server is then ready for your developers to use.

In this exercise, you deploy SQL Server on RHEL, install command-line tools, and create a database on SQL Server.

## Create a Red Hat virtual machine

Start by creating a Red Hat virtual machine (VM) in Azure:

1. Use the Cloud Shell sandbox and Azure CLI commands to create a Red Hat 7 server. The [az vm create](/cli/azure/vm#az-vm-create) command can take a couple of minutes to complete.

    ```azurecli
    export PASSWORD=$(openssl rand -base64 32)
    az vm create \
        --name RedHatServer \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --admin-username redhatadmin \
        --admin-password $PASSWORD \
        --image "RedHat:RHEL:7-LVM:latest" \
        --nsg-rule SSH \
        --public-ip-sku Standard \
        --size Standard_D2s_v3 \
    ```

1. Store the public IP address of your server and display the password.

    ```bash
    export IPADDRESS=$(az vm show -d \
        --name RedHatServer \
        --query publicIps --output tsv \
        --resource-group <rgn>[sandbox resource group name]</rgn>)
    echo $PASSWORD
    ```

## Connect to the Red Hat VM

Now you have a Red Hat VM ready to install a SQL Server. Connect to it by using Secure Shell (SSH):

1. In the Cloud Shell, run this command:

    ```bash
    ssh redhatadmin@$IPADDRESS
    ```

1. When asked if you're sure, type *yes*.
1. For the password, enter the displayed password from the earlier command, and then press **Enter**. SSH connects to the VM and shows a bash shell.

## Install the SQL Server package

Before using `yum` to install, you must add a configuration file:

1. To download the Microsoft SQL Server Red Hat repository configuration file, run this command:

    ```bash
    sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2019.repo
    ```

1. If you're asked for a password, use the password displayed earlier, and then press **Enter**.
1. To install SQL Server, run this command:

    ```bash
    sudo yum install -y mssql-server
    ```

## Configure SQL Server

Before using SQL Server, use the `mssql-conf` script to specify the edition you want and the system administrator password:

1. Run this command:

    ```bash
    sudo /opt/mssql/bin/mssql-conf setup
    ```

1. If prompted for your password, use the password displayed earlier.
1. To select the **Evaluation edition**, enter *1*.
1. Type *Yes* to accept the license terms.
1. Type *Pa$$w0rd* and then press **Enter** to set the system administrator password.
1. Confirm the password.
1. To confirm that SQL Server 2019 is running, run this command:

    ```bash
    systemctl status mssql-server --no-pager
    ```

## Install SQL Server tools

SQL Server is installed. Next, install command-line tools to work with SQL Server:

1. To download the Microsoft SQL Server tools repository configuration file, run this command:

    ```bash
    sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo
    ```

1. To install SQL Server command-line tools, run this command:

    ```bash
    sudo yum install -y mssql-tools unixODBC-devel
    ```

1. Type *YES* to accept the ODBC license terms.
1. Type *YES* to accept the license terms.
1. To add the tools to the `PATH` environment variable, run these commands:

    ```bash
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    source ~/.bashrc
    ```

## Create a database

You can now use the `sqlcmd` tool to create a database:

1. Run this command to connect to SQL Server:

    ```bash
    sqlcmd -S localhost -U sa -P 'Pa$$w0rd'
    ```

1. To create a database called *WideWorld1*, run these SQL commands:

    ```bash
    CREATE DATABASE WideWorld1
    GO
    ```

1. To verify that the database was created, run this SQL query:

    ```bash
    SELECT name, database_id, create_date FROM sys.databases WHERE name = 'WideWorld1'
    GO
    ```

1. To exit the `sqlcmd` tool and SSH, run the command *exit* twice.
