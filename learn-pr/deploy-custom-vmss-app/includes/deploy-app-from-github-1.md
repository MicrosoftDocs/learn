To run applications on virtual machine (VM) instances in a scale set, you first need to install the application components and required files. 

In a previous unit in this module, you learned how to create and use a custom VM image with Packer to deploy your VM instances. This custom image included the installation of the NGINX web server components. You can then use the Azure Custom Script Extension to automate the installation of applications to a scale set after each VM instance is deployed, or update an application that already runs on a scale set.

## Azure VM extensions

Azure VM extensions are small applications that provide post-deployment configuration and automation tasks on Azure VMs. For example, you can use VM extensions to install software, add antivirus protection, and configure Docker.

You can run Azure VM extensions by using Azure CLI 2.0, Azure PowerShell, Azure Resource Manager templates, and the Azure portal. You can bundle extensions with a new VM instance deployment, or run them against any existing VM or scale set.

## Azure Custom Script Extension

The Azure Custom Script Extension downloads files and runs commands on Azure VMs. This extension is useful for post-deployment configuration, software installation, or any other configuration/management task. You can download scripts from Azure Storage or GitHub, or you can provide them to the Azure portal at extension runtime.

The Custom Script Extension integrates with Azure CLI 2.0, Azure PowerShell, Azure portal, templates, or the REST API.

To use the Custom Script Extension with Azure CLI, you specify things like URIs for files to be downloaded and the script execution command in a JSON configuration file. You can reuse these configuration files across scale set deployments to apply consistent application installations. When you combine these files with a Packer image, you ensure that all VM instances in a scale set are configured in an identical way and with a consistent application installation.

The Custom Script Extension is applied to the virtual machine scale set, so both new and existing VM instances run the same script definition. In the next tutorial, you also see how to update an existing script definition when you release a new version of your application to the scale set.

At the end of the tutorial, you can to check your knowledge about this information with a quiz challenge.
