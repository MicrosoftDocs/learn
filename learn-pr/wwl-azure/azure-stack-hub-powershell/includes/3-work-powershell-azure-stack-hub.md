The following diagram shows the relationships between the sets of PowerShell modules. From your machine, you can load the PowerShell modules and manage Azure Stack Hub.

:::image type="content" source="../media/azure-stack-powershell-tool-2df4ee91.png" alt-text="View of relationships between the sets of PowerShell modules.":::


### Azure Stack Hub Resource Manager

Azure Stack Hub PowerShell provides a set of cmdlets that use previous versions of Azure Resource Manager. These cmdlets are compatible with the resource providers in Azure Stack Hub. Each resource provider in Azure Stack Hub uses an older version of the provider found in global Azure. To help you coordinate the version of each provider that's supported by Azure Stack Hub, you can use API profiles.

### Azure Stack Hub administrator

Azure Stack Hub exposes a set of resource providers to the cloud operator so that the operator can install and maintain Azure Stack Hub. In global Azure, this interaction is abstracted from the user and handled behind the scenes as part of Azure. With Azure Stack Hub; however, enterprises can support a private cloud. To do these tasks, the operator interacts with the Azure Stack Hub Admin APIs.

### Azure Stack Hub privileged endpoint

For operator activities in Azure Stack Hub, such as testing the installation and accessing logs, operators can interact with the privileged endpoint (PEP). The PEP is a pre-configured remote PowerShell console that gives operators enough access to do specific tasks. The endpoint uses PowerShell Just Enough Administration (JEA) to expose a restricted set of cmdlets.

### Azure Stack Hub tools

Azure Stack Hub makes scripts and other cmdlets available in a GitHub repository, AzureStack-Tools. AzureStack-Tools hosts PowerShell modules for managing and deploying resources to Azure Stack Hub. If you're planning to establish VPN connectivity, you can download these PowerShell modules to the Azure Stack Development Kit, or to a Windows-based external client.

PowerShell provides a programmatic way to interact with Azure Resource Manager. You can work with an interactive command prompt or, if you're automating tasks, you can write scripts.

If you spend much time working with Azure Stack Hub PowerShell, you'll find yourself installing and reinstalling the modules. If you're working with global Azure at the same time, this routine can be challenging, because you'll need to uninstall and reinstall your modules depending on your target.
