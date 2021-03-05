
Contoso can use Azure Resource Manager to help deploy their VMs. Azure Resource Manager supports a declarative deployment methodology based on deployment templates. The resulting deployment populates the target resource group or the subscription according to the template's content.

## Benefits of templates

Compared to traditional deployment methods that rely on the graphical user interface (GUI) or scripting and programming languages, templates offer some unique benefits. Similar to scripts, they facilitate deployment of multi-component solutions in an automated manner. However, unlike scripts, they don't explicitly specify individual steps required to provision these solutions. Instead, they simply define their intended end state. By doing this, they rely on the intelligence built into the Azure platform to deploy all necessary resources in the most optimal way. This results in minimized deployment time and reduces the potential for errors. If needed, you have the option to define dependencies between resources to control the resource-provisioning sequence.

Deployment templates are ideal if you need to provision multiple solutions with the same general design. For example, you can deploy the same template to separate resource groups representing development, test, quality assurance, and production environments. To account for any potential differences between them, you can replace specific values in the template with parameters, and then assign values to these parameters at the deployment time.

Templates are *idempotent*, which means that you can deploy them multiple times to the same resource group with the same outcome. This is useful when you want to recreate an original deployment or remediate any issues resulting from post-deployment changes. Templates support VM extensions, which allow you to configure operating systems within Azure VMs as part of their deployment. These extensions include configuration management services such as PowerShell Desired State Configuration (DSC), Chef, or Puppet.

### Considerations for working with templates

An Azure Resource Manager template contains a JSON-formatted definition of one or more Azure resources, along with parameters and variables that facilitate customizing their configuration. When creating and working with resource templates, you should consider:

- Which resources you are going to deploy.
- Where your resources will be located.
- Which version of the resource provider application programming interface (API) you will use.
- Whether there are dependencies between resources.
- When you will specify values of resource properties. While you can include these values in the template, it's generally preferable to specify them during deployment by using their corresponding parameters.

## Author Azure Resource Manager templates

A resource template consists of the following sections:

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

The following table describes the sections in the preceding code sample.

|Element name|Description|
|------------------|------------------------------------------------------------|
|**$schema**|The predefined URL identifying the location of the JSON schema file, which describes the template syntax.|
|**contentVersion**|A custom value that you define to track changes to the template content.|
|**parameters**|Parameters that you can provide during deployment, either interactively or using a parameter file.|
|**variables**|Variables that contain values referenced during template deployment.|
|**functions**|Custom functions that facilitate calculations during template deployment.|
|**resources**|Resources that will be provisioned or modified as the result of the deployment.|
|**outputs**|Values returned by the deployment.|

## Deploy Azure VMs by using Azure Resource Manager templates

After you have an Azure Resource Manager template, you can deploy its resources by using any of the methods described in the following table.

|Method|Description|
|---------------------------------------------|------------------------------------------------------------|
|Azure PowerShell|You can initiate deployment by running the **New-AzResourceGroupDeployment** cmdlet. To reference the template file, you use the *-TemplateFile* or *-TemplateUri* parameter, depending on whether the template is stored locally on your computer or resides in a publicly accessible location. This cmdlet will deploy the resources defined in the template to the resource group you specify as the value of the *-ResourceGroupName* parameter. You might also need to provide the values of the parameters specified in the template. Alternatively, during deployment you might assign default values to these parameters directly within the template, or reference a parameter file containing their values.|
|Azure CLI|You can run the **az group deployment create** Azure CLI command with either the *--template-file* or *--template-uri** parameter and the *--resource_group* parameters to initiate deployment. Just as with PowerShell-based deployment, you might also need to provide the values of the parameters specified in the template. Alternatively, during deployment you might assign default values to these parameters directly within the template, or as a reference to a parameter file containing their values.|
|The Azure portal|The **Custom deployment** pane in the Azure portal provides a convenient way to deploy Azure Resource Manager template-based resources. To access it, in the Azure portal, search for and select the **Deploy a custom template** Marketplace item. From the **Custom deployment** pane, you can build your own template in the browser-based template editor, pick one of the predefined templates, or load an existing GitHub QuickStart template.|
|Azure QuickStart Templates GitHub repository|Every QuickStart template published on GitHub has a corresponding **Deploy to Azure** link. When you select the link, the browser will be automatically redirected to the **Custom deployment** pane in the Azure portal. To initiate a deployment, you only need to provide the values of the required parameters.|
|Microsoft Visual Studio or Visual Studio Code|You can author and deploy templates by using Visual Studio and Visual Studio Code.|

## Additional reading

You can learn more by reviewing the following documents:

- [Understand the structure and syntax of Azure Resource Manager templates](https://aka.ms/syntax-ARM-templates?azure-portal=true)
- [Create a Windows virtual machine from a Resource Manager template](https://aka.ms/windows-vm-from-rm-template?azure-portal=true)
- [Azure QuickStart Templates](https://aka.ms/azure-quick-start-templates?azure-portal=true)
- [Creating and deploying Azure resource groups through Visual Studio](https://aka.ms/create-visual-studio-deployment-project?azure-portal=true)
- [Quickstart: Create Azure Resource Manager templates with Visual Studio Code](https://aka.ms/vscode-extension?azure-portal=true)

> [!NOTE]
> If you want to create an Azure VM by using a template, try the following hands on exercise: [Deploy a VM using an Azure Quickstart template.](https://aka.ms/deploy-a-vm-quickstart-template?azure-portal=true).
