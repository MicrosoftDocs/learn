It's easy to install SQL Server on SUSE by using the `zypper` tool.

You're a database administrator at the wholesale company Wide World Importers. You want to benefit from SQL Server without having to change the server operating systems. After you deploy SQL Server on a SUSE server, you can configure the SQL Server package and install command-line tools. SQL Server is then ready for use by your developers.

In this exercise, you see how to deploy SQL Server on SUSE, install command-line tools, and create a database.

## Create a SUSE Virtual Machine

1. Use the Cloud Shell sandbox and Azure CLI commands to create a SUSE Enterprise server. The [az vm create](/cli/azure/vm#az-vm-create) command can take a couple of minutes to complete.

    ```azurecli
    export PASSWORD=$(openssl rand -base64 32)
    az vm create \
        --name SLESSQLServer \
        --resource-group  <rgn>[sandbox resource group name]</rgn> \
        --admin-username suseadmin \
        --admin-password $PASSWORD \
        --image "SUSE:sles-12-sp5:gen1:latest" \
        --nsg-rule SSH \
        --public-ip-sku Standard \
        --size Standard_D2s_v3
    ```

1. Store the public IP address of your server, and display the password.

    ```bash
    export IPADDRESS=$(az vm show -d \
        --name SLESSQLServer \
        --query publicIps --output tsv \
        --resource-group <rgn>[sandbox resource group name]</rgn>)
    echo $PASSWORD
    ```

## Connect to the SUSE virtual machine

Now you have a SUSE VM that's ready to install SQL Server. Connect to it by using Secure Shell (SSH):

1. In the Cloud Shell, run this command.

    ```bash
    ssh suseadmin@$IPADDRESS
    ```

1. When asked if you're sure, type *yes*.
1. For the password, enter the displayed password from the earlier command, and then press **Enter**. SSH connects to the VM and shows a bash shell.

## Install the SQL Server package

Now install and configure SQL Server. The first task is installation:

1. To download the Microsoft SLES repository configuration file, run this command:

    ```bash
    sudo zypper addrepo -fc https://packages.microsoft.com/config/sles/12/mssql-server-2019.repo
    ```

1. If you're asked for a password, use the random password.
1. To refresh your repositories, run this command:

    ```bash
    sudo zypper --gpg-auto-import-keys refresh
    ```

1. If any of the SUSE repositories is unavailable, type *i*, and then press **Enter**. If you're warned about a repository signed with an unknown key, type *yes*, and then press **Enter**.
1. To install SQL Server, run this command, and type *y* to confirm:

    ```bash
    sudo zypper --no-gpg-checks install -y mssql-server
    ```

## Configure SQL Server

Before you use SQL Server, you must specify the edition that you want and the system administrator password.

1. Run the following command:

    ```bash
    sudo /opt/mssql/bin/mssql-conf setup
    ```

1. If prompted, enter your password.
1. To select the **Evaluation edition**, press *1*.
1. Type *Yes* to accept the license terms.
1. For the system administrator password, type *Pa$$w0rd*, and then press **Enter**.
1. Confirm the password.
1. To confirm that SQL Server 2019 is running, run this command:

    ```bash
    systemctl status mssql-server --no-pager
    ```

## Install SQL Server tools

SQL Server is installed. Now install the administrative tools:

1. To add the Microsoft SQL Server tools repository to `zypper`, run these commands:

    ```bash
    sudo zypper addrepo -fc https://packages.microsoft.com/config/sles/12/prod.repo
    sudo zypper --gpg-auto-import-keys refresh
    ```

1. If any of the SUSE repositories is unavailable, type *i*, and then press **Enter**. If you're warned about a repository signed with an unknown key, type *yes*.
1. To install SQL Server command-line tools, run this command:

    ```bash
    sudo zypper --no-gpg-checks install -y mssql-tools unixODBC-devel
    ```

1. Type *YES* to accept the ODBC license terms.
1. Type *YES* to accept the license terms.
1. To add the tools to the `PATH` environment variable, run these commands:

    ```bash
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    source ~/.bashrc
    ```

### Create a database

Now you can use the newly installed `sqlcmd` tool to create a database.

1. To check whether SQL Server is running, run this command:

    ```bash
    systemctl status mssql-server --no-pager
    ```

1. If SQL Server isn't active, run this command to start the server:

    ```bash
    sudo systemctl start mssql-server
    ```

1. Run the following command to connect to SQL Server:

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
