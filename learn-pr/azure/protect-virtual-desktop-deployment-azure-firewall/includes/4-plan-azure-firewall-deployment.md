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

## Plan Azure Firewall deployment

### Planning considerations 
 
Reference content covered in this module that applies to next exercise: [Introduction to Azure Firewall](https://docs.microsoft.com/learn/modules/introduction-azure-firewall/3-how-azure-firewall-works)

### Rule types (overview)

### Deployment options (overview)

## Deploy Azure Firewall for Azure Virtual Desktop

Overview of general steps to deploy Azure Firewall and context with WVD. See below.

The following is from the intro module, should talk about deployment for WVD and how it's related to these steps:
   
Use the following general steps to set up an instance of Azure Firewall:

- Create a hub virtual network that includes a subnet for the firewall deployment. (WVD will be hub Vnet)
- Create the spoke virtual networks and their subnets and servers. 
- Peer the hub and spoke networks. (Don't need this step for WVD)
- Deploy the firewall to the hub's subnet.
- For outbound traffic, create a default route that sends traffic from all subnets to the firewall's private IP address. 
- Configure the firewall with rules to filter inbound and outbound traffic. (Will cover in more detail in unit 6 for WVD)

Also: "For production deployments, a hub and spoke model is recommended, where the firewall is in its own VNet. The workload servers are in peered VNets in the same region with one or more subnets." See [Tutorial: Deploy and configure Azure Firewall using the Azure portal](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal).