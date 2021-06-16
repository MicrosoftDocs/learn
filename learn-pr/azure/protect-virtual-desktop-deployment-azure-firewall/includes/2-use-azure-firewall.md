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

## What is Azure Firewall?

Recall that Azure Firewall is a cloud-based security service that protects your Azure virtual network resources from incoming and outgoing threats. Azure Firewall is provisioned inside a hub virtual network. Traffic to and from the spoke virtual networks and the on-premises network traverses the firewall with the hub network.

All traffic to and from the internet is denied by default. Traffic is only allowed if it passes various tests, such as the configured firewall rules.

:::image type="content" source="../media/2-firewall-description.png" alt-text="Diagram of Azure Firewall in a hub virtual network with traffic to and from the internet passing through the hub network to spoke virtual networks, and an on-premises network." border="false":::

Azure Firewall works not only for traffic to and from the internet, but also internally. Internal traffic filtering includes spoke-to-spoke traffic and hybrid cloud traffic between your on-premises network and your Azure virtual network.

## What is Azure Virtual Desktop?

Azure Virtual Desktop is a desktop and app virtualization service that runs on the cloud. Azure Virtual Desktop works across devices, like Windows, Mac, iOS, Android, and Linux, with apps that you can use to access remote desktops and apps. You can also use most modern browsers to access Azure Virtual Desktop-hosted experiences.

## Why use Azure Firewall with Azure Virtual Desktop?

When an end user connects to an Azure Virtual Desktop environment, their session is run by a host pool. A host pool is a collection of Azure virtual machines (VMs) that register to Azure Virtual Desktop as session hosts. These VMs run in a Azure virtual network and are subject to virtual network security controls.

For Azure Virtual Desktop to work, the session host VMs need outbound internet access to the Azure Virtual Desktop service. The VMs might also need outbound internet access for your users. You can use Azure Firewall to lock down your environment and filter outbound network traffic.

The following diagram shows...

:::image type="content" source="../media/2-firewall-azure-virtual-desktop-architecture.png" alt-text="Diagram of Azure Firewall filtering network traffic between the Azure Virtual Network service and the host pool virtual network." border="false":::

