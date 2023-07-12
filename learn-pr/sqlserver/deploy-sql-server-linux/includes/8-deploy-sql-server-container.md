If you prefer to use containers to virtualize database servers, you can install SQL Server on Linux container hosts.

You're a database administrator at the wholesale company Wide World Importers and want to benefit from SQL Server without having to change the server operating systems. You've decided to deploy SQL Server in a container and use Docker to manage it.

In the following exercise, you learn about running SQL Server in containers. This example uses Docker but you can perform the same steps on containers that run in other hosts.

## Hardware and software requirements

To install SQL Server 2019 on a Docker container, the host server must meet the following requirements:

- Docker Engine 1.8 or later on any supported Linux distribution, or on Windows, or Mac
- At least 2 GB of memory
- 2 GB of disk space

## Install Docker

> [!NOTE]
> These steps are for Red Hat Enterprise Linux, but the steps are very similar for other Linux distributions.

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

Microsoft has created a Docker image that includes SQL Server 2019. You can use this image as a parent for any customer SQL Server images you create. You start SQL Server by pulling this image from the Microsoft repository and then running it.

1. To pull the SQL Server image from the Microsoft repository, run this command:

    ```bash
    sudo docker pull mcr.microsoft.com/mssql/server:2019-latest
    ```

1. If you're asked for a password, type your password, and then press **Enter**.
1. To run the SQL Server image and a container in Docker, run this command:

    ```bash
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=[Type a SQL Server administrator password]' \
    -p 1433:1433 --name [Type a name for your image] \
    -d mcr.microsoft.com/mssql/server:2019-latest
    ```
