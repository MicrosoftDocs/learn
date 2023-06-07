


After you've trained and tracked models with MLflow in Azure Machine Learning, you can explore the metrics and evaluate your models. 

- Review metrics in the Azure Machine Learning studio.
- Retrieve runs and metrics with MLflow. 

> [!Note]
> Azure Machine Learning uses the concept of jobs when you run a script. Multiple job runs in Azure Machine Learning can be grouped within one experiment. MLflow uses a similar syntax where each script is a run, which is part of an experiment. 

## View the metrics in the Azure Machine Learning studio

When your job is completed, you can review the logged parameters, metrics, and artifacts in the Azure Machine Learning studio.

When you review job runs in the Azure Machine Learning studio, you'll explore a job run's metrics, which is part of an experiment.

To view the metrics through an intuitive user interface, you can:

1. Open the Studio by navigating to [https://ml.azure.com](https://ml.azure.com).
1. Find your experiment run and open it to view its details.
1. In the **Details** tab, all logged parameters are shown under **Params**.
1. Select the **Metrics** tab and select the metric you want to explore.
1. Any plots that are logged as artifacts can be found under **Images**.
1. The model assets that can be used to register and deploy the model are stored in the **models** folder under **Outputs + logs**.

> [!Tip]
> Read the documentation to learn more on [how to track models with MLflow](/azure/machine-learning/how-to-use-mlflow).

## Retrieve metrics with MLflow in a notebook

When you run a training script as a job in Azure Machine Learning, and track your model training with MLflow, you can query the runs in a notebook by using MLflow. Using MLflow in a notebook gives you more control over which runs you want to retrieve to compare.

When using MLflow to query your runs, you'll refer to experiments and runs. 

### Search all the experiments
You can get all the active experiments in the workspace using MLFlow:

```python
experiments = mlflow.search_experiments(max_results=2)
for exp in experiments:
    print(exp.name)
```

If you want to retrieve archived experiments too, then include the option `ViewType.ALL`:

```python
from mlflow.entities import ViewType

experiments = mlflow.search_experiments(view_type=ViewType.ALL)
for exp in experiments:
    print(exp.name)
```

To retrieve a specific experiment, you can run:

```python
exp = mlflow.get_experiment_by_name(experiment_name)
print(exp)
```

> [!Tip]
> Explore the documentation on how to [search experiments with MLflow](https://mlflow.org/docs/latest/search-experiments.html?azure-portal=true)

### Retrieve runs

MLflow allows you to search for runs inside of any experiment. You need either the experiment ID or the experiment name. 

For example, when you want to retrieve the metrics of a specific run:

```python
mlflow.search_runs(exp.experiment_id)
```

You can search runs across multiple experiments if necessary. Searching across experiments may be useful in case you want to compare runs of the same model when it's being logged in different experiments (by different people or different project iterations). 

You can use `search_all_experiments=True` if you want to search across all the experiments in the workspace.

By default, experiments are ordered descending by `start_time`, which is the time the experiment was queued in Azure Machine Learning. However, you can change this default by using the parameter `order_by`.

For example, if you want to sort by start time and only show the last two results:

```python
mlflow.search_runs(exp.experiment_id, order_by=["start_time DESC"], max_results=2)
```

You can also look for a run with a specific combination in the hyperparameters:

```python
mlflow.search_runs(
    exp.experiment_id, filter_string="params.num_boost_round='100'", max_results=2
)
```

> [!Tip]
> Explore the documentation on how to [search runs with MLflow](https://mlflow.org/docs/latest/search-runs.html?azure-portal=true)
