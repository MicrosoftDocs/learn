To run applications on virtual machine (VM) instances in a scale set, you first need to install the application components and required files. In a previous unit in this module, you learned how to create and use a custom VM image with Packer to deploy your VM instances. This custom image included the install of the NGINX web server components. You can then use the Azure Custom Script Extension to automate the install of applications to a scale set after each VM instance is deployed, or update an application that already runs on a scale set.

## Azure VM extensions

Azure VM extensions are small applications that provide post-deployment configuration and automation tasks on Azure VMs. For example, you can use VM extensions to install software, add anti-virus protection,configure Docker and more. 

Azure VM extensions can be run using the Azure CLI 2.0, Azure PowerShell, Azure Resource Manager templates, and the Azure portal. Extensions can be bundled with a new VM instance deployment, or run against any existing VM or scale set.

## The Azure Custom Script Extension

The Azure Custom Script Extension downloads files and executes commands on Azure VMs. This extension is useful for post deployment configuration, software installation, or any other configuration / management task. Scripts can be downloaded from Azure storage or GitHub, or provided to the Azure portal at extension run-time.

The Custom Script Extension integrates with with the Azure CLI 2.0, Azure PowerShell, Azure portal, templates, or the REST API.

To use the Custom Script Extension with the Azure CLI, you specify things like URIs for files to be downloaded and the script execution command in a JSON configuration file. These configuration files can be reused across scale set deployments to apply consistent application installs. When combined with a Packer image, you ensure that all VM instances in a scale set are configured in an identical way and with a consistent application install.

The Custom Script Extension is applied to the virtual machine scale set, so both new and existing VM instances run the same script definition. In the next tutorial, you also see how to update an existing script definition when you release a new version of your application to the scale set.