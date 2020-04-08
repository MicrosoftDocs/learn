

#### Customize by environment

Parameters enable you to customize the deployment by providing values that are tailored for a particular environment. For example, you can pass different values based on whether you're deploying to an environment for development, test, and production.

The previous template always deployed a Standard_LRS storage account. You might want the flexibility to deploy different SKUs depending on the environment. The following example shows the changes to add a parameter for SKU. Copy the whole file and paste over your template.


#### Understand resource updates
In the previous section, you deployed a storage account with the same name that you had created earlier. You may be wondering how the resource is affected by the redeployment.

If the resource already exists and no change is detected in the properties, no action is taken. If the resource already exists and a property has changed, the resource is updated. If the resource doesn't exist, it's created.

This way of handling updates means your template can include all of the resources you need for an Azure solution. You can safely redeploy the template and know that resources are changed or created only when needed. For example, if you have added files to your storage account, you can redeploy the storage account without losing those files.