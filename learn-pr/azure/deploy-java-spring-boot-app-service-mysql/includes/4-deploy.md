Azure gives developers the option to deploy to Azure directly from Eclipse, IntelliJ, and Maven. In the previous exercise, you created a quick "Todo" example Java web application and tested it locally. Adding the Maven Plugin for Azure App Service to your project allows you to deploy your application to Azure App Service.

In this unit, you'll look at the options for your company to host its applications on Azure App Service. Then you'll see how to add and configure the `azure-webapp-maven-plugin` to your Maven project.

## Adding the Maven Plugin for Azure App Service to your project

> [!NOTE]
> Please check the [Maven Plugin for Azure App Service documention](https://github.com/microsoft/azure-maven-plugins/wiki/Azure-Web-App), or the [Maven Central Repository](https://search.maven.org/artifact/com.microsoft.azure/azure-webapp-maven-plugin/), for information on the latest version of the Maven plugin.

In the next exercise we'll run the following command to setup the plugin interactively.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

The plugin will prompt you for the information that is required to configure the App Service plan. After you've confirmed your choices, the plugin adds the requisite settings to your project's `pom.xml` file that configure your web application to run in Azure App Service.

### Deployment

Maven will create the App Service plan interactively, in the next exercise, you'll use the below Maven command to deploy your application code to Azure.

```bash
mvn package com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:deploy
```

In the next exercise, you'll deploy your web application to Azure App Service.
