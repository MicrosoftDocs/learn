In this unit, you'll configure GitHub actions to provision your Terraform resources.

You'll configure your pipeline to act as soon as you push code to master (see on: push: branches: master), then you'll check out the code (actions/checkout@master), then do a terraform format, terraform init, terraform validate, terraform plan, terraform apply

## Set Up up your workflow

You now need to allow access from your GitHub workflow to your Azure account. Open up a terminal and type the following command, replacing `yourServicePrincipalName` with the name of your service principal.

Create a service principal to deploy to Azure.

> [!IMPORTANT]
> Make sure you assign the name of your resource group to the variable `AZ_RESOURCE_GROUP` or substitute the value for it in the commands below.

```bash
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

You'll then need to go to Certificates & secrets section of your app registration and create a new client secret. Take note of this value also.

## GitHub Secrets

Once you have the required ID and Secrets, the next step is to add them the secret store in your GitHub project.

Next you’ll create secrets to avoid exposing your service principal.
In GitHub, we can specify them once we go to Settings -> Secrets.

We'll need to create the secrets, `AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET`, `AZURE_SUBSCRIPTION_ID`, and `AZURE_TENANT_ID`.
Add the values to each variable from the ones you're copied when creating your service principal.
The result will be something like this:

![Github Secrets.](../media/6-secrets.png)

## Workflow file

Inside the project directory, you'll see a directory called `.github/workflows` and a file called `main.yml` in it. This file is a GitHub workflow and will use the secret we configured above to deploy the application to your Azure subscription.

In that file, you'll see the following content:

```yaml
name: "Terraform Deploy"
on:
  push:
    branches:
      - master
jobs:
  terraform:
    name: "Terraform"
    runs-on: ubuntu-latest
    steps:
      - name: "Checkout"
        uses: actions/checkout@master
      - name: "Terraform Format"
        uses: hashicorp/terraform-github-actions@master
        with:
          tf_actions_version: 0.12.24
          tf_actions_subcommand: "fmt"
          tf_actions_working_dir: "./terraform"
          tf_actions_comment: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      - name: "Terraform Init"
        uses: hashicorp/terraform-github-actions@master
        with:
          tf_actions_version: 0.12.24
          tf_actions_subcommand: "init"
          tf_actions_working_dir: "./terraform"
          tf_actions_comment: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      - name: "Terraform Validate"
        uses: hashicorp/terraform-github-actions@master
        with:
          tf_actions_version: 0.12.24
          tf_actions_subcommand: "validate"
          tf_actions_working_dir: "./terraform"
          tf_actions_comment: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      - name: "Terraform Plan"
        uses: hashicorp/terraform-github-actions@master
        with:
          tf_actions_version: 0.12.24
          tf_actions_subcommand: "plan"
          tf_actions_working_dir: "./terraform"
          tf_actions_comment: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
          ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
          ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
          ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
      - name: "Terraform Apply"
        uses: hashicorp/terraform-github-actions@master
        with:
          tf_actions_version: 0.12.24
          tf_actions_subcommand: "apply"
          tf_actions_working_dir: "./terraform"
          tf_actions_comment: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
          ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
          ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
          ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

This workflow does the following actions:

- <!--todo add description >

Your workflow will be triggered whenever code is pushed to the repository.
There are many other [events that trigger GitHub actions](https://help.github.com/en/articles/events-that-trigger-workflows). You could, for example, deploy each time a new tag is created on the project.

## Test the GitHub Action

You can now commit and push the `main.yml` file we created.

Going to the `Actions` tab of your  GitHub project, you should see that your project is automatically built and deployed:

![GitHub workflow](media/01-github-workflow.png)

Congratulations! Each time you `git push` your code, your TerraForm provisioned resources are now automatically deployed to production.
