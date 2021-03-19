<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-learning-unit-introduction-format)
-->

# Goal

Recall that in the EDA simulation scenario. After we have identified the throughput or IOPS requirements of the application, we can then decide the most optimal and cost-effective Azure NetApp Files service level. We will use Azure NetApp Files Performance Calculator to achieve this.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->

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

## Performance Considerations

As you have learned in previous module that, the throughput limit for a volume is determined by a combination of the service level selected and the quota assigned to the volume.

And recall that the limit of maximum throughput of an Azure NetApp Files Volume is 4,500 MiB/s. At the Premium service level, a Volume quota of 70.31 TiB will provision a throughput limit that is high enough to achieve this level of performance.

- 64MiB/s * 70.31 = 4,500 MiB/s

That is, if we assign volume quota amounts beyond 70.31 TiB at Premium service level, additional quota will only be assigned for storing additional data, but not result in a further increase in actual throughput.

Most importantly, we will also need to consider the cost structure of different service levels.

### Azure NetApp Files Performance Calculator

[Azure NetApp Files Performance Calculator](https://cloud.netapp.com/azure-netapp-files/tco?hs_preview=tIKQbfoF-41214739590) can be leveraged to specify your throughput or IOPS requirements to help you choose the most cost-effective service level.

## Throughput requirement example

An HPC application need at least 25TiB size of volume storage, and need to ensure 1,500 MiB/s in throughput on 8KiB random with 70/30 read/write.

The output of the Performance Calculator will like:

![Throughput requirement example](../media/throughputrequirement.png)

That is, in this example, Premium service will be the best choice as it achieves throughput requirements with lowest Capacity Pool cost.

## IOPS requirement example

Another HPC application need at least 50TiB size of volume storage, and require at least 140,000 IOPS on 8KiB random with 70/30 read/write.

The output of the Performance Calculator will like:

![IOPS requirement example](../media/iopsrequirement.png)

In this case, Standard will be the best choice as it achieves that specific IOPS requirements and is also the most cost-effective.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->