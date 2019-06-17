<!--Introductory paragraph topic sentence

Summary: A sentence that helps the learner prepare for the upcoming content. This makes sure to set the learner's expectations about what they're going to accomplish.

Scenario sub-task

Summary: A couple of sentences that specifies which section of the overall module scenario will be covered in this unit.

Task the learner will learn to accomplish

Summary: A sentence that describes the content the learner will know by the end of the unit.
 
Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Explanatory paragraph-->

<!--Explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

<!-- Optional knowledge check -->

## Notes from design doc
**Configuring a virtual machine scale set**

You need to set up an environment, which can horizontally scale when demand and load increases. By the end of this unit, you will be able to:

*   Understand virtual machine scale set autoscale approaches.
*   Understand virtual machine scale set autoscale rules.

Cover the following points:

*   A key benefit of a scale set is employing autoscale. There are three ways to configure autoscale, which can be done via the Portal or programmatically via the API/SDK.

    *   Manually by increasing or decreasing the Azure instance count.
    *   Schedule based - if you know you will have an increased workload on a specified date/time window you can proactively plan for that
    *   Metric-based - using a variety of resource can determine how and when to scale out your virtual machine scale set, and how and when to return to your baseline.

    *   A scale set will have a series of rules, defaults, and limits. It is essential to set limits so you can define the outer parameters for the size of your scale set. This includes the minimum number of nodes in a scale set, the maximum, and the default.
    *   An autoscale set rule defines the criteria for horizontally scaling your application; for example, increase the instance count by one when CPU utilization crosses a predefined threshold for example, 70%.
    *   Creating a scale rule brings together a set of conditions for example

    *   Time aggregation (Average, Minimum, Maximum, Last, Count)
    *   Metric name (CPU, Memory, etc.)
    *   Time grain statistic - Defines how the collected metrics in each time grain should be aggregated for analysis.
    *   Operator - the logic condition, for example, greater than
    *   Threshold - the value the condition has to in this case exceed (70)
    *   Duration - of importance as it takes time to provision and scales down the virtual machine so you would want the system to have observed this increased period of the load over a certain amount of time (10 minutes for example) before scaling up another instance into the scale set.
    *   Cool down period - Amount of time to wait before attempting to perform another scaling operation.
    *   [Example](https://docs.microsoft.com/azure/virtual-machine-scale-sets/media/virtual-machine-scale-sets-autoscale-portal/rule-increase.png)
    *   As a default, a scale in rule is not created. For every scale set at least one scale in rule should be set.
