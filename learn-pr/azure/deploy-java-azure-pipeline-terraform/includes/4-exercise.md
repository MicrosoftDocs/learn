In this unit, you'll configure GitHub actions to provision your Terraform resources.
You'll provision an Azure app Service instance and a MySQL for Azure database.
Once your infrastructure is ready, you'll use GitHub Actions to deploy a Spring Boot sample application.

# Part 1 - provision the Infrastructure

## Fork the sample application

In this module, we'll be checking out an existing project that contains all the code for our Terraform provisioning.

Fork the following GitHub repository:

```html
https://github.com/MicrosoftDocs/mslearn-java-petclinic-simplified
```

In your forked repository you need to customize your application, and resource group name.
Using the build in GitHub Text editor or your editor of choice, edit and commit `terraform/variables.tf` and change **CHANGE_ME_RESOURCE_GROUP** to your intended resource group name and **CHANGE_ME_APP_NAME** to your intended application name:

```yaml
variable "resource_group" {
  description = "The resource group"
  default = "CHANGE_ME_RESOURCE_GROUP"
}

variable "application_name" {
  description = "The Spring Boot application name"
  default     = "CHANGE_ME_APP_NAME"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
  default     = "westeurope"
}
```

> [!IMPORTANT]
> Make sure the name of your resource group and application name are unique.

## Set Up up your workflow

You now need to allow access from your GitHub workflow to your Azure account.
Create a service principal with the Azure CLI:

> [!IMPORTANT]
> Make sure you assign the name of your resource group to the variable `AZ_RESOURCE_GROUP` or substitute the value for it in the commands below.
> Replace `yourServicePrincipalName` with a name of your service principal you choose.

```azurecli
RESOURCE_ID=$(az group show --name "$AZ_RESOURCE_GROUP" --query id -o tsv)
az ad sp create-for-rbac --name "yourServicePrincipalName" --role contributor --scopes "$RESOURCE_ID" --sdk-auth
```

This command will return JSON - copy it and keep it safe as we'll use it in the next step:

```bash
{
  "clientId": "XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXX",
  "clientSecret": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  "subscriptionId": "XXXXXXXXX-XXXXX-XXXX-XXXX-XXXXXXXXXXXXX",
  "tenantId": "XXXXXXXX-XXXXX-XXXX-XXXX-XXXXXXXXXXX",
  ...
}
```

## GitHub Secrets

Once you have the required ID and Secrets, the next step is to add them the secret store in your GitHub project.

GitHub repositories have a feature known as Secrets that allow you to store sensitive information related to a project. For this exercise, store three secrets – `AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET`, `AZURE_SUBSCRIPTION_ID`, and `AZURE_TENANT_ID`.
You'll create these secrets because they'll be used by Terraform to authenticate to Azure.

To create the secrets, navigate to your forked GitHub repository, select the `Settings` menu and then on `Secrets`.
Create a GitHub secret for each of four secrets using the values returned the Azure service principal.

The result will be something like this:

![Github Secrets.](../media/4-secrets.png)

## Workflow file

Inside the project directory, you'll see a directory called `.github/workflows` and a file called `main.yml` in it.
This file is a GitHub workflow and will use the secret we configured above to deploy the application to your Azure subscription.

In that file, you'll see the following content:

```yml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

  workflow_dispatch:
jobs:
  terraform:
    runs-on: ubuntu-latest

    env:
      ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      ARM_CLIENT_SECRET: ${{secrets.AZURE_CLIENT_SECRET}}
      ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}

    defaults:
      run:
        working-directory: ./terraform
    steps:
      - uses: actions/checkout@v2

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        run: terraform plan

      - name: Terraform Apply
        run: terraform apply -auto-approve
```

This workflow does the following actions:

- Check whether the configuration is formatted properly
- generate a plan for every pull requests
- apply the configuration when you update the GitHub branch

Your workflow will be triggered whenever code is pushed to the repository.

## Test the GitHub Action

You can now manually trigger the GitHub Actions workflow by going to "Actions", then select the terraform workflow.
Then, select the "Terraform" workflow. Notice how the "Terraform Init", "Terraform Plan" and "Terraform Validate" steps have been triggered.

Expand the "Terraform Apply" step. Terraform has created the resources and displayed the Azure Instance URL.
Verify your Azure App Instance is publicly available.

# Part 2 - Deploy the sample application

Now that we've provisioned our Azure resources we can deploy the sample Spring Boot application.

## Set up your Maven Build/Deploy GitHub Action

![Deployment Center.](../media/4-deployment.png)

We'll use the built-in CI/CD that is available in the Azure App Service portal - The **Deployment Center**.
The Azure App Service Deployment Center will automatically generate a GitHub Actions workflow file based on your application stack and commit it to your GitHub repository in the correct directory. It will also link your GitHub Action to an Azure App Service publishing profile.

- Navigate to your Azure App Service webapp in the Azure portal
- On the left side, select **Deployment Center**
- Under **Continuous Deployment (CI / CD)**, select **GitHub**
- Next, select **GitHub Actions**
- Use the dropdowns to select your GitHub repository, branch, and **JAVA 8** as the application stack
- On the final screen, you can review your selections and preview the workflow file that will be committed to the repository. Your Workflow file will be created similar to the below (You'll have a different app name and publishing profile).

```yml
name: Build and deploy JAR app to Azure Web App - spring-petclinic-app

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@master

    - name: Set up Java version
      uses: actions/setup-java@v1
      with:
        java-version: '8'

    - name: Build with Maven
      run: mvn clean install

    - name: Deploy to Azure Web App
      uses: azure/webapps-deploy@v2
      with:
        app-name: 'spring-petclinic-app'
        slot-name: 'production'
        publish-profile: ${{ secrets.AzureAppService_PublishProfile_c1ee8d191003493b9c9e13a9b78ad2c3 }}
        package: '${{ github.workspace }}/target/*.jar'
```

- If the Workflow is correct, select **Finish**
- This configuration will commit the workflow file to the repository, and immediately start to build and deploy your app.

## Next steps

Congratulations! You now have two GitHub actions setup - a provisioning action and a build/deploy action.
Each time you `git push` your code, your TerraForm provisioned resources are created (if not created already) and your application is deployed.

> [!IMPORTANT]
> Re-running your provision GitHub action will not recreate your resources if they already exist. You will need to delete your resource group or resources manually and then re-run the GitHub action.
> Re-running your build/deploy GitHub action will replace your application.
> If you delete your provisioning GitHub action or your resources you will need to also re-create your build/deploy GitHub action as this action is linked to an Azure App Service publishing profile.

In the next unit, we'll summarize what we learnt about Terraform.
