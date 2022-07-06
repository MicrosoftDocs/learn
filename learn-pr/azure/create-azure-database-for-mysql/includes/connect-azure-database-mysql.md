Now that you’ve reviewed the deployment and connectivity options of Azure Database for MySQL, you want to test the process of provisioning a server and validate its availability by connecting to it. In this unit, you’ll step through a sample deployment and connect to the server by using the mysql.exe utility from the Azure Cloud Shell.

### Connect to an Azure Database for MySQL flexible server

From the Azure Cloud Shell, use the following procedure to connect to and query the newly deployed Azure Database for MySQL flexible server:

1. On the page for your Azure Database for MySQL flexible server, select **Overview**.

2. On the **Overview** pane, note the value of **Server name**. You'll need this fully qualified server name to establish a connection.

3. To verify that your network configuration will allow connectivity from Azure Cloud Shell, under **Settings**, select **Networking**.

4. On the **Networking** pane, verify that the **Allow public access from any Azure service within Azure to this server** checkbox is selected.

5. In the Cloud Shell pane, run the following command to download the public certificate used by the server:

   ```bash
   wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem
   ```

6. Next, run the following command to connect to the server, replacing the <server_name> placeholder with the name of your server, and the <user_name> placeholder with the name of the admin account you specified when provisioning the server in the previous exercise:

   ```bash
   mysql -h <server_name>.mysql.database.azure.com -u <user_name> -p --ssl=true --ssl-ca=DigiCertGlobalRootCA.crt.pem
   ```

7. When prompted, enter the password that you assigned to the admin account you specified when provisioning the server in the previous task.

    > [!NOTE]
    > When connecting to your flexible server by using Azure Cloud Shell, you need to specify the --ssl=true parameter (rather than --ssl-mode=REQUIRED). The reason for this is that Azure Cloud Shell uses the mysql.exe client from MariaDB distribution, and not the mysql client from Oracle's distribution (which requires the --ssl-mode parameter).

    You should be presented with the **MySQL [(none)]** prompt. This verifies that the connection was successful.

8. Next, from the **MySQL [(none)]** prompt, run the following command to list databases hosted by the server:

      ```sql
      SHOW DATABASES;
      ```

9. Verify that the list includes the four pre-created databases (**information_schema**, **mysql**, **performance_schema**, and **sys**) and the **testdb** that you created in the previous exercise.

10. From the **MySQL [(none)]** prompt, run the following command to switch to the **testdb** database:

      ```sql
      use testdb;
      ```

11. From the **MySQL [(testdb)]** prompt, run the following command to create a sample table in the **testdb** database:

      ```sql
      CREATE TABLE table1 (id int NOT NULL, val int,txt varchar(200));
      ```

12. From the **MySQL [(testdb)]** prompt, run the following command to add a row of data into the newly created table:

      ```sql
      INSERT INTO table1 values (1,100,'text1');
      ```

13. From the **MySQL [(testdb)]** prompt, run the following command to display the newly added data:

      ```sql
      SELECT * FROM table1;
      ```

14. To exit the connection, at the **MySQL [(testdb)]** prompt, enter *quit*.

### Clean up resources

To delete the Azure Database for MySQL server resource you provisioned in this exercise, you can delete its resource group.

1. In the Cloud Shell pane run the following command:

    Use the resource group name <rgn>[sandbox resource group name]</rgn> created in the last exercise.

    ```bash
    az group delete --name <resource group name>
    ```

2. When prompted, **Are you sure you want to perform this operation?**, enter *y*.
