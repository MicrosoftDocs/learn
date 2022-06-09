Azure Spring Apps is a platform as a service (PaaS) for Spring developers. Manage the lifecycle of your Spring Boot applications with comprehensive monitoring and diagnostics, configuration management, service discovery, CI/CD integration, and blue-green deployments.

:::image type="content" source="../media/azure-spring-apps-conceptual-70a81d75.png" alt-text="Diagram that shows how Azure Spring Apps services interact.":::


You can deploy an instance of the Azure Spring Apps service using the Azure portal or the Azure CLI.

Your workstation should have the following components installed:

 -  Visual Studio Code available from [Visual Studio Code Downloads](https://code.visualstudio.com/download)
 -  Git available from [Git Downloads](https://git-scm.com/downloads)
 -  Apache Maven 3.8.5 available from [Apache Maven Project downloads](https://maven.apache.org/download.cgi)
 -  Java Development Kit (JDK) available from [JD](https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.msi)[K downloads](https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.msi).
 -  To download the instructions for this module, see Deploying and Running Java apps in Azure Spring Apps.

For Git installations, set the global configuration variables *user.email* and *user.name* by running the following commands from the Git Bash shell:

```Bash
git config \
    --global user.email "<your-email-address>"
git config \
    --global user.email "<your-email-address>
```

To install Apache Maven, extract the content of the *.zip* file by running unzip apache-maven-3.8.5-bin.zip. Add the path to the bin directory of the extracted content to the `PATH` environment variable by running the following command from the Git Bash shell:

```Bash
export PATH=~/apache-maven-3.8.5/bin:$PATH
```

To install JDK, follow the instructions provided in [JDK Installation Guide](https://docs.oracle.com/en/java/javase/18/install/installation-jdk-microsoft-windows-platforms.html). Set the `JAVA_HOME` environment variable by running the following command from the Git Bash shell:

```Bash
export JAVA_HOME="/c/Program Files/Java/jdk-18.0.1.1"
```

> [!NOTE]
> Make sure that you have the Azure Spring Apps extension for AZ CLI enabled.

## Create an Azure Spring Apps service

The following procedure uses the Azure CLI extension to deploy an instance of Azure Spring Apps.

1.  From the Git Bash prompt, run the following command to sign into your Azure account.
    
    ```Bash
    az login
    ```

2.  Update the extension to the most recent version.
    
    ```azurecli
    az extension update \
        --name spring-cloud
    ```

3.  Sign in to Azure CLI using your Azure subscription. This command will open a browser window to sign in.
    
    ```azurecli
    RESOURCE_GROUP=springcloudlab_rg
    LOCATION=westus
    az group create -g $RESOURCE_GROUP -l $LOCATION
    ```
    
    > [!NOTE]
    > Next, you'll create a new instance of the Azure Spring Apps service. The name you use for your Spring Cloud service should be unique, so modify the value used in the script below.

4.  To create a new instance of the Azure Spring Apps service. Wait for the provisioning to complete.
    
    ```azurecli
    SPRING_CLOUD_SERVICE=springcloudlab
    az spring-cloud create \
        --name $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --location $LOCATION \
        --sku Standard
    ```

5.  You can set your default resource group name and Spring Cloud service name. By setting these defaults, you won't need to repeat these names for the next commands.
    
    ```azurecli
    az config set defaults.group=$RESOURCE_GROUP defaults.spring-cloud=$SPRING_CLOUD_SERVICE
    ```

6.  In a new tab, open the [Azure portal](https://portal.azure.com/).
7.  Use the **Search resources, services, and docs** to search for the resource group you created using ***Azure Spring Apps**.*
    
    In the resource group overview, you'll see your newly created Azure Spring Apps instance.
    
    :::image type="content" source="../media/azure-spring-cloud-resources-f587a987.png" alt-text="Screenshot of Azure Spring Apps resource groups.":::
    
    
    > [!NOTE]
    > If you don't see the Azure Spring Apps service in the overview list of the resource group, you may need to refresh the view.

8.  Select the Azure Spring Apps instance and select Apps. Notice that there are no apps deployed to the instance but will be added in the upcoming exercise.
    
    :::image type="content" source="../media/service-apps-spring-cloud-80f4a288.png" alt-text="Screenshot of the apps listed for Azure Spring Apps service.":::
    
