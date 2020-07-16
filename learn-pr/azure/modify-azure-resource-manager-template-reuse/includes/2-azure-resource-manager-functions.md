In the scenario, you want to make deploying your Azure Resource Manager (ARM) template to different environments as seamless as possible. One of the areas of contention is coming up with a unique name for the Azure Storage Account.

You decide to create an expression using [ARM template functions](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions?azure-portal=true) to solve this problem.

## What are ARM template functions

ARM template functions add flexibility to your ARM template by dynamically getting values during deployment.

To understand functions, you first need to understand expressions. Expressions are values that get evaluated when the template is deployed. They start and end with square brackets, [ and ], and can return a string, integer, boolean, array, or object.

You have already worked with expressions in your Resource Manager template in the previous module. As an example, you used:

```json
"parameters": {
  "location": {
    "type": "string",
    "defaultValue": "[resourceGroup().location]"
  }
},
```

The *expression* is the value of the ```defaultValue:``` attribute. Notice that this expression holds the *ARM template function* ```resourceGroup()```. This function returns information on the resource group that this template is deploying to. The ```.location``` retrieves one property from the object returned by that function. Functions allow you to construct values you need dynamically.

## How do I work with ARM template functions

There are a few rules when working with functions:

Use single quotes when passing a string value into a function. For example ```concat('storage',uniqueString(resourceGroup().id)))```. The function here is ```concat``` and the string you are passing in to the function is ```'storage'```.

To work with literal values in template functions you need *escape characters*. The escape character is different depending on what you are escaping.

To set a property to null, you can use ```null``` or ```[json('null')]```. The json function returns an empty object when you provide null as the parameter.

```json
"stringValue": null,
"objectValue": "[json('null')]"
```

Resource Manager provides several [ARM template functions](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions?azure-portal=true) for you. The functions are listed in groups of different types of functions:

- *Array functions* for working with arrays. For example, ```first``` and ```last```.
- *Comparison functions* for making comparisons in your templates. For example, ```equals``` and ```greater```.
- *Date functions* for working with dates. For example, ```utcNow``` and ```dateTimeAdd```.
- *Deployment value functions* for getting values from sections of the template and values related to the deployment. For example, ```environment``` and ```parameters```.
- *Logical functions* for working with logical conditions. For example, ```if``` and ```not```.
- *Numeric functions* for working with integers. For example, ```max``` and ```mod```.
- *Object functions* for working with objects.For example, ```contains``` and ```length```.
- *Resource functions* for getting resource values. For example, ```resourceGroup``` and ```subscription```.
- *String functions* for working with strings. For example, ```length``` and ```startsWith```.

### How can I use several functions in one expression

You can use several template functions together to create your own expressions. In the scenario, you need to create a way to create an expression that creates a unique name per resource group by taking a prefix input and adding a hash of the resource group id. This results in Storage Account names similar to *dev2hu6fktr577wh* or *staging5his8hgr67tt5*. You can use four functions to construct this string value. For example:

```json
"[toLower(concat("Storage",uniqueString(resourceGroup().id)))]"
```

Let's walk through this expression.

Starting with [concat](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions-string#concat?azure-portal=true), this function takes any number of arguments, and can accept either strings or arrays for the parameters. Here, you use a literal string *"Storage"* and concatenate it with the result of another function, [uniqueString](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions-string#uniquestring?azure-portal=true). The uniqueSting function creates a deterministic hash string based on the parameters. Here, you are creating a hash of the current resource group ID using another function, [resourceGroup](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions-resource#resourcegroup?azure-portal=true).

The output from what has been discussed so far looks like:

:::image type="content" source="../media/2-storage-account-name-function.png" alt-text="A string with Storage concatenated with a 13 character hash with both uppercase and lowercase letters." border="false":::

To comply with the naming conventions, you need this string to be all lower case. Here, you add the [toLower](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions-string#tolower?azure-portal=true) function as the outer function.

The resulting string looks like:

:::image type="content" source="../media/2-storage-account-name-function-lower.png" alt-text="A string with Storage concatenated with a 13 character hash with all lowercase letters." border="false":::
