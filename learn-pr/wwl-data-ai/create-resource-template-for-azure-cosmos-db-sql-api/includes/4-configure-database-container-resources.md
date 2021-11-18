Each template resource uses the same resource type and version between both Azure Resource Manager and Bicep templates. If you learn how to build it in one language, you can easily learn it in the other.

> &#128221; A Bicep template does not require any "empty" template syntax. You can begin writing your definitions in a blank file.

## Account resource

The **Microsoft.DocumentDB/databaseAccounts** resource in Bicep must contain the same minimal properties as in an Azure Resource Manager template.

Here is an example of an account that has a unique name with a prefix of **csmsarm** and is deployed to **West US**.

:::code language="bicep" source="../media/4-template.bicep" range="1-12":::

> &#128161; If this resource already exists from a previous deployment, the Azure Resource Manager will just skip the resource and move on to the next. This is very handy when building a template incrementally.

## Database resource

This example of a **Microsoft.DocumentDB/databaseAccounts/sqlDatabases** resource configures a database resource, a slight difference then the JSON template reviewed in a previous unit.

Bicep also requires resources to define a **parent** property defining relationships as opposed to the verbose **dependsOn** property.

:::code language="bicep" source="../media/4-template.bicep" range="14-25":::

## Container resource

This **Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers** resource is similar to the JSON equivalent, except it defines a throughput property at this level.

:::code language="bicep" source="../media/4-template.bicep" range="27-37,52-54":::

## Final template

Now that all resources are in place, the template file should now contain the following code.

:::code language="bicep" source="../media/4-template.bicep" range="1-37,52-54":::
