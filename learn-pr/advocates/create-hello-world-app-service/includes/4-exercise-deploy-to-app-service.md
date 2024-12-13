Now that we have our Hello World Java app running locally we can now deploy it to Azure App Service.

There are multiple ways to deploy your app to Azure App Service. This Module has two approaches:
1. **Approach 1:** Configure and use the Maven Plugin for Azure App Service to deploy your web app
2. **Approach 2:** Use the Azure CLI to create manually create resources required for deployment and deploy

Our suggestion is Approach 1 as it is an easier way to get started.

## Approach 1: Configure the Maven Plugin for Azure App Service

::: zone pivot="maven-plugin"

### Maven Plugin for Azure App Service

Microsoft provides the Maven Plugin for Azure App Service to make it easier for Java developers to deploy applications to Azure. By using this plug-in, you can easily configure and deploy your application to Azure. Execute the following command to use Maven Plugin for Azure App Service.

### Configure the Maven Plugin for Azure App Service

To configure the Maven Plugin for Azure App Service, execute the following command:

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:2.10.0:config
```

After the command, some questions appear at the prompt, so enter and select the appropriate items and set them. Enter the following options:

| Item                          | Input value                    |
|-------------------------------|--------------------------------|
| Subscription                  | Choose your Azure subscription |
| Define value for OS           | Linux                          |
| Define value for pricing tier | B1                             |
| Define value for Java version | Java 17                        |
| Confirm (Y/N)                 | Y                              |

```output
[INFO] Scanning for projects...
[INFO]
[INFO] --------------------< com.example:hello-java-azure >--------------------
[INFO] Building hello-java-azure 1.0-SNAPSHOT
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- azure-webapp:2.10.0:config (default-cli) @ hello-java-azure ---
Downloading from ossrh: https://oss.sonatype.org/content/repositories/snapshots/net/minidev/json-smart/maven-metadata.xml
Downloading from central: https://repo.maven.apache.org/maven2/net/minidev/json-smart/maven-metadata.xml
Downloading from shibboleth-repo: https://build.shibboleth.net/nexus/content/repositories/releases/net/minidev/json-smart/maven-metadata.xml
Downloaded from central: https://repo.maven.apache.org/maven2/net/minidev/json-smart/maven-metadata.xml (1.3 kB at 6.2 kB/s)
Create new run configuration (Y/N) [Y]: Y
Define value for OS [Linux]:
  1: Windows
* 2: Linux
  3: Docker
Enter your choice: 2
Define value for javaVersion [Java 17]:
* 1: Java 17
Enter your choice: 1
Define value for pricingTier [P1v2]:
   1: B1
   2: B2
   3: B3
   4: D1
   5: EP1
   6: EP2
   7: EP3
   8: F1
*  9: P1v2
  10: P1v3
  11: P2v2
  12: P2v3
  13: P3v2
  14: P3v3
  15: S1
  16: S2
  17: S3
  18: Y1
Enter your choice: 1
Please confirm webapp properties
AppName : hello-java-azure-1731367782304
ResourceGroup : hello-java-azure-1731367782304-rg
Region : centralus
PricingTier : B1
OS : Linux
Java Version: Java 17
Web server stack: Java SE
Deploy to slot : false
Confirm (Y/N) [Y]: Y
[INFO] Saving configuration to pom.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:02 min
[INFO] Finished at: 2024-11-11T15:30:21-08:00
[INFO] ------------------------------------------------------------------------
```

You should see a new section in the `<plugins>` section in your **pom.xml** file.

If you want to change the resource group name, instance name, and deployment location, change `<resourceGroup>`, `<appName>`, and `<region>`.

```xml
<plugin>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>azure-webapp-maven-plugin</artifactId>
    <version>2.10.0</version>
    <configuration>
        <schemaVersion>v2</schemaVersion>
        <resourceGroup>hello-java-azure-1731367782304-rg</resourceGroup>
        <appName>hello-java-azure-1731367782304</appName>
        <pricingTier>B1</pricingTier>
        <region>centralus</region>
        <runtime>
            <os>Linux</os>
            <javaVersion>Java 17</javaVersion>
            <webContainer>Java SE</webContainer>
        </runtime>
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

### Compile and deploy to Azure App Service

Now that the settings for deploying to Azure App Service are complete, compile the source code again:

```bash
mvn clean package
```

Once compiled, use the Maven Plugin for Azure Web Apps command to deploy your application. Execute the following command:

```bash
mvn azure-webapp:deploy
```

When the deployment is completed, you should see the following output:

```output
[INFO] Successfully deployed the artifact to https://hello-java-azure-1731367782304.azurewebsites.net
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  02:47 min
[INFO] Finished at: 2024-11-11T15:39:47-08:00
[INFO] ------------------------------------------------------------------------
```

The public URL of the deployed application is displayed in the output message as follows `Successfully deployed the artifact to https://hello-java-azure-1731367782304.azurewebsites.net`

## Confirm the log stream from the command line

To access the log stream, execute the following CLI command:

```azurecli
az webapp log tail --resource-group <resource-group-name> --name <app-name>
```

You should end up seeing something like this:

```output
2024-11-07T18:14:37  Welcome, you are now connected to log-streaming service.
Starting Log Tail -n 10 of existing logs ----
/appsvctmp/volatile/logs/runtime/container.log
2024-11-07T18:06:05.3874260Z  java.base/java.lang.Thread.run(Thread.java:1583)
2024-11-07T18:06:05.5635356Z Nov 07, 2024 6:06:05 PM org.apache.coyote.AbstractProtocol stop
2024-11-07T18:06:05.5636042Z INFO: Stopping ProtocolHandler ["http-nio-127.0.0.1-80"]
2024-11-07T18:06:05.6020767Z Nov 07, 2024 6:06:05 PM org.apache.coyote.AbstractProtocol stop
2024-11-07T18:06:05.6021438Z INFO: Stopping ProtocolHandler ["http-nio-169.254.129.3-80"]
2024-11-07T18:06:05.6423756Z Nov 07, 2024 6:06:05 PM org.apache.coyote.AbstractProtocol destroy
2024-11-07T18:06:05.6424403Z INFO: Destroying ProtocolHandler ["http-nio-127.0.0.1-80"]
2024-11-07T18:06:05.6893602Z Nov 07, 2024 6:06:05 PM org.apache.coyote.AbstractProtocol destroy
2024-11-07T18:06:05.6894311Z INFO: Destroying ProtocolHandler ["http-nio-169.254.129.3-80"]
2024-11-07T18:06:05.7849816Z Done processing signal SIGTERM. Exiting now!
Ending Log Tail of existing logs ---
Starting Live Log Stream ---
```

::: zone-end

::: zone pivot="azure-cli"

## Approach 2: Use the Azure CLI to deploy to Azure App Service

### Install the Azure CLI (if not already installed)

Install the Azure CLI. For more information, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

### Log in to Azure

```azurecli
az login
```

### Set variables

In your code, replace the placeholders with the values in the following table. These values are used throughout this module.

```bash
export RESOURCE_GROUP="appServiceWorkshop"
export LOCATION="<region>"
export APP_SERVICE_PLAN="myAppServicePlan"
export WEBAPP_NAME="<web-app-name>"      # Ensure this name is globally unique
export JAR_FILE_PATH="<jar-file-path>"  # Replace with the actual path to your JAR file
```

In your code, replace the placeholders with the values in the following table. These values are used throughout this module.

| Variable          | Description                                                                                                                                                                                                     |
|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `<web-app-name>`  | The name of your WebApp. It should be unique across Azure.                                                                                                                                                      |
| `<region>`        | The Azure region you want to use. You can use `eastus` by default, but we recommend that you use a region close to where you live. To see the full list of available regions, enter `az account list-locations` |
| `<jar-file-path>` | This is where your **.jar** file was saved in your project directory - for example, **target/\<jar-file>**. Make sure you set the path of this variable to be the full path from your project directory         |

### Create a resource group

```azurecli
az group create \
    --name $RESOURCE_GROUP \
    --location $LOCATION
```

### Create an App Service plan

```azurecli
az appservice plan create \
    --name $APP_SERVICE_PLAN \
    --resource-group $RESOURCE_GROUP \
    --is-linux \
    --sku B1
```

### Create a web app

```azurecli
az webapp create \
    --resource-group $RESOURCE_GROUP \
    --plan $APP_SERVICE_PLAN \
    --name $WEBAPP_NAME \
    --runtime "JAVA|17-java17"
```

### Deploy the app

```azurecli
az webapp deploy \
    --resource-group $RESOURCE_GROUP \
    --name $WEBAPP_NAME \
    --src-path $JAR_FILE_PATH\
```

It's normal for the deployment process to take several minutes.

### Visit your deployed Java web app

```bash
echo "Your website is at https://$(az webapp show \
    --name $WEBAPP_NAME \
    --resource-group $RESOURCE_GROUP \
    --query defaultHostName \
    --output tsv)"
```

When you run this command, it outputs something like: `Your website is at https://<your-app-name>.azurewebsites.net`

When select the link, you should see "Hello, Java on Azure!" on the screen.

Congratulations! You successfully deployed a web app to Azure App Service.

::: zone-end

## Exercise summary

In this unit, you learned how to create and package a Java web application, how to use the Maven Plugin for Azure Web Apps, and how to deploy your application to Azure App Service. These steps are applicable not only for JSF applications but also most Java web applications.