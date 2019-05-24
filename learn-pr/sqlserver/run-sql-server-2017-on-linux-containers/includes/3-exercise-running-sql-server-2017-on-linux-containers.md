Suppose you are the system architect for a company that has created a text messaging application, which uses SQL Server 2017 to host an underlying database of messages and user accounts.

You want to find a way to deploy a consistent, clean set of servers to the integration and acceptance testing environments, including the database server. You want to evaluate whether you can achieve this goal by using containers.

## Start the Host Virtual Machine

Begin by starting the Labs on Demand virtual machine that will act as a Docker host:

1. Open a new web browser tab and navigate to https://labondemand.com/AuthenticatedLaunch/51799?providerId=4.
1. Sign with a Microsoft account, or create a new account and start the virtual machine.

## Install Docker

1. To log on, click **Administrator**, type the password **Pa$$w0rdLinux**, and then click **Sign In**.
1. At the bottom-left of the desktop, click ** Show Applications**, and then click **Terminal**.
1. To update the package index, type the following command, and then press Enter:

    ```-nocode
    sudo apt-get update
    ```
    
1. At the **Password** prompt, type **Pa$$w0rdLinux**, and then press Enter.
1. To add install packages to allow apt to use a repository over HTTPS, type the following command, and then press Enter:

    ```-nocode
    sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    ```
1.  To add the Docker GPG key, type the following command and press Enter:
    ```-nocode
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    ```

1. To add install packages to allow apt to use a repository over HTTPS, type the following command, and then press Enter:

    ```-nocode
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
1. To update the package index, type the following command, and then press Enter:

    ```-nocode
    sudo apt-get update
    ```
    
1. To install Docker, type the following command, and then press Enter:

    ```-nocode
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    ```

1. If the status of Docker is not **Active**, type the following command, and then press Enter:

    ```-nocode
    sudo systemctl start docker
    ```

1. To automatically start Docker when the system boots up, type the following command, and then press Enter:

    ```-nocode
    sudo systemctl enable docker
    ```

## Create and Query a SQL Server Container

1. In the terminal, to pull the SQL Server container image, type the following command, and then press Enter:

    ```-nocode
    sudo docker pull mcr.microsoft.com/mssql/server:2017-latest
    ```

2. In the terminal, to run the SQL Server container image, type the following command, and then press Enter:

    ```-nocode
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Pa$$w0rdSQL' -p 1500:1433 --name sqltestcontainer -d mcr.microsoft.com/mssql/server:2017-latest
    ```

3. At the **Password** prompt, type **Pa$$w0rdLinux**, and then press Enter.
4. When the image has been downloaded and the container started, to check that SQL Server is running in the new container, type the following command, and then press Enter:

    ```-nocode
    sudo docker ps
    ```
1. To install software dependencies for Azure Data Studio, type the following command and press Enter:
 ```-nocode
    sudo apt-get install gconf2-common libxss1 libgconf-2-4 libunwind8
    ```
1. Tpe **Y** if asked for confirmation.

5. To install Azure Data Studio, type the following command, and then press Enter:

    ```-nocode
    sudo dpkg -i ./Downloads/azuredatastudio-linux-1.4.5.deb
    ```

6. At the **Password** prompt, type **Pa$$w0rdLinux**, and then press Enter.
7. Type **y** to any confirmation questions.
8. To start Azure Data Studio, type the following command, and then press Enter:

    ```-nocode
    azuredatastudio
    ```

9. If asked if you would like to enable preview features, click **Yes**.
10. If asked if you would like to allow Microsoft to collect usage data, close the dialog box. 
11. In the **Connection** pane, in the **Server** box, type **localhost, 1500**.
12. In the **Authentication type** drop-down list, click **SQL Login**.
13. In the **User name** box, type **sa**.
14. In the **Password** box, type **Pa$$w0rdSQL**, and then click **Connect**.
15. On the **File** menu, click **New Query**.
16. In the script window, type the following code:

    ```-nocode
    SELECT @@VERSION
    GO
    ```

17. In the top-left of the script window, click **Run**.
18. Switch to the terminal window.
19. To start the Bash shell within the new container, type the following command, and then press Enter:

    ```-nocode
    sudo docker exec -it sqltestcontainer bash
    ```

20. To start the sqlcmd tool, type the following command, and then press Enter:

    ```-nocode
    /opt/mssql-tools/bin/sqlcmd -U SA -P 'Pa$$w0rdSQL'
    ```

21. To query the database server, type the following commands, and then press Enter:

    ```-nocode
    SELECT @@version
    GO
    ```

22. To exit the sqlcmd tool, type **exit**, and then press Enter.
23. To exit the Bash shell on the container, type **exit**, and then press Enter.

## Investigate and Clean Up Containers

1. To list active container instances, in the terminal, type the following command, and then press Enter:

    ```-nocode
    sudo docker ps
    ```

2. To list all container images, type the following command, and then press Enter:

    ```-nocode
    sudo docker image ls
    ```
3. To stop the SQL Server container, type the following command, and then press Enter:

    ```-nocode
    sudo docker stop sqltestcontainer
    ```

4. To check that the container is no longer running, type the following command, and then press Enter:

    ```-nocode
    sudo docker ps -a
    ```
5. To delete the container, type the following command, and then press Enter:

    ```-nocode
    sudo docker rm sqltestcontainer
    ```

6. To check that the container no longer exists, type the following command, and then press Enter:

    ```-nocode
    sudo docker container ls
    ```
