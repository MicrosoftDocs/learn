We've created our dataset in Custom Vision. Now, we can train our model. You could train the model by using the SDK, but we'll use the Custom Vision portal to train our model.

1. In the [Custom Vision portal](https://www.customvision.ai/?azure-portal=true), select the **Bird Classification** project.

1. In the top menu bar, select **Train**.

1. In **Choose Training Type**, select **Quick Training**, and then select **Train**.

:::image type="content" source="../media/custom-vision-quick-train.png" alt-text="Screenshot that shows how to create a quick training iteration in the Custom Vision portal.":::

During the training process, an **Iterations** pane appears. A **Training…** notification in the pane indicates that training is in progress. When the training process finishes, information about how the model performed for the training iteration is shown.

:::image type="content" source="../media/custom-vision-train-model-iteration-metrics.png" alt-text="Screenshot that shows graphical and numerical metrics for a training iteration of a Custom Vision project.":::

Details about the training iteration are displayed through metrics called _precision_, _recall_, and _average precision (AP)_. The metrics are shown for the whole model and for each class (tag). In the next unit, we'll learn more about these metrics.
