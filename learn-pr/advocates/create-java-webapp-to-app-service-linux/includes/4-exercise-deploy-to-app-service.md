In this unit, you deploy your Java Tomcat web app to Azure App Service.

## Maven Plugin for Azure App Service

Microsoft provides the Maven Plugin for Azure App Service to make it easier for Java developers to deploy applications to Azure. By using this plug-in, you can easily configure and deploy your application to Azure. Use the steps in the following sections to configure the Maven Plugin for Azure App Service, compile your source code, and deploy your app.

### Configure the Maven Plugin for Azure App Service

To configure the Maven Plugin for Azure App Service, use the following command:

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:2.10.0:config
```

After you use the command, some questions appear at the prompt, enabling you to configure various options. Configure the options and values according to the information in the following table:

| Item                           | Input value                     |
|--------------------------------|---------------------------------|
| Subscription                   | Choose your Azure subscription. |
| Define value for OS            | Linux                           |
| Define value for pricing tier  | B1                              |
| Define value for Java version  | Java 21                         |
| Define value for runtime stack | TOMCAT 10.0                     |
| Confirm (Y/N)                  | Y                               |

After you configure the options, the following is typical output:

```output
mvn com.microsoft.azure:azure-webapp-maven-plugin:2.10.0:config
[INFO] Scanning for projects...
[INFO] 
[INFO] -------------------< com.example:simple-tomcat-app >--------------------
[INFO] Building simple-tomcat-app 1.0-SNAPSHOT
[INFO]   from pom.xml
[INFO] --------------------------------[ war ]---------------------------------
[INFO] 
[INFO] --- azure-webapp:2.10.0:config (default-cli) @ simple-tomcat-app ---
Downloading from central: https://repo.maven.apache.org/maven2/net/minidev/json-smart/maven-metadata.xml
Downloading from ossrh: https://oss.sonatype.org/content/repositories/snapshots/net/minidev/json-smart/maven-metadata.xml
Downloading from shibboleth-repo: https://build.shibboleth.net/nexus/content/repositories/releases/net/minidev/json-smart/maven-metadata.xml
Downloaded from central: https://repo.maven.apache.org/maven2/net/minidev/json-smart/maven-metadata.xml (1.3 kB at 6.3 kB/s)
Please choose which part to config [Application]:
* 1: Application
  2: Runtime
  3: DeploymentSlot
Enter your choice: 1
Define value for appName [simple-tomcat-app]: tomcatmavendemo
Define value for resourceGroup [tomcatmavendemo-rg]: MyResourceGroup
Define value for region [{azure.region}]: centralus
Define value for pricingTier [B1]:
*  1: B1
   2: B2
   3: B3
   4: D1
   5: EP1
   6: EP2
   7: EP3
   8: F1
   9: P1v2
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
AppName : tomcatmavendemo
ResourceGroup : MyResourceGroup
Region : centralus
PricingTier : B1
OS : Linux
Java Version: 21
Web server stack: Tomcat 10.1
Deploy to slot : false
Confirm (Y/N) [Y]: Y
[INFO] Saving configuration to pom.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:49 min
[INFO] Finished at: 2024-11-07T09:54:55-08:00
[INFO] ------------------------------------------------------------------------
```

Your **pom.xml** file now contains a new section in the `<plugins>` section. If you want to change the resource group name, instance name, or deployment location, change `<resourceGroup>`, `<appName>`, or `<region>`. The following is a typical **pom.xml** file:

```xml
      <!-- Azure Web App Maven Plugin -->
<plugin>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>azure-webapp-maven-plugin</artifactId>
    <version>2.10.0</version>
    <configuration>
        <resourceGroup>MyResourceGroup</resourceGroup>
        <appName>tomcatmavendemo</appName>
        <region>centralus</region>
        <pricingTier>B1</pricingTier>
        <runtime>
            <os>linux</os>
            <javaVersion>21</javaVersion>
            <webContainer>Tomcat 10.1</webContainer>
        </runtime>
        <deployment>
            <resources>
                <resource>
                    <directory>${project.build.directory}</directory>
                    <includes>
                        <include>*.war</include>
                    </includes>
                </resource>
            </resources>
        </deployment>
    </configuration>
</plugin>
```

### Compile and deploy to Azure App Service

You finished configuring the settings for deploying to Azure App Service. Compile the source code again by using the following command:

```bash
mvn clean package
```

After the source code is compiled, use the following Maven Plugin for Azure Web Apps command to deploy your application:

```bash
mvn azure-webapp:deploy
```

When the deployment is complete, the following is typical output:

```bash
[INFO] Successfully deployed the artifact to https://tomcatmavendemo.azurewebsites.net
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  06:55 min
[INFO] Finished at: 2024-11-07T10:05:19-08:00
[INFO] ------------------------------------------------------------------------
```

The following is typical output providing the public URL of the deployed application: `Successfully deployed the artifact to https://tomcatmavendemo.azurewebsites.net`

:::image type="content" source="../media/deployed-to-app-service.png" alt-text="Screenshot that shows the deployed web app in a browser." lightbox="../media/deployed-to-app-service.png":::

## Confirm the log stream from the command line

To access the log stream, use the following command:

```azurecli
az webapp log tail \
    --resource-group <your-resource-group> \
    --name <your-app-name>
```

The following is typical output:

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

## Exercise summary

In this unit, you learned how to create a Tomcat web app using Maven. You also learned how to create a servlet and how it works. Next, you deployed your web app locally using Tomcat. Finally, you deployed to Azure App Service for anyone in the world to access!
