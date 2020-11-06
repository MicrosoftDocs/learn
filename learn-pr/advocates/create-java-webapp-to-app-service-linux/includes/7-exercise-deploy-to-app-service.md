Now that we have verified the operation with Tomcat in the local environment, deploy the application to Azure App Services.
You can use the `Maven Plugin for Azure App Service` to deploy to Azure App Service. Please specify the latest version.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

When you execute the command, some question items will be displayed at the prompt, so enter and select the appropriate items and set them. Please enter the following contents this time.

|  Item  |  Input value  |
| ---- | ---- |
|  Subscription  |  Choose the right subscription |
|  Define value for OS  |  1: Linux |
|  Define value for Java Version  |  1: Java 11 |
|  Define value for Runtime Stack  |  1: TOMCAT 9.0 |
|  Confirm (Y/N)  |  Y |

When you execute it, the following will be displayed.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF-8
[INFO] Scanning for projects...
[INFO]
[INFO] -----------< com.microsoft.azure.samples:azure-javaweb-app >------------
[INFO] Building azure-javaweb-app Maven Webapp 1.0-SNAPSHOT
[INFO] --------------------------------[ war ]---------------------------------
[INFO]
[INFO] --- azure-webapp-maven-plugin:1.12.0:config (default-cli) @ azure-javaweb-app ---

Available subscriptions:
* 1: My Subscription (********-****-****-****-************)
Please choose a subscription [My Subscription]: [Enter]
[INFO] It may take a few minutes to load all Java Web Apps, please be patient.
[WARNING] There are no Java Web Apps in current subscription, please follow the following steps to create a new one.
Define value for OS [Linux]:
* 1: Linux
  2: Docker
  3: Windows
Enter your choice:
Define value for javaVersion:
  1: Java 11
* 2: Java 8
Enter your choice: 1
Define value for runtimeStack:
  1: TOMCAT 9.0
* 2: TOMCAT 8.5
Enter your choice: 1
Please confirm webapp properties
Subscription Id : ********-****-****-****-************
AppName : azure-javaweb-app-1601541274402
ResourceGroup : azure-javaweb-app-1601541274402-rg
Region : westeurope
PricingTier : PremiumV2_P1v2
OS : Linux
RuntimeStack : TOMCAT 9.0-java11
Deploy to slot : false
Confirm (Y/N) [Y]: y
[INFO] Saving configuration to pom.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  37.656 s
[INFO] Finished at: 2020-10-01T17:24:02+09:00
[INFO] ------------------------------------------------------------------------
```

When you succeeded the command, the `<plugins>` entry similar to the following will be added to the `pom.xml` file.

If you want to change the resource group name, instance name, and deployment location, please change the `<resourceGroup>`, `<appName>`, and `<region>`, entries respectively.

Also, in order to listen to the PORT number 80 on Azure App Services, we need to configure the port transfer setting on `PORT` and `WEBSITES_PORT` inside of the `<appSettings>`.
Because Tomcat start the service with port number 8080 by default.
And also we need to configure the timeout of startup time on  `WEBSITES_CONTAINER_START_TIME_LIMIT`.

```xml
    <plugins>
      <plugin>
        <groupId>com.microsoft.azure</groupId>
        <artifactId>azure-webapp-maven-plugin</artifactId>
        <version>1.12.0</version>
        <configuration>
          <schemaVersion>V2</schemaVersion>
          <subscriptionId>********-****-****-****-************</subscriptionId>
          <resourceGroup>azure-javaweb-app</resourceGroup>
          <appName>azure-javaweb-app-1601463451101</appName>
          <pricingTier>P1v2</pricingTier>
          <region>japaneast</region>
          <runtime>
            <os>linux</os>
            <javaVersion>java11</javaVersion>
            <webContainer>TOMCAT 9.0</webContainer>
          </runtime>

          <appSettings>
            <property>
              <name>PORT</name>
              <value>8080</value>
            </property>
            <property>
              <name>WEBSITES_PORT</name>
              <value>8080</value>
            </property>
            <property>
              <name>WEBSITES_CONTAINER_START_TIME_LIMIT</name>
              <value>600</value>
            </property>
          </appSettings>

          <deployment>
            <resources>
              <resource>
                <directory>${project.basedir}/target</directory>
                <includes>
                  <include>*.war</include>
                </includes>
              </resource>
            </resources>
          </deployment>
        </configuration>
      </plugin>
    </plugins>
```

### Compile & Deploy to Azure  App Services

Now that the settings for deploying to Azure App Services are complete, so please compile the source code again.

```bash
mvn clean package
```

Once compiled, use the `Maven Plugin for Azure Web Apps` command to deploy your application.
Execute the following command.

```bash
mvn azure-webapp:deploy
```

When the deployment is completed, the following message will be output.

```text
[INFO] Successfully deployed the artifact to https://azure-javaweb-app-1601463451101.azurewebsites.net
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:35 min
[INFO] Finished at: 2020-09-30T20:02:37+09:00
[INFO] ------------------------------------------------------------------------
```

When you check the message, the public URL of the deployed application is displayed in `Successfully deployed the artifact to`, so access the URL with a browser.

`https://azure-javaweb-app-1601463451101.azurewebsites.net`

:::image type="content" source="../media/deployed-to-the-appservices.png" alt-text="Deployed Web App on Azure App Services":::

## Confirm the Log Stream from Command Line

To confirm the Log Stream, Azure CLI provide the sub command. In this command, you can see the application log on your terminal.  

Execute the following command?

```azurecli
az webapp log tail -g azure-javaweb-app-1601463451101 -n azure-javaweb-app
```

Then you can see the following result.

:::image type="content" source="../media/azure-cli-log-stream.png" alt-text="Execution of the Log Stream":::
