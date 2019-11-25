It's easy to install Docker on Linux and use it to host SQL Server containers.

Suppose you are the system architect for a company that has created a text messaging application, which uses SQL Server 2017 to host an underlying database of messages and user accounts. You want to find a way to deploy a consistent, clean set of servers to the integration and acceptance testing environments, including the database server. You want to evaluate whether you can achieve this goal by using containers.

Here, you will install Docker and a SQL Server image on an Ubuntu server.

## Start the lab

Start by logging into the Docker hoar server:

<!--YAML added to connect to https://labondemand.com/AuthenticatedLaunch/51799?providerId=4 -->
1. Sign into the VM with a Microsoft account, or create a new account.
1. Click **Commands**, click **CTRL+ALT+DEL**, and then login with the **Administrator** password **Pa$$w0rdLinux**.
1. Close the Server Manager window.

## Install Prerequisites

Before you can install Docker, add all the dependency packages that docker requires:

1. At the bottom-left of the desktop, click **Show Applications**, and then click **Terminal**.
1. To update the package index, type the following command, and then press Enter:

    ```bash
    sudo apt-get update
    ```

1. At the **Password** prompt, type **Pa$$w0rdLinux**, and then press Enter.
1. To install packages that allow `apt` to use a repository over HTTPS, type the following command, and then press Enter:

    ```bash
    sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    ```

1.  To add the Docker GPG key, type the following command and then press Enter:
    
    ```bash
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    ```

1. To add install packages that allow `apt` to use a repository over HTTPS, type the following command, and then press Enter:

    ```bash
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    ```

## Install Docker

Now let's install Docker:

1. To update the package index, type the following command, and then press Enter:

    ```bash
    sudo apt-get update
    ```
    
1. To install Docker, type the following command, and then press Enter:

    ```bash
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    ```

1. If the status of Docker is not **Active**, type the following command, and then press Enter:

    ```bash
    sudo systemctl start docker
    ```

1. To automatically start Docker when the system boots up, type the following command, and then press Enter:

    ```bash
    sudo systemctl enable docker
    ```

## Create and run a SQL Server Container

Now that the installation is complete, we can use the Microsoft SQL Server container image to start a SQL Server database:

1. In the terminal, to pull the SQL Server container image, type the following command, and then press Enter:

    ```bash
    sudo docker pull mcr.microsoft.com/mssql/server:2017-latest
    ```

1. In the terminal, to run the SQL Server container image, type the following command, and then press Enter:

    ```bash
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Pa$$w0rdSQL' -p 1500:1433 --name sqltestcontainer -d mcr.microsoft.com/mssql/server:2017-latest
    ```

1. At the **Password** prompt, type **Pa$$w0rdLinux**, and then press Enter.
1. When the image has been downloaded and the container started, to check that SQL Server is running in the new container, type the following command, and then press Enter:

    ```bash
    sudo docker ps
    ```

## Install Azure Data Studio

Azure Data Studio is a free tool with a Graphical User Interface (GUI). Becuase it runs on Linux, we can use to explore databases and run queries when we don't have Windows:

1. To install software dependencies for Azure Data Studio, type the following command and press Enter:

    ```bash
    sudo apt-get install gconf2-common libxss1 libgconf-2-4 libunwind8
    ```

1. Type **Y** if asked for confirmation.
1. To install Azure Data Studio, type the following command, and then press Enter:

    ```bash
    sudo dpkg -i ./Downloads/azuredatastudio-linux-1.4.5.deb
    ```

1. At the **Password** prompt, type **Pa$$w0rdLinux**, and then press Enter.
1. Type **y** to any confirmation questions.

## Query the database server by using Azure Data Studio 

You can use Azure Data Studio to execute any Transact-SQL query. Let's find out what the version of SQL Server is:

1. To start Azure Data Studio, type the following command, and then press Enter:

    ```bash
    azuredatastudio
    ```

1. If asked if you would like to enable preview features, click **Yes**. If asked if you would like to allow Microsoft to collect usage data, close the dialog box. 
1. In the **Connection** pane, in the **Server** box, type **localhost, 1500**, and then in the **Authentication type** drop-down list, click **SQL Login**.
1. In the **User name** box type **sa**, in the **Password** box type **Pa$$w0rdSQL**, and then click **Connect**.
1. On the **File** menu, click **New Query**.
1. In the script window, type the following code and then click **Run**:

    ```sql
    SELECT @@VERSION
    GO
    ```

## Query the database server by using sqlcmd

If you don't want to install Azure Data Studio, you can use the command line `sqlcmd` tool to execute queries:

1. Switch to the terminal window.
1. To start the Bash shell within the new container, type the following command, and then press Enter:

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

1. To exit the `sqlcmd` tool, type **exit**, and then press Enter.
1. To exit the Bash shell on the container, type **exit**, and then press Enter.

## Investigate and clean up containers

Let's find out what containers are running on Docker, and remove the SQL Server image, ready for the next exercise:

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
