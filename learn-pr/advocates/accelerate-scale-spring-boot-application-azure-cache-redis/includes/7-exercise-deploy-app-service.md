Now that everything runs locally, you can deploy the application to the cloud and test its behavior in production.

## Create an Azure App Service instance

Create an Azure App Service instance to host your application. Use the following Azure CLI code to create a basic App Service plan that uses Linux, and then add an instance of Java on App Service in that plan.

To use Java 11 or Java 17 instead of Java 8, use `"JAVA|<version>-java<version>"` instead of `"JAVA|8-jre8"` as the web application runtime.

```azurecli
az appservice plan create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_REDIS_NAME-webapp-plan \
    --is-linux \
    --sku B1

az webapp create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_REDIS_NAME-webapp \
    --runtime "JAVA|8-jre8" \
    --plan $AZ_REDIS_NAME-webapp-plan
```

> [!NOTE]
> The preceding code reuses the `$AZ_REDIS_NAME` variable to name the App Service plan and App Service instance, but you can use different names. The App Service instance name is part of the URL, which must be unique across Azure.

You can do the next step while this deployment finishes.

## Deploy the Spring Boot application to Azure App Service

1. In your project's *pom.xml* file, add the following new plug-in in the `<plugins>` section:

   ```xml
   <plugin>
       <groupId>com.microsoft.azure</groupId>
       <artifactId>azure-webapp-maven-plugin</artifactId>
       <version>2.11.0</version>
       <configuration>
           <schemaVersion>V2</schemaVersion>
           <resourceGroup>${env.AZ_RESOURCE_GROUP}</resourceGroup>
           <appName>${env.AZ_REDIS_NAME}-webapp</appName>
           <deployment>
               <resources>
                   <resource>
                       <directory>${project.basedir}/target</directory>
                       <includes>
                           <include>*.jar</include>
                       </includes>
                   </resource>
               </resources>
           </deployment>
       </configuration>
   </plugin>
   ```

   > [!NOTE]
   > The preceding configuration uses the environment variables that you configured earlier. For this configuration to work, make sure your `$AZ_RESOURCE_GROUP` and `$AZ_REDIS_NAME` variables are correctly set up.

1. After the App Service deployment finishes, run the following command to package your application and deploy it to Azure:

   ```bash
   ./mvnw package azure-webapp:deploy
   ```

1. When the deployment completes successfully, it returns the following line:

   ```output
   Successfully deployed the artifact to https://<redisName>-webapp.azurewebsites.net
   ```

   Note the URL of your running application, as shown in the preceding output, to use in the next section.

## Test the application on Azure

Use your application URL to run the same client URL (cURL) commands in the cloud that you used on your local server.

1. To add a data item, run the following command:

   ```bash
   curl -d '{"description":"another description", "details":"some more details"}' -H "Content-Type: application/json" -X POST https://$AZ_REDIS_NAME-webapp.azurewebsites.net
   ```

1. To retrieve the data, run:

   ```bash
   curl https://$AZ_REDIS_NAME-webapp.azurewebsites.net
   ```

1. To increment your session, run the following command several times:

   ```bash
   curl -b cookie.txt -c cookie.txt https://$AZ_REDIS_NAME-webapp.azurewebsites.net/session
   ```

Your local server and your cloud service use the same Redis instance, so they're clustered. Data that you write in one instance is available in the other instance. The cloud service can scale out by adding more nodes that all use the same Redis instance to store both business data and session data.
