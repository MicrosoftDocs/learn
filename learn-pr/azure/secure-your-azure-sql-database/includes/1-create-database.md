Here you'll set up the resources you'll need for use throughout this module. Let's envision a basic architecture consisting of a server hosting an application that your customers use, which connects to a database for the storage of its data. The application runs on a virtual machine, and the database has been recently migrated from a SQL Server database running on a VM to a database on the Azure SQL Database service. To show how you can secure your database, we're going to set up the following resources for use throughout this module:

- A Linux VM named _appServer_. This server will act as the application server that users would be connecting to, and will need to connect to the database. We'll install `sqlcmd` on the VM to simulate an application running on _appServer_ making connections to the database.
- An Azure SQL Database logical server. This logical server is needed to host one or more databases.
- A database on our logical server called _marketplaceDb_. We'll create it using the _AdventureWorksLT_ demo database so we have some tables and data to work with. This will include some sensitive data, such as email addresses and phone numbers that we'll want to make sure are properly secured.

Let's get things set up!

## Create an Azure SQL Database

1. First, let's set up some variables. Replace values below that are shown in `[]` with values of your choice. Note that the `[password]` must have at least eight characters and contain characters from at least three of these categories: uppercase characters, lowercase characters, numbers, and non-alphanumeric characters. Save the login for use later.

    ```bash
    # Set an admin login and password for your database
    export ADMINLOGIN='[ServerAdmin]'
    export PASSWORD='[password]'
    # Set the logical SQL server name. We'll add a random string as it needs to be globally unique.
    export SERVERNAME=server$RANDOM
    export RESOURCEGROUP=<rgn>[sandbox resource group name]</rgn>
    # Set the location, we'll pull the location from our resource group.
    export LOCATION=$(az group show --name $RESOURCEGROUP | jq -r '.location')
    ```

1. Run the following command to create a new Azure SQL Database logical server.

    ```azurecli
    az sql server create \
        --name $SERVERNAME \
        --resource-group $RESOURCEGROUP \
        --location $LOCATION \
        --admin-user $ADMINLOGIN \
        --admin-password "$PASSWORD"
    ```

1. Now run the following to create the database called **marketplaceDb** on the logical server you just created. This will use the _AdventureWorksLT_ database as a template so we'll have some pre-populated tables to work with.

    ```azurecli
    az sql db create --resource-group $RESOURCEGROUP \
        --server $SERVERNAME \
        --name marketplaceDb \
        --sample-name AdventureWorksLT \
        --service-objective Basic
    ```

1. Let's do one last thing and get the connection string for this database.

    ```azurecli
    az sql db show-connection-string --client sqlcmd --name marketplaceDb --server $SERVERNAME | jq -r
    ```

    Your output resembles this. Keep this handy, you'll need this command to connect to your database later in this module. Note the `[username]` and `[password]` placeholders in the command that you will want to replace with the `ADMINLOGIN` and `PASSWORD` credentials you specified in variables earlier.

    ```output
    sqlcmd -S tcp:server12345.database.windows.net,1433 -d marketplaceDb -U '[username]' -P '[password]' -N -l 30
    ```

## Create and configure a Linux virtual machine

Now let's create the Linux VM that we'll use through some examples.

1. Run the following command to create the VM; this might take several minutes to complete.

    ```azurecli
    az vm create \
      --resource-group $RESOURCEGROUP \
      --name appServer \
      --image UbuntuLTS \
      --size Standard_DS2_v2 \
      --generate-ssh-keys
    ```

    When this command completes, you should see output that resembles the following example:

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

1. Once your VM is successfully created, connect to its public IP address using SSH.

    ```azurecli
    ssh nnn.nnn.nnn.nnn
    ```

    Where `nnn.nnn.nnn.nnn` is the value from the `publicIpAddress` output in the previous step.

    > [!NOTE]
    > Two things to note. First, we don't need a password because we generated an SSH key pair as part of the VM creation. Second, on the initial shell connection into the VM it will give you a prompt about the authenticity of the host. This occurs because we are connecting to an IP address instead of a host name. Answering "yes" will save the IP as a valid host for connection and allow the connection to proceed.

1. Now let's finish things up by installing mssql-tools on the Linux VM so we'll be able to connect to our database through sqlcmd.

    ```bash
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    source ~/.bashrc
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
    sudo apt-get update
    sudo ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev
    ```

    > [!NOTE]
    > A lot of text will scroll by for some of these commands, so make sure you hit enter after the final command to ensure it runs.

We've created an Azure SQL Database logical server, a database on that logical server, and a virtual machine called _appServer_ that we'll use to simulate network connectivity from an application server. Let's take a look at how we can properly secure our database.
