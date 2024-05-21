In the preceding unit, you learned how the Maven Plugin for Azure App Service provides makes it easy for Java developers to automate the build and deployment of their web apps to Azure. Once you've created your web app tested it locally, your next step is to deploy it to Azure App Service.

In this exercise, you'll add the `azure-webapp-maven-plugin` plugin to your project and configure the requisite settings to deploy your app to Azure App Service. After you've successfully deployed your web app to Azure, you'll test your web app running on Azure App Service.

## Add the `azure-webapp-maven-plugin` plugin to your project

1. Use the `azure-webapp-maven-plugin` to add the plugin and configuration settings interactively to your Maven `pom.xml` file:

    ```bash
    cd ~/MyWebApp
    mvn com.microsoft.azure:azure-webapp-maven-plugin:2.13.0:config
    ```

    Enter the following values for each of the interactive prompts:

    | Prompt | Value |
    |---|---|
    | **Create new run configuration** | *Enter **Y*** |
    | **Define value for OS** | *Enter the corresponding number for **Linux*** |
    | **Define value for javaVersion** | *Enter the corresponding number for **Java 17*** |
    | **Define value for webContainer** | *Enter the corresponding number for **TOMCAT 10.0*** |
    | **Define value for pricingTier** | *Enter the corresponding number for **S1*** |
    | **Confirm (Y/N)** | *Enter **Y*** |

    The plugin will add the appropriate settings that reflect your choices to your `pom.xml` file.

1. You can use `code` to verify and edit the `pom.xml` file.

    ```bash
    code pom.xml
    ```

1. The `<build>` section of your `pom.xml` file should resemble the following example:

    ```xml
    <finalName>MyWebApp</finalName>
    <pluginManagement>
      ...
    </pluginManagement>
      <plugins>
        <plugin>
          <groupId>com.microsoft.azure</groupId>
          <artifactId>azure-webapp-maven-plugin</artifactId>
          <version>2.13.0</version>
          <configuration>
            <schemaVersion>v2</schemaVersion>
            ...
    ```

1. Save your changes by typing <kbd>Ctrl</kbd>+<kbd>S</kbd>.

1. Quit the code editor by typing <kbd>Ctrl</kbd>+<kbd>Q</kbd>.

## Configure the plugin to use sandbox resource group

1. For this exercise, you'll need to determine the name and location of the resource group for your sandbox. To do so, use the following command:

    ```azurecli
    az group list --query [0].name
    az group list --query [0].location
    ```

    Copy these values for use later in this exercise.

1. Use the `azure-webapp-maven-plugin` again to configure more settings interactively to your Maven `pom.xml` file:

    ```bash
    mvn com.microsoft.azure:azure-webapp-maven-plugin:2.13.0:config
    ```

    Enter the following values for each of the interactive prompts:

    | Prompt | Value |
    |---|---|
    | **Please choose which part to config** | _Enter the corresponding number to configure the **Application**_ |
    | **Define value for appName** | _Accept the default_ |
    | **Define value for resourceGroup** | _Enter the **name** of the resource group that you copied earlier (which should be **<rgn>[sandbox resource group name]</rgn>**)_ |
    | **Define value for region** | _Enter the **location** for the resource group that you copied earlier_ |
    | **Define value for pricingTier** | _Enter the corresponding number for the **f1** tier_ |
    | **Confirm (Y/N)** | _Enter **Y**_ |

    The plugin will update the settings in your `pom.xml` file.

## Deploy and test the web app

1. Use Maven to build and deploy your web app to Azure App Service:

    ```bash
    mvn package azure-webapp:deploy
    ```

    Enter the following values for each of the interactive prompts:

    | Prompt | Value |
    |---|---|
    | **Please choose a subscription** | _Enter the corresponding number for your subscription_ |

    Maven displays a series of build messages, and the final message should indicate successful deployment to Azure.

    ```console
    [INFO] Successfully deployed the resources to MyWebApp-1570214065588
    [INFO] Trying to deploy artifact to MyWebApp-1570214065588...
    [INFO] Deploying (/home/cephas/MyWebApp/target/MyWebApp.war)[war]  ...
    [INFO] Application url: https://MyWebApp-1570214065588.azurewebsites.net
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  31.001 s
    [INFO] Finished at: 2024-05-02T12:08:40Z
    [INFO] ------------------------------------------------------------------------
    ```

1. Visit the deployed app by selecting the URL in the shell. By default, the Maven plugin deploys the Tomcat application to the default (root) context.

    :::image type="content" source="../media/3-app-service-response.png" alt-text="Example web app running on Azure App Service in a web browser." loc-scope="other"::: <!-- no-loc -->

In the next exercise, you'll update your web app and redeploy it to Azure App Service.
