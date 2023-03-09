In this unit, you'll lock down access to your MySQL database by redeploying it inside a subnet. MySQL Flexible Server currently doesn't support private endpoint connections. Thus you'll deploy it inside a subnet.

Once you've enabled a private endpoint, you can block public access to your database.<br>

1.  You'll delete the previous MySQL Flexible server instance.
    
    ```Bash
    az mysql  flexible-server delete \
        --name $MYSQL_SERVER_NAME \
        --resource-group $RESOURCE_GROUP \ 
        --yes
    ```

2.  Next, create a private DNS zone for the new MySQL Flexible Server instance. You'll set the DNS zone to `private.mysql.database.azure.com`.
    
    ```
    MYSQL_DNS="private.mysql.database.azure.com"
    az network private-dns zone create -g $RESOURCE_GROUP -n $MYSQL_DNSs.
    ```

3.  Next, recreate the MySQL Flexible Server and link it to the DNS zone. When you link the new server instance to the DNS zone, MySQL Flexible server will link your DNS Zone to your VNet. The link will add an A record to the DNS zone for the name of your database.
    
    ```Bash
    MYSQL_SERVER_NAME=mysql-vnet$APPNAME-$UNIQUEID
    az mysql flexible-server create \
        --name ${MYSQL_SERVER_NAME} \
        --resource-group ${RESOURCE_GROUP}  \
        --location $LOCATION \
        --admin-user myadmin \
        --admin-password ${MYSQL_ADMIN_PASSWORD} \
        --sku-name Standard_B1ms  \
        --tier Burstable \
        --version 5.7 \
        --storage-size 20 \
        --vnet $VIRTUAL_NETWORK_NAME \
        --subnet $DATABASE_SUBNET_NAME \
        --private-dns-zone $MYSQL_DNS
    ```

4.  Recreate the `petclinic` database.
    
    ```Bash
    az mysql flexible-server db create \
        --server-name $MYSQL_SERVER_NAME \
        --resource-group $RESOURCE_GROUP \
        -d $DATABASE_NAME
    ```
5.  Display the FQDN of your newly created MySQL Flexible Server, you'll use this value to update the `spring.datasource.url` property in your config repo.
    
    ```Bash
    az mysql flexible-server show \
        --name $MYSQL_SERVER_NAME \
        --resource-group $RESOURCE_GROUP \
        --query fullyQualifiedDomainName
    ```

6.  From the Git Bash window, in the config repository you cloned locally, use your favorite text editor to open the `application.yml` file. Update the `url` of the `datasource` to now use your MYSQL Vnet integrated instance.
    
    ```azurecli
    url: jdbc:mysql://<your-vnet-integrated-server-name>.mysql.database.azure.com:3306/petclinic?useSSL=true
    ```

7.  Restart the spring apps that use the backend database to use the new connection string information.
    
    ```azurecli
    az spring app restart \
        --name customers-service \
        --resource-group $RESOURCE_GROUP \
        --service $SPRING_APPS_SERVICE \
        --no-wait
    
    az spring app restart \
        --name vets-service \
        --resource-group $RESOURCE_GROUP \
        --service $SPRING_APPS_SERVICE \
        --no-wait
    
    az spring app restart \
        --name visits-service \
        --resource-group $RESOURCE_GROUP \
        --service $SPRING_APPS_SERVICE \
        --no-wait
    
    ```

8.  You should be able to browse the spring petclinic app and see the data.

9.  In the Azure portal, navigate to your newly created MySQL Flexible Server and select the **Networking** menu. You'll notice you can no longer lock down the server firewall. The server however only allows incoming calls through the virtual network.
