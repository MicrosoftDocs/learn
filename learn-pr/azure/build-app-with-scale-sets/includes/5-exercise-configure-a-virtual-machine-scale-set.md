<!-- Topic sentence -->

<!-- Scenario sub-task -->

<!-- Task performed in the exercise -->

<!-- Optional image (this should be either an image of the completed solution or the section that is being completed in the greater solution)-->

## [Part 1 title]

<!-- Introduction paragraph -->

1. <!-- Step 1 -->

1. <!-- Step 2 -->

1. <!-- Step n -->

## [Part 2 title]

<!-- Introduction paragraph -->

1. <!-- Step 1 -->

1. <!-- Step 2 -->

1. <!-- Step n -->

## [Part n title]

<!-- Introduction paragraph -->

1. <!-- Step 1 -->

1. <!-- Step 2 -->

1. <!-- Step n -->

## [Result part title]

<!-- Introduction paragraph -->

1. <!-- Optional step 1 -->

1. <!-- Optional step 2 -->

1. <!-- Optional step n -->

## Notes from design doc
**Exercise - Configuring a virtual machine scale set**

You need to set up an environment, which can horizontally scale when demand and load increases. In this unit, you will:

*   Configure an existing scale set to autoscale when CPU threshold exceeds 70% utilization
*   Set a Scale in rule to reduce the number of instances when the demand cools.

Use the Scale set created in unit 2.

1.  Open the Azure portal and navigate to virtual machine scale set
2.  Select the scale set created in unit 2.
3.  In settings panel, select scaling
4.  Select Enable autoscale
5.  Select scale based upon a metric
6.  Select add a rule
7.  Time aggregation: Average
8.  Metric Name: Percentage CPU
9.  Time grain statistic: Average
10.  Operator: Greater than
11.  Threshold: 70
12.  Duration: 10
13.  Increase count by 1
14.  Set cool down period to 5 minutes and save.
15.  To add a scale down route repeat steps 6-14 replacing step 11 with 60 and step 13 with a decrease by 1.
