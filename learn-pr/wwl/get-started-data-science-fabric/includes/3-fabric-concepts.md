

When you perform data science in Microsoft Fabric, there are three key features to help you manage your work: **notebooks**, **experiments**, and **models**. 

You use notebooks to write and run code. Within a notebook, you can run one or more experiments. An experiment allows you to track your workloads like training a machine learning model. Finally, you can save a machine learning model as a model in Fabric.

## Understand notebooks

Data scientists mainly work in notebooks to write, edit, and run code. Notebooks in Microsoft Fabric run on Apache Spark compute. Apache Spark is an open source parallel processing framework for large-scale data processing and analytics. 

Notebooks are automatically attached to Spark compute. When you run a cell in a notebook for the first time, a new Spark session starts. The session persists when you run subsequent cells. The Spark session will automatically stop after some time of inactivity to save costs. You can also manually stop the session. 

When you're working in a notebook, you can choose the language you want to use. For data science workloads, you're likely to work with PySpark (Python) or SparkR (R). 

:::image type="content" source="../media/notebooks.png" alt-text="Screenshot of a notebook in Microsoft Fabric.":::

To get access to data, you can connect a notebook to a lakehouse and read the data as a Spark or Pandas dataframe. The option you choose depends on the libraries you work with.

## Understand experiments

Whenever you train a model in a notebook that you want to track, you can create an experiment in Microsoft Fabric.

An experiment can consist of multiple runs. Each **run** represents a task you executed in a notebook, like training a machine learning model. 

For example, to train a machine learning model for sales forecasting, you can try different training datasets with the same algorithm. Each time you train a model with a different dataset, you create a new experiment run. Then, you can compare the experiment runs to determine the best performing model.

You can create a new experiment through the user interface (UI) or by using the MLflow library in the notebook.

### Create an experiment using the UI

To create a machine learning experiment from the UI:

1. Navigate to the **Data Science** home page in Microsoft Fabric.
1. Select **Experiment** to create a new experiment.
1. Provide a name for your experiment and select **Create**.

### Create an experiment using MLflow

To create an experiment inline with MLflow:

1. Navigate to the **Data Science** home page in Microsoft Fabric. 
1. Open or create a new notebook. 
1. In the notebook, run the following cell to create a new experiment with the provided name:

    ```python
    import mlflow
     
    mlflow.create_experiment("<EXPERIMENT_NAME>")
    ```

### Start tracking metrics

To compare experiment runs, track parameters, metrics, and artifacts for each run. When you want to track machine learning model training with MLflow in Microsoft Fabric, you first run the following code:

```python
mlflow.set_experiment("<EXPERIMENT_NAME>")
```

When you run `set_experiment()`, you set the given experiment as the active experiment. If an experiment with the provided name doesn't exist, a new experiment is created. 

After the experiment is set, you can start tracking your work with MLflow by using: 

- **Autologging**: Automatically logs metrics, parameters, and models without the need for explicit log statements.
- **Custom logging**: Explicitly log any metrics, parameters, models, or artifacts you create during model training.

> [!Tip]
> Find a list of [all supported frameworks for autologging in the official MLflow documentation](https://mlflow.org/docs/latest/tracking.html#automatic-logging?azure-portal=true).

All parameters, metrics, and artifacts you track in an experiment run are shown in the experiments overview. You can view experiment runs individually in the **Run details** tab, or compare across runs with the **Run list**:

:::image type="content" source="../media/experiment.png" alt-text="Screenshot of an experiment overview in Microsoft Fabric.":::

## Understand models

One of the artifacts you can track with MLflow is the trained model. When you want to use a model for scoring, you can save models in Microsoft Fabric. 

From an experiment run, you can **save as model** to create a new model within your workspace that includes all relevant metadata. When you save a model, you can choose to create a new model or select an existing model. 

By selecting an existing model, you create a new version of a model under the same name. Model versioning allows you to compare models that serve a similar purpose and choose the best performing model to generate predictions.

:::image type="content" source="../media/models.png" alt-text="Screenshot of the model overview in Microsoft Fabric.":::