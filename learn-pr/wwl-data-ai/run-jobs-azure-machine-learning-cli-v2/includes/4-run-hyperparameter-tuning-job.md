Perform hyperparameter tuning with the Azure Machine Learning workspace by submitting a sweep job with the CLI (v2).

The data scientist who created the customer churn model is wondering if the model can be even more accurate. Because the model was trained on a personal computer, the data scientist didn't have the time or compute power to train multiple models with varying model parameter values. Now that you are able to train the customer churn model using a compute cluster, you can parallelize the model training to quickly iterate through hyperparameter values.

You'll tune hyperparameters using a Python script with the Azure Machine Learning CLI (v2).

## Tune hyperparameters

Use a **sweep job** to configure and submit a **hyperparameter tuning** job via the CLI (v2).

To find the *best* model, a data scientist trains multiple models. **Hyperparameter tuning** allows a data scientist to train multiple models, using the same algorithm and training data but different hyperparameter values. For each iteration, the performance metrics need to be tracked to evaluate which configuration resulted in the *best* model.

Similarly to a basic Python training job, the configuration of the sweep job is stored in a YAML file `sweep-job.yml`:

```yml
$schema: https://azuremlschemas.azureedge.net/latest/sweepJob.schema.json
type: sweep
sampling_algorithm: grid
trial:
  code: 
    local_path: src
  command: >-
    python main.py
    --learning-rate ${{search_space.learning_rate}}
  environment: azureml:basic-env-scikit:1
inputs:
    diabetes:
      data: azureml:diabetes-data:1
compute: azureml:aml-cluster
search_space:
  learning_rate:
    type: choice
    values: [0.01, 0.1, 1.0]
objective:
  primary_metric: training_roc_auc_score
  goal: maximize
limits:
  max_total_trials: 6
  max_concurrent_trials: 3
  timeout: 3600
experiment_name: customer-churn-sweep-example
description: Run a hyperparameter sweep job for classification on customer churn dataset.
```

To create a sweep job, add the following parameters:

- `type`: The job type, which in this case is `sweep_job`.
- `algorithm`: The sampling method used to choose values from the search space. Can be `bayesian`, `grid`, or `random`.
- `search_space`: The set of values tried during hyperparameter tuning. For each hyperparameter, you can configure the search space type (`choice`) and values (`0.01`, `0.1`, `1.0`).
- `objective`: The name of the logged metric that is used to decide which model is *best* (`primary_metric`). And whether that metric is *best* when maximized or minimized (`goal`).
- `max_total_trials`: A hard stop for how many models to train in total.
- `max_concurrent_trials`: When you use a compute cluster, you can train models in parallel. The number of maximum concurrent trials can't be higher than the number of nodes provisioned for the compute cluster.

To submit the job and open it in the Studio, use the command:

```azurecli
az ml job create -f job-sweep.yml --web 
```

The Studio will open to show the Hyperdrive experiment run and its details. To explore the details and metrics for each individual model that is trained, expand the **Child runs** tab.

> [!Tip]
> Learn more about how to [use the CLI (v2) to train models](/azure/machine-learning/how-to-train-cli) in the official documentation. Find more [examples on training models with the CLI(v2)](https://github.com/Azure/azureml-examples/tree/main/cli) on Github.