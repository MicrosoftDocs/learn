To train a machine learning model, you may choose to use an open source framework that best suits your needs. After training, you want to deploy your model. **MLflow** is an open source platform that streamlines machine learning deployment, regardless of the type of model you trained and the framework you used.

MLflow is integrated with Azure Machine Learning. The integration with Azure Machine Learning allows you to easily deploy models that you train and track with Mlflow. For example, when you have an MLflow model, you can opt for the no-code deployment in Azure Machine Learning.

> [!Note]
> Some types of models are currently not supported by Azure Machine Learning and MLflow. In that case, you can register a `custom` model. Learn more about [how to work with (custom) models in Azure Machine Learning](/azure/machine-learning/how-to-manage-models?azure-portal=true). 

## Why use MLflow? 

When you train a machine learning model with Azure Machine Learning, you can use MLflow to register your model. MLflow standardizes the packaging of models, which means that an MLflow model can easily be imported or exported across different workflows. 

For example, imagine training a model in an Azure Machine Learning workspace used for development. If you want to export the model to another workspace used for production, you can use an MLflow model to easily do so. 

When you train and log a model, you store all relevant artifacts in a directory. When you register the model, an `MLmodel` file is created in that directory. The `MLmodel` file contains the model's metadata, which allows for model traceability.

You can register models with MLflow by enabling autologging, or by using custom logging. 

> [!Note]
> MLflow allows you to log a model as an artifact, or as a model. When you log a model as an artifact, the model is treated as a file. When you log a model as a model, you're adding information to the registered model that enables you to use the model directly in pipelines or deployments. Learn more about [the difference between an artifact and a model](/azure/machine-learning/concept-mlflow-models#the-mlmodel-format?azure-portal=true)

## Use autologging to log a model

When you train a model, you can include `mlflow.autolog()` to enable autologging. MLflow's autologging automatically logs parameters, metrics, artifacts, and the model you train. The model is logged when the `.fit()` method is called. The framework you use to train your model is identified and included as the **flavor** of your model. 

Optionally, you can specify which flavor you want your model to be identified as by using `mlflow.<flavor>.autolog()`. Some common flavors that you can use with autologging are: 

- Keras: `mlflow.keras.autolog`
- Scikit-learn: `mlflow.sklearn.autolog()`
- LightGBM: `mlflow.lightgbm.autolog`
- XGBoost: `mlflow.xgboost.autolog`
- TensorFlow: `mlflow.tensorflow.autolog`
- PyTorch: `mlflow.pytorch.autolog`
- ONNX: `mlflow.onnx.autolog`

> [!Tip]
> Explore the complete list of [MLflow's built-in model flavors](https://mlflow.org/docs/latest/models.html#built-in-model-flavors?azure-portal=true).

When you use autologging, an output folder is created which includes all necessary model artifacts, including the `MLmodel` file that references these files and includes the model's metadata.

## Manually log a model

When you want to have more control over how the model is logged, you can use `autolog` (for your parameters, metrics, and other artifacts), and set `log_models=False`. MLflow doesn't automatically log the model, and you can add it manually.

As logging the model allows you to easily deploy the model, you may want to customize the model's expected inputs and outputs. The schemas of the expected inputs and outputs are defined as the signature in the `MLmodel` file. If you deploy your model and the inputs don't match the defined schema in the signature, you may encounter errors. 

Therefore, you may want to customize the signature to alter the deployed model's behavior.

### Customize the signature

The model signature defines the schema of the model's inputs and outputs. The signature is stored in JSON format in the `MLmodel` file, together with other metadata of the model. 

The model signature can be inferred from datasets or created manually by hand. 
 
To log a model with a signature that is inferred from your training dataset and model predictions, you can use `infer_signature()`. For example, the following example takes the training dataset to infer the schema of the inputs, and the model's predictions to infer the schema of the output:

```python
import pandas as pd
from sklearn import datasets
from sklearn.ensemble import RandomForestClassifier
import mlflow
import mlflow.sklearn
from mlflow.models.signature import infer_signature

iris = datasets.load_iris()
iris_train = pd.DataFrame(iris.data, columns=iris.feature_names)
clf = RandomForestClassifier(max_depth=7, random_state=0)
clf.fit(iris_train, iris.target)

# Infer the signature from the training dataset and model's predictions
signature = infer_signature(iris_train, clf.predict(iris_train))

# Log the scikit-learn model with the custom signature
mlflow.sklearn.log_model(clf, "iris_rf", signature=signature)
```

Alternatively, you can create the signature manually:

```python
from mlflow.models.signature import ModelSignature
from mlflow.types.schema import Schema, ColSpec

# Define the schema for the input data
input_schema = Schema([
  ColSpec("double", "sepal length (cm)"),
  ColSpec("double", "sepal width (cm)"),
  ColSpec("double", "petal length (cm)"),
  ColSpec("double", "petal width (cm)"),
])

# Define the schema for the output data
output_schema = Schema([ColSpec("long")])

# Create the signature object
signature = ModelSignature(inputs=input_schema, outputs=output_schema)
``` 

> [!Note]
> Learn more about [logging MLflow models in Azure Machine Learning](/azure/machine-learning/how-to-log-mlflow-models?azure-portal=true) and [MLflow's model signature](https://mlflow.org/docs/latest/models.html#model-signature-and-input-example?azure-portal=true).