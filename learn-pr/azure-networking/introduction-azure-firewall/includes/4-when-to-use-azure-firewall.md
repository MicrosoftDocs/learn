You know what Azure Firewall is and how it works. Now you need some criteria to help you evaluate whether Azure Firewall and Azure Firewall Manager are suitable choices for your company. To help you decide, let's consider the following scenarios:

- You want to protect your network against infiltration.
- You want to protect your network against user error.
- Your business includes e-commerce or credit card payments.
- You want to configure spoke-to-spoke connectivity.
- You want to monitor incoming and outgoing traffic.
- Your network requires multiple firewalls.
- You want to implement hierarchical firewall policies.

As part of your evaluation of Azure Firewall and Azure Firewall Manager, you know that Contoso has faced several of these scenarios. Read the following corresponding sections for more details.

## You want to protect your network against infiltration

A common goal of many malicious actors is to infiltrate your network. These intruders might want to use your network resources or examine, steal, or destroy sensitive or proprietary data.

Azure Firewall is designed to help prevent such intrusions. For example, a malicious hacker might try to infiltrate the network by requesting access to a network resource. Azure Firewall uses stateful inspection of network packets to examine the context of such requests. If a request is a response to earlier legitimate activity, then the firewall will likely allow the request; if a request came seemingly out of nowhere—as would the request sent by a would-be infiltrator—then the firewall would deny the request.

## You want to protect your network against user error

Perhaps the most common method for infiltrating a network or installing malware on a network computer is to trick a network user into clicking a link in an email message. That link sends the user to a malicious hacker-controlled website that either installs the malware or tricks the user into entering network credentials.

Azure Firewall prevents such attacks by using threat intelligence to deny access to known malicious domains and IP addresses.

## Your business includes e-commerce or credit card payments

Does your business have an e-commerce component, or does it process online credit card payments? If so, then your company might have to comply with the Payment Card Industry Data Security Standard (PCI DSS). The PCI DSS is a set of security standards created and maintained by the PCI Security Standards Council. To achieve PCI compliance, the PCI DSS lists a dozen requirements. Here's the first requirement:

- *Install and maintain a firewall configuration to protect cardholder data.*

The PCI DSS specifies that you need to set up a firewall configuration that restricts all inbound and outbound traffic from untrusted networks and hosts. The firewall must also deny all other traffic except for the protocols needed to process payment cards.

## You want to configure spoke-to-spoke connectivity

A typical hub and spoke network topology has the following characteristics:

- One virtual network that acts as a central connection point—the *hub*.
- One or more virtual networks that are peered to the hub—the *spokes*. An on-premises network connected via an ExpressRoute circuit or a VPN gateway can also be considered a spoke in this topology.

The spoke networks can exchange data with the hub, but the spokes can't communicate directly with each other. You might need such a direct connection. For example, one spoke network might host an application programming interface (API) that requires information from a SQL database deployed in a different spoke.

One solution is to peer the spoke networks with each other. That works for a few such connections but can quickly grow unwieldy as the number of connections increases.

An easier and more secure solution is to use Azure Firewall to set up direct connectivity between spokes. You achieve this connectivity by first deploying an Azure Firewall instance in the hub. You then configure the spoke virtual networks with user-defined routes (UDRs) that specifically route data through the firewall and on to the other spoke.

:::image type="content" source="../media/4-using-firewall.png" alt-text="Network diagram of a spoke-to-spoke connection between a virtual machine and a SQL database via Azure Firewall.":::

## You want to monitor incoming and outgoing traffic

Your company might want to analyze detailed reports on inbound and outbound network traffic. There are many reasons for requiring such reports, including regulatory compliance, enforcing company policies on internet usage, and troubleshooting problems.

You can configure Azure Firewall to maintain diagnostic logs of four types of firewall activity:

- Application rules
- Network rules
- Threat intelligence
- DNS proxy

For example, the log for your firewall's application rules might include entries such as the following for an outbound request:

- *HTTPS request from 10.1.0.20:24352 to somewebsite.com:443. Action: Allow. Rule Collection: collection100. Rule: rule105*

Similarly, the log for your firewall's network rules might include entries such as the following for an inbound request:

- *TCP request from 73.121.236.17:12354 to 10.0.0.30:3389. Action: Deny*

Once you've enabled diagnostic logging, you can monitor and analyze the logs in the following ways:

- You can examine the logs directly in their native JSON format.
- You can examine the logs in Azure Monitor.
- You can examine and analyze the logs in Azure Firewall Workbook.

## Your network requires multiple firewalls

If your company's Azure footprint spans multiple Azure regions, you have multiple internet connections, which means you need a firewall instance deployed for each of these connections. You could configure and manage those firewalls separately, but doing so creates several problems:

- Managing multiple firewalls is a great deal of work.
- Global rule and settings changes must be propagated to every firewall.
- It's difficult to maintain consistency across all the firewalls.

Azure Firewall Manager solves these problems by giving you a central management interface for every Azure Firewall instance across all your Azure regions and subscriptions. You can create firewall policies and then apply them to every firewall to maintain consistency. Changes to a policy are automatically propagated to all firewall instances.

## You want to implement hierarchical firewall policies

Many smaller companies can simply use a one-size-fits-all firewall policy. That is, small companies can often create a single firewall policy that applies to every user and resource on the network.

For most larger companies, however, a more nuanced and detailed approach is required. For example, consider the following two scenarios:

- A DevOps shop might have a virtual network for developing an app, another virtual network for staging the app, and a third virtual network for the production version of the app.
- A large business might have separate teams for database users, engineering, and sales. Each of those teams has its own set of applications running in separate virtual networks.

Although there will certainly be firewall rules that are common to all, the users and resources in each virtual network will require specific firewall rules. So, larger companies almost always require *hierarchical* firewall policies. Hierarchical firewall policies consist of the following two components:

- A single *base firewall policy* that implements the rules that need to be enforced company wide.
- One or more *local firewall policies* that implement rules that are specific to a particular app, team, or service. Local policies inherit the base firewall policy and then add rules related to the underlying app, team, or service.

When using Azure Firewall Manager, you can set up a base firewall policy, then create local policies that inherit the base policy and implement specific rules designed for the underlying resource.

