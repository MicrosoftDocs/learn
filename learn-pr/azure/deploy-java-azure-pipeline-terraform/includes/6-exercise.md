In this unit, you'll configure GitHub actions to provision your Terraform resources.

You'll configure your pipeline to act as soon as you push code to master (see on: push: branches: master), then you'll check out the code (actions/checkout@master), then do a terraform format, terraform init, terraform validate, terraform plan, terraform apply

## Set Up up your workflow



You now need to allow access from your GitHub workflow to your Azure Spring Cloud instance. Open up a terminal and type the following command, replacing `$AZ_RESOURCE_GROUP` with the name of your resource group.

🛑 Make sure you assign the name of your resource group to the variable `AZ_RESOURCE_GROUP` or replace the value for it in the commands below.

Create a service principal to deploy to Azure:

```bash
RESOURCE_ID=$(az group show --name "$AZ_RESOURCE_GROUP" --query id -o tsv)
SPNAME="sp-$(az spring-cloud list --query '[].name' -o tsv)"
az ad sp create-for-rbac --name "${SPNAME}" --role contributor --scopes "$RESOURCE_ID" --sdk-auth
```

This output should output a JSON text, that you need to copy.

Next you’ll create secrets to avoid exposing your service principal.
In GitHub, we can specify them once we go to Settings -> Secrets.
The result will be something like this:

<!-- todo add results screen -->

Paste the GitHub token text you copied into that secret.

## Workflow file

Inside the project directory, create a new directory called `.github/workflows` and add a file called `main.yml` in it. This file is a GitHub workflow and will use the secret we configured above to deploy the application to your Azure subscription.

In that file, copy/paste the following content, doing the indicated substitutions:

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
          tf_actions_version: 0.12.13
          tf_actions_subcommand: "fmt"
          tf_actions_working_dir: "./terraform"
          tf_actions_comment: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      - name: "Terraform Init"
        uses: hashicorp/terraform-github-actions@master
        with:
          tf_actions_version: 0.12.13
          tf_actions_subcommand: "init"
          tf_actions_working_dir: "./terraform"
          tf_actions_comment: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      - name: "Terraform Validate"
        uses: hashicorp/terraform-github-actions@master
        with:
          tf_actions_version: 0.12.13
          tf_actions_subcommand: "validate"
          tf_actions_working_dir: "./terraform"
          tf_actions_comment: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      - name: "Terraform Plan"
        uses: hashicorp/terraform-github-actions@master
        with:
          tf_actions_version: 0.12.13
          tf_actions_subcommand: "plan"
          tf_actions_working_dir: "./terraform"
          tf_actions_comment: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          TF_VAR_agent_client_id: ${{ secrets.TF_VAR_agent_client_id }}
          TF_VAR_agent_client_secret: ${{ secrets.TF_VAR_agent_client_secret }}
          TF_VAR_subscription_id: ${{ secrets.TF_VAR_subscription_id }}
          TF_VAR_tenant_id: ${{ secrets.TF_VAR_tenant_id }}
      - name: "Terraform Apply"
        uses: hashicorp/terraform-github-actions@master
        with:
          tf_actions_version: 0.12.13
          tf_actions_subcommand: "apply"
          tf_actions_working_dir: "./terraform"
          tf_actions_comment: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          TF_VAR_agent_client_id: ${{ secrets.TF_VAR_agent_client_id }}
          TF_VAR_agent_client_secret: ${{ secrets.TF_VAR_agent_client_secret }}
          TF_VAR_subscription_id: ${{ secrets.TF_VAR_subscription_id }}
          TF_VAR_tenant_id: ${{ secrets.TF_VAR_tenant_id }}
```

This workflow does the following actions:

- <!--todo add description >

Your workflow will be triggered whenever code is pushed to the repository.
There are many other [events that trigger GitHub actions](https://help.github.com/en/articles/events-that-trigger-workflows). You could, for example, deploy each time a new tag is created on the project.

## Test the GitHub Action

You can now commit and push the `main.yml` file we created.

Going to the `Actions` tab of your  GitHub project, you should see that your project is automatically built and deployed to your Azure Spring Cloud instance:

![GitHub workflow](media/01-github-workflow.png)

Congratulations! Each time you `git push` your code, your microservice is now automatically deployed to production.
