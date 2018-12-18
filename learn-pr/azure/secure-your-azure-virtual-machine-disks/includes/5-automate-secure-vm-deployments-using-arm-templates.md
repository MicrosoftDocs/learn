Suppose your company is deploying several servers as part of their cloud transition. VM disks must be encrypted during the deployment, so there's no time when the disks are vulnerable. You want to automate this process, and have to modify the Azure Resource Manager templates to automatically enable encryption.

Here, we'll look at how to use an Azure Resource Manager template to automatically enable encryption for new Windows VMs.

## What are Azure Resource Manager templates?

Resource Manager templates are JSON files used to define a set of resources to deploy to Azure. You can write them from scratch, and for some Azure resources, including VMs, you can use the Azure portal to generate them. You'll need to complete the required information for a manual VM deployment, but instead of deploying the VM to Azure, you save the template. You can then _reuse_ the template to create that specific VM configuration.

There are [example templates available in docs](https://azure.microsoft.com/resources/templates) to automate all sorts of administrative tasks. In fact, we could have used one of these templates to encrypt our VM that we just did manually!

![Screenshot showing the Azure templates](../media/5-browse-templates.png)

## Using GitHub templates

The actual template source is stored in GitHub. You can browse to a template in GitHub and deploy right to Azure from the page.

![Screenshot showing GitHub template with the Deploy to Azure button highlighted](../media/5-deploy-from-github.png)

When the template is deployed, Azure will display a list of required input fields.

![Screenshot showing template in Azure portal](../media/5-fill-in-template.png)

You can then execute the template to create, modify, or remove resources.

### Running templates in the Azure portal

If you already know the template you want to use, or you have saved templates in your Azure account, you can use the **Create a resource** > **Template Deployment** resource to locate and run defined templates in the portal. You can search through templates by name, edit a template to change the parameters or behavior, and execute the template right from the GUI.

### Running templates from the command line

Given a URL to a template, you can execute it with Azure PowerShell. For example, we could run the disk encryption template with the following PowerShell command:

```powershell
New-AzResourceGroupDeployment `
    -Name encrypt-disk `
    -ResourceGroupName <resource-group-name> `
    -TemplateUri https://raw.githubusercontent.com/azure/azure-quickstart-templates/master/201-encrypt-running-windows-vm-without-aad/azuredeploy.json
```

Or, if you prefer the Azure CLI, with the `group deployment create` command.

```azurecli
azure config mode arm
azure group deployment create <my-resource-group> <my-deployment-name> \ 
    --template-uri https://raw.githubusercontent.com/azure/azure-quickstart-templates/master/201-encrypt-running-windows-vm-without-aad/azuredeploy.json
```

