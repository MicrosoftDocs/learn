<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-learning-unit-introduction-format)
-->
TODO: add your topic sentences(s)

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
TODO: add your scenario sub-task

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
TODO: write your prose table-of-contents

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
TODO: add a visual element

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->


Reference content covered in this module that applies to next exercise: [Introduction to Azure Firewall](https://docs.microsoft.com/learn/modules/introduction-azure-firewall/3-how-azure-firewall-works)

## Recommended network topology

Recall that Azure Firewall is best deployed using a hub and spoke network topology with the following characteristics:

- A virtual network that acts as the central connectivity point. This network is the hub virtual network.
- One or more virtual networks that are peered to the hub. These peers are the spoke virtual networks and are used to provision workload servers.

You deploy the firewall instance in a subnet of the hub virtual network and then configure all inbound and outbound traffic to go through the firewall. You'll use this configuration when you deploy Azure Firewall with Azure Virtual Desktop.

## Azure Firewall rules

Recall that, by default, the firewall denies access to everything. Your job is to configure the firewall with the conditions under which traffic is allowed through the firewall. Each condition is called a rule. Each rule applies one or more checks on the data. Only traffic that passes every check in all the firewall's rules is allowed to pass through.

The following table describes the three types of rules you can create for an Azure firewall. To allow the appropriate network traffic for Azure Virtual Desktop, you'll use application and network rules.

|Rule type  |Description  |
|---------|---------|
|NAT     |Translate and filter inbound internet traffic based on your firewall's public IP address and a specified port number. For example, to enable a remote desktop connection to a virtual machine, you might use a NAT rule to translate your firewall's public IP address and port **3389** to the private IP address of the virtual machine.  (Azure Virtual Desktop example?)      |
|Application     |Filter traffic based on an FQDN or FQDN tag. A FQDN tag represents a group of fully qualified domain names (FQDNs) associated with well known Microsoft services like Azure Virtual Desktop. For example, you'll use an application rule to allow outbound traffic for the Azure Virtual Desktop virtual machines using the FQDN tag *WindowsVirtualDesktop*.         |
|Network     |Filter traffic based on one or more of the following three network parameters: IP address, port, and protocol. For example, use a network rule to allow traffic from an on-premises Active Directory Domain Server (AD DS) private IP address to Azure for TCP and UDP port **53**. If you're using Azure AD DS, you don't need to create a network rule. DNS queries are forwarded to Azure DNS at 168.63.129.16. |

Azure Firewall applies rules in priority order. Rules based on threat intelligence are always given the highest priority and are processed first. After that, rules are applied by type: NAT rules, then network rules, then application rules. Within each type, rules are processed according to the priority values you assign when you create the rule, from lowest value to highest value.


## Deployment options

Recall that Azure Firewall offers many features designed to make it easier to create and manage rules. The following table summarizes these features. To allow network traffic for Azure Virtual Desktop, you'll use FQDN tags but you might also use these other options in your environment.

|Feature  |Description  |
|---------|---------|
|FQDN     |A domain name of a host, or one or more IP addresses. Adding an FQDN to an application rule allows access to that domain. When you use an FQDN in an application rule, you can use wild cards, such as *.google.com.        |
|FQDN tag     |A group of well-known Microsoft FQDNs. Adding an FQDN tag to an application rule allows outbound access to the tag's FQDNs. There are FQDN tags for Windows Update, Azure Virtual Desktop, Windows diagnostics, Azure Backup, and more. FQDN tags are managed by Microsoft and can't be modified or created.       |
|Service tag     |A group of IP address prefixes related to a specific Azure service. Adding a service tag to a network rule allows access to the service represented by the tag. There are service tags for dozens of Azure services, including Azure Backup, Azure Cosmos DB, Logic Apps, and more. Service tags are managed by Microsoft and can't be modified or created.        |
|IP groups     |A group of IP addresses, such as 10.2.0.0/16 or 10.1.0.0-10.1.0.31. You can use an IP group as the source address in a NAT or application rule, or as the source or destination address in a network rule.        |
|Custom DNS     |A custom DNS server that resolves domain names to IP addresses. If you use a custom DNS server rather than Azure DNS, you must also configure Azure Firewall as a DNS proxy.        |
|DNS proxy     |You can configure Azure Firewall to act as a DNS proxy, which means that all client DNS requests go through the firewall before going to the DNS server.        |

## Deployment steps for Azure Firewall

In the previous exercise, we created a virtual network with a subnet, and deployed a session host virtual machine for Azure Virtual Desktop into that subnet. You'll complete the following steps in the rest of exercises in this module.

**Step 1: Set up the network**

- Create a hub virtual network that includes a subnet for the firewall deployment.
- Peer the hub and spoke networks. In the next exercise, you'll peer the hub virtual network with the virtual network used by Azure Virtual Desktop.  

**Step 2: Deploy Azure Firewall**

- Deploy Azure firewall to a subnet in the hub virtual network.
- For outbound traffic, create a default route that sends traffic from all subnets to the firewall's private IP address.

**Step 3: Create Azure Firewall rules**

- Configure the firewall with rules to filter inbound and outbound traffic. 

Also: "For production deployments, a hub and spoke model is recommended, where the firewall is in its own VNet. The workload servers are in peered VNets in the same region with one or more subnets." See [Tutorial: Deploy and configure Azure Firewall using the Azure portal](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal).