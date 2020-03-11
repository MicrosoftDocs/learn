The `azure-webapp-maven-plugin` has two goals for Java developers: the first is to make managing and configuring the Azure App Service plugin easier, and the second is to simplify deploying Maven projects to Azure App Service. In the previous exercise, you created a quick "hello world" example Java web app and tested it locally. Adding the Maven Plugin for Azure App Service to your project allows you to deploy your app to Azure App Service.

In this unit, you'll look at the options for your company to host its apps on Azure App Service. Then you'll see how to add and configure the `azure-webapp-maven-plugin` to your Maven project.

## Introduction to the Azure App Service

The Azure App Service allows you to host your company's websites, web apps, REST APIs, and other application code on Azure. Your project code is running in the cloud; you don't have to provision or configure any infrastructure. Running your web app in Azure App Service provides you with all the benefits of running on Azure: your app is globally available, it scales automatically, has security and compliance built-in, and you only pay for the resources you use.

### Features

Azure App Service supports multiple programming languages, which allows developers to continue writing their applications using the languages where they're most comfortable. Java is a first-class citizen, along with other languages like .NET Core, Python, Node.js, etc. The web apps you create can be hosted on Linux, Windows, or inside a docker container. Before you deploy your web app to Azure, you'll create an App Service plan on Azure that specifies the OS and the pricing tier, which determines the size of the provisioned compute resources that your app needs.

There are three categories of pricing tier:

 - **Free and Shared**
 
     This tier is only for development and testing. The resources are shared with other Azure customers, and apps can't be scaled out.

 - **Basic, Standard, Premium, and Premium V2**
 
     Apps have dedicated resources. Apps in the same App Service plan can share the same compute resources. Scale-out can be done, with more options available at the higher price tiers.

- **Isolated**

    This plan includes network and compute isolation. This tier has the maximum scale-out capabilities.

### Why use an App Service?

Azure has lots of different options if you need to run your application code in the cloud. Azure App Service is one of those options, but if your code has different requirements, you might choose a different option. For example, you might want to use Azure App Service when you don't need full control of the hosting environment.

The following flowchart can help you decide if using an Azure App Service is the best solution for your application code.

![Flowchart on how to decide to use an App Service](../media/4-compute-decision-tree.png)

## Maven workflows

Maven has three built-in lifecycles for building projects: `default`, `clean`, and `site`, where the `default` lifecycle includes the following phases:

| Phase | Description |
|---|---
| `compile` | Compiles your code |
| `package` | Packages your code into a JAR or WAR |
| `install` | Installs the package into your local repository |
| `deploy` | Copies the final package into your remote repository |

However, when you're using the Maven Plugin for Azure App Service, you won't use the deploy phase that is included with Maven's `default` lifecycle. Instead, you'll deploy your app to Azure with the `mvn azure-webapp:deploy` command.

## Adding the Maven Plugin for Azure App Service to your project

To add the Maven Plugin for Azure App Service to your web app, you would add the XML for `azure-webapp-maven-plugin` to your project's `pom.xml` file following the same steps that you used in the previous exercise when you added the Tomcat server.

The following excerpt illustrates the XML elements that you need to add to your project's `pom.xml` file:

```xml
<plugin>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-webapp-maven-plugin</artifactId>
  <version>1.8.0</version>
</plugin>
```

> [!NOTE]
> Please check the [Maven Plugin for Azure App Service documention](https://github.com/microsoft/azure-maven-plugins/wiki/Azure-Web-App), or the [Maven Central Repository](https://search.maven.org/artifact/com.microsoft.azure/azure-webapp-maven-plugin/), for information on the latest version of the Maven plugin.

After you've added the plugin to your project's `pom.xml` file, you can run the following command to complete the plugin setup interactively.

```bash
mvn azure-webapp:config
```

The plugin will prompt you for the information that is required to configure the App Service plan. After you've confirmed your choices, the plugin adds the requisite settings to your project's `pom.xml` file that configure your web app to run in Azure App Service.

### Configuration options

The preceding section of this unit demonstrated using the Maven Plugin for Azure App Service interactively to configure your web app. However, you don't need to run the configuration interactively. If you wish, you can add the plugin's XML to your project's `pom.xml` file manually.

The following annotated excerpt from a `pom.xml` file demonstrates some of the settings that are required:

```xml
<plugin>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>azure-webapp-maven-plugin</artifactId>
    <version>1.8.0</version>
    <configuration>
        <schemaVersion>v2</schemaVersion>
        <resourceGroup>${RESOURCEGROUP_NAME}</resourceGroup>
        <appName>${WEBAPP_NAME}</appName>
        <region>${REGION}</region>
        <pricingTier>P1V2</pricingTier>

        <!-- Reference <serverId> in Maven's settings.xml to authenticate with Azure -->
        <!-- You don't need to authenticate when running Maven in the Cloud Shell -->
        <authentication>
          <serverId>${AZURE_AUTH}</serverId>
        </authentication>

        <!-- Choose OS either linux, windows, or docker -->
        <!-- Choose your java version on webserver version -->
        <runtime>
            <os>linux</os>
            <javaVersion>java11</javaVersion>
            <webContainer>TOMCAT 9.0</webContainer>
        </runtime>

        <!-- App specific settings -->
        <appSettings>
            <property>
            <!-- Tell Azure which port you want to use, required for springboot jar applications -->
              <name>PORT</name>
              <value>8081</value>
            </property>
            <!-- JVM OPTIONS -->
            <property>
              <name>JAVA_OPTS</name>
              <value>-Xmx512m -Xms512m</value>
            </property>
        </appSettings>

        <!-- Specify the location of the WAR file to deploy -->
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
  
        <!-- Deployment Slot settings -->
        <deploymentSlotSetting>
            <name>${SLOT_NAME}</name>
            <configurationSource>parent</configurationSource>
        </deploymentSlotSetting>
    </configuration>
</plugin>
```

Some of the relevant configuration options are in the table below. For a full list of options, see the Maven Plugin for Azure App Service documentation.

| Tag | Options |
|---------|---------|
| `<javaVersion>` | For Linux, versions 8 and 11 are supported<br/>For Windows, version 1.7 up to 11 are supported |
| `<webContainer>` | For Linux, Tomcat, Wildfly, and Java SE are supported<br/>For Windows, Tomcat and Jetty are supported |
| `<resource>` | Specifies where the WAR or JAR is located in the project |
| `<authentication>` | Specifies the authentication method to use – three different methods are supported |
| `<appSettings>` | Specifies settings for Spring Boot apps |
| `<deploymentSlotSetting>` | Specifies an existing deployment slot |
| `<allowTelemetry>` | Specifies whether to allow the plugin to send telemetry data to Microsoft – this option is enabled by default |
| `<stopAppDuringDeployment>` | Allows you to stop the target web app, which may prevent deployment failures on Windows with IIS locking files |

### Deployment options

If you've already created an App Service plan, you can specify the settings for that plan in your `pom.xml` file. When you deploy your web app to Azure, Maven will use those settings to deploy your new app to the existing App Service plan.

```xml
<!-- Deploy Web App to the existing App Service Plan -->
<appServicePlanResourceGroup>${PLAN_RESOURCEGROUP_NAME}</appServicePlanResourceGroup>
<appServicePlanName>${PLAN_NAME}</appServicePlanName>
```

Another option is to allow the `azure-webapp-maven-plugin` to create the App Service plan for you when you configure the plugin setup interactively. This option is the default behavior of the plugin if you don't specify an existing App Service plan in your `pom.xml` file.

Whether you choose to create the App Service plan interactively or manually, you use the same Maven command to deploy your application code to Azure.

```bash
mvn package azure-webapp:deploy
```

In the next exercise, you'll deploy your web app to Azure App Service.
