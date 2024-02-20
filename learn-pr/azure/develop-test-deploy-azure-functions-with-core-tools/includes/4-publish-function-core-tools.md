You can use Core Tools to publish your functions to Azure.

Now that you built and tested your simple interest function, you want to publish it to Azure. It would be great to see it up and running on the web. When it is, you can send the URL to your colleagues so they can call it from anywhere.

## Create a function app

Before you can use Core Tools to publish a project, you need to create the required resources in Azure, including the function app used to host the project. Functions also requires a storage account. You can't use Core Tools to create these Azure resources. Instead, you create function apps through Azure management tools, which include the Azure portal, Azure CLI, and Azure PowerShell. In the next exercise, run the Azure CLI command `az functionapp create` to create a function app to which you can publish your code.

Within the scope of this tutorial, the most important option to consider when you create a function app is the language runtime. A function app only supports a single language runtime. If you already have a local functions project that you want to publish, make sure to create the function app with the same language runtime. When you try to deploy a project to an app with a different runtime, publishing halts with an error.

## Publish to Azure

To publish your functions project to a function app in Azure, run `func azure functionapp publish <app_name>` from the functions project folder. `<app_name>` is the name of the target function app in Azure, not the name of your project folder, which can be different.

:::image type="content" source="../media/4-publish.png" alt-text="Publishing a function app with func azure functionapp publish." loc-scope="other":::

Core Tools doesn't ask you to sign in to Azure. Instead, it accesses your subscriptions and resources by loading your session information from the Azure CLI or Azure PowerShell. If you don't have an active session in one of those tools, publishing fails. It's possible to publish from the Core Tools without the Azure CLI or Azure PowerShell. However, it's easier if you do have them. We recommend you install one or the other. Make sure to sign in before you try to publish.

After the output indicates that publishing is complete, your functions are up and running in Azure. The final publishing output shows the functions that were published, including the invocation URL of each HTTP triggered function.

### Things to know

Here are a few things to keep in mind when you use Core Tools to publish your functions:

- Core Tools don't validate or test your functions code during publishing.
- Make sure to use `func start` to do some testing before you publish!
- When you publish, any functions already present in the target app are stopped and deleted before the contents of your project are deployed.
- You can't combine functions from multiple projects into one app by publishing them in this sequence.
- All of the functions you want in the app must be in one project.
- Publishing to Azure doesn't create any kind of relationship between the local project and the target function app.
- You can publish a single functions project to multiple function apps.
- You can also republish a project to the same app repeatedly as you work on your code.
- The invocation URLs displayed after you publish might include a `code` parameter in the query string.
- You can see it in the screenshot: `?code=4FowT1ywMNoxqa...`
- HTTP trigger functions have an authorization level of *function*, which requires you to pass a secret *function* key in the request headers or query string.
- Core Tools returns the key in the query string of the displayed URL, for your convenience.
