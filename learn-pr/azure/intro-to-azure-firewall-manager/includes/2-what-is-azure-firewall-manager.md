Azure Firewall is a fully managed cloud-based network security service. By implementing Azure Firewall, you can help protect your Azure resources. 

## What is centralized firewall management?

If you manage multiple firewalls, it can become challenging to maintain them. If, for example, your security needs change, you might easily need to reconfigure all your firewalls to try to keep their settings in sync. You can use Azure Firewall Manager to help simplify firewall management. 

Your security team must configure and maintain network and application level rules for traffic filtering. If your organization has multiple Azure Firewall instances, the security team will benefit by centralizing these configurations. With Azure Firewall Manager, you can:

- Span multiple Azure subscriptions 
- Span different Azure regions
- Implement hub and spoke architectures to provide for traffic governance and protection

## Firewall policy definition

The fundamental building block of Azure Firewall Manager is the Firewall policy. A firewall policy can consist of the following elements:

- NAT settings
- Network rule collections
- Application rule collections 
- Threat Intelligence settings

You apply firewall policies to firewalls. After you have created policies, you can associate them with one or more virtual networks or virtual hubs. 

> [!TIP]
> You can create and manage Azure Firewall policies using the Azure Portal, REST API, templates, Azure PowerShell, and CLI.

## How to centrally manage your firewalls 

By implementing Azure Firewall Manager, you can benefit from the following features:

- **Centralized deployment and configuration**. Enables you to configure multiple Azure Firewall instances than can potentially span Azure subscriptions and Azure regions.
- **Centralized route management**. Bypasses the requirement of having to manually create user-defined routes on spoke virtual networks.

   > [!IMPORTANT]
   > Only available on secured virtual hub architecture.

- **Hierarchical policies**. Enables you to centrally manage Azure Firewall policies across multiple secured virtual hubs. This enables your IT security team to create global firewall policies and apply them across your organization. 

   > [!IMPORTANT]
   > Only available on secured virtual hub architecture.

- **Third-party integration**. Supports the integration of third-party security as a service providers.  

- **Cross-region availability**. Enables you to create Azure Firewall policies in one region, and apply them in other regions. 

You can implement Azure Firewall Manager in one of two architectures. These are described in the following table. 

| Architecture type   | Description                                                  |
| ------------------- | ------------------------------------------------------------ |
| Hub virtual network | A standard Azure virtual network that you create and manage. When you associate firewall policies with such a hub, it's referred to as a *hub virtual network*. The underlying resource associated with this architecture is a virtual network. |
| Secured virtual hub | A Microsoft managed resource that enables you to easily create hub and spoke architectures. When policies are associated, this is referred to as a *secured virtual hub*. The underlying resource is a virtual WAN hub. |

In the following diagram, each of these architecture types are displayed. A global admin has overarching policy control over the organization's security policies. A local admin has some control over policies associated with a hub virtual network. 

:::image type="content" source="../media/firewall-manager-architecture.png" alt-text="A diagram displays the architecture of Azure Firewall Manager. Two scenarios are displayed: Secured virtual hub and Hub virtual network.":::
