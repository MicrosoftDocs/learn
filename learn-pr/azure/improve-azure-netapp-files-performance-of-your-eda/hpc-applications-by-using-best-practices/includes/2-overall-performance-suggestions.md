<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-learning-unit-introduction-format)
-->

## Build on reference architectures

Recall that you will be running EDA applications on Azure. The reference architectures below illustrate how you can use Azure NetApp  for EDA workloads in both cloud-bursting (hybrid) and fully-on-Azure architectures.

![Reference Architecture](../media/referencearchitecture.png)

You can see that different Volumes are created to deal with different kinds of workloads based on the read/write requirements during the EDA run:

- /project and /scratch: directly mounted from compute client VMs for mixed Read/Write or massive writes operations.
- acting as backend storage-target of HPC Cache to optimize massive read access to tools and libraries files.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->

## Client VMs

The best practice is usually to run the latest OS patch version available of the Client VMs, as well as updating the NFS utilities to their latest releases to get the newest bug fixes and feature functionality.

## Virtual Networking (VNet)

Network architecture planning is a key element of designing any application infrastructure.

You can access Azure NetApp Files volumes directly from your VNet, from peered VNets in the same region, or from on-premises over a Virtual Network Gateway (ExpressRoute or VPN Gateway) as necessary.

As most EDA/HPC applications are latency sensitive, it is suggested to connect your compute client VMs to Azure NetApp Files volumes directly in the same VNet.

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->

<!-- 4. Image (highly recommended) ----------------------------------------------------------------

    Goal: Add a visual like an image, table, list, etc. that supports the topic sentence. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).
-->

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. A visual like an image, table, or list

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->