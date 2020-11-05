In this unit, you'll configure your  Spring Boot app to be deployed via Maven and then create and deploy to an Azure App Service instance.

# Configure the Maven plugin

The deployment process to Azure App Service will use your Azure credentials from the Azure CLI automatically.

Run the Maven command below to configure the deployment. This command will help you to set up the App Service operating system,Azure subscription and Java version.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
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
    [INFO] Finished at: 2020-11-01T17:38:51-07:00
    [INFO] ------------------------------------------------------------------------
    ```

## Deploy the app

The maven deploy plugin will copy your executable Spring Boot JAR file to your Azure App Service's instance, and also copy your JAR file to the server's "/local/site/wwwroot" directory
Finally it will start your App via your Spring Boot JAR file's embedded HTTP server.

Next, deploy your Spring Boot app to Azure using the following command:

```bash
mvn package azure-webapp:deploy
```

Once deployment has completed, your application will be ready at `http://<appName>.azurewebsites.net/`(`http://azure-spring-workshop-1590394316693.azurewebsites.net` in the demo). To confirm that your App is connection to the database, Open the url with your local web browser, you should see

![Sample app running in Azure App Service](./media/quickstart-java/java-hello-world-in-browser-azure-app-service.png)
