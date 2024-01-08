In this unit, you create your resources for the Contoso Video website. Make sure you have all the prerequisites listed in the introduction to this module.

## Set up the project

1. Fork [the sample repository](https://github.com/MicrosoftDocs/mslearn-aks-deployment-pipeline-github-actions) to your GitHub account. You don't have write permissions to the original sample repository, so you need to fork the repository to create your own GitHub Actions pipeline.

1. [Sign in to Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) with the Azure subscription you want to deploy resources to. When Cloud Shell opens, make sure **Bash** is selected as the shell to run.

1. To clone your forked repository, run the following command in Cloud Shell, changing the \<GitHub username> placeholder to your GitHub username:

    ```bash
    git clone https://github.com/<GitHub username>/mslearn-aks-deployment-pipeline-github-actions
    ```

1. Go to the new cloned *mslearn-aks-deployment-pipeline-github-actions* directory by running the following command:

    ```bash
    cd mslearn-aks-deployment-pipeline-github-actions
    ```

1. Run the following command to execute the *init.sh* file located in the root of the project:

    ```bash
    bash init.sh
    ```

    The *init.sh* file does the following tasks:

    - Creates a new Azure resource group.
    - Creates a new AKS cluster and sets up Kubectl to access it.
    - Creates a new Container Registry repository and links it to your AKS cluster.
    - Sets up the environment variables `AKS_NAME`, `DNS_NAME`, `RESOURCE_GROUP_NAME`, and `ACR_NAME`.

1. When the script finishes running, it outputs a list of variables. *Copy and store the variable values* to use in future exercises.

   - **Resource Group Name**
   - **ACR Name**
   - **ACR Login Username**
   - **ACR Password**
   - **AKS DNS Zone Name**

## Check the results

Confirm that the *init.sh* script created all the resources.

1. Run the following Azure CLI command to check whether the resource group shown in the script output is listed.

    ```azurecli
    az group list -o table
    ```

1. Run the following command to check whether the Container Registry instance shown in the script output is listed.

    ```azurecli
    az acr list -o table
    ```

Now that your Azure resources are created, proceed to the next unit to learn about tagged application images.
