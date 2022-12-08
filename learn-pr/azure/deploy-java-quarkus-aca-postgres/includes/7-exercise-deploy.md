In this unit, you'll configure your Quarkus application to be deployed through Maven. Then you'll create and deploy to an Azure Container Apps instance.






```bash
az containerapp up \
    --name "$AZ_CONTAINERAPP" \
    --environment "$AZ_CONTAINERAPP_ENV" \
    --location "$AZ_LOCATION" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --ingress external \
    --source src/main/docker/
```

```bash
Using resource group 'rg-azure-deploy-quarkus'
Creating ContainerAppEnvironment 'cae-azure-deploy-quarkus' in resource group rg-azure-deploy-quarkus
No Log Analytics workspace provided.
Generating a Log Analytics workspace with name "workspace-rgazuredeployquarkusEED7"
Creating Azure Container Registry ca001ad52ae7acr in resource group rg-azure-deploy-quarkus
```

> [!NOTE]
> This module uses the `jq` tool, which is installed by default on [Azure Cloud Shell](https://shell.azure.com/) to display JSON data and make it more readable.
>
> If you don't want to use the `jq` tool, you can safely remove the `| jq` part of all commands in this module.

### Configure a firewall rule for your PostgreSQL server

Azure Database for PostgreSQL is secured by default. Its firewall allows no incoming connections. So add a firewall rule to allow the local IP address to access the database server.

Run the following command to open the server's firewall:

```bash
az mysql server firewall-rule create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_DATABASE_NAME-database-allow-local-ip \
    --server-name $AZ_DATABASE_NAME \
    --start-ip-address $AZ_LOCAL_IP_ADDRESS \
    --end-ip-address $AZ_LOCAL_IP_ADDRESS \
    | jq
```

Run the following command to allow firewall access from Azure resources:

```bash
az mysql server firewall-rule create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name allAzureIPs \
    --server-name $AZ_DATABASE_NAME \
    --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0 \
    | jq
```

### Configure a PostgreSQL database

The PostgreSQL server that you created earlier is empty. It has no database that you can use with the Quarkus application. Create a new database called `demo`:

```bash
az mysql db create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name demo \
    --server-name $AZ_DATABASE_NAME \
    | jq
```



## Configure the Maven plug-in

The deployment process to Azure Container Apps automatically uses your Azure credentials from the Azure CLI.

Run the following Maven command to configure the deployment. This command helps you set up the App Service operating system, Azure subscription, and Java version.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

1. When you're prompted with the **Subscription** option, select a subscription by entering the appropriate number at the beginning of the line.
1. When you're prompted with the **Web App** option, accept the default option `<create>` by pressing Enter.
1. When you're prompted with the **OS** option, select `linux` by pressing Enter.
1. Choose the default Java version, 1.8, by pressing Enter.
1. At the last prompt, press Enter to confirm your selections.

    ```bash
    Please confirm webapp properties
    AppName : demo-1604579125693
    ResourceGroup : demo-1604579125693-rg
    Region : eastus
    PricingTier : PremiumV2_P1v2
    OS : Linux
    Java : Java 8
    Web server stack: Java SE
    Deploy to slot : false
    Confirm (Y/N) [Y]: Y
    [INFO] Saving configuration to pom.
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  28.781 s
    [INFO] Finished at: 2020-11-05T14:30:00+02:00
    [INFO] ------------------------------------------------------------------------
    ```


> [!IMPORTANT]
> The default value for the region is `westeurope`. For the best performance, change the value to `eastus` because your database is located in this region.

In your project's *pom.xml* file, change the following field.

```xml
    <configuration>
        ...
        <region>eastus</region>
        ...
    </configuration>
```

## Deploy the app

The Maven deployment plug-in creates your Azure Container Apps server. It copies your JAR file to the application server's */local/site/wwwroot* directory. Finally, the plug-in starts your application by using your Quarkus JAR file's embedded HTTP server.

Next, deploy your Quarkus application to Azure by using the following command:

```bash
mvn package com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:deploy
```
This screenshot shows the application deployed to Azure Container Apps:

![Screenshot showing the deployed application.](../media/5-spring-boot-01.png)

## Test the Azure Container Apps application

When the deployment finishes, your application is ready at `http://<appName>.azurewebsites.net/`. 

To test the application, you can use `cURL`.

As you redeployed your application, you cleared the database. Now you need to create a new to-do item in the database:

```bash
curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"description":"configuration","details":"congratulations, you have set up your Quarkus application correctly!","done": "true"}' \
    http://<appName>.azurewebsites.net
```

This command should return the created item:

```json
{"id":1,"description":"configuration","details":"congratulations, you have set up your Quarkus application correctly!","done":true}
```

Retrieve the data by using a new `cURL` request:

```bash
curl http://<appName>.azurewebsites.net
```

This command returns the list of to-do items, including the item you created:

```json
[{"id":1,"description":"configuration","details":"congratulations, you have set up your Quarkus application correctly!","done":true}]
```

> [!NOTE]
> You can also open the URL in a web browser to return the list of to-do items.
