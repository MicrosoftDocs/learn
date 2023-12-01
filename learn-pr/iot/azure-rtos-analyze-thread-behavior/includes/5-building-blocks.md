## Introduction

There's no fundamental design change between ProjectHelloWorld and ProjectAnalyze. All we need to do is make several modifications so that we can capture data relative to the performance of our system.

## Declarations, definitions, and prototypes - part 1

The following code block shows **Part 1 of building block 1**.

> [!NOTE]
> This code is virtually identical to the code in ProjectHelloWorld. The only changes shown in the following code block are in the comments section where additional information is provided and brief instructions added on how to change this project.

:::code language="c" source="code/project-analyze.c" range="1-18":::

## Declarations, definitions, and prototypes - part 2

The following code block shows **Part 2 of building block 1**. You'll need to make the following changes in the highlighted lines:

1. Add variables for counters and totals in part 2.
1. Define the variables needed to obtain cumulative performance information about Urgent thread and Routine thread.
1. Add a `/* Define variables for Urgent thread performance info */` section that defines variables for the Urgent thread performance information.

:::code language="c" source="code/project-analyze.c" range="20-33" highlight="1,2,3,5,6,7,8,9":::

## The main entry point

In **Building block 2**, the main entry point is _exactly the same as ProjectHelloWorld_. You don't need to make any changes to the following code; it's displayed here for reference.

:::code language="c" source="code/project-analyze.c" range="35-40":::

## Applications definitions

**Building block 3** is _exactly the same as ProjectHelloWorld_, but it's displayed here for reference.

:::code language="c" source="code/project-analyze.c" range="42-75":::

## Thread entry functions

**Building block 4** includes the Urgent and Routine thread entry functions, and these functions are the same as in ProjectHelloWorld. They're shown here for reference. No changes are need in these blocks.

### Urgent thread entry function

:::code language="c" source="code/project-analyze.c" range="81-107":::

### Routine thread entry function

:::code language="c" source="code/project-analyze.c" range="111-137":::

### Print statistics

You'll need to make numerous changes in the `print_stats` timer entry function as indicated in the highlighted sections of the following code:

1. The `capture performance data for Routine thread` was already added. You don't need to change this section.
1. Add a service to capture performance data for the Urgent thread. Add it after the service for the Routine thread.
1. Add `printf` statements to display Urgent thread data. See highlighted gap in the `printf` statement section.

:::code language="c" source="code/project-analyze.c" range="140-173" highlight="6,11,12,13,27":::
