Now that you've provisioned an Azure Database for MySQL flexible server, you want to connect to it to validate its availability. In this unit, you step through connecting to the server by using the mysql.exe utility from the Azure Cloud Shell.

### Connect to an Azure Database for MySQL flexible server

From the Azure Cloud Shell, use the following procedure to connect to and query the newly deployed Azure Database for MySQL flexible server:

1. On the page for your Azure Database for MySQL flexible server, select **Overview**.

1. On the **Overview** pane, note the value of **Server name**. You need this fully qualified server name to establish a connection.

 :::image type="content" source="../media/connect-azure-database-mysql/5-server-overview-pane.png" alt-text="Screenshot displays the Overview menu item highlighted in the left-hand menu and the server name highlighted in the Essentials section.":::

1. To verify that your network configuration allows connectivity from Azure Cloud Shell, under **Settings**, select **Networking**.

1. On the **Networking** pane, verify that the **Allow public access from any Azure service within Azure to this server** checkbox is selected.

1. In the Cloud Shell pane, run the following command to download the public certificate used by the server:

   ```bash
   wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem
   ```

1. Next, run the following command to connect to the server, replacing the <server_name> placeholder with the name of your server, and the <user_name> placeholder with the name of the admin account you specified (such as `mysqladmin`) when provisioning the server in the previous exercise:

   ```bash
   mysql -h <server_name>.mysql.database.azure.com -u <user_name> -p --ssl-mode=VERIFY_IDENTITY --ssl-ca=DigiCertGlobalRootCA.crt.pem
   ```

1. When prompted, enter the password that you assigned (such as `Passw0rd123`) to the admin account you specified when provisioning the server in the previous task.

    You should be presented with the **MySQL [(none)]** prompt. This prompt verifies that the connection was successful.

1. Next, from the **MySQL [(none)]** prompt, run the following command to list databases hosted by the server:

      ```sql
      SHOW DATABASES;
      ```

1. Verify that the list includes the four precreated databases (**information_schema**, **mysql**, **performance_schema**, and **sys**) and the **testdb** that you created in the previous exercise.

1. From the **MySQL [(none)]** prompt, run the following command to switch to the **testdb** database:

      ```sql
      USE testdb;
      ```

1. From the **MySQL [(testdb)]** prompt, run the following command to create a sample table in the **testdb** database:

      ```sql
      CREATE TABLE table1 (id int NOT NULL, val int,txt varchar(200));
      ```

1. From the **MySQL [(testdb)]** prompt, run the following command to add a row of data into the newly created table:

      ```sql
      INSERT INTO table1 values (1,100,'text1');
      ```

1. From the **MySQL [(testdb)]** prompt, run the following command to display the newly added data:

      ```sql
      SELECT * FROM table1;
      ```

1. To exit the connection, at the **MySQL [(testdb)]** prompt, enter *quit*.
