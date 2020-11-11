In this section, in order to deploy your Java Web Application, we will use the `Maven Plugin for Azure App Service`.  
At first, we will add and configure the plugin. After the configuration, you will create an artifact of the Maven project as `war` file. After that you can deploy it to the `Azure App Service` from the Maven command. Then you can access to your application on Azure by using your Web Browser. If you have Azure CLI command, you can also see the Application log stream from the command line.

## Configure Maven Plugin for Azure App Service

In order to add and configure the `Maven Plugin for Azure App Service`, please execute the following command.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

When you execute the command, some question items will be displayed at the prompt, so enter and select the appropriate items and set them. Please enter the following contents this time.

|  Item  |  Input value  |
| ---- | ---- |
|  Subscription  |  Choose the right subscription |
|  Define value for OS  |  1: Linux |
|  Define value for pricingTier | P1v2 |
|  Define value for Java Version  |  1: Java 8 or 2: Java 11 |
|  Define value for Runtime Stack  |  3: TOMCAT 9.0 |
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
Define value for pricingTier [P1v2]:
   1: B1
   2: B2
   3: B3
   4: D1
   5: F1
*  6: P1v2
   7: P2v2
   8: P3v2
   9: S1
  10: S2
  11: S3
Define value for javaVersion [Java 8]:
* 1: Java 8
  2: Java 11
Enter your choice: 1
Define value for runtimeStack:
  1: Jbosseap 7.2
* 2: Tomcat 8.5
  3: Tomcat 9.0
Enter your choice: 3
Please confirm webapp properties
Subscription Id : f77aafe8-6be4-4d3d-bd9c-d0c37687ef70
AppName : azure-javaweb-app-1604982052600
ResourceGroup : azure-javaweb-app-1604982052600-rg
Region : westeurope
PricingTier : PremiumV2_P1v2
OS : Linux
Java : Java 8
Web server stack: Tomcat 9.0
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
            <javaVersion>Java 8</javaVersion>
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
az webapp log tail -g azure-javaweb-app -n azure-javaweb-app-1601463451101
```

Then you can see the following result.

:::image type="content" source="../media/azure-cli-log-stream.png" alt-text="Execution of the Log Stream":::

## Completed the Exercise

Now you finished all of exercises. In this module, you could learn how to create and package the Java Web Application, how to use the `Maven Plugin for Azure Web Apps` and deploy your application to Azure App Service. This procedure is applicable not only for JSF Application but also general Java Web Application like JAX-RS. So if you create Java Web Application, please use this step and deploy your application to Azure App Service.
