# Configure the Maven plugin

The deployment process to Azure App Service will use your Azure credentials from the Azure CLI automatically.

Run the Maven command below to configure the deployment. This command will help you to set up the App Service operating system, Java version.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.11.0:config
```

1. When prompted with **Subscription** option, select the proper `Subscription` by entering the number print in the line start.
1. When prompted with **Web App** option, accept the default option `<create>` by pressing enter.
1. When prompted with **OS** option, select **linux** by pressing enter.
1. Use the default Java version, 1.8, by pressing enter.
1. Finally, press enter on the last prompt to confirm your selections.

    ```bash
    Please confirm webapp properties
    Subscription Id : ********-****-****-****-************
    AppName : spring-boot-1599007116351
    ResourceGroup : spring-boot-1599007116351-rg
    Region : westeurope
    PricingTier : PremiumV2_P1v2
    OS : Linux
    RuntimeStack : JAVA 8-jre8
    Deploy to slot : false
    Confirm (Y/N)? : Y
    [INFO] Saving configuration to pom.
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time: 20.925 s
    [INFO] Finished at: 2020-09-01T17:38:51-07:00
    [INFO] ------------------------------------------------------------------------
    ```

You can modify the configurations for App Service directly in your `pom.xml` if needed. Some common ones are listed below:

Property | Required | Description | Version
---|---|---|---
`<schemaVersion>` | false | Specify the version of the configuration schema. Supported values are: `v1`, `v2`. | 1.5.2
`<subscriptionId>` | false | Specify the subscription id. | 0.1.0+
`<resourceGroup>` | true | Azure Resource Group for your Web App. | 0.1.0+
`<appName>` | true | The name of your Web App. | 0.1.0+
`<region>` | true | Specifies the region where your Web App will be hosted; the default value is **westeurope**. All valid regions at [Supported Regions](/java/api/overview/azure/maven/azure-webapp-maven-plugin/readme) section. | 0.1.0+
`<pricingTier>` | false | The pricing tier for your Web App. The default value is **P1V2**.| 0.1.0+
`<runtime>` | true | The runtime environment configuration, you could see the detail [here](/java/api/overview/azure/maven/azure-webapp-maven-plugin/readme). | 0.1.0+
`<deployment>` | true | The deployment configuration, you could see the details [here](/java/api/overview/azure/maven/azure-webapp-maven-plugin/readme). | 0.1.0+

Be careful about the values of `<appName>` and `<resourceGroup>`(`helloworld-1590394316693` and `helloworld-1590394316693-rg` accordingly in the demo), they will be used later.

## Deploy the app

The maven plugin will copy your App's Spring Boot Library to your hosted Azure App Service's file system and then deploy it to the App Service's embedded web server.
Once it has moved the files and configuration over it will also attempt to restart the App Service.

Deploy your Spring Boot app to Azure using the following command.

```bash
mvn package azure-webapp:deploy
```

Once deployment has completed, your application will be ready at `http://<appName>.azurewebsites.net/`(`http://helloworld-1590394316693.azurewebsites.net` in the demo). To confirm that your App is connection to the database, Open the url with your local web browser, you should see

![Sample app running in Azure App Service](./media/quickstart-java/java-hello-world-in-browser-azure-app-service.png)
