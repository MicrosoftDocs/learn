Now that we understand what we need to do, let's create our resources and publish our pipeline.

> [!IMPORTANT]
> To run this exercise, you need:
>
> - Your own GitHub account. If you don't already have a GitHub account, create a [free account](https://github.com?azure-portal=true) before you begin.
> - Your own Azure subscription. You might incur charges. If you don't already have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Set up the project

1. Fork [the sample repository](https://github.com/MicrosoftDocs/mslearn-aks-deployment-pipeline-github-actions) to your account.

    Fork the repository so that you can create your own GitHub Actions pipeline. If you used the hosted sample version, you couldn't complete the exercise because you don't have write permissions to the original sample repository.

1. Sign in to Azure Cloud Shell by using the Azure subscription you want to deploy resources to.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    > [!IMPORTANT]
    > We'll use Bash to run all the scripts. When you open Cloud Shell, select **Bash** as the running shell.

1. To clone the forked repository, run the following command:

    ```bash
    git clone https://github.com/{your-username}/mslearn-aks-deployment-pipeline-github-actions
    ```
   
   The command creates a new directory called mslearn-aks-deployment-pipeline-github-actions.

1. To go to the new directory, run `cd mslearn-aks-deployment-pipeline-github-actions`.

1. Execute the **init.sh** file that's located in the root of the project.

    The init.sh file does the following tasks:

    * Sets up the environment variables `AKS_NAME`, `DNS_NAME`, `RESOURCE_GROUP_NAME`, and `ACR_NAME`. These variables are the names of the resources you will create.

    * Creates a new resource group.

    * Creates a new AKS cluster and sets up Kubectl to access it.

    * Creates a new Container Registry repository and links it to your AKS cluster.

   When the script finishes running, it displays a list of variables. *Copy and store the variables names*. We'll use those variable names in the next steps.

## Check the results

Confirm that all the resources were created when the init.sh script ran:

1. Run `az group list -o table` and check whether the resource group shown in the script output is listed.

1. Run `az acr list -o table` and check whether the Container Registry instance shown in the script output is listed.
