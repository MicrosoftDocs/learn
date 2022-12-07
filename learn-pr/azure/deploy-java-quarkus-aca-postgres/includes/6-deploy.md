Developers can deploy to Azure directly from Eclipse, IntelliJ, or Maven. In the previous exercise, you created a to-do example Java web application and tested it locally. By adding Maven Plugin for Azure App Service to your project, you can deploy your application to Azure App Service.

In this unit, you'll see how to add and configure `azure-webapp-maven-plugin` for your Maven project.

## Add Maven Plugin for Azure App Service to your project

> [!NOTE]
> For information about the latest version of Maven Plugin, check the [Maven Plugin for Azure App Service documentation](https://github.com/microsoft/azure-maven-plugins/wiki/Azure-Web-App) or the [Maven central repository](https://search.maven.org/artifact/com.microsoft.azure/azure-webapp-maven-plugin/).

In the next exercise, you run the following command to set up the plug-in interactively.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

The plug-in will prompt you for information to configure the App Service plan. After you confirm your choices, the plug-in adds the required settings to your project's *pom.xml* file to configure your web application to run in Azure App Service.

## Deploy

Maven creates the App Service plan interactively. In the next exercise, you'll use the following Maven command to deploy your application code to Azure App Service.

```bash
mvn package com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:deploy
```
