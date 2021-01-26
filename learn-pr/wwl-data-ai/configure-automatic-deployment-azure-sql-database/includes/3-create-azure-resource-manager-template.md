An Azure Resource Manager template is a JSON (JavaScript Object Notation) document that describes the resources that will be deployed within an Azure Resource Group. The structure of these templates is shown below.

```javascript
{

 "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",

 "contentVersion": "",

 "apiProfile": "",

 "parameters": { },

 "variables": { },

 "functions": [ ],

 "resources": [ ],

 "outputs": { }

}
```

The schema file, which is referenced on the first line the above example describes the version of the template language. This file is supplied by Microsoft to define the Azure API. The content version number is only defined by you as needed, and should align with your internal versioning standard. The API profile serves as a collection of API versions for this environment. This is especially useful when deploying resources to different environments like national clouds and commercial clouds, which may have differing resource providers. Parameters are values that are provided to the template in order to customize resources at deployment time, whereas variables are values that are used as JSON fragments to simplify template language expressions. You can also include user-defined functions within the template. The resource component defines what resources are getting defined in the template. The resources are the resource types that you are deploying. The code sample below shows the example resources section from an Azure Resource Manager template to deploy an Azure SQL Database.

```javascript
"resources": [

 {

 "name": "[variables('sqlServerName')]",

 "type": "Microsoft.Sql/servers",

 "apiVersion": "2014-04-01-preview",

 "location": "[parameters('location')]",

 "tags": {

 "displayName": "SqlServer"

 },

 "properties": {

 "administratorLogin": "[parameters('sqlAdministratorLogin')]",

 "administratorLoginPassword": "[parameters('sqlAdministratorLoginPassword')]",

 "version": "12.0"

 },

 "resources": [

 {

 "name": "[variables('databaseName')]",

 "type": "databases",

 "apiVersion": "2015-01-01",

 "location": "[parameters('location')]",

 "tags": {

 "displayName": "Database"

 },

 "properties": {

 "edition": "[variables('databaseEdition')]",

 "collation": "[variables('databaseCollation')]",

 "requestedServiceObjectiveName": "[variables('databaseServiceObjectiveName')]"

 },

 "dependsOn": [

 "[variables('sqlServerName')]"

 ],

 "resources": [

 {

 "comments": "Transparent Data Encryption",

 "name": "current",

 "type": "transparentDataEncryption",

 "apiVersion": "2014-04-01-preview",

 "properties": {

 "status": "[parameters('transparentDataEncryption')]"

 },

 "dependsOn": [

 "[variables('databaseName')]"

 ]

 }

 ]

 }
```

One of the most important things to note about the structure of the resources section of the above template is the **dependsOn** option. This option allows you to build a dependency structure into your template. A simple example is in the template above; the Azure SQL Database is dependent on the existence of an Azure SQL Database server, and Transparent Data Encryption is dependent on the existence of the database. This option can be used to build even more complex dependency structures for complex application deployments.

It is important to understand the difference between variables and parameters. Parameters can accept values from outside the template by user interaction, a file, or CI/CD pipelines. Variables can be defined within the template and are used for simplification, since you can define a complicated expression once, and then use it throughout the template. An example of variable definition in an Azure Resource Manager template is shown in the exhibit below.

```javascript
"variables": {

 "storageName": "[concat(toLower(parameters('storageNamePrefix')), uniqueString(resourceGroup().id))]"

}
```

By defining this expression in the variables section of your template, you can reuse it by referencing the variable in other parts of the template in the following manner: `"[variables('storageName;)]"`. Variables let you avoid repeating a complicated expression throughout your template, by using the variable name.

## *Source control for templates*

Azure Resource Manager Templates are an example of infrastructure as code. Since all hardware resources are abstracted behind a set of APIs, your entire infrastructure can just be another component of your application code. Just like application or database code, it is important to protect and version this code. In addition to the internal version in the template, your source control system should version your templates. You can also configure your templates to be automatically deployed from GitHub.

:::image type="content" source="../media/module-66-automation-final-02.png" alt-text="GitHub Azure Quickstart Template":::
