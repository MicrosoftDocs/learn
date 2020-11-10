Now that we have confirmed the operation in the local environment, we will explain how to deploy the Java Web Application to the Cloud environment.
Azure allows you to deploy Java web applications to different environments depending on your purpose like below.

* General VM (Linux, Windows)
* Azure App Service
* Azure App Service for Container
* Azure Container Instances
* Azure Kubernetes Service
* Azure Red Hat OpenShift
* Azure Spring Cloud

You can flexibly choose which environment to deploy according to the application to be created and the service to be provided.
The application created in the previous section is an application that runs on Tomcat, so here I would like to select an environment that allows you to quickly and easily create and run Tomcat on Azure. Azure provides Azure App Service as Platform as a Service as the environment for running Tomcat.
This section gives you an overview of Azure App Service.

## What is Azure App Service

Azure App Service is an HTTP-based service for running web applications, REST APIs, and mobile backend.
A Windows environment and a Linux environment are available, and the environment can be selected according to the user's wishes.
It features security, load balancing, autoscaling, auto managing, and even integrates with CI / CD environments such as Azure DevOps and GitHub.
By using this, you can leave OS management and Java VM, Tomcat version control to Azure, and users can concentrate on building business applications, and with few management items, it can be applied to production environments.

:::image type="content" source="../media/app-service-portal-screen.png" alt-text="Azure Portal Screen":::

Also, if you use Azure App Service, you can log in with SSH or Bash using a browser from the Azure Portal screen, and you can check the application log from the browser, which is very convenient for analysis in the event of a failure.

:::image type="content" source="../media/Advanced-Toold-for-Appservice.png" alt-text="Advanced Tool for App Service":::

## Java Deployment Options for App Service

:::image type="content" source="../media/app-service-java-runtime-options.png" alt-text="Java Runtime Selection":::

If you use the Azure Portal Screen, you can select the version of Java VM to use with App Service. In App Service, you can select either `Java 11` or `Java 8` as shown below.
If you select `Java SE 8` or `Java 11`, you can select the Tomcat 9.0 as `Java Web Server Stack`.

| Runtime Stack |  Java 11  |  Java 8  |
| ---- | ---- | ---- |
|Java Web Server Stack| Tomcat 9.0 |  Tomcat 9.0  |

This ToDo sample application runs on Tomcat 9.0, so select Tomcat 9.0.

## Maven Plugin for Azure App Service

Microsoft provides the `Maven Plugins for Azure Services` to make it easier for Java developers to deploy applications to Azure.

* Maven Plugin for Azure App Service

By using this plugin, you can easily deploy your application to Azure environment.
Execute the following command to use `Maven Plugin for Azure App Service`.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

After configured for deploying to App Service, you can deploy your application with following command.

```bash
mvn clean package
mvn azure-webapp:deploy
```

