By using Dockerfiles, you can create images that are customized to your requirements.

You are the system architect for a company that has created a text messaging application. Subscribers send short messages to groups by using their mobile devices. You use SQL Server 2017 to host an underlying database of messages and user accounts.

You want to deploy containers in your integration testing environment to host a sample SQL Server database. You want to deploy the database by restoring a database backup on the image. In this way, whenever you deploy the image to the test environment, it will contain a clean sample database with no further configuration necessary.

Here, you will create a custom Docker image that includes a backed-up SQL Server database.

## Start the exercise

If you logged out of the VM, start this exercise by logging on and starting the terminal:

1. Sign into the VM with your Microsoft account.
1. Click **Commands**, click **CTRL+ALT+DEL**, and then login with the username **Administrator** and the password **Pa$$w0rdLinux**.
1. Close the **Server Manager** window.
1. At the bottom-left of the desktop, click **Show Applications**, and then click **Terminal**.
1. To ensure you are in the home folder, type the following command and then press Enter:

    ```bash
    cd ~
    ```

## Create a Docker file

You will use a Dockerfile to copy a backup of the database into the new container. To create the Dockerfile, follow these steps:

1. To create and edit an empty text file, type the following command and then press Enter:

    ```bash
    nano Dockerfile
    ```

1. In the **nano** text editor, enter the following lines of text:

    ```Dockerfile
    FROM microsoft/mssql-server-linux:latest
    COPY containers/mssql-custom-image-example/SampleDB.bak /var/opt/mssql/data/SampleDB.bak
    CMD ["/opt/mssql/bin/sqlservr"]
    ```

1. Press Escape and then press CTRL-X. When asked if you want to save changes, press **y** and then press Enter.
1. To check the contents of the **Dockerfile**, type the following command and then press Enter:

    ```bash
    cat Dockerfile
    ```

## Build an image from the Docker file

Now that you have created the Dockerfile, you can use it to build an image and then start a container:

1. To build the new image from the Dockerfile, type the following command and then press Enter:

    ```bash
    sudo docker build . -t mssql-with-test-database
    ```

1. When the build is complete, to list the images available, type the following command and then press Enter:

    ```bash
    sudo docker image ls
    ```

1. To start the container, type the following command and then press Enter:

    ```bash
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Pa$$w0rdSQL' \
      -p 1500:1433 --name sqltestcontainer2 \
      -d mssql-with-test-database
    ```

## Restore the database

The Dockerfile ensures that the database backup is included in the image. Now you must restore that backup file to create the database. Follow these steps:

1. In the terminal, to restore the database file list, enter the following command and then press Enter:

    ```bash
    sudo docker exec -it sqltestcontainer2 /opt/mssql-tools/bin/sqlcmd \
    -S localhost -U SA -P 'Pa$$w0rdSQL' \
    -Q 'RESTORE FILELISTONLY FROM DISK = "/var/opt/mssql/data/SampleDB.bak"' \
    -W \
    | tr -s ' ' | cut -d ' ' -f 1-2
    ```

1. To restore the database, enter the following command and then press Enter:

    ```bash
    sudo docker exec -it sqltestcontainer2 /opt/mssql-tools/bin/sqlcmd \
       -S localhost -U sa -P 'Pa$$w0rdSQL' \
       -Q 'RESTORE DATABASE ProductCatalog FROM DISK = "/var/opt/mssql/data/SampleDB.bak" WITH MOVE "ProductCatalog" TO "/var/opt/mssql/data/ProductCatalog.mdf", MOVE "ProductCatalog_log" TO "/var/opt/mssql/data/ProductCatalog.ldf"'
    ```

## Run a query

Now that the database is running in the container, you can use Azure Data Studio to execute a query:

1. To start Azure Data Studio, type **azuredatastudio** and then press Enter.
1. Click **File** and then click **New Query**.
1. In the query window, type the following code, and then click **Run**:

    ```SQL
    SELECT ProductID, Name, Price
    FROM ProductCatalog.dbo.Product
    ```

1. In the **Connection** window, in the **Server** textbox, type **localhost, 1500**.
1. In the **User name** textbox, type **sa**, in the **Password** textbox, type **Pa$$w0rdSQL**, and then click **Connect**.
1. Examine the results of the query, and then close Azure Data Studio.

## Stop and delete the container

Before the next exercise, you must remove the container you have been using:

1. Switch to the terminal.
1. To stop the container that you have deployed, type the following command, and then press Enter:

    ```bash
    sudo docker stop sqltestcontainer2
    ```

1. To delete the container, type the following command and then press Enter:

    ```bash
    sudo docker container rm sqltestcontainer2
    ```