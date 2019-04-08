In this unit you will deploy a model.  You will create a Ridge Regression model using a well know public dataset called diabetes. Run the code below to prepare the data.

```python
from sklearn.datasets import load_diabetes
from sklearn.linear_model import Ridge
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split
from sklearn.externals import joblib

X, y = load_diabetes(return_X_y = True)
columns = ['age', 'gender', 'bmi', 'bp', 's1', 's2', 's3', 's4', 's5', 's6']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)
data = {
    "train":{"X": X_train, "y": y_train},        
    "test":{"X": X_test, "y": y_test}
}

print ("Data contains", len(data['train']['X']), "training samples and",len(data['test']['X']), "test samples")
```


Run the code below to train the model and display the Mean Squared Error.

```python
# Create, fit, and test the scikit-learn Ridge regression model
regression_model = Ridge(alpha=0.03)
regression_model.fit(data['train']['X'], data['train']['y'])
preds = regression_model.predict(data['test']['X'])

# Output the Mean Squared Error to the notebook and to the run
print('Mean Squared Error is', mean_squared_error(data['test']['y'], preds))
```

Now run the code below to write the trained model to a text file in your local environment.

```python
from sklearn.externals import joblib

joblib.dump(value=regression_model, filename='sklearn_regression_model.pkl')
```

Now you can register your model in the workspace for further use. Like a container registry, the model registry is a single place to keep track of all the models in your Azure Machine Learning Service, to make sure that the models are stored in a structured format. With a single call to the Azure Machine Learning Model Management service, you can manage your model:

```python
from azureml.core.model import Model
model = Model.register(model_path = "sklearn_regression_model.pkl",
                       model_name = "sklearn_regression_model.pkl",
                       tags = {'area': "diabetes", 'type': "regression"},
                       description = "Ridge regression model to predict diabetes",
                       workspace = ws)
```

In the above code, you can add `tags` and `description` to your models, to make the model easily searchable. Using `tags`, you can track useful information such as the purpose for the model, the name, and version of the machine learning library used to train the model, etc. Note that tags must be alphanumeric.

After registering the models, you see the below screen from the Azure portal so that you can see your registered models:

![Screenshot of Registering Models](../media/5-register-models.png)

As you can see, models are identified by name and version. Whenever a new model is registered with the same name, the machine learning model registry increments the version automatically. A detailed view of a version of the model is as below:

![Screenshot of Detailed View of a Version of Model](../media/5-detailed-view-model.png)