
One of the advantages of using Apache Spark in Azure Databricks is the ability to distribute processing tasks across multiple cluster nodes. When you use a Spark-aware machine learning library like MLlib, machine learning training can be scaled out to reduce the overall time the training process takes. When using Hyperopt with a distributed training library like MLlib, the work is automatically scaled across the available worker nodes in the cluster.

Hyperopt supports the scaling out of hyperparameter tuning trials for libraries that <u>aren't</u> distributed by using the **SparkTrials** class in place of a regular **Trials** class. This approach enables you to take advantage of scale-out parallelism of Spark to distribute hyperparameter tuning runs across multiple nodes, even when using a library that is designed for processing on a single computer such as Scikit-Learn.

The following example code shows how to use the **SparkTrials** class.

```python
from hyperopt import SparkTrials

  spark_trials = SparkTrials()
  with mlflow.start_run():
    argmin = fmin(
      fn=objective,
      space=search_space,
      algo=algo,
      max_evals=100,
      trials=spark_trials)
  
  print("Best param values: ", argmin)
```

> [!TIP]
> For more information about using the **SparkTrials** class, see [The SparkTrials class](/azure/databricks/machine-learning/automl-hyperparam-tuning/hyperopt-concepts?azure-portal-true#the-sparktrials-class) in the Azure Databricks documentation.
