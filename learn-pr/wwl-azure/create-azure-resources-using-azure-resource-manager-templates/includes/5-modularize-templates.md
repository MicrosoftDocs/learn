
When using Azure Resource Manager templates, it's best to modularize them by breaking them into individual components.

The primary methodology to use is by using linked templates.

It allows you to break the solution into targeted components and reuse those various elements across different deployments.

## Linked template

Add a deployment resource to your main template to link one template to another.

```JSON
"resources": [
  {
      "apiVersion": "2017-05-10",
      "name": "linkedTemplate",
      "type": "Microsoft.Resources/deployments",
      "properties": {
          "mode": "Incremental",
          <link-to-external-template>
      }
  }
]


```

## Nested template

You can also nest a template within the main template, use the template property, and specify the template syntax.

It does somewhat aid modularization, but dividing up the various components can result in a sizeable main file, as all the elements are within that single file.

```JSON
"resources": [
  {
    "apiVersion": "2017-05-10",
    "name": "nestedTemplate",
    "type": "Microsoft.Resources/deployments",
    "properties": {
      "mode": "Incremental",
      "template": {
        "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "resources": [
          {
            "type": "Microsoft.Storage/storageAccounts",
            "name": "[variables('storageName')]",
            "apiVersion": "2015-06-15",
            "location": "West US",
            "properties": {
              "accountType": "Standard_LRS"
            }
          }
        ]
      }
    }
  }
]

```

> [!NOTE]
> You can't use parameters or variables defined within the nested template itself for nested templates. You can only use parameters and variables from the main template.

The properties you provide for the deployment resource will vary based on linking to an external template or nesting an inline template within the main template.

## Deployments modes

When deploying your resources using templates, you have three options:

 -  **validate**. This option compiles the templates, validates the deployment, ensures the template is functional (for example, no circular dependencies), and correct syntax.
 -  **incremental mode (default)**. This option only deploys whatever is defined in the template. It doesn't remove or modify any resources that aren't defined in the template. For example, if you've deployed a VM via template and then renamed the VM in the template, the first VM deployed will remain after the template is rerun. It's the default mode.
 -  **complete mode**: Resource Manager deletes resources that exist in the resource group but isn't specified in the template. For example, only resources defined in the template will be present in the resource group after the template deploys. As a best practice, use this mode for production environments to achieve idempotency in your deployment templates.

When deploying with PowerShell, to set the deployment mode use the *Mode* parameter, as per the nested template example earlier in this topic.

> [!NOTE]
> As a best practice, use one resource group per deployment.

> [!NOTE]
> You can only use `incremental` deployment mode for both linked and nested templates.

## External template and external parameters

To link to an external template and parameter file, use **templateLink** and **parametersLink**.

When linking to a template, ensure that the Resource Manager service can access it.

For example, you can't specify a local file or a file only available on your local network.

You can only provide a Uniform Resource Identifier (URI) value that includes HTTP or HTTPS.

One option is to place your linked template in a storage account and use the URI for that item.

You can also provide the parameter inline. However, you can't use both inline parameters and a link to a parameter file.

The following example uses the *templateLink* parameter:

```JSON
  "resources": [
    {
      "name": "linkedTemplate",
      "type": "Microsoft.Resources/deployments",
      "apiVersion": "2018-05-01",
      "properties": {
          "mode": "Incremental",
          "templateLink": {
              "uri":"https://linkedtemplateek1store.blob.core.windows.net/linkedtemplates/linkedStorageAccount.json?sv=2018-03-28&sr=b&sig=dO9p7XnbhGq56BO%2BSW3o9tX7E2WUdIk%2BpF1MTK2eFfs%3D&se=2018-12-31T14%3A32%3A29Z&sp=r"
          },
          "parameters": {
              "storageAccountName":{"value": "[variables('storageAccountName')]"},
              "location":{"value": "[parameters('location')]"}
          }
      }
    },


```

## Securing an external template

Although the linked template must be available externally, it doesn't need to be made available to the public.

Instead, you can add your template to a private storage account accessible to only the storage account owner, creating shared access signature (SAS) tokens to enable access during deployment.

You add that SAS token to the URI for the linked template.

Even though the token is passed in as a secure string, the linked template's URI, including the SAS token, is logged in the deployment operations.

To limit exposure, you can also set an expiration date for the token.
