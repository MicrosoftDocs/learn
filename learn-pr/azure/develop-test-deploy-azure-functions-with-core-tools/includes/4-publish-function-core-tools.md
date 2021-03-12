You can use the Core Tools to publish your functions to Azure.

Now that you've built and tested your simple interest function, you'd like to get it published to Azure. It would be great to see it up and running on the web, and provide the URL to your colleagues so they can see how it can be called from anywhere.

In this unit, you'll see how to create a function app in Azure and use the Core Tools to publish your functions project to it.

## Create a function app

Before you can use the Core Tools to publish a project, you need to create a function app in Azure. This is not a capability of the Core Tools: creating function apps is one of the responsibilities of the Azure management tools, which include the Azure portal, Azure CLI and Azure PowerShell. In the next exercise, we'll use the Azure CLI's `az functionapp create` command to create a function app to which we can publish our code.

Within the scope of this tutorial, the most important option to consider when creating a function app is the language runtime. A given function app only supports a single language runtime. If you already have a local functions project you want to publish, make sure to create the function app with the same language runtime. If you try to deploy a project to an app with a different runtime, publishing will halt with an error.

## Publish to Azure

To publish a functions project to Azure, run `func azure functionapp publish <app_name>` from the functions project folder. `<app_name>` is the name of the target function app in Azure, not the name of your project folder, which can be different.

:::image type="content" source="../media/4-publish.png" alt-text="Publishing a function app with func azure functionapp publish." loc-scope="other":::

The Core Tools don't ask you to sign in to Azure. Instead, they access your subscriptions and resources by loading your session information from the Azure CLI or Azure PowerShell. If you don't have an active session in one of those tools, publishing will fail. It's possible to publish from the Core Tools without the Azure CLI or Azure PowerShell, but it's much easier if you do have them, and we recommend you install one or the other and log in before trying to publish.

Once the tools indicate that publishing is complete, your functions are up and running in Azure. The final output from the Core Tools will show the functions that were published, including the invocation URL of each function.

### Things to know

Here are a few things to keep in mind when you use the Core Tools to publish your functions:

- The Core Tools do not validate or test your functions code during publishing. Make sure to use `func start` to do some testing before you publish!
- When you publish, any functions already present in the target app are stopped and deleted before the contents of your project are deployed. You can't combine functions from multiple projects into one app by publishing them in sequence - all of the functions you want in the app must be in one project.
- Publishing to Azure does not create any kind of relationship between the local project and the target function app. You can publish a single functions project to multiple function apps. You can also re-publish a project to the same app repeatedly as you work on your code.
- The invocation URLs displayed after you publish may include a `code` parameter in the query string, as in the screenshot above. By default, HTTP functions created by the Core Tools are configured with an authorization level of *function*, meaning they require callers to provide a secret key in the request headers or query string. The Core Tools includes the key in the query string of the displayed URL for your convenience.
