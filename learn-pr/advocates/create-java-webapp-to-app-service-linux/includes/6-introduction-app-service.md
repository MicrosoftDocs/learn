Now you can run your application in a local environment, we'll explain how to deploy it to Azure.
Azure allows you to deploy Java web applications to different environments:

* General VM (Linux, Windows)
* Azure App Service
* Azure App Service for Container
* Azure Container Instances
* Azure Kubernetes Service
* Azure Red Hat OpenShift
* Azure Spring Cloud

## What is Azure App Service

Azure provides Azure App Service as Platform as a Service as the environment for running Tomcat.
It features a Window and Linux environments, security, load balancing, autoscaling, and DevOps integration.

You can leave OS and Tomcat management to Azure, and concentrate on building applications.

:::image type="content" source="../media/app-service-portal-screen.png" alt-text="Azure portal Screen":::

Azure App Service allows you to sign in with SSH or Bash using a browser, and you can check the application log from the browser.

:::image type="content" source="../media/Advanced-Toold-for-Appservice.png" alt-text="Advanced Tool for App Service":::

## Java Deployment Options for App Service

If you use the Azure portal, you can select the version of Java VM to use with App Service. In App Service, you can select either `Java 8` or `Java 11` as shown below.
If you select the Java Runtime, you can select the `Tomcat 9.0` as `Java Web Server Stack`.

:::image type="content" source="../media/app-service-java-runtime-options.png" alt-text="Java Runtime Selection":::

| Runtime Stack |  Java 11  |  Java 8  |
| ---- | ---- | ---- |
|Java Web Server Stack| Tomcat 9.0 |  Tomcat 9.0  |

## Maven Plugin for Azure App Service

Microsoft provides the `Maven Plugins for Azure Services` to make it easier for Java developers to deploy applications to Azure.
By using this plugin, you can easily configure and deploy your application to Azure.
Execute the following command to use `Maven Plugin for Azure App Service`.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

After configured for deploying to App Service, you can deploy your application with following command.

```bash
mvn clean package
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:deploy
```
