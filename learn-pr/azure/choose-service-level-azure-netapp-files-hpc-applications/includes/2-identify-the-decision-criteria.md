<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-learning-unit-introduction-format)

-->

# Goal

You will examine the key factors that determine Azure NetApp Files performance, and learn how to calculate the required bandwidth of your applications.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->

## Storage Hierarchy

Below chart shows the relationships of the Azure subscription, Azure NetApp accounts, Capacity Pools, and Volumes.

![Azure NetApp Files Storage Hierarchy](../media/storagehierarchy.png)

### Azure NetApp account

Azure NetApp Files account is primarily an administrative concept and is in regional scope.

### Capacity Pool

A single Azure NetApp account can have up to 25 Capacity Pools. The provisioned size of each Pool can then be assigned to Volumes within it. 

In above example, we provisioned 4TB to Capacity Pool 1. This Pool is also assigned a "Premium" ANF service level, which we'll discuss in next section. 

Please note that ANF is charged based on the provisioned size of Capacity Pools. Size of Pools can vary from 4TB to 500TB each.

### Volume

Volumes are the actual constructs which will be mounted from your VM(s) and being consumed. They're assigned a quota limit, which can range from 100GB to 100TB, and the total Volume capacity cannot exceed the provision size of the Capacity Pool.

In above example, there are 2 Volumes within Capacity Pool 1 and the total quota limit cannot exceed 4TiB. All Volumes in a Pool will have the same service level, Premium in this example.

## Service Levels

The first important concept in determining performance with Azure NetApp Files is the Service Level. The service levels are defined and differentiated by the QoS threshold for the maximum throughput allowed on a normalized basis relative to volume quota.  

Azure NetApp Files offers 3 service levels suited to different workload types: Standard, Premium, and Ultra.

![Service Levels](../media/servicelevel.png)

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
TODO: write your prose table-of-contents
-->

<!-- 4. Image (highly recommended) ----------------------------------------------------------------

    Goal: Add a visual like an image, table, list, etc. that supports the topic sentence. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).
TODO: add a visual dddd

-->

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. A visual like an image, table, or list

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

## Performance Sizing

Performance for Azure NetApp Files is simple to design and easy to configure. There are 2 key factors involved: the service level, which we just introduced, establishes the baseline level of performance.

The second is the Volume quota.

The gross performance limit of the Volume is the product of these two factors.

![Performance Sizing](../media/performancesizing.png)

Let's walk through an example:

- If I choose the Premium Tier, I get 64MB per second for every 1TB of quota within the Volume.

- If I provision a Volume with a 2TB quota, then that Volume can deliver up to 128MB per second of throughput.  

Please note that:

1. The limit of maximum throughput of an Azure NetApp Files Volume is 4,500 MiB/s.

2. The gross throughput is set by the quota of the Volume, not the actual capacity consumed in the Volume.

3. You can increase or decrease the quota of your Volume in anytime, and it will affect the performance behavior virtually instantly. You do not need to reboot your VM nor to re-mount your Volume.

And please keep in mind that in real-world, storage performance is impacted by a wide range of factors, including the Read/Write mix, block size mix, and access patterns like random or sequential access.

## Calculate Required Bandwidth

How do you know the needed bandwidth of throughput? If you know both the IOPS and the transfer size of your workload, you can calculate the bandwidth required by multiplying them together.

For example, if your workloads need 100,000 IOPS and have an averaged transfer size of 16KB, then the bandwidth required is 1.53 GB per second.

- 100,000 IOPS * 16KB = 1,600,000 KB/s = 1.53 GB/s

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->