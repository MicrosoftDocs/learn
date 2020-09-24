Now that we have all the understanding about what we need to do, let's start by creating our resources and publish our pipeline.

> [!IMPORTANT]
> You need your own GitHub account to run this exercise. If you don't already have a GitHub account, create a [free account](https://github.com) before you begin.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Set up the project

1. Fork [this sample repository](https://github.com/MicrosoftDocs/mslearn-aks-deployment-pipeline-github-actions) to your account
1. Sign in to Azure Cloud Shell with the account you want to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    > [!IMPORTANT]
    > We'll run all the scripts with Bash, so if you haven't created a Cloud Shell yet, select "Bash" as the running shell.
1. Clone the forked repository by issuing the command `git clone https://github.com/your-username/mslearn-aks-deployment-pipeline-github-actions`. By the end of the execution you should have a new directory called `mslearn-aks-deployment-pipeline-github-actions`
1. Enter the newly created directory with `cd mslearn-aks-deployment-pipeline-github-actions`
1. Execute the `init.sh` file located in the root of the project

    This `init.sh` file will be responsible for:

    1. Set up environment variables `AKS_NAME`, `DNS_NAME`, `RESOURCE_GROUP_NAME`, and `ACR_NAME`, which are the names given to the resources you'll be creating
    1. Create a new resource group
    1. Create a new AKS Cluster and set up Kubectl to access it
    1. Create a new ACR repository and link it to your AKS cluster

By the end of the execution, the script will give you a list of variables. __Copy and store them__, we'll be using those names in the next steps.

## Check the work

To test if all the resources have been created:

1. Issue `az group list -o table` and check if the resource group listed by the script is shown
1. Issue `az acr list -o table` and check if the ACR the script named is listed
