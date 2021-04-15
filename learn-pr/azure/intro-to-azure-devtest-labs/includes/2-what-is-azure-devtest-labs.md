For development teams, there's often a requirement to develop products by using several technologies. This process can be difficult and time consuming if you have to wait for approvals and the setting up of virtual machines and test environments.

In our e-commerce scenario, you want to speed up the developer onboarding process. A good solution is to use Azure DevTest Labs. It can simplify the process by allowing developers and administrators to manage virtual machines and platform as a service (PaaS) resources within a predefined budget. You can then use on-premises solutions to spin up test servers and development virtual machines in minutes rather than days.

In this unit, you'll learn about the capabilities and features of Azure DevTest Labs.

## The DevTest Labs environment

A lab in Azure DevTest Labs is the infrastructure that encompasses a group of resources, such as virtual machines (VMs). These labs help you better manage resources by specifying limits and quotas.

## Capabilities

To help you create and manage environments for development, testing, and staging, DevTest Labs offers the following capabilities. It can help you:

- Create virtual machines quickly by using an approved set of templates.
- Use formulas to tailor custom builds to a specific situation.
- Use artifacts to install software extensions on virtual machines after they're provisioned.
- Set autostart and auto-shutdown schedules.
- Claim a pre-created virtual machine without going through the creation process.

## Cost control and governance

Importantly, Azure DevTest Labs doesn't cost more than the cost of running the virtual machines in each lab. It offers many tools to control how costs are incurred and ensure you stick to a budget. To manage costs with DevTest Labs, you can:

- Set a maximum number of virtual machines for each lab and user.
- Permit specific virtual machine sizes.
- Set autostart and auto-shutdown times.
- Define virtual machine expiration dates.

In DevTest Labs, you can track the cost of environments and the costs incurred by an individual virtual machine. PaaS resources also appear in your cost tracking.

## Security

To help ensure security, DevTest Labs gives you close control over the use of Azure resources. With DevTest Labs environments, a lab owner can allow users to access the PaaS resources they need, providing approved configurations without giving access to any other Azure resources. 

For our scenario's e-commerce company, which needs to onboard new developers rapidly, DevTest Labs allows the developers to customize their environments. The lab owner can allow contributor access, which means that the lab user can add or remove Azure resources within the managed resource group only. It's then easier to track and manage the resources. You don't have to grant the user contributor access to the entire Azure subscription.

## Creating IaaS and PaaS resources

PaaS and infrastructure as a service (IaaS) resources are both available within Azure DevTest Labs. PaaS resources, such as an Azure web app, provide a more managed solution. Because a virtual machine is an IaaS resource, it becomes your responsibility to manage the operating system. You handle both PaaS and IaaS resources in the *Environments* area, and you support and configured them by using Azure Resource Manager templates (ARM templates) that come from a specified Git repository. By using ARM templates, you enable a consistent deployment and management of environments that are versioned under source control.

With DevTest Labs, you create an environment by picking a configured ARM template from the Azure portal, as you do with other VM base types. You provision Azure PaaS resources and IaaS VMs in an environment from an ARM template.

## DevTest Labs and Azure Lab Services compared

People sometimes confuse DevTest Labs and Azure Lab Services, but they're two separate products with different intentions. 

With Azure Lab Services, you can create simple and controlled classroom lab environments in the cloud. A lab owner creates a lab, provisions Windows or Linux virtual machines, installs the necessary software and tools through reusable templates, and then makes them available to lab users. Lab users connect to virtual machines in the lab and then use them for their classroom exercises. When people start using resources in the lab, the lab admin can analyze cost and usage across multiple labs and then set overarching policies to optimize organizational or team costs.

Although similar to Lab Services in some respects, DevTest Labs gives you greater control over the infrastructure and configuration within a custom lab. Your lab can be more than a classroom environment. For example, you can create labs for testing and staging software.

The two products' main differences are highlighted in the following table:

| Feature | Azure Lab Services | Azure DevTest Labs
| -------- | ----------- | ----------- |
| Management of Azure infrastructure | The service manages the infrastructure automatically. | You manage the infrastructure on your own. |
| Built-in resiliency | The service handles resiliency automatically. | You handle resiliency on your own. |
| Subscription management | The service:<li>Handles allocation of resources within Microsoft subscriptions that back the service.<li>Handles scaling automatically. | You manage the subscription within your own Azure subscription. There is no autoscaling of subscriptions. |
| Azure Resource Manager deployment within the lab | Not available | Available |
| | |
