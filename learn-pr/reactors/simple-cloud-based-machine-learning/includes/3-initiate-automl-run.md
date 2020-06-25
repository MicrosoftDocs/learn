From inside Azure Machine Learning Studio, create an automated machine learning experiment and initiate a set of runs to determine the most accurate machine learning model.

1. Select **Automated ML**, and create a new automated machine learning experiment.

   :::image type="content" alt-text="Specify the settings for the uploaded CVS file" source="../media/new-automated-ml.png" loc-scope="azure":::

1. Select the **bank-marketing** dataset.

1. Configure the run experiment.

   :::image type="content" alt-text="Configure the run experiment" source="../media/configure-run.png" loc-scope="azure":::

   1. Select an experiment named **ms-learn-exp**.
   1. Select **y** as the target column.
   1. Create a new compute cluster called **ms-learn-compute**.

1. Select **Classification** as the task type.

1. After the run finishes, select **Models** to see the most accurate model. The **VotingEnsemble** model is the best with 90.85 accuracy.

   :::image type="content" alt-text="View the run experiments" source="../media/view-best-run.png" loc-scope="azure":::
