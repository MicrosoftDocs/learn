You can create images that customize containers to your requirements.

You're the system architect for a company that's created a text messaging application. Subscribers send short messages to groups by using their mobile devices. You use SQL Server 2019 to host an underlying database of messages and user accounts.

You want to deploy containers in your integration testing environment to host a sample SQL Server database. You'll deploy the database by restoring a database backup on the image. In this way, whenever you deploy the image to the test environment, it will contain a clean sample database with no further configuration necessary.

Here, you'll create a custom Docker image that includes a backed-up SQL Server database.

## Connect to the Ubuntu VM

If you've disconnected from the VM that you created in the last unit, you must reconnect:

1. In the Cloud Shell on the right, enter this command. Replace the placeholder with the IP address you made a note of earlier:

    ```bash
    ssh ubuntuadmin@<your ip address>
    ```

1. When asked if you're sure, type **yes**, and then press Enter.
1. For the password, type the password you recorded earlier, and then press Enter. SSH connects to the VM and shows a bash shell.

## Create a Dockerfile

You'll use a Dockerfile to copy a backup of the database into the new container. To create the Dockerfile, follow these steps:

1. In the Cloud Shell, to create and edit an empty text file, type the following command, and then press Enter:

    ```bash
    nano Dockerfile
    ```

1. In the **nano** text editor, enter the following lines of text:

    ```Dockerfile
    FROM mcr.microsoft.com/mssql/server:2019-latest
    ADD --chown=mssql:users https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak /var/opt/mssql/backup/SampleDB.bak
    CMD ["/opt/mssql/bin/sqlservr"]
    ```

1. Press <kbd>Escape</kbd>, and then press <kbd>CTRL</kbd>-<kbd>X</kbd>. When asked if you want to save changes, press **y**, and then press Enter.
1. To check the contents of the **Dockerfile**, type the following command, and then press Enter:

    ```bash
    cat Dockerfile
    ```

## Build an image from the Dockerfile

Now you've created the Dockerfile, you can use it to build an image, and then start a container:

1. To build the new image from the Dockerfile, type the following command, and then press Enter:

    ```bash
    sudo docker build . -t mssql-with-test-database
    ```

1. When the build is complete, to list the images available, type the following command, and then press Enter:

    ```bash
    sudo docker image ls
    ```

1. To start the container, type the following command, and then press Enter:

    ```bash
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Pa$$w0rdSQL' \
      -p 1500:1433 --name sqltestcontainer2 \
      -d mssql-with-test-database
    ```

## Restore the database

The Dockerfile ensures that the database backup is included in the image. Now you must restore that backup file to create the database. Follow these steps:

1. In the terminal, to restore the database file list, enter the following command, and then press Enter:

    ```bash
    sudo docker exec -it sqltestcontainer2 /opt/mssql-tools/bin/sqlcmd \
    -S localhost -U SA -P 'Pa$$w0rdSQL' \
    -Q 'RESTORE FILELISTONLY FROM DISK = "/var/opt/mssql/backup/SampleDB.bak"' \
    -W \
    | tr -s ' ' | cut -d ' ' -f 1-2
    ```

1. To restore the database, enter the following command, and then press Enter:

    ```bash
    sudo docker exec -it sqltestcontainer2 /opt/mssql-tools/bin/sqlcmd \
       -S localhost -U sa -P 'Pa$$w0rdSQL' \
       -Q 'RESTORE DATABASE WideWorldImporters FROM DISK = "/var/opt/mssql/backup/SampleDB.bak" WITH MOVE "WWI_Primary" TO "/var/opt/mssql/data/WideWorldImporters.mdf", MOVE "WWI_UserData" TO "/var/opt/mssql/data/WideWorldImporters_userdata.ndf", MOVE "WWI_Log" TO "/var/opt/mssql/data/WideWorldImporters.ldf", MOVE "WWI_InMemory_Data_1" TO "/var/opt/mssql/data/WideWorldImporters_InMemory_Data_1"'
    ```

## Query the database

Now the database is running in the container, you use `sqlcmd` to execute a query:

1. To check the list of databases, run this command:

    ```bash
    sudo docker exec -it sqltestcontainer2 /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Pa$$w0rdSQL' \
        -Q 'SELECT Name FROM sys.Databases'
    ```

1. To query the Wide World Importers database, run this command:

    ```bash
    sudo docker exec -it sqltestcontainer2 /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Pa$$w0rdSQL' \
        -Q 'SELECT TOP 10 StockItemID, StockItemName FROM WideWorldImporters.Warehouse.StockItems ORDER BY StockItemID'
    ```

    The query displays some products from the database.

## Stop and delete the container

Before the next exercise, you must remove the container you've been using:

1. In the Cloud Shell, to stop the container that you've deployed, type the following command, and then press Enter:

    ```bash
    sudo docker container stop sqltestcontainer2
    ```

1. To delete the container, type the following command, and then press Enter:

    ```bash
    sudo docker container rm sqltestcontainer2
    ```