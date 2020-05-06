Here, we discuss deploying a container-based web app to Microsoft Azure Web Apps by using GitHub Actions. But before we can deploy, we discuss some options for triggering a workflow. Then we dive into how to work with conditionals in the workflow. Finally, we talk about how to create and destroy Azure resources by using GitHub Actions.

## Options for triggering a continuous delivery workflow

There are several options for starting a continuous delivery workflow. Let's talk about a few of them.

In the previous module on continuous integration using GitHub Actions, you learned about triggering a workflow from a push to the GitHub repository. However, for continuous delivery you may want to trigger that workflow on some other event.

One option is to trigger a deployment workflow with ChatOps. *ChatOps* is using digital conversation and bots to automate some part of a workflow. For example, leaving a specific comment in a pull request can kick off a bot that comments back with some statistics or runs a workflow.

Another option is to use labels in your pull request to run a workflow. With this option, different labels can start different workflows. For example, you add a *stage* label to begin a deployment workflow to your staging environment, or a *spin up environment* label to run the workflow that creates the Microsoft Azure resources you will deploy to. To use this option, your workflow will look like this:

```yml
on:
  pull_request:
    types: [labeled]
```

## Control execution with a job conditional

A common scenario with workflows is to only run the workflow based on some condition.

GitHub workflows provide the *if* conditional for this scenario. The conditional uses an [expression](https://help.github.com/actions/reference/context-and-expression-syntax-for-github-actions?azure-portal=true) that will be evaluated at run time. For example, we want to run this workflow if a *stage* label is added to the pull request.

```yml
if: contains(github.event.pull_request.labels.*.name, 'stage')
```

## Store credentials with GitHub Secrets

GitHub Secrets is a secure place to store sensitive information that your workflow will need without exposing that information in the workflow file.

In order to deploy to an Azure resource, the GitHub Action must have permission to access the resource. But you don't want to store your Azure credentials in the workflow file in plain sight.

To store information in GitHub Secrets, you create a secret on the portal.

![Creating a github secret in the github portal](../media/2-github-secrets.png)

Then you use the name of the secret you created in your workflow wherever you need that secret. For example, below we are using the Azure credential that was stored in GitHub Secrets in the ```creds:``` attribute of an Azure login action. We talk about that action in the next section.

```yml
steps:
      - name: "Login via Azure CLI"
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
```

## Deploy to Microsoft Azure using GitHub Actions

The [GitHub Marketplace](https://github.com/marketplace?type=actions&query=azure&azure-portal=true) has several actions that help you automate Azure-related tasks.

![The github marketplace with search results for Azure](../media/2-github-marketplace-azure-actions.png)

Suppose you wanted to deploy a container-based web app to Azure Web Apps. Searching the GitHub Marketplace for the Actions you need yields these actions:

- [azure/webapps-container-deploy@v1](https://github.com/Azure/webapps-container-deploy?azure-portal=true)
- [azure/login@v1](https://github.com/Azure/login?azure-portal=true) that we saw above  
- [azure/docker-login@v1](https://github.com/Azure/docker-login?azure-portal=true).

Using these actions, the ```Deploy-to-Azure``` job in your workflow would look like this:

```yml
  Deploy-to-Azure:
    runs-on: ubuntu-latest
    needs: Build-Docker-Image
    name: Deploy app container to Azure
    steps:
      - name: "Login via Azure CLI"
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      - uses: azure/docker-login@v1
        with:
          login-server: ${{env.IMAGE_REGISTRY_URL}}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Deploy web app container
        uses: azure/webapps-container-deploy@v1
        with:
          app-name: ${{env.AZURE_WEBAPP_NAME}}
          images: ${{env.IMAGE_REGISTRY_URL}}/${{ github.repository }}/${{env.DOCKER_IMAGE_NAME}}:${{ github.sha }}

      - name: Azure logout
        run: |
          az logout
```

Notice that this job depends on a previous job ```Build-Docker-Image```. This previous job would create the artifact that gets deployed.

The [azure/login@v1](https://github.com/Azure/login?azure-portal=true) action is specific to Azure. It will need credentials to login to your Azure account so it can access the Azure resources that you want to deploy to. Here, we get the credentials that we stored in GitHub Secrets.

The same is true for the [azure/docker-login@v1](https://github.com/Azure/docker-login?azure-portal=true) action. Since you are deploying a container image, you will need to login to your private container registry.

The [azure/webapps-container-deploy@v1](https://github.com/Azure/webapps-container-deploy?azure-portal=true) action will perform the deployment. It depends on the two actions mentioned above.

## Create and destroy Azure resources with GitHub Actions

GitHub Actions can automate the tasks needed to create and destroy deployment environments on Azure. With continuous delivery, you will want to automate these tasks. Having these tasks defined in a workflow in your repository is known as *infrastructure as code*. It is important to destroy resources that you are no longer using as soon as possible to avoid unnecessary charges.

One option is to create a new workflow with two jobs, one for spin-up and one for destroy. Then, use a conditional to run only the job you want. In this example, the conditional looks for a label in the pull request and runs the ```set-up-azure-resources``` job if the label is *spin up environment* and the ```destroy-azure-resources``` job if the label is *destroy environment*.

```yml
jobs:
  set-up-azure-resources:
    runs-on: ubuntu-latest

    if: contains(github.event.pull_request.labels.*.name, 'spin up environment')

    ...

  destroy-azure-resources:
    runs-on: ubuntu-latest

    if: contains(github.event.pull_request.labels.*.name, 'destroy environment')

    ...
```

The jobs will use Azure CLI (command-line interface) to create and destroy the Azure resources. If you are not familiar with Azure CLI, check out [Overview of Azure CLI](https://docs.microsoft.com/cli/azure/?view=azure-cli-latest&azure-portal=true) in the Microsoft documentation.

Here is an example of the steps in the ```set-up-azure-resources``` job:

```yml
steps:
  - name: Checkout repository
    uses: actions/checkout@v2

  - name: Azure login
    uses: azure/login@v1
    with:
      creds: ${{ secrets.AZURE_CREDENTIALS }}

  - name: Create Azure resource group
    if: success()
    run: |
      az group create --location ${{env.AZURE_LOCATION}} --name ${{env.AZURE_RESOURCE_GROUP}} --subscription ${{secrets.AZURE_SUBSCRIPTION_ID}}
  - name: Create Azure app service plan
    if: success()
    run: |
      az appservice plan create --resource-group ${{env.AZURE_RESOURCE_GROUP}} --name ${{env.AZURE_APP_PLAN}} --is-linux --sku F1 --subscription ${{secrets.AZURE_SUBSCRIPTION_ID}}
  - name: Create webapp resource
    if: success()
    run: |
      az webapp create --resource-group ${{ env.AZURE_RESOURCE_GROUP }} --plan ${{ env.AZURE_APP_PLAN }} --name ${{ env.AZURE_WEBAPP_NAME }}  --deployment-container-image-name nginx --subscription ${{secrets.AZURE_SUBSCRIPTION_ID}}
  - name: Configure webapp to use GitHub Packages
    if: success()
    run: |
      az webapp config container set --docker-custom-image-name nginx --docker-registry-server-password ${{secrets.GITHUB_TOKEN}} --docker-registry-server-url https://docker.pkg.github.com --docker-registry-server-user ${{github.actor}} --name ${{ env.AZURE_WEBAPP_NAME }} --resource-group ${{ env.AZURE_RESOURCE_GROUP }} --subscription ${{secrets.AZURE_SUBSCRIPTION_ID}}

```

Notice that you use GitHub actions to check out the repository and to sign in to Azure. After that, creating the resources you need and deploying the container are done using Azure CLI.
