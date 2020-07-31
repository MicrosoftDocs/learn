In the previous scenario, you decided to use an expression made up of several Azure Resource Manager (ARM) template functions to create a unique name for the Azure Storage Account. This flexibility will make sure each of your customers will be able to use this ARM template for their deployment. However, you notice that adding this expression in several places will be a problem for maintaining this template. You decide to use a variable for the Storage Account name expression so you can define the expression in one place and reuse it throughout the template. 

## What is an ARM template variable

An ARM template variable is a construct that holds a value for later use. Variables are best used when a value needs to be specified in several places in the template. Wherever the variable is used in the template, Resource Manager replaces it with the resolved value.

For example, you have an expression that defines a value for a resource location. Several of the resources you have defined in your template require a location. You create a variable to hold the location expression and then use the variable in all of the places a location is required.

### Advantages to using ARM template variables

ARM template variables allow you to write an expression once, and then use it in several places. Further, maintenance of the expression is in one place and the template is more readable.

## How do I use ARM template variables

ARM template variables are defined in the ```variables: {}``` section of the template. For example, here is the expression for the Storage Account name you defined in the last unit. It is now defining the value for the ```storageName``` variable.

```json
"variables": {
  "storageName": "[concat(toLower(parameters('storageNamePrefix')), uniqueString(resourceGroup().id))]"
},
```

Then, use that variable in the template wherever you need the Storage Account name.

```json
"resources": [
  {
    "type": "Microsoft.Storage/storageAccounts",
    "name": "[variables('storageName')]",
    ...
  }
]
```

### Best practices for ARM template variables

Template variables are specified using camel case and are best used for values that you need to specify more than once, especially if that value is a complex expression.

Don't use the ```reference``` function in the variables section of the template. The reference function is resolved at runtime and variables are resolved when the template is parsed. Also, don't use variables for ```apiVersion``` on a resource. The API version determines the schema of the resource and often you can't change the version without changing the properties for the resource.
