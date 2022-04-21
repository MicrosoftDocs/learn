## Introduction

You get to conduct a little experiment in this project. You'll observe whether Producer can keep up with the demands of Consumer, or whether Producer will overwhelm Consumer by filling *StorageFacility* to capacity. You'll also get to study the result of adding a second Consumer.

> [!TIP]
> Refer to [Set up your environment](https://docs.microsoft.com/learn/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true) before getting started on the exercises in this module.

## Use GitHub Codespaces

1. Open the codespace you've created from GitHub repo. Once done, you can view the sample projects repo within VSCode web.

1. Expand the **TASK EXPLORER** pane and expand the **vscode** node you'll find **Build / Clean / Run Project** tasks. Choose **Build Project** and select the run button.

   ![VSCode Web Task Explorer](../../introduction-azure-rtos/media/vscode-web-tasks.png)

1. Choose **04: ProjectProducerConsumer** to build the project.

1. Now choose **Run Project** in the same **TASK EXPLORER**.

## Use Visual Studio

1. Open the solution `azure_rtos_threadx_training.sln` in Visual Studio.

1. In the **Solution Explorer**, right click on **ProjectProducerConsumer** and select **Set as Startup Project**.

1. Select the **Build** tab and choose **Build ProjectProducerConsumer** to build your project. Then select the **Debug** tab, followed by **Start debugging** to debug your project.

## Complete the sample

If all has gone well, you should see initial output appearing on the screen similar to the following image:

:::image type="content" source="../media/figure-12-partial-output.png" alt-text="Sample partial output." border="false":::

> [!NOTE]
>
> - After 200 timer ticks, the count of *StorageFacility* is 23.

It's clear that Producer is putting many more instances in *StorageFacility* than Consumer can get. The question is, what would happen if we added a second consumer? That is precisely the modification you're about to make. Let's assign the name of Consumer2 to the second consumer. Consumer2 will be identical to the original consumer, that is, it will have priority 15, and it will get an instance from *StorageFacility* every 12 timer ticks.

Review [building block 1](https://review.docs.microsoft.com/learn/modules/threadx-event-notification/6-building-blocks#building-block-1) and observe that you'll need to add several items to this building block, including defining another thread, counter, and prototype.

Review [building block 3 part 2](https://review.docs.microsoft.com/learn/modules/threadx-event-notification/6-building-blocks#building-block-3-part-2) to create an entry function for the second consumer.

After you have made your modifications, build and debug *ProjectProducerConsumer.c* to produce output similar to the following image:

:::image type="content" source="../media/figure-13-final-output.png" alt-text="Sample complete output." border="false":::

> [!NOTE]
>
> - After 200 timer ticks, the count of *StorageFacility* is 6.

What would happen if you decreased the sleep time of the consumers?
