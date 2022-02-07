Companies often require their developer teams to develop products by using several different technologies. This process can be difficult and time consuming if you need to set up virtual machines and test environments, and wait for approvals.

In our e-commerce scenario, you want to speed up the developer onboarding process. A good solution is to use Azure DevTest Labs. It simplifies onboarding by allowing developers and administrators to manage VMs and platform as a service (PaaS) resources within a predefined budget. You can then use on-premises solutions to spin up test servers and development VMs in minutes rather than days.

Virtualization is the process of creating a software-based, or *virtual* version of a computer. A VM is a computer file, typically called an image, that behaves like an actual computer. It has a CPU, memory, disks to store your files, and can connect to the internet. Each VM is independent from one another and the physical host machine. For more information, see [What is a virtual machine?](https://azure.microsoft.com/overview/what-is-a-virtual-machine/#overview).

In this unit, you'll learn about the capabilities and features of Azure DevTest Labs.

## The DevTest Labs environment

A lab in Azure DevTest Labs is the infrastructure that encompasses a group of resources, such as VMs. These labs help you better manage resources by specifying limits and quotas.

## Capabilities

To help you create and manage environments for development, testing, and staging, use DevTest Labs to:

- Create VMs quickly by using an approved set of templates.
- Manage formulas to tailor custom builds to a specific situation.
- Manage artifacts to install software extensions on VMs after they're provisioned.
- Set autostart and autoshutdown schedules.
- Claim a pre-created VM without going through the creation process.

## Cost control and governance

Importantly, Azure DevTest Labs doesn't cost more than the cost of running the VMs in each lab. It offers many tools to control how costs are incurred and ensures you stick to a budget. To manage costs with DevTest Labs, you can:

- Set a maximum number of VMs for each lab and user.
- Permit specific VM sizes.
- Set autostart and autoshutdown times.
- Define VM expiration dates.

In DevTest Labs, you can track the cost of environments and the costs incurred by an individual VM. PaaS resources also appear in your cost tracking.

## Security

To ensure security, DevTest Labs environments give you close control over the use of Azure resources. A lab owner can allow users access to only the PaaS resources they need. The owner provides approved configurations without giving access to any other Azure resources.

For our scenario's e-commerce company, which needs to onboard new developers rapidly, DevTest Labs also allows developers to customize their environments in a controlled way. For example, the lab owner can allow lab users to add or remove Azure resources within the managed resource group only. Because the user's not granted access to the entire Azure subscription, it's easier to track and manage resources.

## Create IaaS and PaaS resources

PaaS and infrastructure as a service (IaaS) resources are both available within Azure DevTest Labs. PaaS resources, such as an Azure web app, provide a more managed solution. IaaS resources give you additional control but come with more responsibilities. For example, for VMs you manage the operating system. You handle both PaaS and IaaS resources in the *Environments* area.

You support and configure PaaS and IaaS resources by using Azure Resource Manager templates (ARM templates). An ARM template is a JavaScript Object Notation (JSON) file that defines the infrastructure and configuration for your project. In the template, you specify the resources to deploy and the resource properties. You can version an ARM template under source control, such as a Git repository, and manage it like any other code file. By using ARM templates, you enable consistent deployment and management of environments. For more information, see [What are ARM templates?](/azure/azure-resource-manager/templates/overview).

With DevTest Labs, you create an environment by picking a configured ARM template from the Azure portal, as you do with other VM base types. You provision Azure PaaS resources and IaaS VMs in an environment from an ARM template.

## Compare DevTest Labs and Azure Lab Services

Although DevTest Labs and Azure Lab Services are sometimes confused with each other, they're two distinct products with different intentions.

With Azure Lab Services, you create simple and controlled classroom lab environments in the cloud. A lab owner creates a lab, provisions VMs for Windows or Linux, installs the necessary software and tools through reusable templates, and then makes them available to lab users. Users connect to VMs in the lab and then use them for their classroom exercises. When users start accessing resources in the lab, the lab admin can analyze cost and usage across multiple labs. Then, the admin can set global policies to optimize organizational or team costs.

DevTest Labs is similar to Lab Services in some respects, but it gives you greater control over the infrastructure and configuration within a custom lab. Your lab can be more than a classroom environment. For example, you can create labs for testing and staging software.

The two products' main differences are highlighted in the following table:

| Feature | Azure Lab Services | Azure DevTest Labs
| -------- | ----------- | ----------- |
| Management of Azure infrastructure | Automatic infrastructure management | You manage the infrastructure manually. |
| Built-in resiliency | Automatic handling of resiliency | You handle resiliency manually. |
| Subscription management | The service handles allocation of resources within Microsoft subscriptions that back the service. | You manage the subscription within your own Azure subscription. |
| Autoscaling | Service automatically scales | No subscription autoscaling |
| Azure Resource Manager deployment within the lab | Not available | Available |
