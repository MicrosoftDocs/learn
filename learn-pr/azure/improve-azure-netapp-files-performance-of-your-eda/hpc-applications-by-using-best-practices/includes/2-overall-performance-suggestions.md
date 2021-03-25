<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-learning-unit-introduction-format)
-->

# Goal

We will introduce overall performance suggestions regarding reference architecture, client VMs and network running your EDA applications on Azure NetApp Files.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->

## Reference Architecture

The reference architectures below illustrate how you can use Azure NetApp Files for EDA workloads in both cloud-bursting (hybrid) and fully-on-Azure architectures.

![Reference Architecture](../media/referencearchitecture.png)

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->

## Client VMs and NFS utility versions

It's always the best practice to run the latest OS patch version available, and updating the NFS utilities to their latest releases to get the newest bug fixes and feature functionality, to optimal performance and system stability.

## Accelerate Networking and VNET

It is always the best practice to enable Accelerated Networking on Azure Virtual Machines, if supported, to provide 30+ Gb/s in networking throughput.

Client VMs and Azure NetApp Files to be in the same VNET when possible, to reduce network latency in between.

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