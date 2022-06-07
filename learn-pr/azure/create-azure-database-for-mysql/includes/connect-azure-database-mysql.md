Now that you’ve reviewed the deployment and connectivity options of Azure Database for MySQL, you want to test the process of provisioning a server and validate its availability by connecting to it. In this unit, you’ll step through a sample deployment and connect to the server by using the mysql.exe utility from the Azure Cloud Shell.

### Connect to Azure Database for MySQL Flexible Server

From the Azure Cloud Shell in the Azure portal, use the following procedure to connect to and query the newly deployed Azure Database for MySQL Flexible Server:

1. From your computer, in the web browser window displaying the Azure portal, navigate to the page of the Azure Database for MySQL Flexible Server you deployed in the previous task of this exercise.

2. In the **Overview** pane, note the value of **Server name**. You will need this fully qualified server name to establish a connection.

3. To verify that your network configuration will allow connectivity from Azure Cloud Shell, in the vertical menu, in the **Settings** section, select **Networking**.

4. On the **Networking** page, verify that the **Allow public access from any Azure service within Azure to this server** checkbox is selected.

5. Open a browser tab in the same web browser window and navigate to https://shell.azure.com.

   > [!NOTE]
   > If this is the first time you’re using Cloud Shell and you’re presented with the message **You have no storage mounted**, select the subscription you’re using in this exercise, and then select **Create storage**.

6. If required, in the Cloud Shell pane, switch to the **Bash** option using the drop-down menu in the toolbar.

7. In the Cloud Shell pane, run the following command to download the public certificate used by the server:

   ```bash
   wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem
   ```

8. Next, run the following command to connect to the server, replacing the <server_name> placeholder with the name of your server, and the <user_name> placeholder with the name of the admin account you specified when provisioning the server in the previous task:

   ```bash
   mysql -h <server_name>.mysql.database.azure.com -u <user_name> -p --ssl=true --ssl-ca=DigiCertGlobalRootCA.crt.pem
   ```

9. When prompted, enter the password that you assigned to the admin account you specified when provisioning the server in the previous task.

   > [!NOTE]
   > When connecting to your Flexible Server by using Azure Cloud Shell, you need to specify the --ssl=true parameter (rather than --ssl-mode=REQUIRED). The reason for this is that Azure Cloud Shell uses the mysql.exe client from MariaDB distribution, and not the mysql client from Oracle's distribution (which requires the --ssl-mode parameter).

10. You should be presented with the **MySQL [(none)]** prompt. This verifies that the connection was successful.

11. Next, from the **MySQL [(none)]** prompt, run the following command to list databases hosted by the server:

      ```sql
      SHOW DATABASES;
      ```

12. Verify that the list includes the four pre-created databases (information_schema, mysql, performance_schema, and sys) and the testdb that you created in the previous task.

13. From the **MySQL [(none)]** prompt, run the following command to switch to the testdb database:

      ```sql
      use testdb;
      ```

14. From the **MySQL [(testdb)]** prompt, run the following command to create a sample table in the testdb database:

      ```sql
      CREATE TABLE table1 (id int NOT NULL, val int,txt varchar(200));
      ```

15. From the **MySQL [(testdb)]** prompt, run the following command to add a row of data into the newly created table:

      ```sql
      INSERT INTO table1 values (1,100,'text1');
      ```

16. From the **MySQL [(testdb)]** prompt, run the following command to display the newly added data:

      ```sql
      SELECT * FROM table1;
      ```

17. To exit the connection, at the **MySQL [(testdb)]** prompt, enter quit.

### Clean up resources

To delete the Azure Database for MySQL server resource you provisioned in this exercise, you can simply delete its resource group. To do so, complete the following steps:

1. Close the Azure Cloud Shell browser tab.

2. In the Azure portal, on the page displaying the Azure Database for MySQL Flexible Server, in the vertical menu, select **Overview**.

3. On the **Overview** pane, next to the Resource group label, select the **mysql-RG** link.

4. On the **mysql-RG** page, select the **Delete resource group** toolbar entry.

5. When prompted to confirm, in the **TYPE THE RESOURCE GROUP NAME** text box, enter the name of the resource group, and then select **Delete**.