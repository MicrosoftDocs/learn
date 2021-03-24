Let's start with a definition and an overview of core features of Firewall Manager. This overview should help you determine when you need to use Firewall Manager and whether it is a good fit for your organizational requirements. <!--Andy, I added this first bit as an overview, and moved the definition to the "what is product" heading below-->

## What is centralized firewall management?

Centralized firewall management is the ability to manage multiple firewalls at the same time. If you have multiple firewalls, over time, it can become challenging to maintain them individually. If your security needs change, you might need to reconfigure all your firewalls to try to keep their settings in sync. Similarly, if your security needs grow, you might need to update all your firewalls. You can simplify firewall management by using Firewall Manager.

## Firewall Manager definition

Azure Firewall is a fully managed cloud-based network security service. By implementing Azure Firewall, you can help protect your Azure resources.

Your security team must configure and maintain network and application level rules for traffic filtering. If your organization has multiple Azure Firewall instances, the security team will benefit by centralizing these configurations. With Firewall Manager, you can:

- Span multiple Azure subscriptions.
- Span different Azure regions.
- Implement hub and spoke architectures to provide for traffic governance and protection.

### Firewall policy

The fundamental building block of Firewall Manager is the Firewall policy. A firewall policy can consist of the following elements:

- NAT settings
- Network rule collections
- Application rule collections
- Threat Intelligence settings

You apply firewall policies to firewalls. After you've created policies, you can associate them with one or more virtual networks or virtual hubs.

> [!TIP]
> You can create and manage Azure Firewall policies by using the Azure Portal, REST API, templates, Azure PowerShell, and CLI.

## How to centrally manage your firewalls 

To centrally manage your firewalls, you set up and configure Firewall Manager. By implementing Firewall Manager, you can benefit from the following features:

- **Centralized deployment and configuration**. Enables you to configure multiple Azure Firewall instances that can potentially span Azure subscriptions and Azure regions.
- **Centralized route management**. Bypasses the requirement of having to manually create user-defined routes on spoke virtual networks.

   > [!IMPORTANT]
   > Centralized route management is only available on secured virtual hub architecture.

- **Hierarchical policies**. Enable you to centrally manage Azure Firewall policies across multiple secured virtual hubs. This enables your IT security team to create global firewall policies and apply them across your organization.

   > [!IMPORTANT]
   > Hierarchical policies are only available on secured virtual hub architecture.

- **Third-party integration**. Supports the integration of third-party security as a service provider.  

- **Cross-region availability**. Enables you to create Azure Firewall policies in one region, and apply them in other regions.

You can implement Firewall Manager in one of two architectures, which the following table describes.

| Architecture type   | Description                                                  |
| ------------------- | ------------------------------------------------------------ |
| Hub virtual network | A standard Azure virtual network that you create and manage. When you associate firewall policies with such a hub, it's referred to as a *hub virtual network*. The underlying resource associated with this architecture is a virtual network. |
| Secured virtual hub | A Microsoft-managed resource that enables you to easily create hub and spoke architectures. When policies are associated, this is referred to as a *secured virtual hub*. The underlying resource is a virtual WAN hub. |

The following diagram depicts each of these architecture types. A global admin has overarching policy control over the organization's security policies. A local admin has some control over policies associated with a hub virtual network.

:::image type="content" source="../media/firewall-manager-architecture.png" alt-text="Architecture of Firewall Manager depicting two scenarios: secured virtual hub and hub virtual network.":::