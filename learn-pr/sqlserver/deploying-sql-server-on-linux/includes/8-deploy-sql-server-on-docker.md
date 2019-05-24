You are a database administrator at the wholesale company World Wide Importers and want to benefit from SQL Server without having to change the server operating systems. You have decided to deploy SQL Server in a container and use Docker to deploy and manage it.

## Hardware and software requirements

To install SQL Server 2017 on Docker it must meet the following requirements:

- Docker Engine 1.8 or later on any supported Linux distribution, or on Windows
- At least 2GB of memory.
- 2GB of disk space.

## Install Docker

> [!NOTE]
> These steps are for Red Hat Enterprise Linux, but the steps will be very similar for other Linux distros.

To install Docker on Red Hat Enterprise Linux, follow these steps:

1. Enable the rhel-7-server-rpms repository.
1. Enable the rhel-7-server-extras-rpms repository.
1. Enable the rhel-7-server-optional-rpms repository.
1. Install Docker, device-mapper-libs, and device-mapper-event-libs dependent packages.
1. To start Docker, type the following command, and then press Enter:

    ```bash
    sudo systemctl start docker.service
    ```

1. To enable Docker, type the following command, and then press Enter:

    ```bash
    sudo systemctl enable docker.service
    ```

## Pull and run the container image

SQL Server needs to be installed and then configured. The first task is installation.

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