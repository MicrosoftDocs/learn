# Adding parameters to an ARM templates

By leveraging parameters, you can reuse templates for different environments by passing different values either through the command line or a parameter file to the template. Azure Resource Manager resolves parameter values before starting the deployment operations. Wherever the parameter is used in the template, Resource Manager replaces it with the resolved value, making it reusable, and repeatable.

Now, let's get back to parameters.

## Customize by environment

Parameters enable you to customize the deployment by providing values that are tailored for a particular environment. For example, you can pass different values based on whether you're deploying to an environment for development, test, and production or others.

In the last Unit, you deployed the template with a Standard_LRS storage account. You might want the flexibility to deploy different SKUs depending on the environment. by using parameters, you can achieve that.

## Understand resource updates

In the previous section, you deployed a storage account with the same name that you had created earlier. You may be wondering how existing resource already deployed will be affected by a template redeployment. As mentioned in Unit 1, Templates are idempotent, which means you can deploy the same template many times and get the same resource types, in the same state. When using an ARM template, if the resource already exists and no change is detected in the properties, no action is taken. If the resource already exists and a property has changed, the resource is updated. If the resource doesn't exist, it's created.

This way of handling updates means your template can include all of the resources you need for an Azure solution. You can safely redeploy the template and know that resources are changed or created only when needed. For example, if you have added files to your storage account, you can redeploy the storage account without losing those files.

## Defining parameter

When specifying parameters,  you can define the default value for a parameter, you can use most template functions. You can use another parameter value to build a default value. The following template demonstrates the use of functions in the default value. When no name is provided for the site, it creates a unique string value and appends it to site. When no name is provided for the host plan, it takes the value for the site, and appends -plan.

In the parameters section of the template, you specify which values you can input when deploying the resources. You're limited to **256 parameters** in a template.

The available properties for a parameter are:

```json
"parameters": {
  "<parameter-name>" : {
    "type" : "<type-of-parameter-value>",
    "defaultValue": "<default-value-of-parameter>",
    "allowedValues": [ "<array-of-allowed-values>" ],
    "minValue": <minimum-value-for-int>,
    "maxValue": <maximum-value-for-int>,
    "minLength": <minimum-length-for-string-or-array>,
    "maxLength": <maximum-length-for-string-or-array-parameters>,
    "metadata": {
      "description": "<description-of-the parameter>"
    }
  }
}
```
The allowed types of parameters are 
- String
- Securestring
- Integers
- Boolean
- Object
- SecureObject
- Array

The following JSON file shows the usage and formats of different parameter types.

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "exampleString": {
      "value": "test string"
    },
    "exampleInt": {
      "value": 4
    },
    "exampleBool": {
      "value": true
    },
    "exampleArray": {
      "value": [
        "value 1",
        "value 2"
      ],
    },
    "secretValue": {
        "type": "securestring",
        "metadata": {
            "description": "The value of the secret to store in the vault."
        }
    },
    "exampleObject": {
      "value": {
        "property1": "value1",
        "property2": "value2"
      }
    }
   }
}
```

Below is a table of each element that makes up the definition of a parameter and whether they are a **required** in the template.

| Element name | Required | Description |
|:--- |:--- |:--- |
| parameter-name |Yes |Name of the parameter. Must be a valid JavaScript identifier. |
| type |Yes |Type of the parameter value. (See above) |
| defaultValue |No |Default value for the parameter, if no value is provided for the parameter. |
| allowedValues |No |Array of allowed values for the parameter to make sure that the right value is provided. |
| minValue |No |The minimum value for "int" type parameters, this value is inclusive. |
| maxValue |No |The maximum value for int type parameters, this value is inclusive. |
| minLength |No |The minimum length for string, secure string, and array type parameters, this value is inclusive. |
| maxLength |No |The maximum length for string, secure string, and array type parameters, this value is inclusive. |
| description |No |Description of the parameter that is displayed to users through the portal. |


## General recommendations for parameters

when creating your template, there are some recommendations you should follow. These recommendations are not rules, and therefore can be altered for your own environment.  However, experience has taught us that the following points will benefit you when building your own templates from scratch. 

1. Minimize your use of parameters. Instead, use variables or literal/constructed values for properties that don't need to be specified during each deployment or do not required an easily readable notation.

1. Use camel case for parameter names.  Camel case is a typographical way of compounding words together where the initial capital is used for the first letter of each word after and including the second word of the compound.<br>for example, exampleArray, contentVersion, storageAccountType...

1. Use parameters for settings that vary according to the environment, like SKU, size, or capacity.

1. Use parameters for resource names that you want to specify yourself for easy identification or to comply with internal naming conventions.

1. Provide a description of **every** parameter in the metadata:

:::code language="json" source="../samples/parameter-description-example.json" highlight="5":::

6. Define default values for parameters whenever possible.  A defined value will make it easier to deploy the template, and users of your template see an example of an appropriate value.

:::code language="json" source="../samples/parameter-defaultValue-example.json" highlight="4":::

7. To specify an optional parameter, instead of making up strings or other types,  you can use a literal value with a language expression to **construct** a value using template functions.

:::code language="json" source="../samples/parameter-construct-example.json" highlight="3,10":::

8. **Don't*** use a parameter for the API version for a resource type

## Security recommendations for parameters

1. As if we have to specify this one....  NEVER hard code or provide default values for usernames and/or passwords in templates. Always use parameters for usernames and passwords (or secrets).
1. Use **securestring** for all passwords and secrets. If you pass sensitive data in a JSON object, use the secureObject type. Template parameters with secure string or secure object types can't be read/harvested after the deployment of the resource.

