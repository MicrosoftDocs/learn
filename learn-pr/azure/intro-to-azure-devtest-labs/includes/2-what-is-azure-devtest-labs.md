In a development team, there's often a requirement to develop using several technologies. This process can be difficult if you have to wait for approvals and the provisioning of virtual machines and test environments.

In our e-commerce scenario, you're looking at speeding up the developer onboarding process. You can use Azure DevTest Labs to simplify the process by allowing developers and administrators to manage virtual machines and Platform-as-a-Service (PaaS) resources within a predefined budget. You can then use on-premises solutions to spin up test servers and development virtual machines in minutes rather than days.

Here, you'll learn about the capabilities and features of Azure DevTest Labs.

## What is a DevTest lab?

A lab in Azure DevTest Labs is the infrastructure that encompasses a group of resources, such as virtual machines. These labs help you better manage resources by specifying limits and quotas.

## Capabilities

DevTest Labs has the following features, which can help you to create and manage environments for development, testing, and staging:

- You can create virtual machines quickly using an approved set of templates
- You can use formulas to tailor custom builds to a specific situation
- You can use artifacts to install software extensions on virtual machines after they're provisioned
- You can set auto-shutdown and autostart schedules
- You can claim a pre-created virtual machine without going through the creation process

## Cost control and governance

Importantly, Azure DevTest Labs doesn't cost more than the cost of running the virtual machines in each lab. You also have many tools to control how costs are incurred and ensure you stick to a budget. Costs can be managed by using the following features:

- You can set a maximum number of virtual machines for each lab and user
- You can permit specific virtual machine sizes
- You can set autostart and auto-shutdown times
- You can define virtual machine expiration dates

You can track the cost of environments in a DevTest lab, and the costs incurred by an individual virtual machine. PaaS resources also appear in cost tracking. 

## Security

DevTest Labs gives you close control over the use of Azure resources to ensure good security. With environments, a lab owner can allow users to access the PaaS resources they need with approved configurations without giving access to any other Azure resources. 

For the e-commerce company, which needs to onboard new developers rapidly, DevTest Labs allows them to customize their environments. The lab owner can allow contributor access. This action means the lab user can add or remove Azure resource only within the managed resource group. It's then easier to track and manage resources. You don't have to allow the user contributor access to the Azure subscription.

## Creating IaaS and PaaS resources

PaaS and Infrastruce-as-a-Service (IaaS) resources are both available within Azure DevTest Labs. PaaS resources provide a more managed solution, such as an Azure web app. A virtual machine is an IaaS resource so it's your responsibility to manage the operating system. Both PaaS and IaaS are handled in the **Environments** area and are supported and configured by using Azure Resource Manager templates taken from a specified Git repository. By using templates, you enable a consistent deployment and management of environments versioned under source control.

Users create an environment by picking a configured Azure Resource Manager template from the Azure portal, as they do with other VM base types. You provision Azure PaaS resources and IaaS VMs in an environment from an Azure Resource Manager template.

## Differences between Azure Lab Services and DevTest Labs

Although there's sometimes confusion between Azure Lab Services and DevTest Labs, they're two separate products with different intentions. 

With Azure Lab Services, you can create simple and controlled classroom lab environments in the cloud. A lab owner creates a lab, provisions Windows or Linux virtual machines, installs the necessary software and tools through reusable templates, and makes them available to lab users. Lab users connect to virtual machines in the lab, and use them for their classroom exercises. When people start using resources in the lab, the lab admin can analyze cost and usage across multiple labs, and set overarching policies to optimize your organizational or team costs.

While similar to Lab Services, DevTest Lab gives you greater control over the infrastructure and configuration within a custom lab. Your lab can be more than a classroom environment. For example, you can create labs for testing and staging software. 

Here's a table that highlights the differences:

| Features | Lab Services | DevTest Lab
| -------- | ----------- | ----------- |
| Management of Azure infrastructure | Automatically managed by the service. | You manage on your own. |
| Built-in resiliency | Automatically handled by the service. | You manage on your own. |
| Subscription management | Service handles allocation of resources within Microsoft subscriptions that back the service. Scaling is automatically handled by the service. | You manage within your own Azure subscription. No autoscaling of subscriptions. |
| Azure Resource Manager deployment within the lab | Not available. | Available |
| | |
