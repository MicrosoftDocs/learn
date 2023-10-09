Your organization has several requirements for moving its applications to Azure virtual machines. You want to review these requirements and select the appropriate tool based on your organization's needs.

The right provisioning tools depend on your problem, the size of your infrastructure, and the outcome you want to achieve. Because these criteria vary from network to network, here are a few fundamental metrics that we can use to determine which tool is more suitable to provision compute:

- Ease of setup
- Management
- Interoperability
- Configuration language
- Limitations and drawbacks

Let's consider the advantages or disadvantages for each of these tools, by using these metrics. We can examine a business scenario and see how each tool can help us handle a specific scenario.

## Custom script

- **Ease of setup.** The custom script extension is built into the Azure portal, so setup is easy.
- **Management.** The management of custom scripts can get tricky as your infrastructure grows and you accumulate different custom scripts for different resources.
- **Interoperability.** The custom script extension can be added into an Azure Resource Manager template. You can also deploy it through Azure PowerShell or the Azure CLI.
- **Configuration language.** You can write scripts by using many types of commands. You can use PowerShell and Bash.
- **Limitations and drawbacks.** Custom scripts aren't suitable if your script needs more than one and a half hours to apply your configuration. Avoid using custom scripts for any configuration that needs reboots.

### Scenario

The organization you work for has been given a new contract to work for a new client. They have a handful of virtual machines that run on Azure. The development team decides they need to install a small application they've written to help increase their team's productivity and make sure they can meet new deadlines. This application doesn't require a restart.

The team asks you to implement a solution to ensure that these virtual machines all have the application installed properly, and in the fastest and least complex manner possible.

You decide that a custom script can help ensure that this application is set up on all of the machines with minimal effort. You set up the extensions on the virtual machines with just a few settings in the Azure portal.

### Solution summary

The custom script extension is good for small configurations after provisioning. It's also good if you need to add or update some applications on a target machine quickly. It's imperative for ad-hoc cross-platform scripting.

## Azure Desired State Configuration extensions

- **Ease of setup.** Desired State Configurations (DSCs) are easy to read, update, and store. Configurations define what state you want to achieve. The author doesn't need to know how that state is reached.
- **Management.** DSC democratizes configuration management across servers.
- **Interoperability.** DSCs are used with Azure Automation State Configuration. They can be configured through the Azure portal, Azure PowerShell, or Azure Resource Manager templates.
- **Configuration language.** Use PowerShell to configure DSC.
- **Limitations and drawbacks.** You can only use PowerShell to define configurations. If you use DSC without Azure Automation State Configuration, you have to take care of your own orchestration and management.

### Scenario

The organization you work for is testing a new application, which requires new virtual machines to be identical so that the application can be accurately tested. The company wants to ensure that the virtual machines have the exact same configuration settings. You notice that some of these settings require multiple restarts of each virtual machine. Your company wants a singular state configuration for all machines at the point of provisioning. Any error handling to achieve the state should be abstracted as much as possible from the state configuration. Configurations should be easy to read.

You decide to use DSC. DSC configurations are easy to read. You can declare a singular identical state for all virtual machines. You can abstract any error handling logic from your state configurations and maintain simple and clean state configurations. You can also ensure that the configurations are successful even after a reboot.

### Solution summary

DSC is easy to read, update, and store. DSC configurations help you declare the state your machines should be in at the point they're provisioned, rather than having instructions that detail how to put the machines in a certain state. Without Azure Automation State Configuration, you have to manage your own DSC configurations and orchestration. DSC can achieve more when it's coupled with Azure Automation State Configuration.

## Azure Automation State Configuration

- **Ease of setup.** Automation State Configuration isn't difficult to set up, but it requires the user to be familiar with the Azure portal.
- **Management.** The service manages all of the virtual machines for you automatically. Each virtual machine can send you detailed reports about its state, which you can use to draw insights from this data. Automation State Configuration also helps you to manage your DSC configurations more easily.
- **Interoperability.** Automation State Configuration requires DSC configurations. It works with your Azure virtual machines automatically, and any virtual machines that are on-premises or on another cloud provider.
- **Configuration language.** Use PowerShell.
- **Limitations and drawbacks.** You can only use PowerShell to define configurations.

### Scenario

You learn that the company you work for wants to be able to create hundreds of virtual machines, with identical configurations. They want to report back on these configurations. They want to be able to see which machines accept which configurations without problems. They also want to see those problems when a machine doesn't achieve a desired state. In addition, they want to be able to feed all of this data into a monitoring tool so they can analyze all of the data and learn from it.

Based on the requirements provided to you by your organization, you decide that the best solution is to use Azure Automation State Configuration with DSC configurations declaring the states. Azure Automation State Configuration can automatically set your DSC state configurations on all of your nodes. This approach also ensures that the machines report the state of each node. You can also forward this data to Azure Monitor logs. You use Azure Automation State Configuration to improve the management of your DSC state configurations.

### Solution summary

The Azure Automation State Configuration service is good for automating your DSC configurations, along with the management of machines that need those configurations, and getting centralized reporting back from each machine. You can use DSC without Azure Automation State Configuration, particularly if you want to administer a smaller number of machines. For larger and more complicated scenarios that need orchestration, Azure Automation State Configuration is the solution you need. All of the configurations and features that you need can be pushed to all of the machines, and applied equally, with minimal effort.

## Azure Resource Manager templates

- **Ease of setup.** You can create Resource Manager templates easily. You have many templates available from the GitHub community, which you can use or build upon. Alternatively, you can create your own templates from the Azure portal.
- **Management.** Managing Resource Manager templates is straightforward because you manage JavaScript Object Notation (JSON) files.
- **Interoperability.** You can use other tools to provision Resource Manager templates, such as the Azure CLI, the Azure portal, PowerShell, and Terraform.
- **Configuration language.** Use JSON.
- **Limitations and drawbacks.** JSON has a strict syntax and grammar, and mistakes can easily render a template invalid. The requirement to know all of the resource providers in Azure and their options can be onerous.

### Scenario

Each developer should be able to automatically provision an entire group of virtual machines that are identical to what everyone else on the team creates. The developers want to be sure they're all working in the same environment. The developers are familiar with JSON, but they don't necessarily know how to administer infrastructure. They need to be able to provision all of the resources they need to run these virtual machines in an easy and rapid manner.

You decide to introduce Azure Resource Manager templates to the developers. This way, you can collaborate with the developers to decide which resources they need on Azure. You can also agree on a template that satisfies their requirements. Because the template is JSON-based and easily deployable, the developers can rapidly learn how to provision and deploy Azure resources.

### Solution summary

Resource Manager templates can be used for small ad-hoc infrastructures. They're also ideal for deploying larger infrastructures with multiple services along with their dependencies. Resource templates can fit well into developers' workflows. You use the same template to deploy your application repeatedly during every stage of the application lifecycle.
