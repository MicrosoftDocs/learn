Your organization has several requirements for moving its applications to Azure virtual machines. You'll select the appropriate tool based on your organization's needs.

The right provisioning tools depend on your problem, the size of your infrastructure and the outcome you want to achieve. As these criteria would vary from network to network, here are a few fundamental metrics that we can use to determine which tool is more suitable for provisioning compute.

- Ease of setup
- Management
- Interoperability
- Configuration language
- Limitations and Drawbacks

Let's consider each of the following tools' advantages or disadvantages using each of the above metrics. We'll also examine a business scenario and see how each tool can help us handle a specific scenario.

## Custom script

- **Ease of setup** - Easy to set up. The custom script extension is built into the Azure portal.
- **Ease of management** - Management of custom scripts can get tricky as your infrastructure grows and you accumulate different customer scripts for different resources.
- **Interoperability** - The custom script extension can be added into an Azure Resource Manager template. You can also deploy it through Azure PowerShell or Azure CLI.
- **Configuration language** – Many types of commands including PowerShell and Bash.
- **Limitations and Drawbacks** - Custom script isn't suitable if your script would need more than one and a half hours to apply your configuration. Avoid using custom scripts for any configuration that needs reboots.

### Scenario

The organization you work for has been given a new contract to work for a new client. They have a handful of virtual machines running on Azure. The development team decides they need to install a small application they have written to help increase their team's productivity to make sure they can meet new deadlines. This application doesn't require a restart.

The team asks you to implement a solution to ensure these virtual machines all have the application installed properly, and in the fastest and least complex manner possible.

You decide that a custom script can help ensure this application is set up on all of the machines with minimal effort. You use the Azure portal to set the extensions on the virtual machines within a few clicks.

### Summary

The custom script extension is good for small configurations after provisioning, or if you need to add or update some applications on a target machine quickly. It’s imperative for ad-hoc cross-platform scripting.

## Azure desired state configuration (DSC) extension

- **Ease of setup** – Easy to read, update, and store. Configurations simply state what state you want to achieve, the logic behind the setup of the state is abstracted from the script author. The primary use case for the DSC extension is to bootstrap a virtual machine to the Azure Automation State Configuration (DSC) service. The setup is fairly easy.
- **Management** – DSC democratizes configuration management across servers.
- **Interoperability** – Used with Azure Automation State Configuration. Can be configured through the Azure portal, or Azure PowerShell, Azure Resource Manager templates.
- **Configuration language** - PowerShell.
- **Limitations/Drawbacks** – Configurations are written only in PowerShell. Use of DSC without Azure Automation State Configuration, means you have to take care of your own orchestration and management.

### Scenario

The organization you work for is testing a new application, which requires new virtual machines to be identical, so that the application can be accurately tested. The company wants to ensure that the virtual machines have the exact same configuration settings. You notice that some of these settings require multiple restarts of each virtual machine. Your company wants a singular state configuration for all machines at the point of provisioning. Any error handling to achieve the state should be abstracted away as much as possible from the state configuration. Configurations should be easy to read.

You decide to use DSC. DSC configurations are easy to read. You can declare a singular identical state for all virtual machines. You can abstract away any error handling logic from your state configurations and maintain simple and clean state configurations. You can also ensure that the configurations are successful even after a reboot.

### Summary

DSC is easy to read, update, and store. DSC configurations help you declare the state your machines should be in at the point they are provisioned, rather than having instructions that detail how to put the machines in a certain state. Without Azure Automation State Configuration, you have to manage your own DSC configurations and orchestration. DSC can achieve more when coupled with Azure Automation State Configuration.

## Azure automation state configuration

- **Ease of setup** - It’s not difficult to set up but it requires the user to familiar with the Azure portal.
- **Management** - Easy to manage. The service manages all of the nodes (machines) for you automatically. Each node can send you detailed reports concerning its state, which then allows for you to draw insights from this data. Also helps you manage your DSC configurations easier.
- **Interoperability** - Needs DSC configurations. Automatically works with your Azure virtual machines, in addition to any virtual machines you have on-premises or on another cloud provider.
- **Configuration language** – PowerShell.

### Scenario

You learn that the company you work for wants to be able to create hundreds of virtual machines, with identical configurations. They want to report back on these configurations. They want to be able to see which machines accept which configurations without problems, and they want to see those problems once a machine does not achieve a desired state. In addition, they want to be able to feed all of this data into a monitoring tool so they can analyze all of the data and learn from it.

Based on the requirements provided to you by your organization, you decide that the best solution is to use Azure Automation State Configuration with DSC configurations declaring the states. Azure Automation State Configuration can automatically set your DSC state configurations on all of your nodes. This approach would also ensure the machines report back for you what the state of each node is, and you can also forward this data to Azure Monitor Logs for insight. You use Azure Automation State Configuration to improve the management of your DSC state configurations.

### Summary

The Azure Automation State Configuration service is good for automating your DSC configurations, along with the management of machines that need those configurations, and getting centralized reporting back from each machine. You can use DSC without Azure Automation State Configuration, particularly for if you want to administer a smaller number of machines on an ad-hoc basis. For larger and more complicated scenarios that need orchestration, Azure Automation State Configuration is the solution you need. All of the configurations and features that you need can be pushed to all of the machines, and applied equally, with minimal effort.

## Azure Resource Manager templates

- **Ease of setup** - Creating Resource Manager templates can be easy. You have various templates available from the GitHub community, which you can use or build upon. Alternatively, you can create your own from Azure.
- **Management** – Managing Resource Manager templates is straight-forward as you are managing JavaScript Object Notation (JSON) files.
- **Interoperability** - You can use other tools to provision Resource Manager templates – Azure CLI, Azure portal, PowerShell, and Terraform.
- **Configuration language** – JSON.
- **Limitation/drawbacks** - JSON is sensitive can easily become invalid if a single character is put in the wrong place. The need to have knowledge of all of the resource providers in Azure and their options can be difficult.

### Scenario

Each developer should be able to automatically provision an entire group of virtual machines, identical to what everyone else in the team is creating. The developers want to be sure they are all working in the same environment. The developers are familiar with JSON, but not necessarily administering infrastructure. They need to be able to provision all of the resources they need to run these virtual machines in an easy and rapid manner.

You decide to introduce Azure Resource Manager templates to the developers. This way, you can collaborate with the developers to decide which resources they will need on Azure, and agree on a template that will satisfy their requirements. Since the template is JSON-based and easily deployable, the developers will be able to rapidly learn how to provision Azure resources, and deploy it themselves when the time comes.

### Summary

Resource Manager templates can be used for small ad-hoc infrastructures. They're also ideal for deploying larger infrastructures with multiple services along with their dependencies. Resource templates can fit well into developers' workflows. You use the same template to repeatedly deploy your application during every stage of the application lifecycle.
