To run applications on virtual machine (VM) instances in a scale set, you first need to install the application components and required files. 

In a previous  module, you learned how to create and use a custom VM image with Packer to deploy your VM instances. This custom image included the install of the NGINX web server components. You can then use the Azure Custom Script Extension to automate the install of applications to a scale set after each VM instance is deployed, or update an application that already runs on a scale set.

## Azure VM extensions

Azure VM extensions are small applications that provide post-deployment configuration and automation tasks on Azure VMs. For example, if a VM requires software installation, anti-virus protection, or Docker configuration, you can use a VM extension to complete these tasks.

Azure VM extensions can be run using the Azure CLI 2.0, Azure PowerShell, Azure Resource Manager templates, and the Azure portal. Extensions can be bundled with a new VM instance deployment, or run against any existing VM or scale set.

## The Azure Custom Script Extension

The Custom Script Extension downloads files and executes commands on Azure VMs. This extension is useful for post deployment configuration, software installation, or any other configuration / management task. Scripts can be downloaded from Azure storage or GitHub, or provided to the Azure portal at extension run-time.

The Custom Script extension integrates with with the Azure CLI 2.0, Azure PowerShell, Azure portal, templates, or the REST API.

To use the Custom Script Extension with the Azure CLI, you create a JSON file that defines what files to obtain and commands to execute. These JSON definitions can be reused across scale set deployments to apply consistent application installs. When you combine these definitions with a Packer image, you ensure that all VM instances in a scale set are configured in an identical way and with a consistent application installation.

The Custom Script Extension is applied to the virutal machine scale set, so both new and existing VM instances run the same script definition. In the next module, you see how to update an existing script definition as new versions of your application would be released.