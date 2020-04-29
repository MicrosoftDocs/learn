# Add outputs to your template - Exercise

## Review template
At the end of the previous exercise, your template had the following JSON:

:::code language="JSON" source="../samples/exercise4-function-2.json":::

It deploys your storage account, but it doesn't return any information about the storage account. You might need to capture properties from a new resource so they're available later for reference or to pass it to another template if you're using nested templates.

### Add outputs

You can use outputs to return values from the template. For example, it might be helpful to get the endpoints for your new storage account.

The following example highlights the change to your template to add an output value. Copy the whole file and replace your template with its contents.


There are some important items to note about the output value you added.

The type of returned value is set to object, which means it returns a JSON object.

It uses the reference function to get the runtime state of the storage account. To get the runtime state of a resource, you pass in the name or ID of a resource. In this case, you use the same variable you used to create the name of the storage account.

Finally, it returns the primaryEndpoints property from the storage account

## Deploy your template

You're ready to deploy the template and look at the returned value.


In the output for the deployment command, you'll see an object similar to the following example only if the output is in JSON format:

```json
{
    "dfs": "https://storeluktbfkpjjrkm.dfs.core.windows.net/",
    "web": "https://storeluktbfkpjjrkm.z19.web.core.windows.net/",
    "blob": "https://storeluktbfkpjjrkm.blob.core.windows.net/",
    "queue": "https://storeluktbfkpjjrkm.queue.core.windows.net/",
    "table": "https://storeluktbfkpjjrkm.table.core.windows.net/",
    "file": "https://storeluktbfkpjjrkm.file.core.windows.net/"
}
```


>[!NOTE]
>If the deployment failed, use the debug switch with the deployment command to show the debug logs. You can also use the verbose switch to show the full debug logs.

## Review your work

You've done a lot in the last six tutorials. Let's take a moment to review what you have done. You created a template with parameters that are easy to provide. The template is reusable in different environments because it allows for customization and dynamically creates needed values. It also returns information about the storage account that you could use in your script.

Now, let's look at the resource group and deployment history.

Sign in to the Azure portal.

From the left menu, select Resource groups.

Select the resource group you deployed to.

Depending on the steps you did, you should have at least one and perhaps several storage accounts in the resource group.

You should also have several successful deployments listed in the history. Select that link.

Select deployments

You see all of your deployments in the history. Select the deployment called addoutputs.

Show deployment history

You can review the inputs.

Show inputs

You can review the outputs.

Show outputs

You can review the template.

Show template