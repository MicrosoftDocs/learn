In the previous scenario, you decided to use an expression made up of several Azure Resource Manager (ARM) template functions to create a unique name for the Azure storage account. This flexibility ensures that all your customers are able to use the ARM template for their deployments. But you notice that adding this expression in several places is a problem for maintaining the template. You decide to use a variable for the storage account name expression so you can define the expression in one place and reuse it throughout the template. 

## What is an ARM template variable?

An ARM template variable is a construct that holds a value for later use. Variables are best used when a value needs to be specified in several places in a template. Wherever the variable is used in the template, Resource Manager replaces it with the resolved value.

For example, you have an expression that defines a value for a resource location. Several of the resources that you defined in your template require a location. You can create a variable to hold the location expression and then use the variable wherever a location is required.

### Advantages to using ARM template variables

ARM template variables allow you to write an expression once and then use it in several places. Also, maintenance of the expression is in one place, and the template is more readable.

## How do I use ARM template variables?

ARM template variables are defined in the ```variables: {}``` section of a template. For example, here's the expression for the storage account name you defined in the last unit. It's now defining the value for the ```storageName``` variable.

```json
"variables": {
  "storageName": "[concat(toLower(parameters('storageNamePrefix')), uniqueString(resourceGroup().id))]"
},
```

You then use the variable in the template wherever you need the storage account name:

```json
"resources": [
  {
    "type": "Microsoft.Storage/storageAccounts",
    "name": "[variables('storageName')]",
    ...
  }
]
```

### Recommendations for ARM template variables

Template variables are specified in camel case. They're best used for values that you need to specify more than once, especially if that value is a complex expression.

Don't use the ```reference``` function in the variables section of a template. The ```reference``` function is resolved at runtime, and variables are resolved when the template is parsed. Also, don't use variables for ```apiVersion``` on a resource. The API version determines the schema of the resource, and often you can't change the version without changing the properties for the resource.
