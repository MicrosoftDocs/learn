## Introduction

You get to detect and abort unacceptably long suspension times in this project. We'll use GitHub Codespaces or Visual Studio, and you have a C project named *ProjectBreakSuspension* to modify.

> [!TIP]
> Refer to [Set up your environment](https://docs.microsoft.com/learn/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true) before getting started on the exercises in this module.

## Use GitHub Codespaces

1. Open the codespace you've created from GitHub repo. Once done, you can view the sample projects repo within VSCode web.

1. Expand the **TASK EXPLORER** pane and expand the **vscode** node you'll find **Build / Clean / Run Project** tasks. Choose **Build Project** and select the run button.

   ![VSCode Web Task Explorer](../../introduction-azure-rtos/media/vscode-web-tasks.png)

1. Choose **ProjectBreakSuspension** to build the project.

1. Now choose **Run Project** in the same **TASK EXPLORER**.

## Use Visual Studio

1. Open the solution `azure_rtos_threadx_training.sln` in Visual Studio.

1. In the **Solution Explorer**, right click on **ProjectBreakSuspension** and select **Set as Startup Project**.

1. Select the **Build** tab and choose **Build ProjectBreakSuspension** to build your project. Then select the **Debug** tab, followed by **Start debugging** to debug your project.

## Complete the sample

If all has gone well, you should see initial output appearing on the screen similar to what is depicted in the following image.

:::image type="content" alt-text="Diagram that shows initial, incomplete output for the project." source="../media/incomplete-output.png" loc-scope="Azure":::

Your task is to modify the sample code as follows.

1. Modify the Routine entry function so that it detects possibly unacceptably long wait times, similar to that of the Urgent entry function.

1. Modify the Monitor entry function so that it detects unacceptably long wait times and takes appropriate action, similar to how the Urgent thread was handled.

Build and debug *ProjectBreakSuspension* project to produce the final output:

:::image type="content" alt-text="Diagram that shows the final, complete output for the project." source="../media/complete-output.png" loc-scope="Azure":::

Thus, at time 1000, we detected 3 wait aborts for the Urgent thread and 4 wait aborts for the Routine thread. Why did the Routine counter and average time have such a large difference between the initial and final outputs?