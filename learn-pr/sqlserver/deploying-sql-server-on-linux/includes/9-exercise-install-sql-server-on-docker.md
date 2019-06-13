You can run SQL Server on a Docker host by using the Microsoft SQL Server 2017 image.

You are a database administrator at the wholesale company Wide World Importers and want to benefit from SQL Server without having to change the server operating systems. You have decided to deploy SQL Server in a container and use Docker to deploy and manage it.

In this unit, you will see how to deploy SQL Server on a container with Docker.

## Start the lab

Start by logging into the database server:

<!--TODO: This link must be corrected when we know where the lab is hosted.-->
1. Open a new web browser tab and navigate to https://labondemand.com/AuthenticatedLaunch/47218?providerId=4.
1. Sign in with a Microsoft account, or create a new account.
1. To sign in, type **student**, and then press Enter.
1. Type **Pa55w.rd**, and then press Enter.

## Install Docker

Before you can run any containers, you must begin by installing the Docker container host software. Follow these steps:

> [!NOTE]
> These steps are for Red Hat Enterprise Linux, but the steps will be very similar for other Linux distros.

1. To enable the RHEL Server repository, run this command:

    ```bash
    sudo subscription-manager repos --enable=rhel-7-server-rpms
    ```

1. To enable the RHEL Server extras repository, run this command

    ```bash
    sudo subscription-manager repos --enable=rhel-7-server-extras-rpms
    ```

1. To enable the RHEL Server optional repository, run this command:

    ```bash
    sudo subscription-manager repos --enable=rhel-7-server-optional-rpms
    ```

1. To install Docker and the dependent packages, run this command:

    ```bash
    sudo yum install docker device-mapper-libs device-mapper-event-libs
    ```

    > [!NOTE]
    > If you are asked for confirmation, press **y** and **Enter** each time.

1. To start Docker, run this command:

    ```bash
    sudo systemctl start docker.service
    ```

1. To enable Docker, run this command:

    ```bash
    sudo systemctl enable docker.service
    ```

## Pull and run the container image

To use SQL Server in Docker containers, the easiest method is to use the Microsoft SQL Server on Linux image as a parent. In the following steps, you will download and run that image:

1. To pull the SQL Server image from the Docker hub, run this command:

    ```bash
    sudo docker pull microsoft/mssql-server-linux:2017-latest
    ```

1. If you are asked for a password, type your password, and then press Enter.
1. To run the SQL Server Docker image, run this command:

    ```bash
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=[Type a SQL Server administrator password]' \
    -p 1433:1433 --name [Type a name for your image] \
    -d microsoft/mssql-server-linux:2017-latest
    ```

## Create a database

Now that SQL Server is running in the container, you can create a database in it. Follow these steps:

1. To create a bash shell inside your container, run this command:

    ```bash
    sudo docker exec -it [Type the name of your image] "bash"
    ```

1. To start `sqlcmd` in the container, run this command:

    ```bash
    /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '[Type your SQL Server administrator password]'
    ```

1. To create a database, run this command:

    ```bash
    CREATE DATABASE WideWorld
    GO
    ```

1. To verify that the database has been created, run this command:

    ```bash
    SELECT Name from sys.Databases
    ```

1. To close `sqlcmd`, run this command:

    ```bash
    quit
    ```

1. To exit the container, run this command:
    ```bash
    exit
    ```