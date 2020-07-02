It's easy to install a container host on Linux and use it to host SQL Server containers.

Suppose you're the system architect for a company that's created a text messaging application. This application uses SQL Server 2019 to host an underlying database of messages and user accounts. You want to find a way to deploy a consistent, clean set of virtualized servers to the integration and acceptance testing environments, including the database server. You want to evaluate whether you can achieve this goal by using containers.

Here, you'll install the Docker container host and a SQL Server image on an Ubuntu server.

## Create an Ubuntu Virtual Machine 

Let's start by creating an Ubuntu Virtual Machine (VM) in Azure. Later, we can install Docker on that VM:

1. Using the Cloud Shell on the right, enter Azure CLI commands to create an Ubuntu 18.04 LTS server. This can take a couple of minutes to complete.

    ```azurecli
    export UBUNTUPASSWORD=$(openssl rand -base64 32)
    az vm create \
        --name UbuntuServer \
        --image "Canonical:UbuntuServer:18.04-LTS:latest" \
        --size Standard_D2s_v3 \
        --admin-username ubuntuadmin \
        --admin-password $UBUNTUPASSWORD \
        --nsg-rule SSH \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

1. Store the public IP address of your server, and display the password.

    ```bash
    export IPADDRESS=$(az vm show -d \
        --name UbuntuServer \
        --query publicIps --output tsv \
        --resource-group <rgn>[sandbox resource group name]</rgn>)
    echo $UBUNTUPASSWORD
    ```

    Make a note to the IP address and password for use later in this module.

## Connect to the Ubuntu VM

Now you have an Ubuntu VM, ready to install Docker on, connect to it using Secure Shell (SSH):

1. In the Cloud Shell on the right, enter this command. Replace the placeholder with the IP address you copied.

    ```bash
    ssh ubuntuadmin@$IPADDRESS
    ```

1. When asked if you're sure, type **yes**, and then press Enter.
1. For the password, use displayed password from above,, and then press Enter. SSH connects to the VM and shows a bash shell.

## Install prerequisites

Before you install Docker, add all the dependency packages that Docker requires:

1. In the Cloud Shell, to update the package index, type the following command, and then press Enter:

    ```bash
    sudo apt-get update
    ```

1. If you're asked for a password, type the displayed password from above, and then press Enter.
1. To install packages that allow `apt` to use a repository over HTTPS, type the following command, and then press Enter:

    ```bash
    sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    ```

1.  To add the Docker GPG key, type the following command, and then press Enter:
    
    ```bash
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    ```

1. To add install packages that allow `apt` to use a repository over HTTPS, type the following command, and then press Enter:

    ```bash
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    ```

## Install Docker

Now you install Docker:

1. To update the package index, type the following command, and then press Enter:

    ```bash
    sudo apt-get update
    ```
    
1. To install Docker, type the following command, and then press Enter:

    ```bash
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    ```

1. When installation is complete, check the status of the Docker service with this command:

    ```bash
    systemctl status docker --no-pager
    ```

1. If the status of Docker isn't **Active**, type the following command, and then press Enter:

    ```bash
    sudo systemctl start docker
    ```

1. To automatically start Docker when the system boots up, type the following command, and then press Enter:

    ```bash
    sudo systemctl enable docker
    ```

## Create and run a SQL Server container

Now that installation is complete, you can use the Microsoft SQL Server container image to start a SQL Server database:

1. In the terminal, to pull the SQL Server container image, type the following command, and then press Enter:

    ```bash
    sudo docker pull mcr.microsoft.com/mssql/server:2019-latest
    ```

1. In the terminal, to run the SQL Server container image, type the following command, and then press Enter:

    ```bash
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Pa$$w0rdSQL' -p 1500:1433 --name sqltestcontainer -d mcr.microsoft.com/mssql/server:2019-latest
    ```

1. If you're prompted for a password, type the displayed password from above, and then press Enter.
1. When the image is downloaded and the container started, you check that SQL Server is running in the new container. Type the following command, and then press Enter:

    ```bash
    sudo docker ps
    ```

## Query the database server by using sqlcmd

You can use the command-line `sqlcmd` tool to execute queries. Use the `docker` command to start a bash shell within the image first:

1. In the Cloud Shell, To start the bash shell within the new container, type the following command, and then press Enter:

    ```bash
    sudo docker exec -it sqltestcontainer bash
    ```

1. To start the sqlcmd tool, type the following command, and then press Enter:

    ```bash
    /opt/mssql-tools/bin/sqlcmd -U SA -P 'Pa$$w0rdSQL'
    ```

1. To query the database server, type the following commands, and then press Enter:

    ```sql
    SELECT @@version
    GO
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
1. To exit the `sqlcmd` tool, type **exit**, and then press Enter.
1. To exit the bash shell on the container, type **exit**, and then press Enter.

## Investigate and clean up containers

Now you'll find out what containers are running on Docker, and remove the SQL Server image, ready for the next exercise:

1. To list active container instances, in the terminal, type the following command, and then press Enter:

    ```bash
    sudo docker ps
    ```

1. To list all container images, type the following command, and then press Enter:

    ```bash
    sudo docker image ls
    ```
1. To stop the SQL Server container, type the following command, and then press Enter:

    ```bash
    sudo docker stop sqltestcontainer
    ```

1. To check that the container is no longer running, type the following command, and then press Enter:

    ```bash
    sudo docker ps -a
    ```
1. To delete the container, type the following command, and then press Enter:

    ```bash
    sudo docker rm sqltestcontainer
    ```

1. To check that the container no longer exists, type the following command, and then press Enter:

    ```bash
    sudo docker container ls
    ```
