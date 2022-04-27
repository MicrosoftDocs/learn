Azure Resource Manager templates are written in JSON, which allows you to express data stored as an object (such as a virtual machine) in text. A JSON document is essentially a collection of key-value pairs. Each key is a string, whose value can be:

 -  A string
 -  A number
 -  A Boolean expression
 -  A list of values
 -  An object (which is a collection of other key-value pairs)

A Resource Manager template can contain sections that are expressed using JSON notation, but are not related to the JSON language itself:

```json
{
    "$schema": "http://schema.management.​azure.com/schemas/2019-04-01/deploymentTemplate.json#",​
    "contentVersion": "",​
    "parameters": {},​
    "variables": {},​
    "functions": [],​
    "resources": [],​
    "outputs": {}​
}

```

:::row:::
  :::column:::
    **Element name**
  :::column-end:::
  :::column:::
    **Required**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    $schema
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Location of the JSON schema file that describes the version of the template language. Use the URL shown in the preceding example.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    contentVersion
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Version of the template (such as 1.0.0.0). You can provide any value for this element. Use this value to document significant changes in your template. When deploying resources using the template, this value can be used to make sure that the right template is being used.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    parameters
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Values that are provided when deployment is executed to customize resource deployment.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    variables
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Values that are used as JSON fragments in the template to simplify template language expressions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    functions
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    User-defined functions that are available within the template.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    resources
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Resource types that are deployed or updated in a resource group.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    outputs
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Values that are returned after deployment.
  :::column-end:::
:::row-end:::
