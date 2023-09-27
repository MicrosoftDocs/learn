## Introduction

You get to analyze your work with ProjectHelloWorld in this project. We'll use GitHub Codespaces or Visual Studio, and you have a C project named *ProjectAnalyze* to modify.

> [!TIP]
> Refer to [Set up your environment](/training/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true) before getting started on the exercises in this module.

## Use GitHub Codespaces

1. Open the codespace you created from the GitHub repo. Once done, you can view the sample projects repo within VS Code web.

1. Expand the **TASK EXPLORER** pane and expand the **vscode** node you'll find **Build / Clean / Run Project** tasks. Choose **Build Project** and select the run button.

   ![Screenshot of the VS Code Web Task Explorer.](../../introduction-azure-rtos/media/vscode-web-tasks.png)

1. Choose **ProjectAnalyze** to build the project.

1. Now choose **Run Project** in the same **TASK EXPLORER**.

## Use Visual Studio

1. Open the solution `azure_rtos_threadx_training.sln` in Visual Studio.

1. In the **Solution Explorer**, right click on **ProjectAnalyze** and select **Set as Startup Project**.

1. Select the **Build** tab and choose **Build ProjectAnalyze** to build your project. Then, select the **Debug** tab, followed by **Start debugging** to debug your project.

## Complete the sample

If all has gone well, you should see initial output appearing on the screen similar to the following image:

:::image type="content" source="../media/partial-output.png" alt-text="Screenshot showing partial output from Project Analyze.":::  <br /> *Partial Output from ProjectAnalyze*

Your file has an application timer that invokes a function periodically (that is, 500 timer ticks) that displays a statistical summary for both threads. This function will compute the average cycle times, then display those values, the current time, and the values of the counters. The second part of the output is produced by a thread performance info get for the Routine thread.

### Modify the sample code

1. You'll modify the sample code by defining variables for the Urgent thread. Refer to the code in the previous unit discussion of building block 1, part 2 (declarations, definitions, and prototypes).

1. The second part of your task is to modify the output section by obtaining performance data for the Urgent thread and displaying it using several `printf` statements. Refer to the code shown in building block 4.

After modifying the sample code, build and debug the project to produce output shown in the following image:

:::image type="content" source="../media/modified-output.png" alt-text="Screenshot showing complete output from Project Analyze.":::  <br /> *Complete Output from modified ProjectAnalyze*

> [!NOTE]
> We used the contents of the internal system clock (for example: `tx_time_get()`) to obtain the times when the two threads completed their cycles. We used an application timer to display summary statistical results every 500 timer ticks.
