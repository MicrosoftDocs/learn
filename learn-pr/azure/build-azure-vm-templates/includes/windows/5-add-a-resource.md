When you create a VM for your financial analysts, you typically include a web server that provides a dashboard for the analyst to visualize and collect the results of the run. Using a Resource Manager template to bring up a VM is a good start. But how can you extend the template to configure web server software inside the VM?

Using the Azure CLI to configure a VM to run a web server requires only a few basic commands. But what happens when:

* You need to create and delete VMs continuously?
* Your deployments require additional components such as storage and networking, increasing their complexity?

Managing individual resources through the Azure CLI is a good start. But it quickly becomes tedious and error prone because you still need to correctly connect resources together. You need a more automated solution.

Here you'll examine the requirements for your VM's web server and learn how to build resources you can add to your templates.

> [!NOTE]
> The code and commands you see on this page are for illustration. For now, just follow along. You don't need to modify any files or run any commands just yet.

## What's the Custom Script Extension?

The Custom Script Extension is an easy way to download and run scripts on your Azure VMs. It's just one of the many ways you can configure a VM once it's up and running.

You can store your scripts in Azure storage or in a public location such as GitHub. You can run scripts manually or as part of a more automated deployment. Here, you'll define a  resource that you'll soon add to your Resource Manager template. The resource will use the Custom Script Extension to download a PowerShell script from GitHub and execute that script on your VM. The script enables the IIS-WebServerRole feature and configures a basic home page.

## How do I extend a Resource Manager template?

Your Resource Manager template creates a Windows VM. There are a few ways to extend the template to also enable IIS when the VM starts.

One way to extend your template is to create multiple templates, each defining one piece of the system. You then _link_ or _nest_ them together to build a more complete system. As you create your own templates, you can build a library of smaller, more granular templates and combine them how you need.

Another way is to modify an existing template to suit your needs. You'll do that in this module because that's often the fastest way to get started writing your own templates.

## Build the template resource

Here you'll learn how to build template resources, using the Custom Script Extension as an example. You'll use the reference documentation as a starting point and then define the resource properties you need.

Let's start by reviewing your requirements.

### Gather requirements

Here's a brief summary of what you want to accomplish through your template.

1. Create a VM.
1. Open port 80 through the network firewall.
1. Install and configure web server software on your VM.

The Resource Manager template you used in the previous part already covers the first two requirements. For the third, let's start by taking a look at an Azure CLI command we could run manually from the command line to enable IIS on your VM using the Custom Script Extension.

```azurecli
az vm extension set \
  --resource-group $RESOURCEGROUP \
  --vm-name simple-vm \
  --name CustomScriptExtension \
  --publisher Microsoft.Compute \
  --version 1.9 \
  --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-iis.ps1"]}' \
  --protected-settings '{"commandToExecute": "powershell -ExecutionPolicy Unrestricted -File configure-iis.ps1"}'
```

This command uses the Custom Script Extension to run a PowerShell script on your VM that installs IIS. You can [examine the PowerShell script](https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-iis.ps1?azure-portal=true) from a separate browser tab if you'd like.

You need a way to map this command to use the Resource Manager template syntax. The `az vm extension set` example shown above is a command you'd enter on the command line. What you need is the declarative JSON in template format.

### Locate the resource schema

To discover how to use the Custom Script Extension in your template, one approach is to learn by example. For example, you might find an Azure Quickstart template that does something similar and adapt it to your needs.

Another approach is to look up the resource you need in the [reference documentation](https://docs.microsoft.com/azure/templates?azure-portal=true). In this case, searching the documentation would reveal [Microsoft.Compute virtualMachines/extensions template reference](https://docs.microsoft.com/azure/templates/Microsoft.Compute/2018-10-01/virtualMachines/extensions?azure-portal=true).

You can start by copying the schema to a temporary document, like this.

```json
{
  "name": "string",
  "type": "Microsoft.Compute/virtualMachines/extensions",
  "apiVersion": "2018-10-01",
  "location": "string",
  "tags": {},
  "properties": {
    "publisher": "string",
    "type": "string",
    "typeHandlerVersion": "string",
    "autoUpgradeMinorVersion": boolean,
    "settings": {},
    "protectedSettings": {},
    "instanceView": {
      "name": "string",
      "type": "string",
      "typeHandlerVersion": "string",
      "substatuses": [
        {
          "code": "string",
          "level": "string",
          "displayStatus": "string",
          "message": "string",
          "time": "string"
        }
      ],
      "statuses": [
        {
          "code": "string",
          "level": "string",
          "displayStatus": "string",
          "message": "string",
          "time": "string"
        }
      ]
    }
  }
}
```

### Specify required properties

The schema shows all of the properties you can provide. Some properties are required; others are optional. You might start by identifying all of the required properties. Locate these below the schema definition on the reference page.

Here are the required parameters.

* `name`
* `type`
* `apiVersion`
* `location`
* `properties`

After you remove all the parameters that aren't required, your resource definition might look like this.

```json
{
  "name": "[concat(variables('vmName'), '/', 'ConfigureIIS')]",
  "type": "Microsoft.Compute/virtualMachines/extensions",
  "apiVersion": "2018-06-01",
  "location": "[parameters('location')]",
  "properties": { }
}
```

The values for the `type` and `apiVersion` properties come directly from the documentation. `properties` is required but for now can be empty.

You know that your existing VM template has a parameter named `location`. This example uses the built-in `parameters` function to read that value.

The `name` property follows a special convention. This example uses the built-in `concat` function to concatenate, or combine, multiple strings. The complete string contains the VM name followed by a slash `/` character followed by a name you choose (here, it's "ConfigureIIS"). The VM name helps the template identify which VM resource to run the script on.

### Specify additional properties

Next, you might add in any additional properties that you need. Referring back to the CLI example earlier, you need the location, or URI, of the script file and the PowerShell command to execute on the VM to run that script. As a recommended practice, you might also include the resource's publisher name, its type, and version.

Referring back to the documentation, you need these values, shown here using "dot" notation.

* `properties.publisher`
* `properties.type`
* `properties.typeHandlerVersion`
* `properties.autoUpgradeMinorVersion`
* `properties.settings.fileUris`
* `properties.protectedSettings.commandToExecute`

Your Custom Script Extension resource now looks like this.

```json
{
  "name": "[concat(variables('vmName'), '/', 'ConfigureIIS')]",
  "type": "Microsoft.Compute/virtualMachines/extensions",
  "apiVersion": "2018-06-01",
  "location": "[parameters('location')]",
  "properties": {
    "publisher": "Microsoft.Compute",
    "type": "CustomScriptExtension",
    "typeHandlerVersion": "1.9",
    "autoUpgradeMinorVersion": true,
    "settings": {
      "fileUris": [
        "https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-iis.ps1"
      ]
    },
    "protectedSettings": {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File configure-iis.ps1"
    }
  }
}
```

### Specify dependent resources

You can't run the Custom Script Extension until the VM is available. All template resources provide a `dependsOn` property. This property helps Resource Manager determine the correct order to apply resources.

Here's what your template resource might look like after you add the `dependsOn` property.

```json
{
  "name": "[concat(variables('vmName'), '/', 'ConfigureIIS')]",
  "type": "Microsoft.Compute/virtualMachines/extensions",
  "apiVersion": "2018-06-01",
  "location": "[parameters('location')]",
  "properties": {
    "publisher": "Microsoft.Compute",
    "type": "CustomScriptExtension",
    "typeHandlerVersion": "1.9",
    "autoUpgradeMinorVersion": true,
    "settings": {
      "fileUris": [
        "https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-iis.ps1"
      ]
    },
    "protectedSettings": {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File configure-iis.ps1"
    }
  },
  "dependsOn": [
    "[resourceId('Microsoft.Compute/virtualMachines/', variables('vmName'))]"
  ]
}
```

The bracket `[ ]` syntax means that you can provide an array, or list, of resources that must exist before applying this resource.

There are multiple ways to define a resource dependency. You can provide its name, such as "simple-vm", its full name (including its namespace, type, and name), such as "Microsoft.Compute/virtualMachines/simple-vm", or by its resource ID.

This example uses the built-in `resourceId` function to get the VM's resource ID using its full name. This helps clarify which resource you're referring to and can help avoid ambiguity when more than one resource has a similar name.

The existing template provides a `vmName` variable that defines the VM's name. This example uses the built-in `variables` function to read it.

## Summary

You now have everything you need to define the Custom Script Extension resource in your template. In the next part, you'll extend your template to use it.
