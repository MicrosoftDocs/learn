TODO: Roberta, ignore this page.

* Create web app on Azure using AppService (CLI)
* Modify stage in build pipeline that deploys to Dev environment (the Dev deployment slot)
* `git add; git commit; git push` and watch it run. Verify app is running.

## GET BRANCH

1. From the terminal, run the following `git` commands to fetch a branch named `release-workflow` from Microsoft's repository and switch to that branch.

    ```bash
    git fetch upstream release-workflow
    git checkout release-workflow
    ```

    As you did in previous modules, the format of this command enables you to get starter code from Microsoft's GitHub repository, known as `upstream`. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

## CREATE WEB APP

```bash
webappname=TailspinGame$RANDOM
az group create --location westus --name TailspinResourceGroup
az appservice plan create --name myAppServicePlan --resource-group TailspinResourceGroup --sku P2V2
az webapp create --name $webappname --resource-group TailspinResourceGroup --plan myAppServicePlan
az webapp deployment slot create --name $webappname --resource-group TailspinResourceGroup --slot Dev
az webapp deployment slot create --name $webappname --resource-group TailspinResourceGroup --slot Test
az webapp deployment slot create --name $webappname --resource-group TailspinResourceGroup --slot Staging
```

```bash
az webapp deployment slot list --name $webappname --resource-group TailspinResourceGroup --query [].name --output tsv
```

```bash
az webapp deployment slot list --name $webappname --resource-group TailspinResourceGroup --query [].hostNames --output tsv
```

### CREATE SERVICE CONNECTION

* Select **Service Principal Authentication**.

  * **Connection name**: Sandbox
  * **Scope level**: Subscription
  * **Subscription**: Concierge Subscription
  * **Resource Group**: <rgn>[Resource Group Name]</rgn>

TODO: SET VARIABLE FOR WEB APP NAME (and update reference code!)

FORGET THE FOLLOWING. IT'S SCRATCH WORK WE LIKELY DON'T NEED

```bash
az account list --query "[?name=='Concierge Subscription'][].{SubscriptionName:name, SubscriptionID:id, TenantID:tenantId}" --output table
```

```
az account list --query "[?name=='Microsoft Azure Internal Consumption'][].{SubscriptionName:name, SubscriptionID:id, TenantID:tenantId}" --output table
```

## PROMOTE TO DEV ENVIRONMENT

[!code-yml[](code/4-azure-pipelines.yml)]