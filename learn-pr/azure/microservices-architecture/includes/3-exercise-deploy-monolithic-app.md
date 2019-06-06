Now that we've talked a bit about monolithic and microservices architectures, let's deploy a monolithic application and dive further into how we can evolve it to a microservices architecture.

Fabrikam has currently added the drone service into their existing application.

Include an image of what is being deployed, including the logical setup of the application.

What we're deploying:
- App service
- Application insights
- Storage account for Application insights data
- ???

<!-- Activate the sandbox -->
[!include[](../../../includes/azure-sandbox-activate.md)]

## Deploy a monolithic application on Azure App Service

Let's start by deploying the application. First, we'll need to great the Azure resources to host the application.

1. Run this command to deploy the resources needed for this application.

    ```azurecli
    az group deployment create \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --template-uri https://raw.githubusercontent.com/MicrosoftDocs/mslearn-microservices-architecture/master/deployment/azuredeploy.json
    ```

1. Now that we have the resources created, lets deploy the application. First, run this command to pull down the source code from the sample repository.

    ```azurecli
    git clone https://github.com/MicrosoftDocs/mslearn-microservices-architecture.git
    cd mslearn-microservices-architecture
    ```

1. Next, run this command to set up a deployment user. This user will be used to access the git repo on the App Service. Replace `<username>` and `<password>`, including the brackets, with a new username and password. The username must be unique within Azure. The password must be at least eight characters long, with two of the following three elements: letters, numbers, and symbols.

    ```azurecli
    az webapp deployment user set --user-name <username> --password <password>
    ```

1. Run this command to set a variable with the name of the App Service.

    ```bash
    APPSERVICENAME="$(az webapp list --query '[].name' --output tsv)"
    ```

1. Now let's set up the App Service to use local git, allowing us to deploy code to the site. Run the following command.

    ```azurecli
    az webapp deployment source config-local-git \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --name $APPSERVICENAME
    ```

1. Run this command to add the git location as a remote. Replace `<deploymentuser>` with the deployment user you created earlier.

    ```bash
    git remote add azure https://<deploymentuser>@$APPSERVICENAME.scm.azurewebsites.net/$APPSERVICENAME.git
    ```

1. Run the following command to deploy the application to App Service.

    ```bash
    git push azure master
    ```

