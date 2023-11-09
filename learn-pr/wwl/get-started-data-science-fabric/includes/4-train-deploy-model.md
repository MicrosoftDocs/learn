When you've ingested, explored, and preprocessed your data, you can use the data to train a model. Training a model is an iterative process, and you want to be able to track your work.

Microsoft Fabric integrates with MLflow to easily track and log your work, enabling you to review your work at any time to decide what the best approach is to train the final model. When you track your work, your results are easily reproducible.

Any work you want to track, can be tracked as **experiments**.

## Understand experiments

Whenever you train a model in a notebook that you want to track, you create an experiment in Microsoft Fabric.

An experiment can consist of multiple runs. Each **run** represents a task you executed in a notebook, like training a machine learning model.

For example, to train a machine learning model for sales forecasting, you can try different training datasets with the same algorithm. Each time you train a model with a different dataset, you create a new experiment run. Then, you can compare the experiment runs to determine the best performing model.

### Start tracking metrics

To compare experiment runs, you can track parameters, metrics, and artifacts for each run.

All parameters, metrics, and artifacts you track in an experiment run are shown in the experiments overview. You can view experiment runs individually in the **Run details** tab, or compare across runs with the **Run list**:

:::image type="content" source="../media/experiment.png" alt-text="Screenshot of an experiment overview in Microsoft Fabric.":::

By tracking your work with MLflow, you can compare model training iterations and decide which configuration resulted in the best model for your use case.

## Understand models

After you train a model, you want to use it for scoring. With scoring, you use the model on new data to generate predictions or insights. When you train and track a model with MLflow, artifacts are stored within the experiment run to represent your model and its metadata. You can save these artifacts in Microsoft Fabric as a **model**.

By saving your model artifacts as a registered model in Microsoft Fabric, you can easily manage your models. Anytime you train a new model and save it under the same name, you add a new version to the model.

:::image type="content" source="../media/models.png" alt-text="Screenshot of the model overview in Microsoft Fabric.":::

### Use a model to generate insights

To use a model for generating predictions, you can use the PREDICT function in Microsoft Fabric. The PREDICT function is built to easily integrate with MLflow models and allows you to use the model for generating batch predictions.

For example, every week you receive sales data from several stores. Based on the historical data, you've trained a model that can predict the sales for the next week, based on the sales of the last few weeks. You tracked the model with MLflow and saved it in Microsoft Fabric. Whenever the new weekly sales data comes in, you use the PREDICT function to let the model generate the forecast for the next week. The forecasted sales data is stored as a table in a lakehouse, which is visualized in a Power BI report for business users to consume.
