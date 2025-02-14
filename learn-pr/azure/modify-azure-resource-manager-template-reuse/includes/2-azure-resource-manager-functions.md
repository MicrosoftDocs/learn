In this scenario, you want to make deploying your Azure Resource Manager (ARM) template to different environments as easy as possible. One of the areas of contention is coming up with a unique name for the Azure storage account.

To solve this problem, you decide to create an expression by using [ARM template functions](/azure/azure-resource-manager/templates/template-functions?azure-portal=true).

## What are ARM template functions?

ARM template functions add flexibility to your ARM template by dynamically getting values during deployment.

To understand functions, you first need to understand expressions. Expressions are values that are evaluated when the template is deployed. They start and end with brackets `[]`, and can return a string, integer, Boolean, array, or object.

In the previous module in this learning path, you already worked with expressions in your Resource Manager template. For example, you used:

```json
"parameters": {
  "location": {
    "type": "string",
    "defaultValue": "[resourceGroup().location]"
  }
},
```

The *expression* is the value of the ```defaultValue:``` attribute. Notice that this expression holds the *ARM template function* ```resourceGroup()```. This function returns information about the resource group to which this template is deploying. The ```.location``` retrieves one property from the object returned by the function. Functions allow you to construct values you need dynamically.

## How do I work with ARM template functions?

There are a few rules to follow when you work with functions:

- Use single quotation marks when you pass a string value into a function. Here's an example: `concat('storage',uniqueString(resourceGroup().id))`. The function is `concat`, and the string you're passing in to the function is `'storage'`.

- To work with literal values in template functions, you need *escape characters*. The escape character varies depending on what you're escaping.

- To set a property to null, you can use ```null``` or ```[json('null')]```. The JSON function returns an empty object when you provide null as the parameter.

  ```json
  "stringValue": null,
  "objectValue": "[json('null')]"
  ```

Resource Manager provides several [ARM template functions](/azure/azure-resource-manager/templates/template-functions?azure-portal=true) for you. The functions are listed in groups based on their type:

- **Array functions** for working with arrays. For example, ```first``` and ```last```.
- **Comparison functions** for making comparisons in your templates. For example, ```equals``` and ```greater```.
- **Date functions** for working with dates. For example, ```utcNow``` and ```dateTimeAdd```.
- **Deployment value functions** for getting values from sections of the template and values related to the deployment. For example, ```environment``` and ```parameters```.
- **Logical functions** for working with logical conditions. For example, ```if``` and ```not```.
- **Numeric functions** for working with integers. For example, ```max``` and ```mod```.
- **Object functions** for working with objects. For example, ```contains``` and ```length```.
- **Resource functions** for getting resource values. For example, ```resourceGroup``` and ```subscription```.
- **String functions** for working with strings. For example, ```length``` and ```startsWith```.

### How can I use several functions in one expression?

You can use several template functions together to create your own expressions. In this scenario, you need to create an expression that creates a unique name for each resource group by combining a prefix input with a hash of the resource group ID. This expression results in storage account names like `dev2hu6fktr577wh` and `staging5his8hgr67tt5`. You can use four functions to construct this string value. For example:

```json
"[toLower(concat('Storage',uniqueString(resourceGroup().id)))]"
```

Let's walk through this expression.

Beginning with [concat](/azure/azure-resource-manager/templates/template-functions-string), this function takes any number of arguments, and can accept either strings or arrays for the parameters. Here, you use a literal string `"Storage"` and concatenate it with the result of another function, [uniqueString](/azure/azure-resource-manager/templates/template-functions-string). The `uniqueString` function creates a deterministic hash string based on the parameters. In this expression, you create a hash of the current resource group ID by using another function, [resourceGroup](/azure/azure-resource-manager/templates/template-functions-resource).

Here's the output from what we discussed so far:

:::image type="content" source="../media/2-storage-account-name-function.png" alt-text="Picture of a string created by concatenating the word Storage with a 13-character hash that contains both uppercase and lowercase letters." border="false":::

To comply with the naming conventions, you need this string to be all lowercase. Here, you add the [toLower](/azure/azure-resource-manager/templates/template-functions-string#tolower?azure-portal=true) function as the outer function.

Here's what the resulting string looks like:

:::image type="content" source="../media/2-storage-account-name-function-lower.png" alt-text="Picture of a string created by concatenating the word Storage with a 13-character hash, and then converting all letters to lowercase." border="false":::