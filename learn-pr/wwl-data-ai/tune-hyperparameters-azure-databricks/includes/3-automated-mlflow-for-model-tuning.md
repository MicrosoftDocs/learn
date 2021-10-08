To choose the best model trained during hyperparameter tuning, you want to compare all models by evaluating their metrics. One common and simple approach to track model training in Azure Databricks is by using the open-source platform **MLflow**. 

## Use automated MLflow
As you train multiple models with hyperparameter tuning, you want to avoid the need to make explicit API calls to log all necessary information about the different models to MLflow. To make tracking hyperparameter tuning easier, the [Databricks Runtime for Machine Learning](https://docs.databricks.com/runtime/mlruntime.html) also supports *automated* MLflow Tracking.
When you use automated MLflow for model tuning, the hyperparameter values and evaluation metrics are automatically logged in MLflow and a hierarchy will be created for the different runs that represent the distinct models you train.

To use automated MLflow tracking, you have to do the following:
- Use a Python notebook to host your code.
- Attach the notebook to a cluster with Databricks Runtime or Databricks Runtime for Machine Learning.
- Set up the hyperparameter tuning with `CrossValidator` or `TrainValidationSplit`.

MLflow will automatically create a main or parent run that contains the information for the method you chose: `CrossValidator` or `TrainValidationSplit`. MLflow will also create child runs that are nested under the main or parent run. Each child run will represent a trained model and you can see which hyperparameter values were used and the resulting evaluation metrics.

## Run tuning code
When you want to run code that will train multiple models with different hyperparameter settings, you can go through the following steps:
- List the available hyperparameters for a specific algorithm. 
- Set up the search space and sampling method.
- Run the code with automated MLflow, using `CrossValidator` or `TrainValidationSplit`.

### List the available hyperparameters
You can explore the hyperparameters of a specific machine learning algorithm by using the `.explainParams()` method on a model. For example, if we want to train a linear regression model `lr`, we can use the following command to view the available hyperparameters:

```python
print(lr.explainParams())
```

The `.explainParams()` method will return a list of hyperparameters you can choose from, including the name of the hyperparameter, a description, and the default value. Three of the hyperparamaters available for the linear regression model are:
- maxIter: max number of iterations (>= 0). (default: 100)
- fitIntercept: whether to fit an intercept term. (default: True)
- standardization: whether to standardize the training features before fitting the model. (default: True)

### Set up the search space and sampling method
After you select the hyperparameters, you can use `ParamGridBuilder()` to specify the **search space**. The search space is the range of values of the hyperparameters you want to try out. You can then specify how you want to choose values from that search space to train individual models with which is known as the **sampling method**. The most straight-forward sampling method is known as **grid sampling**. The grid sampling method tries all possible combinations of values for the hyperparameters listed. 

By default, the individual models will be trained in serial. It is possible to train models with different hyperparamater values in parallel. You can find more information on setting up the parameter grid in the documentation [here](https://spark.apache.org/docs/latest/ml-tuning.html).

> [!NOTE] 
> Since grid search works through exhaustively building a model for each combination of hyperparameters, it quickly becomes a lot of different unique combinations. As each model training can consume a lot of compute power, be careful with the configuration you set up.

If we continue the example with the linear regression model `lr`, the following code shows how to set up a grid search to try out all possible combinations of parameters:

```python
from pyspark.ml.tuning import ParamGridBuilder

paramGrid = (ParamGridBuilder()
  .addGrid(lr.maxIter, [1, 10, 100])
  .addGrid(lr.fitIntercept, [True, False])
  .addGrid(lr.standardization, [True, False])
  .build()
)
```

### Run code and invoke automated MLflow
To test how the model performs and to generate evaluation metrics, you can use a test dataset. If you want to train multiple models on the same training dataset and the same test dataset, you can use the `TrainValidationSplit` method to run your code, build the models, and log them automatically with MLflow. 

In case you want to take extra measures to prevent overfitting, you can use the `CrossValidator` method to train the models with different training datasets for each model and different test datasets to calculate the evaluation metrics. 

To build the models for the linear regression model `lr` used in the examples above, you can create a `RegressionEvaluator()` to evaluate the grid search experiments, which will help decide which model is best. The settings for the hyperparameter tuning experiment can be set by using the `CrossValidator()` method as is done in the example below.

```python
from pyspark.ml.evaluation import RegressionEvaluator
from pyspark.ml.tuning import CrossValidator

evaluator = RegressionEvaluator(
  labelCol = "medv", 
  predictionCol = "prediction"
)

cv = CrossValidator(
  estimator = pipeline,             # Estimator (individual model or pipeline)
  estimatorParamMaps = paramGrid,   # Grid of parameters to try (grid search)
  evaluator=evaluator,              # Evaluator
  numFolds = 3,                     # Set k to 3
  seed = 42                         # Seed to sure our results are the same if ran again
)

cvModel = cv.fit(trainDF)
```

Once all models have been trained, you can get the best model with the following code:

 ```python
 bestModel = cvModel.bestModel
 ```

Alternatively, you can look at all models you trained through the UI of MLflow. Just remember that there will be a parent run for the complete experiment and child runs for each individual model that has been trained. 