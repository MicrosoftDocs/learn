In this exercise, you create a function app in Azure and publish our project.

## Create a function app

> [!IMPORTANT]
> The procedures in this unit depend upon work completed in Unit 3. The sandbox for this module must be active. The sandbox gives you free, temporary access to Azure and the Azure CLI.
>
> The Azure Cloud Shell should already be signed in to your account and configured. If the sandbox isn't active, you've lost the necessary access, resources, and output you need. Go back and complete Unit 3.

Before you can publish your code to a function app using Core Tools, you need to create the app in Azure using the Azure CLI from  Cloud Shell.

To create a function app in Azure, run the following commands in Azure Cloud Shell.

```azurecli
RESOURCEGROUP="<rgn>[sandbox resource group]</rgn>"
STORAGEACCT=learnstorage$(openssl rand -hex 5)
FUNCTIONAPP=learnfunctions$(openssl rand -hex 5)

az storage account create \
  --resource-group "$RESOURCEGROUP" \
  --name "$STORAGEACCT" \
  --kind StorageV2 \
  --location centralus

az functionapp create \
  --resource-group "$RESOURCEGROUP" \
  --name "$FUNCTIONAPP" \
  --storage-account "$STORAGEACCT" \
  --runtime node \
  --consumption-plan-location centralus \
  --functions-version 4
```

Here's what these commands do:

- The first three lines at the top create shell variables with values that we use repeatedly in the following commands.

  - For resource group, specify the group created for you by the sandbox. This should already be the correct value based on your current sandbox.
  - The storage account and function app names include `$(openssl rand -hex 5)`, which generates a random five-character string, to ensure that the names meet the requirement of being globally unique, as well as other service naming requirements.

- `az storage account create` creates an Azure storage account that the function app uses. A storage account is a separate Azure resource that must be created before the function app can be created.

- `az functionapp create` creates the function app. Your new app uses the `node` (JavaScript) runtime, which runs serverless in a Consumption hosting plan.

>[!NOTE]
>The `az functionapp create` command also tries to automatically create an Application Insights instance for monitoring executions in your function app. Because workspace-based Application Insights resources can't currently be hosted in the sandbox, your functions work but execution logs aren't sent to Application Insights.  

## Publish to Azure

Now that you created your function app in Azure, you can publish the project to it with the Core Tools.

Run the following commands in Cloud Shell to publish. Run `cd` first to make sure you're still in the functions project folder before you publish.

```azurecli
cd ~/loan-wizard
func azure functionapp publish "$FUNCTIONAPP" --force
```

> [!NOTE]
> If this command displays an error that it can't find your app, wait two minutes and try again. New function apps take a few seconds to become discoverable by the Core Tools after they're created.
>
> Also, you're appending `--force` to the command to update the function app version mismatch.

Unlike the previous exercise, where you temporarily hosted your function locally from the Core Tools, your function is now live on the web. It remains globally available until the sandbox for this tutorial expires. Because the HTTP endpoint was defined with an `anonymous` authorization level, it can be accessed by anyone on the web.

## Run the function

Your function is now published to Azure and can be called from anywhere. As an HTTP-triggered function that responds to GET requests, it can be run from any browser.

1. Run the following command to get the request URL:

   ```azurecli
   func azure functionapp list-functions "$FUNCTIONAPP" --show-keys
   ```

1. Paste the URL from the output into a new browser tab. You see the same output that you observed when you ran the function locally without providing the right query string parameters. No keys are included in the output when you use an `anonymous` authorization level.

1. Add `?principal=5000&rate=.035&term=36` to the end of the URL and select **Enter**. Make sure that you preserve the `code` parameter, if present. The result returned is `6300.000000000001`, as expected.
