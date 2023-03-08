You now have the compute service that will host your applications and the config server that will be used by your migrated application. Before you start deploying individual microservices as Azure Spring Apps applications, you need to first create an Azure Database for MySQL Single Server-hosted database for them.

:::image type="content" source="../media/azure-db-for-mysql-diagram-f3bd8fe2.png" alt-text="Diagram that shows MySQL Server interaction with the Azure portal and other management tools.":::


For details on how create an Azure Database for MySQL server using Azure CLI, see this [Quickstart](/azure/mysql/quickstart-create-mysql-server-database-using-azure-cli).

You'll also need to update the config for your applications to use the newly provisioned MySQL Server to authorize access to your private GitHub repository. You'll be updating the application.yml config file for your private git config repo with the values provided in the MySQL Server connection string.

1.  Run the following commands to create an instance of Azure Database for MySQL Single Server. The name of the server must be globally unique, so adjust it accordingly in case the randomly generated name is already in use. Keep in mind that the name can contain only lowercase letters, numbers and hyphens. In addition, replace the *myadmin\_password* placeholder with a complex password and record its value.
    
    ```Bash
    SQL_SERVER_NAME=springappsmysql$RANDOM$
    MYSQL_ADMIN_USERNAME=myadmin
    RANDOM SQL_ADMIN_PASSWORD=<myadmin_password>
    DATABASE_NAME=petclinic
    
    az mysql server create \
        --admin-user myadmin \
        --admin-password ${SQL_ADMIN_PASSWORD} \
        --name ${SQL_SERVER_NAME} \.
        --resource-group ${RESOURCE_GROUP} \
    ```
    
    > [!NOTE]
    > You'll be asked if access to your IP address and access for all IP addresses should be added. Answer no on both questions.
    
    > [!NOTE]
    > Provisioning might take about 3 minutes.

2.  Once the Azure Database for MySQL Single Server instance gets created, it will output details about its settings. In the output, you'll find the server connection string. Record its value since you'll need it later in this exercise.
3.  Run the following commands to create a database in the Azure Database for MySQL Single Server instance.
    
    ```Bash
    az mysql db create \
        --server-name $SQL_SERVER_NAME \
        --resource-group $RESOURCE_GROUP \
        --name $DATABASE_NAME
    ```

4.  You'll need to allow connections to the server from Azure Spring Apps. You'll create a server firewall rule to allow inbound traffic from all Azure Services. This way your apps running in Azure Spring Apps will be able to reach the MySQL database providing them with persistent storage. In one of the upcoming exercises, you'll restrict this connectivity to limit it exclusively to the apps hosted by your Azure Spring Apps instance.
    
    ```Bash
    az mysql server firewall-rule create \
        --rule-name allAzureIPs \
        --name ${MYSQL_SERVER_NAME} \.
        --resource-group ${RESOURCE_GROUP} \
        --start-ip-address 0.0.0.0 \
        --end-ip-address 0.0.0.0
    ```

5.  From the Git Bash window, in the config repository you cloned locally, use your favorite text editor to open the application.yml file. Change the entries in lines 82, 83, and 84 that contains the values of the target datasource endpoint, the corresponding admin user account, and its password. Set these values by using the information in the Azure Database for MySQL Single Server connection string you recorded earlier in this task. Your configuration should look like this:
    
    > [!NOTE]
    > The original content of these three lines in the application.yml file has the following format:
    
    ```
    url: jdbc:mysql://localhost:3306/db?useSSL=false
    username: root
    password: petclinic
    ```
    
    The updated content of these three lines in the application.yml file should have the following format (where the *mysql-server-name* and *myadmin-password* placeholders represent the name of the Azure Database for MySQL Single Server instance and the password you assigned to the myadmin account during its provisioning,
    
    ```
    url: jdbc:mysql://<mysql-server-name>.mysql.database.azure.com:3306/<mysql-database-name>?useSSL=true
    username: myadmin
    password: <myadmin-password> 
    ```
    
    > [!NOTE]
    > Ensure to change the value of the useSSL parameter to true and enforced by default by Azure Database for MySQL Fixed Server.

6.  Save the changes and push the updates you made to the **application.yml** file to your private GitHub repo by running the following commands from the Git Bash prompt:
    
    ```Bash
    git add .
    git commit -m 'azure mysql info'
    git push
    ```
    
    > [!NOTE]
    > The admin account user name and password are stored in clear text in the application.yml config file. In one of upcoming exercises, you'll remediate this potential vulnerability by removing clear text credentials from your configuration.
