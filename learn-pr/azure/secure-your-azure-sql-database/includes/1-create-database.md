In this unit, you set up the resources that you use throughout this module. Envision a basic architecture that consists of a server hosting an application that your customers use. The server connects to a database for the storage of its data. The application runs on a virtual machine (VM). The database recently migrated from a SQL Server database running on a VM to a database on the Azure SQL Database service. To show how you can secure your database, set up the following resources for use throughout this module:

- A Linux VM named _appServer_. This server acts as the application server that users would be connecting to. It needs to connect to the database. Install `sqlcmd` on the VM to simulate an application running on _appServer_ making connections to the database.
- An Azure SQL Database logical server. This logical server is needed to host one or more databases.
- A database on your logical server called _marketplaceDb_. You create it using the _AdventureWorksLT_ demo database so you have some tables and data to work with. This data includes some sensitive data, such as email addresses and phone numbers that you want to properly secure.

## Create an Azure SQL Database

1. First, set up some variables. Replace the following values that are shown in `[]` with values of your choice. The `[password]` must have at least eight characters, and contain characters from at least three of these categories: uppercase characters, lowercase characters, numbers, and nonalphanumeric characters. Save the value for use later.

    ```bash
    export ADMINLOGIN='[ServerAdmin]'
    export PASSWORD='[password]'
    export SERVERNAME=server$RANDOM
    export RESOURCEGROUP=<rgn>[sandbox resource group name]</rgn>
    export LOCATION=$(az group show --name $RESOURCEGROUP | jq -r '.location')
    ```

1. Run the following command to create a new Azure SQL Database logical server.

    ```azurecli
    az sql server create \
        --name $SERVERNAME \
        --resource-group $RESOURCEGROUP \
        --location $LOCATION \
        --admin-user $ADMINLOGIN \
        --admin-password $PASSWORD
    ```

1. Run the following command to create the database called _marketplaceDb_ on the logical server that you created. This command uses the _AdventureWorksLT_ database as a template so you have some prepopulated tables to work with.

    ```azurecli
    az sql db create --resource-group $RESOURCEGROUP \
        --server $SERVERNAME \
        --name marketplaceDb \
        --sample-name AdventureWorksLT \
        --service-objective Basic
    ```

1. Run the following command to get the connection string for this database.

    ```azurecli
    az sql db show-connection-string --client sqlcmd --name marketplaceDb --server $SERVERNAME | jq -r
    ```

    Your output should resemble the following example. Keep this command handy because you need this command to connect to your database later in this module. Note the `[username]` and `[password]` placeholders in the command that you want to replace with the `ADMINLOGIN` and `PASSWORD` credentials you specified in variables earlier.

    ```output
    sqlcmd -S tcp:server12345.database.windows.net,1433 -d marketplaceDb -U '[username]' -P '[password]' -N -l 30
    ```

## Create and configure a Linux virtual machine

Create the Linux VM that to use through some examples.

1. Run the following command to create the VM. This command might take several minutes to complete.

    ```azurecli
    az vm create \
      --resource-group $RESOURCEGROUP \
      --name appServer \
      --image Ubuntu2204 \
      --size Standard_DS2_v2 \
      --public-ip-sku Standard \
      --generate-ssh-keys
    ```

    When this command completes, you should see output that resembles the following example.

    ```json
    {
      "fqdns": "",
      "id": "/subscriptions/nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn/resourceGroups/learn-nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn/providers/Microsoft.Compute/virtualMachines/appServer",
      "location": "westus",
      "macAddress": "nn-nn-nn-nn-nn-nn",
      "powerState": "VM running",
      "privateIpAddress": "nn.nn.nn.nn",
      "publicIpAddress": "nnn.nnn.nnn.nnn",
      "resourceGroup": "learn-nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn",
      "zones": ""
    }
    ```

1. After your VM is successfully created, connect to its public IP address using SSH.

    ```azurecli
    ssh nnn.nnn.nnn.nnn
    ```

    Where `nnn.nnn.nnn.nnn` is the value from the `publicIpAddress` output in the previous step.

    > [!NOTE]
    > Two things to note. First, you don't need a password because you generated an SSH key pair as part of the VM creation. Second, on the first shell connection into the VM, you are prompted about the authenticity of the host. This occurs because you are connecting to an IP address instead of a host name. Answering _yes_ saves the IP address as a valid host for connection and allows the connection to proceed.

1. Finish things by installing mssql-tools on the Linux VM so you can connect to your database through sqlcmd.

    ```bash
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
    source ~/.bashrc
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
    curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list
    sudo apt-get update
    sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev
    ```

    > [!NOTE]
    > A lot of text will scroll by for some of these commands, so make sure you select **Enter** after the final command to ensure that it runs.

You created an Azure SQL Database logical server, a database on that logical server, and a virtual machine called _appServer_ that simulates network connectivity from an application server. Next, take a look at how to properly secure your database.
