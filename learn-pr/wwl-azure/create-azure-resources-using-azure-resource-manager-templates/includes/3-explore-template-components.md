
Azure Resource Manager templates are written in JSON, which allows you to express data stored as an object (such as a virtual machine) in text.

A *JSON document* is essentially a collection of key-value pairs. Each key is a string that values can be:

 -  A string.
 -  A number.
 -  A Boolean expression.
 -  A list of values.
 -  An object (which is a collection of other key-value pairs).

A Resource Manager template can contain sections that are expressed using JSON notation but aren't related to the JSON language itself:

```JSON
{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "",
    "parameters": {  },
    "variables": {  },
    "functions": [  ],
    "resources": [  ],
    "outputs": {  }
}

```

Let's review each of these sections in a little more detail.

## Parameters

This section is where you specify which values are configurable when the template runs.

For example, you might allow template users to set a username, password, or domain name.

Here's an example that illustrates two parameters: one for a virtual machine's (VMs) username and one for its password:

```JSON
"parameters": {
  "adminUsername": {
    "type": "string",
    "metadata": {
      "description": "Username for the Virtual Machine."
    }
  },
  "adminPassword": {
    "type": "securestring",
    "metadata": {
      "description": "Password for the Virtual Machine."
    }
  }
}

```

## Variables

This section is where you define values that are used throughout the template.

Variables can help make your templates easier to maintain.

For example, you might define a storage account name one time as a variable and then use that variable throughout the template.

If the storage account name changes, you need only update the variable once.

Here's an example that illustrates a few variables that describe networking features for a VM:

```JSON
"variables": {
  "nicName": "myVMNic",
  "addressPrefix": "10.0.0.0/16",
  "subnetName": "Subnet",
  "subnetPrefix": "10.0.0.0/24",
  "publicIPAddressName": "myPublicIP",
  "virtualNetworkName": "MyVNET"
}

```

## Functions

This section is where you define procedures that you don't want to repeat throughout the template.

Like variables, functions can help make your templates easier to maintain.

Here's an example that creates a function for creating a unique name to use when creating resources that have globally unique naming requirements:

```JSON
"functions": [
  {
    "namespace": "contoso",
    "members": {
      "uniqueName": {
        "parameters": [
          {
            "name": "namePrefix",
            "type": "string"
          }
        ],
        "output": {
          "type": "string",
          "value": "[concat(toLower(parameters('namePrefix')), uniqueString(resourceGroup().id))]"
        }
      }
    }
  }
],

```

## Resources

This section is where you define the Azure resources that make up your deployment.

Here's an example that creates a public IP address resource:

```JSON
{
  "type": "Microsoft.Network/publicIPAddresses",
  "name": "[variables('publicIPAddressName')]",
  "location": "[parameters('location')]",
  "apiVersion": "2018-08-01",
  "properties": {
    "publicIPAllocationMethod": "Dynamic",
    "dnsSettings": {
      "domainNameLabel": "[parameters('dnsLabelPrefix')]"
    }
  }
}

```

Here, the type of resource is `Microsoft.Network/publicIPAddresses`.

The **name** is read from the variables section, and the **location**, or *Azure region*, is read from the **parameters** section.

Because resource types can change over time, `apiVersion` refers to the version of the resource type you want to use.

As resource types evolve, you can modify your templates to work with the latest features.

## Outputs

This section is where you define any information you'd like to receive when the template runs.

For example, you might want to receive your VM's IP address or fully qualified domain name (FQDN), the information you won't know until the deployment runs.

Here's an example that illustrates an output named **hostname**.

The FQDN value is read from the VM's public IP address settings:

```JSON
"outputs": {
  "hostname": {
    "type": "string",
    "value": "[reference(variables('publicIPAddressName')).dnsSettings.fqdn]"
  }
}

```
