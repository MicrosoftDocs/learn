Now that you’ve reviewed the deployment and connectivity options of Azure Database for MySQL, you want to test the process of provisioning a server and validate its availability by connecting to it. In this unit, step through a sample deployment and connect to the server by using the mysql.exe utility from the Azure Cloud Shell.

### Connect to an Azure Database for MySQL flexible server

From the Azure Cloud Shell, use the following procedure to connect to and query the newly deployed Azure Database for MySQL flexible server:

1. On the page for your Azure Database for MySQL flexible server, select **Overview**.

2. On the **Overview** pane, note the value of **Server name**. You need this fully qualified server name to establish a connection.

3. To verify that your network configuration allows connectivity from Azure Cloud Shell, under **Settings**, select **Networking**.

4. On the **Networking** pane, verify that the **Allow public access from any Azure service within Azure to this server** checkbox is selected.

5. In the Cloud Shell pane, run the following command to download the public certificate used by the server:

   ```bash
   wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem
   ```

6. Next, run the following command to connect to the server, replacing the <server_name> placeholder with the name of your server, and the <user_name> placeholder with the name of the admin account you specified when provisioning the server in the previous exercise:

   ```bash
   mysql -h <server_name>.mysql.database.azure.com -u <user_name> -p --ssl-mode=VERIFY_IDENTITY --ssl-ca=DigiCertGlobalRootCA.crt.pem
   ```

7. When prompted, enter the password that you assigned to the admin account you specified when provisioning the server in the previous task.

    You should be presented with the **MySQL [(none)]** prompt. This prompt verifies that the connection was successful.

8. Next, from the **MySQL [(none)]** prompt, run the following command to list databases hosted by the server:

      ```sql
      SHOW DATABASES;
      ```

9. Verify that the list includes the four precreated databases (**information_schema**, **mysql**, **performance_schema**, and **sys**) and the **testdb** that you created in the previous exercise.

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
