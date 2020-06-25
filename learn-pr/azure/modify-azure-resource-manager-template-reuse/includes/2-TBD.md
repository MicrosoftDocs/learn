In the scenario, you want to make deploying your template to different environments as seamless as possible. One of the areas of contention is coming up with a unique name for the Azure storage account.

You decide to use an [Azure Resource Manager template function](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions?azure-portal=true) to solve this problem.

## What are template functions

Functions add flexibility to your template by dynamically getting values during deployment.

To understand functions, you first need to understand expressions. Expressions are values that get evaluated when the template is deployed. They start and end with square brackets, [ and ], and can return a string, integer, boolean, array, or object.

You have already worked with expressions in you Azure Resource Manager template in the previous module. As an example, you used:

```json
"parameters": {
  "location": {
    "type": "string",
    "defaultValue": "[resourceGroup().location]"
  }
},
```

The expression is for the ```defaultValue:``` attribute. Notice that this expression holds a *template function*, ```resourceGroup()```. This is a template function that returns that returns information on the resource group that this template is deploying to. The ```.location``` retrieves one property from the object returned by that function. Functions allow you to construct values you need dynamically.

## How do I work with functions

There are a few rules when working with functions:

Use single quotes when passing a string value into a function. For example ```concat('storage',uniqueString(resourceGroup().id)))```.

To work with literal values in template functions you need *escape characters*. The escape character is different depending on what you are escaping.

To have a literal string start with a left bracket [ and end with a right bracket ], but not have it interpreted as an expression, add an extra bracket to start the string with [[. For example, the variable:

```json
"demoVar1": "[[test value]"
```

Resolves to ```[test value]```.

However, if the literal string doesn't end with a bracket, don't escape the first bracket.

```json
"demoVar2": "[test] value"
```

Resolves to ```[test] value```.

To escape double quotes in an expression, such as adding a JSON object in the template, use the backslash.

```json
"tags": {
    "CostCenter": "{\"Dept\":\"Finance\",\"Environment\":\"Production\"}"
},
```

To set a property to null, you can use ```null``` or ```[json('null')]```. The json function returns an empty object when you provide null as the parameter. In both cases, Resource Manager templates treat it as if the property isn't present.

```json
"stringValue": null,
"objectValue": "[json('null')]"
```

The Azure Resource Manager provides several [template functions](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions?azure-portal=true) for you.

### How can I use several functions in one expression

You can use several template functions together to create your own expressions. In the scenario, you need to create a way to create an expression that creates a unique name per resource group by taking a prefix input and adding a hash of the resource group id. This results in storage account names similar to *dev2hu6sbtr5* or *staging5his8hgr67*. You can use four functions to construct this string value. For example:

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
