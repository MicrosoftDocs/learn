If you've been using Azure for a while, you've likely heard about Azure Resource Manager. Let's review Resource Manager's role and define what makes up a Resource Manager template.

## What's Azure Resource Manager?

Azure Resource Manager is the interface for managing and organizing cloud resources. Think of Resource Manager as a way to deploy cloud resources.

If you're familiar with Azure resource groups, you know that they enable you to treat sets of related resources as a single unit. Resource Manager is what organizes the resource groups that let you deploy, manage, and delete all of the resources together in a single action.

Think about the financial models you run for your analysts. To run a model, you might need one or more VMs, a database to store data, and a virtual network to enable connectivity between everything. With Resource Manager, you deploy these assets into the same resource group and manage and monitor them together. When you're done, you can delete all of the resources in a resource group in one operation.

### What are Resource Manager templates?

A Resource Manager _template_ precisely defines all the Resource Manager resources in a deployment. You can deploy a Resource Manager template into a resource group as a single operation.

A Resource Manager template is a JSON file, making it a form of _declarative automation_. Declarative automation means that you define _what_ resources you need but not _how_ to create them. Put another way, you define what you need, and it is the Resource Manager's responsibility to ensure that resources are deployed correctly.

You can think of declarative automation similar to how web browsers display HTML files. The HTML file describes _what_ elements appear on the page, but doesn't describe _how_ to display them. The "how" is the web browser's responsibility.

> [!NOTE]
> You may hear Resource Manager templates referred to as "ARM templates". We prefer the full names "Azure Resource Manager templates" or "Resource Manager templates".

## Why use Resource Manager templates?

Using Resource Manager templates will make your deployments faster and more repeatable. For example, you no longer have to create a VM in the portal, wait for it to finish, then create the next VM, and so on. Resource Manager takes care of the entire deployment for you.

Here are some other benefits to consider:

* **Templates improve consistency**

    Resource Manager templates provide a common language for you and others to describe your deployments. Regardless of the tool or SDK used to deploy the template, the structure, format, and expressions inside the template remain the same.

* **Templates help express complex deployments**

    Templates enable you to deploy multiple resources in the correct order. For example, you wouldn't want to deploy a virtual machine before creating an OS disk or network interface. Resource Manager maps out each resource and its dependent resources, and creates dependent resources first. Dependency mapping helps ensure that the deployment is carried out in the correct order.

* **Templates reduce manual, error-prone tasks**

    Manually creating and connecting resources can be time consuming, and it's easy to make mistakes along the way. Resource Manager ensures that the deployment happens the same way every time.

* **Templates are code**

    Templates express your requirements through code. Think of a template as a type of _infrastructure as code_ that can be shared, tested, and versioned like any other piece of software. Also, because templates are code, you can create a "paper trail" that you can follow. The template code documents the deployment. Most users maintain their templates under some kind of revision control, such as Git. When you change the template, its revision history also documents how the template (and your deployment) has evolved over time.

* **Templates promote reuse**

    Your template can contain parameters that are filled in when the template runs. A parameter can define a username or password, a domain name, and so on. Template parameters enable you to create multiple versions of your infrastructure, such as staging and production, but still utilize the exact same template.

* **Templates are linkable**

    Resource Manager templates can be linked together to make the templates themselves modular. You can write small templates that each define a piece of a solution, and combine them to create a complete system.

The models your financial analysts run are unique, but you see patterns in the underlying infrastructure. For example, most models require a database to store data. Many models use the same programming languages, frameworks, and operating systems to carry out the details. You can define templates that describe each individual component (compute, storage, networking, and so on), and combine them to meet each analyst's specific needs.

## What's in a Resource Manager template?

> [!NOTE]
> Here, you'll see a few code examples to give you a sense about how each section is structured. Don't worry if what you see is unfamiliar to you &mdash; you'll be able to read others' templates and write your own as you gain hands-on experience with them.

You may have used JavaScript Object Notation (JSON) to send data between servers and web applications. JSON is also a popular way to describe how applications and infrastructure are configured. 

JSON allows us to express data stored as an object (such as a virtual machine) in text. A JSON document is essentially a collection of key-value pairs. Each key is a string; its value can be a string, a number, a Boolean expression, a list of values, or an object (which is a collection of other key-value pairs).

A Resource Manager template can contain the following sections. These sections are expressed using JSON, but are not related to the JSON language itself.

```json
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
Let's look at each of these sections in a little more detail.

### Parameters

This is where you specify which values are configurable when the template runs. For example, you might allow users of your template to specify a username, password, or domain name.

Here's an example that illustrates two parameters &ndash; one for a VM's username, and one for its password.

```json
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

### Variables 

This is where you define values that are used throughout the template. Variables can help make your templates easier to maintain. For example, you might define a storage account name one time as a variable, and use that variable throughout the template. If the storage account name changes, you need to only update the variable.

Here's an example that illustrates a few variables that describe networking features for a VM.

```json
"variables": {
  "nicName": "myVMNic",
  "addressPrefix": "10.0.0.0/16",
  "subnetName": "Subnet",
  "subnetPrefix": "10.0.0.0/24",
  "publicIPAddressName": "myPublicIP",
  "virtualNetworkName": "MyVNET"
}
```

### Functions

This is where you define procedures that you don't want to repeat throughout the template. Like variables, functions can help make your templates easier to maintain. Here's an example that creates a function to create a unique name that could be used when creating resources that have globally unique naming requirements.

```json
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

### Resources

This section is where you define the Azure resources that make up your deployment.

Here's an example that creates a public IP address resource.

```json
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

Here, the type of resource is `Microsoft.Network/publicIPAddresses`. Its name is read from the variables section and its location, or Azure region, is read from the parameters section.

Because resource types can change over time, `apiVersion` refers to the version of the resource type you want to use. As resource types evolve and change, you can modify your templates to work with the latest features when you're ready.

### Outputs

This is where you define any information you'd like to receive when the template runs. For example, you might want to receive your VM's IP address or FQDN &ndash; information you do not know until the deployment runs.

Here's an example that illustrates an output named "hostname". The FQDN value is read from the VM's public IP address settings.

```json
"outputs": {
  "hostname": {
    "type": "string",
    "value": "[reference(variables('publicIPAddressName')).dnsSettings.fqdn]"
  }
}
```

## How do I deploy a Logic Apps workflow in a template?

A Logic Apps workflow is a resource in Azure. Therefore, it can be deployed in a template by adding it to the list of resources to deploy in the `resources` section of Resource Manager template. What exactly do we add to the resources section so the workflow is defined? We add the JSON workflow definition of the workflow in question to the resources section. In fact, the following JSON snippet shows a Resource Manager template to deploy the basic workflow we described in the preceding unit. As you can see from the highlight, the resources section contains the complete workFlow definition.

[!code-json[](../code/basic-template/template.json?highlight=7-43)]

We can deploy this template using one of the following methods:
- Deploy using the Azure portal
- Deploy using the PowerShell Az module
- Deploy from the Azure Command Line Interface (CLI).

In this module, we'll deploy templates using the Azure CLI and the `az deployment group` commands.

## How do I write a Resource Manager template?

There are many approaches to writing Resource Manager templates. Although you can write a template from scratch, it's common to start with an existing template and modify it to suit your needs.

Here are a few ways you can get a starter template:

* Use the Azure portal to create a template based on the resources in an existing resource group.
* Start with a template you or your team built that serves a similar purpose.
* Start with an Azure QuickStart template. You'll see how in the next part.

Whatever your approach, writing a template involves working with a text editor. You can bring your favorite editor, but Visual Studio Code's [Azure Resource Manager Tools extension](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) is specially designed for the task of creating templates. This extension makes it easier to navigate your template code, and provides autocompletion for many common tasks.

As you explore and write your templates, you'll want to [refer to the documentation](https://docs.microsoft.com/azure/templates?azure-portal=true) to understand what resource types are available and how to use them.

In the next unit, we'll examine and existing template in more detail and then deploy it from the Azure CLI.