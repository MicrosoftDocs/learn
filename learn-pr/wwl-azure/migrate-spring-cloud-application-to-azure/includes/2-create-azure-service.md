Azure Spring Apps is a platform as a service (PaaS) for Spring developers. Manage the lifecycle of your Spring Boot applications with comprehensive monitoring and diagnostics, configuration management, service discovery, CI/CD integration, and blue-green deployments.

:::image type="content" source="../media/azure-spring-apps-conceptual-70a81d75.png" alt-text="Diagram that shows how Azure Spring Apps services interact.":::


You can deploy an instance of the Azure Spring Apps service using the Azure portal or the Azure CLI.

The labstarter branch of the [Azure-Samples/spring-petclinic-microservices repository](https://github.com/Azure-Samples/spring-petclinic-microservices/tree/labstarter) contains a development container for Java development. The *dev* container holds all tools for running this lab. You can choose to use the *dev* container as a [GitHub CodeSpace](https://github.com/features/codespaces) if your GitHub account is enabled for Codespaces. Or, you can use the [Visual Studio Code Remote Containers](https://code.visualstudio.com/docs/remote/containers).

To run from your workstation, you should have the following components installed:

 -  Visual Studio Code available from [Visual Studio Code Downloads](https://code.visualstudio.com/download)
 -  Java and Spring Boot Visual Studio Code extension packs available from [Java extensions for Visual Studio Code](https://code.visualstudio.com/docs/java/extensions).
 -  Git for Windows 2.3.61 is available from [Git Downloads](https://git-scm.com/downloads).
 -  Apache Maven 3.8.5 available from [Apache Maven Project downloads](https://maven.apache.org/download.cgi)
 -  Java and the Java Development Kit (JDK) available from [JD](https://www.oracle.com/java/technologies/downloads/)[K](https://www.oracle.com/java/technologies/downloads/)[ downloads](https://www.oracle.com/java/technologies/downloads/).
 -  To download the instructions for this module, see [Deploying and Running Java apps in Azure Spring Apps](https://github.com/MicrosoftLearning/Deploying-and-Running-Java-apps-in-Azure-Spring-Cloud).<br>

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

To install JDK, follow the instructions provided in [J](https://docs.oracle.com/en/java/javase/18/install/installation-jdk-microsoft-windows-platforms.html)[DK Installation Guide](https://docs.oracle.com/en/java/javase/18/install/installation-jdk-microsoft-windows-platforms.html). Set the `JAVA_HOME` environment variable by running the following command from the Git Bash shell:

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

3.  Make sure that you're logged in to the right subscription for the consecutive commands.
    
    ```azurecli
    az account list -o table
    ```
4.  If in the above statement you don't see the right account being indicated as your default one, change your environment to the right subscription with the following command, replacing the `<subscription-id>`.
    
    ```azurecli
    az account set \
        --subscription <subscription-id>
    ```

5.  Run the following commands to create a resource group to contain all resources. Replace the `<azure-region>` placeholder with the name of any Azure region in which you can create a Standard SKU instance of the Azure Spring Apps service and an Azure Database for MySQL Single Server instance. See the [Products available by region](https://azure.microsoft.com/global-infrastructure/services/?products=mysql%2Cspring-apps&regions=all) page for services availability.
    
    ```azurecli
    UNIQUEID=$(openssl rand -hex 3)
    RESOURCE_GROUP=springappslab_rg_$UNIQUEID
    LOCATION=<azure-region>
    az group create -g $RESOURCE_GROUP -l $LOCATION
    ```

6.  Run the listed commands to create an instance of the standard SKU of the Azure Spring Apps service. The name of the service must be globally unique and contain only lowercase letters, numbers, and hyphens.
    
    ```azurecli
    SPRING_APPS_SERVICE=springappssvc$UNIQUEID
        --name $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --location $LOCATION \
        --sku Standard
    ```
    
    > [!NOTE]
    > The commands above will automatically register the Spring extension if needed. Confirm the extension installation with *Y*.
    
    > [!NOTE]
    > You can also add the spring extension with az extension `add --name spring.`
    
    > [!NOTE]
    > Provisioning will take approximately 5 minutes.

7.  You can set your default resource group name and Spring Apps service name. By setting these defaults, you won't need to repeat these names for the next commands.
    
    ```azurecli
    az config set defaults.group=$RESOURCE_GROUP defaults.spring-cloud=$SPRING_APPS_SERVICE
    ```

8.  In a new tab, open the [Azure portal](https://portal.azure.com/).
9.  Use the **Search resources, services, and docs** to search for the resource group you created using **Azure Spring Apps**.
    
    In the resource group overview, you'll see your newly created Azure Spring Apps instance.
    
    :::image type="content" source="../media/azure-spring-apps-resources-1-7ae31568.png" alt-text="Screenshot of Azure Spring Apps resource groups.":::
    
    
    > [!NOTE]
    > If you don't see the Azure Spring Apps service in the overview list of the resource group, you may need to refresh the view.

10. Select the Azure Spring Apps instance and select Apps. Notice that there are no apps deployed to the instance but will be added in the upcoming exercise.
    
    :::image type="content" source="../media/azure-spring-apps-resources-2-c00c34e2.png" alt-text="Screenshot of the apps listed for Azure Spring Apps service.":::
    
