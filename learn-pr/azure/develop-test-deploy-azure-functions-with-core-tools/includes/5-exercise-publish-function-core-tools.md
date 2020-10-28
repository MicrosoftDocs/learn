In this exercise, we'll create a function app in Azure and publish our project.

## Create a function app

Before we can use the Core Tools to publish our code to a function app, we need to create the app in Azure. We'll use the Azure CLI in the Cloud Shell to do that.

This tutorial's sandbox gives you free, temporary access to Azure, and the Azure CLI in the Cloud Shell pane on the right has already been signed in to your account and configured to use your free access.

Run the following commands in the Cloud Shell to create a function app in Azure:

```azurecli
RESOURCEGROUP=<rgn>[sandbox resource group]</rgn>
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
  --functions-version 2
```

Here's what these commands do:

1. The three lines at the top create shell variables with values that we use repeatedly in the following commands. For resource group, we specify the group created for you by the sandbox. The storage account and function app names include `$(openssl rand -hex 5)`, which generates a random 5-character string, to ensure that the names meet the requirement of being globally unique.

2. `az storage account create` creates an Azure storage account that will be used by the function app. A storage account is a separate Azure resource that needs to be created before the function app can be created.

3. `az functionapp create` creates the function app. Our new app uses the `node` (JavaScript) runtime, and runs on the serverless, pay-as-you-go consumption billing plan.

## Publish to Azure

Now that our function app has been created in Azure, we can publish our project to it with the Core Tools.

Run the following commands in the Cloud Shell to publish. Here, we use `cd` first to make sure we're still in the functions project folder before publishing.

```azurecli
cd ~/loan-wizard
func azure functionapp publish "$FUNCTIONAPP"
```

> [!NOTE]
> If this command displays an error that it can't find your app, wait a moment and try again. New function apps take a few seconds to become discoverable by the Core Tools after they're created. You can also try adding `--force` to update the function app version mismatch. 

Unlike the previous exercise, where you temporarily hosted your function locally from the Core Tools, your function is now live on the web and will remain globally available until the sandbox for this tutorial expires.

## Run the function

Our function is now published to Azure and can be called from anywhere. As an HTTP-triggered function that responds to GET requests, we can run it from a browser. Let's try it:

1. Click the invoke URL from the previous command's output to open it in a new browser tab. You'll see the same output we observed when we ran the function locally without providing the right query string parameters.

2. Add `&principal=5000&rate=.035&term=36` to the end of the URL (make sure you preserve the `code` parameter) and press <kbd>Enter</kbd>. The result returned is `6300`, just as before.
