If you prefer to use containers to virtualize your database servers, you can install SQL Server on Linux Docker Hosts.

You are a database administrator at the wholesale company Wide World Importers and want to benefit from SQL Server without having to change the server operating systems. You have decided to deploy SQL Server in a container and use Docker to manage it.

Here, you will learn about running SQL Server in containers.

## Hardware and software requirements

To install SQL Server 2017 on Docker, the host server must meet the following requirements:

- Docker Engine 1.8 or later on any supported Linux distribution, or on Windows
- At least 2 GB of memory
- 2 GB of disk space

## Install Docker

> [!NOTE]
> These steps are for Red Hat Enterprise Linux, but the steps will be very similar for other Linux distributions.

To install Docker on Red Hat Enterprise Linux, complete these tasks:

1. Enable the **rhel-7-server-rpms** repository.
1. Enable the **rhel-7-server-extras-rpms** repository.
1. Enable the **rhel-7-server-optional-rpms** repository.
1. Install the **docker**, **device-mapper-libs**, and **device-mapper-event-libs** packages.
1. To start Docker, run this command:

    ```bash
    sudo systemctl start docker.service
    ```

1. To enable Docker, run this command:

    ```bash
    sudo systemctl enable docker.service
    ```

## Pull and run the container image

Microsoft has created a Docker image that includes SQL Server 2017. You can use this image as a parent for any customer SQL Server images you create. You can start SQL Server by pulling this image from the repository and then running it:

1. To pull the SQL Server image from the Docker hub, run this command:

    ```bash
    sudo docker pull microsoft/mssql-server-linux:2017-latest
    ```

1. If you are asked for a password, type your password and then press Enter.
1. To run the SQL Server Docker image, run this command:

    ```bash
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=[Type a SQL Server administrator password]' \
    -p 1433:1433 --name [Type a name for your image] \
    -d microsoft/mssql-server-linux:2017-latest
    ```