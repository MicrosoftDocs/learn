There is no fundamental design change between ProjectHelloWorld and ProjectAnalyze. All we need to do is make several modifications so that we can capture data relative to the performance of our system.

## Declarations, definitions, and prototypes - part 1

The code block below shows **Part 1 of Building Block 1**.

> [!NOTE]
> This code is virtually identical to what's in ProjectHelloWorld. The only changes shown in the following code block are in the comments section where additional information is provided, and brief instructions added on how to change this project.

:::code language="c" source="code/project-analyze.c" range="1-18":::

## Declarations, definitions, and prototypes - part 2

The code block below shows **Part 2 of Building Block 1**. You'll need to make the following changes in the highlighted lines:

1. Add variables for counters and totals in part 2.
1. Define the variables needed to obtain cumulative performance information about urgent thread and routine thread.
1. Add a `/* Define variables for urgent thread performance info */` section that defines variables for the urgent thread performance information.

:::code language="c" source="code/project-analyze.c" range="20-33" highlight="1,2,3,5,6,7,8,9":::

## The main entry point

**Building Block 2** - the main entry point - is _exactly the same as ProjectHelloWorld_. You don't need to make any changes to the following code; it's displayed for reference.

:::code language="c" source="code/project-analyze.c" range="35-40":::

## Applications definitions

**Building Block 3** is _exactly the same as ProjectHelloWorld_, but it is displayed here for reference.

:::code language="c" source="code/project-analyze.c" range="42-75":::

## Thread entry functions

**Building block 4** includes the urgent and routine thread entry functions, and these are the same as ProjectHelloWorld. They're shown here for reference. No changes are need in these blocks.

#### Urgent thread entry function

:::code language="c" source="code/project-analyze.c" range="81-107":::

#### Routine thread entry function

:::code language="c" source="code/project-analyze.c" range="111-137":::

### Print statistics

You'll need to make numerous changes in the `print_stats` timer entry function as indicated in the highlighted sections of the following code:

1. The `capture performance data for routine thread` was already added. You don't need to change this.
1. Add a service to capture performance data for the urgent thread. Add it after the service for the routine thread.
1. Add `printf` statements to display urgent thread data. See highlighted gap in the `printf` statement section.

:::code language="c" source="code/project-analyze.c" range="140-173" highlight="6,11,12,13,27":::
