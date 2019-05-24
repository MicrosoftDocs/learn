You are a database administrator at the wholesale company WorldWide Importers and want to benefit from SQL Server without having to change the server operating systems. You have decided to deploy SQL Server in a container and use Docker to deploy and manage it.

In this unit, you will see how to deploy SQL Server on a container with Docker.

## Start the lab

Start by logging into the database server:

SQL Server needs to be installed and then configured. The first task is installation.

<!--TODO: This link must be corrected when we know where the lab is hosted.-->
1. Open a new web browser tab and navigate to https://labondemand.com/AuthenticatedLaunch/47218?providerId=4.
1. Sign with a Microsoft account, or create a new account.
1. To log on, type **student**, and then press Enter.
1. Type **Pa55w.rd**, and then press Enter.

## Install Docker

Before you can run any containers, you must begin by installing the Docker container host software. Follow these steps:

> [!NOTE]
> These steps are for Red Hat Enterprise Linux, but the steps will be very similar for other Linux distros.

1. To enable the RHEL Server repository, type the following command, and then press Enter:

    ```bash
    sudo subscription-manager repos --enable=rhel-7-server-rpms
    ```

1. To enable the RHEL Server extras repository, type the following command, and then press Enter:

    ```bash
    sudo subscription-manager repos --enable=rhel-7-server-extras-rpms
    ```

1. To enable the RHEL Server optional repository, type the following command, and then press Enter:

    ```bash
    sudo subscription-manager repos --enable=rhel-7-server-optional-rpms
    ```

1. To install Docker and dependent packages, type the following command, and then press Enter:

    ```bash
    sudo yum install docker device-mapper-libs device-mapper-event-libs
    ```

    > [!NOTE]
    > If requested for confirmation, press **y** and **Enter** each time.

1. To start Docker, type the following command, and then press Enter:

    ```bash
    sudo systemctl start docker.service
    ```

1. To enable Docker, type the following command, and then press Enter:

    ```bash
    sudo systemctl enable docker.service
    ```

## Pull and run the container image

To use SQL Server in Docker containers, the easiest method is to use the Microsoft SQL Server on Linux image as a parent. In the following steps, you will download and run that image:

1. To pull the SQL Server image from the Docker hub, type the following command, and then press Enter:

    ```bash
    sudo docker pull microsoft/mssql-server-linux:2017-latest
    ```

1. If requested for a password, type your password and press Enter.
1. To run the SQL Server Docker image, type the following command, and then press Enter:

    ```bash
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=[Type a SQL Server administrator password]' \
    -p 1433:1433 --name [Type a name for your image] \
    -d microsoft/mssql-server-linux:2017-latest
    ```

## Create a database

Now that SQL Server is running in the container, you can create a database in it. Follow these steps:

1. To create a bash shell inside your container, type the following command, and then press Enter:

    ```bash
    sudo docker exec -it [Type the name of your image] "bash"
    ```

1. To start sqlcmd in the container, type the following command, and then press Enter:

    ```bash
    /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '[Type your SQL Server administrator password]'
    ```

1. To create a database, type the following command, and then press Enter:

    ```bash
    CREATE DATABASE WideWorld
    GO
    ```

1. To verify that the database has been created, type the following command, and then press Enter:

    ```bash
    SELECT Name from sys.Databases
    ```

1. To close sqlcmd, type the following command, and then press Enter:

    ```bash
    quit
    ```

1. To exit the container, type the following command, and then press Enter:
    ```bash
    exit
    ```