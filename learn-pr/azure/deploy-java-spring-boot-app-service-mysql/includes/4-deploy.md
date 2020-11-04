Azure gives developers the option to deploy to Azure directly from Eclipse, IntelliJ, and Maven.For maven, the `azure-webapp-maven-plugin` has two goals for Java developers: the first is to make managing and configuring the Azure App Service plugin easier, and the second is to simplify deploying Maven projects to Azure App Service. In the previous exercise, you created a quick "hello world" example Java web app and tested it locally. Adding the Maven Plugin for Azure App Service to your project allows you to deploy your app to Azure App Service.

In this unit, you'll look at the options for your company to host its apps on Azure App Service. Then you'll see how to add and configure the `azure-webapp-maven-plugin` to your Maven project.

## Adding the Maven Plugin for Azure App Service to your project

To add the Maven Plugin for Azure App Service to your web app, you need to add a dependency for `azure-webapp-maven-plugin` to your project's `pom.xml` file.

The following excerpt illustrates the XML elements that you need to add to your project's `pom.xml` file:

```xml
<plugin>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-webapp-maven-plugin</artifactId>
  <version>1.9.0</version>
</plugin>
```

> [!NOTE]
> Please check the [Maven Plugin for Azure App Service documention](https://github.com/microsoft/azure-maven-plugins/wiki/Azure-Web-App), or the [Maven Central Repository](https://search.maven.org/artifact/com.microsoft.azure/azure-webapp-maven-plugin/), for information on the latest version of the Maven plugin.

After you've added the plugin to your project's `pom.xml` file, you can run the following command to complete the plugin setup interactively.

```bash
mvn azure-webapp:config
```

The plugin will prompt you for the information that is required to configure the App Service plan. After you've confirmed your choices, the plugin adds the requisite settings to your project's `pom.xml` file that configure your web app to run in Azure App Service.

### Deployment

Maven will create the App Service plan interactively, you use the same Maven command to deploy your application code to Azure.

```bash
mvn package azure-webapp:deploy
```

In the next exercise, you'll deploy your web app to Azure App Service.
