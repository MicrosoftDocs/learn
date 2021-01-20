Now that you have everything running locally, let's deploy the application to the cloud and test its behavior in production.

## Create an Azure App Service instance

Let's create an Azure App Service instance to host our application. You'll create a basic application service plan using Linux, and you'll add a Java application service instance in it:

```bash
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
> If you'd rather use Java 11 instead of Java 8, use **"JAVA|11-java11"** as the web application runtime.

> [!NOTE]
> We're re-using the **$AZ_REDIS_NAME** variable to name the Application Service plan and the Application Service instance, but you can use your own names here. Az the Application Service instance name will be part of its URL, it needs to be unique across Azure.

You can go to the next section while this command completes.

## Deploy the Spring Boot application to Azure App Service

In your project's `pom.xml` file, add a new plugin in the `<plugins>` section:

```xml
<plugin>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>azure-webapp-maven-plugin</artifactId>
    <version>1.12.0</version>
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
> In the above configuration, you'll re-use the environment variables you have configured earlier.
> For this configuration to work, your **$AZ_RESOURCE_GROUP** and **$AZ_REDIS_NAME** variables need
> to be correctly setup.

You can now package your application and deploy it to Azure:

```bash
./mvnw package azure-webapp:deploy
```

That command will end up with a line like:

```bash
Successfully deployed the artifact to https://xxxx.azurewebsites.net
```

This is the URL of your running application, which we'll use in the next section.

## Testing the application on Azure

Using the URL from the previous section, you can now use the cURL commands that we were using on our local server, but on the cloud:

To retrieve data:

```bash
curl https://$AZ_REDIS_NAME-webapp.azurewebsites.net
```

To add an item:

```bash
curl -d '{"description":"a description", "details":"some details"}' -H "Content-Type: application/json" -X POST https://$AZ_REDIS_NAME-webapp.azurewebsites.net
```

And to increment your session:

```bash
curl -b cookie.txt -c cookie.txt https://$AZ_REDIS_NAME-webapp.azurewebsites.net/session
```

> [!NOTE]
> As both your local server and your cloud service use the same Redis instance, they are in fact clustered! Any data you write in one instance will be available in the other instance.
> That's also how the cloud service will be able to scale out, by adding more nodes which will all use the same Redis instance to store both business data and session data.
