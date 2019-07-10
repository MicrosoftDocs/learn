So, the big question now is how do you decide which tools to use to provision compute?

The right provisioning tools depend on your problem, the size of your infrastructure and the outcome you want to achieve. As these criteria would vary from network to network, here are a few fundamental metrics that we can use to determine which tool is more suitable for provisioning compute:

- Scalability
- Ease of set up
- Management
- Interoperability
- Configuration language
- Limitations/Drawbacks

Consider each of the following tools' advantages or disadvantages using each of the above metrics:

## Custom script

- **Scalability** – Not scalable, custom scripts are great for small networks but if you have to provision 500+ VMs they are not ideal.

- **Ease of set up** - Easy to set up, the custom script extension is built into the Azure Portal.

- **Ease of management** - Management of custom scripts can get tricky as your infrastructure grows and you accumulate different customer scripts for different resources.

- **Interoperability** - The custom script extension can be added into an Azure Resource Manager template, it can also be deployed through PowerShell or Azure CLI amongst other tools.

- **Configuration language** – PowerShell

- **Limitations/Drawbacks** - Custom script is not suitable for anything that requires more than one and half hour to configure.  You should also avoid using custom scripts for any configuration that requires  reboots.  

- **Scenario**

  The organization you work for has been given a new contract to work for a new client. They have a handful of virtual machines running on Azure. The development team decides they need to install a small application they have written to help increase their team's productivity to make sure they can meet new deadlines. This application does not require a restart.

   The team asks you to implement a solution to ensure these virtual machines all have the application installed properly, and in the fastest and least complex manner possible.  

  You decide that this is a good situation where a custom script can help ensure this application is set up on all of the machines with minimal effort.  You use the Azure Portal to set the extensions on the virtual machines within a few clicks.

- **Summary** -The custom script extension is good for small configurations after provisioning, or if you need to quickly add or update some applications on a target machine.  It’s imperative for ad-hoc cross-platform scripting. But for large infrastructure deployment and automation, it is not ideal.  

## Azure desired state configuration (DSC) extension

- **Scalability** – The DSC extension is more scalable than custom scripts.

- **Ease of set up** – The primary use case for the DSC extension is to bootstrap a VM to the Azure Automation State Configuration (DSC) service. The setup is fairly easy.

- **Management** – DSC democratizes configuration management across servers.

- **Interoperability** –  Configured through the Azure Portal, or Azure PowerShell, Azure Resource Manager templates.

- **Configuration language** - PowerShell.

- **Limitations/Drawbacks** – DSC is not for automated compliance checking and enforcing continuous compliance. It lacks the ability to track changes and state compliance across environments or orchestrate configuration changes.

- **Scenario**

  The organization you work for is testing a new application which requires some virtual machines to be identical so that the application can be accurately tested. The company wants to ensure that the virtual machines have the exact same configuration settings. You notice that some of these settings require multiple restarts of each virtual machine.  

  You decide that Azure DSC would be needed. You have chosen this because you want to ensure the configurations still applied even after a reboot.

- **Summary** – DSC is more robust than custom scripts, and can be configured with the Azure Automation State Configuration service.  But it lacks the ability to automate continuance compliance checks across environments or orchestrate configuration changes.

## Azure automation state configuration

- **Scalability** - Highly scalable.

- **Ease of set up** - It’s not difficult to set up but it requires the user to familiar with the Azure portal

- **Management** - Very easy to manage.  The service manages all of the nodes (machines) for you automatically.  Each node can send you detailed reports concerning its state, which then allows for you to draw insights from this data.

- **Interoperability**  - Automatically works with your Azure virtual machines, in addition to any virtual machines you have have on-premises or on another cloud provider.

- **Configuration language** – PowerShell.

- **Scenario**

  You learn that the company you work for wants to be able to create hundreds of virtual machines, with identical configurations. These are configurations that they want to report back on. They want to be able to see which machines accept which configurations without problems, and they want to see those problems once a machine does not achieve a desired state. In addition, they want to be able to feed all of this data into a monitoring tool so they can analyze all of the data and learn from it.  

  You have noted the scale requirements and the reporting needs, based on this information, you then decide that the best solution is to use Azure Automation State Configuration, and make use to set configurations on all of the nodes. This would ensure the machines report back for you what the state of each node is, and you can now also forward this data to Azure Monitor Logs.

- **Summary** - The Azure Automation service is good for handling your DSC configurations and the machines that have those configurations at a scale, and getting reporting back from each machine. Using PowerShell DSC is great when you have few VMs to administrate.  For larger situations,  Azure Automation State Configuration is the solution you need, configurations and features are pushed to all of the machines, and applied equally. And this is all done in Azure for you.

## Azure resource manager templates

- **Scalability** – Highly scalable for provisioning compute resources from small to large infrastructures.

- **Ease of set up** - Creating ARM templates is really easy. You have various templates available from the GitHub community, which you can use or build upon. Alternatively, you can create your own from Azure.

- **Management** – Managing ARM templates is very straight-forward as you are managing JavaScript Object Notation (JSON) files.

- **Interoperability** - you can use other tools to provision ARM Templates – Azure Cli, Azure Portal, PowerShell and Terraform.

- **Configuration language** – JSON.

- **Limitation/drawbacks** - Certain regions are not supported for certain resources.

- **Scenario**

  Each developer should be able to automatically provision an entire group of virtual machines, identical to what everyone else in the team is creating.  The developers want to be sure they are all working in the same environment.  The developers are very familiar with JSON, but not necessarily administering infrastructure. They need to be able to provision all of the resources they need to run these virtual machines in an easy and rapid manner.

  You decide to introduce Azure Resource Manager templates to the developers. This way, you can collaborate with the developers to decide which resources they will need on Azure, and agree on a template that will satisfy their requirements. Since the template is JSON based and easily deployable, the developers will be able to rapidly learn how Azure resources are provisioned, and deploy it themselves once the time comes. 

- **Summary** - ARM Templates are ideal for deploying large infrastructure with multiple services along with their dependencies. You use the same template to repeatedly deploy your application during every stage of the application lifecycle.
