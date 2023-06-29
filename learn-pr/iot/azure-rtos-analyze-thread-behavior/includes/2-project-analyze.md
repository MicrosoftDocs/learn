## Introduction

> [!TIP]
> Refer to [Set up your environment](/training/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true) before getting started on the exercises in this module.

The following image contains an illustration of the ProjectAnalyze activities:

:::image type="content" source="../media/project-analyze-activities.svg" alt-text="Diagram showing the activities of ProjectAnalyze.":::

> [!NOTE]
> ProjectAnalyze is identical to ProjectHelloWorld, except that we capture the start and ending times for each of the two threads and compute the cycle times and the average times for the two threads.
>
> We'll also introduce the concept of an application timer and the `thread_performance_info_get` service so that we can display summary statistics at periodic intervals.

Before proceeding, let's first discuss the features of an application timer that we can use in this project.
