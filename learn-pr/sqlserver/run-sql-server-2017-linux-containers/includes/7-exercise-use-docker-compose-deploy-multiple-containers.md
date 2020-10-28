You can automate the startup of multiple Docker images by using a container orchestrator package, such as Docker Compose.

Suppose you're the system architect for a company that retails bicycle parts. Your customer-facing website has two servers: a front-end web server that hosts the website code, and a SQL Server that hosts the product database. You want to deploy containers in your integration testing environment to host both the website and the database. You need to deploy both servers in a single step.

Here, you'll use Docker Compose to automate the creation of a complete test environment for your bike parts database.

## Connect to the Ubuntu VM

If you've disconnected from the VM that you created earlier, you must reconnect:

1. In the Cloud Shell on the right, enter this command. Replace the placeholder with the IP address you recorder earlier.

    ```bash
    ssh ubuntuadmin@<your ip address>
    ```

1. When asked if you're sure, type **yes**, and then press Enter.
1. For the password, type the password you recorded earlier, and then press Enter. SSH connects to the VM and shows a bash shell.

## Install Docker Compose

When you use Docker Compose, you can create a .yml file with instructions to deploy multiple containers. Start by installing Docker Compose. Follow these steps:

1. To download Docker Compose, type the following command, and then press Enter:

    ```bash
    sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    ```

1. To mark the downloaded file as executable, type the following command, and then press Enter:

    ```bash
    sudo chmod +x /usr/local/bin/docker-compose
    ```

1. To create a link to the downloaded executable, type the following command, and then press Enter:

    ```bash
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    ```

## Clone the GitHub repository

To use Docker Compose, you'll need some files in YAML format, some Dockerfiles, and other code files. Get these files from a GitHub repository:

1. In the Cloud Shell on the left, to clone the GitHub repo in the Ubuntu VM, run this command:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-run-sql-server-linux-containers
    ```


## Complete a docker-compose.yml file

You've been supplied with a **docker-compose.yml** file. You want to ensure that all values in this file are correct before you use it to start the containers. Follow these steps:

1. In the terminal, to change to the right folder, type the following command, and then press Enter:

    ```bash
    cd ~/mslearn-run-sql-server-linux-containers
    ```

1. To edit the **docker-compose.yml** file, type the following command, and then press Enter:

    ```bash
    nano docker-compose.yml
    ```

1. In the editor, replace the password **safePASSWORD123** with the password **Passw0rdSQL**.

    > [!IMPORTANT]
    > Don't use dollar signs in this password as in previous units. This is because dollar signs are interpreted differently in a YAML file.

1. To close the file, press <kbd>Escape</kbd>, and then press <kbd>CTRL</kbd>-<kbd>X</kbd>. To save the changes, press **y**, and then press **Enter**.
1. To edit the password in the **db-init.sh** file, type the following command, and then press Enter:

    ```bash
    nano ./mssql-aspcore-example-db/db-init.sh
    ```

1. In the editor, replace the password **safePASSWORD123** with the password **Passw0rdSQL**.
1. To close the file, press <kbd>Escape</kbd>, and then press <kbd>CTRL</kbd>-<kbd>X</kbd>. To save the changes, press **y**, and then press **Enter**.

## Start the containers

Now you've created and configured the Docker Compose file, you can use it to start the two containers. Follow these steps:

1. In the terminal, to check that Docker is running, type the following command, and then press Enter:

    ```bash
    systemctl status docker --no-pager
    ```

1. If the status isn't **Active**, type the following command, and then press Enter:

    ```bash
    sudo systemctl start docker
    ```

1. In the terminal, type the following command, and then press Enter:

    ```bash
    sudo docker-compose up -d
    ```

   Docker Compose downloads the necessary images and starts the containers.

## Query the new database container

The two-container system is now up and running. You can check that the database is present by using `sqlcmd`.

1. First, let's check that the two containers are running. Use this command:

    ```bash
    sudo docker ps -a
    ```

    The results should include a web server container named `run-sql-server-containers_web_1` and a database container named `run-sql-server-containers_db_1`.

1. If the status of the database container is **Up**, you can query the database:

    ```bash
    sudo docker exec -it run-sql-server-linux-containers_db_1 /opt/mssql-tools/bin/sqlcmd \
       -S localhost -U SA -P 'Passw0rdSQL' -Q 'SELECT Name FROM sys.Databases'
    ```

    The results should include the default SQL Server databases and a database called **ProductCatalog**.

1. To find out what tables are in the **ProductCatalog** database, use this command:

    ```bash
    sudo docker exec -it run-sql-server-linux-containers_db_1 /opt/mssql-tools/bin/sqlcmd \
       -S localhost -U SA -P 'Passw0rdSQL' -Q 'SELECT TABLE_NAME FROM ProductCatalog.INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = "BASE TABLE"'
    ```

1. To find about the products in the database, use this command:

    ```bash
    sudo docker exec -it run-sql-server-linux-containers_db_1 /opt/mssql-tools/bin/sqlcmd \
       -S localhost -U SA -P 'Passw0rdSQL' -Q 'USE ProductCatalog; SELECT ProductID, Name FROM ProductCatalog.Product'
    ```

    The results show that the table is empty. No products have been added yet.

## Shut down and remove the Docker images

To stop and clean up the Docker images, follow these steps:

1. To stop and remove the containers and images, type the following command, and then press Enter:

    ```bash
    sudo docker-compose down --rmi all
    ```