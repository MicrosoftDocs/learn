You can run SQL Server on a container host by using the Microsoft SQL Server 2019 image.

You're a database administrator at the wholesale company Wide World Importers and want to benefit from SQL Server without having to change the server operating systems. You've decided to deploy SQL Server in a container and use Docker to deploy and manage it.

In this exercise, you see how to deploy SQL Server on a container with Docker.

## Connect to the Ubuntu VM

Before you can run any containers, begin by installing the Docker container host software. Follow these steps:

1. If you haven't completed the exercise in unit 3, then start by installing a new Ubuntu 18.04 LTS server. This command takes a couple of minutes to complete. If you have completed unit 3, you can skip this section:

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

1. In the Cloud Shell, enter these commands.

    ```bash
    export IPADDRESS=$(az vm show -d \
        --name UbuntuServer \
        --query publicIps --output tsv \
        --resource-group <rgn>[sandbox resource group name]</rgn>)
    echo $UBUNTUPASSWORD
    ssh ubuntuadmin@$IPADDRESS
    ```

1. When asked if you're sure, enter *yes*.
1. For the password, use the displayed password, and then press **Enter**. SSH connects to the virtual machine (VM) and shows a bash shell.

## Install Docker

To install Docker, add the Docker repository, and then use the `apt-get` tool.

1. To add the Docker GPG key to your Ubuntu system, run this command:

    ```bash
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    ```

1. To add the Docker repository to the Ubuntu sources, run this command:

    ```bash
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    ```

1. To update your package database, run this command:

    ```bash
    sudo apt-get update
    ```

1. Now you can install Docker. Run this command:

    ```bash
    sudo apt-get install -y docker-ce
    ```

## Pull and run the container image

To use SQL Server in Docker containers, the easiest method is to use the Microsoft SQL Server on Linux image as a parent. In the following steps, download and run that image:

1. To check that Docker is running, run this command:

    ```bash
    systemctl status docker --no-pager
    ```

1. To pull the SQL Server image from the Microsoft repository, run this command:

    ```bash
    sudo docker pull mcr.microsoft.com/mssql/server:2019-latest
    ```

1. If you're asked for a password, use the password displayed previously, and then press **Enter**.
1. To run the SQL Server Docker image, run this command:

    ```bash
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Pa55w.rd' \
    -p 1435:1435 --name sql-server-image \
    -d mcr.microsoft.com/mssql/server:2019-latest
    ```

## Create a database

Now that SQL Server is running in the container, you can create a database in it. Follow these steps:

1. To create a bash shell inside your container, run this command:

    ```bash
    sudo docker exec -it sql-server-image "bash"
    ```

1. To start `sqlcmd` in the container, run this command:

    ```bash
    /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Pa55w.rd'
    ```

1. To create a database, run this command:

    ```bash
    CREATE DATABASE WideWorld1
    GO
    ```

1. To verify that the database has been created, run these commands:

    ```bash
    SELECT Name from sys.Databases
    GO
    ```

1. To close `sqlcmd`, run this command:

    ```bash
    quit
    ```

1. To exit the container and SSH, run the command *exit* twice.
