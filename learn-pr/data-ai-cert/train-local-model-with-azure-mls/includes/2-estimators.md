In Azure Machine Learning, yYou can use a **Run Configuration** and a **Script Run Configuration** to run a script-based experiment that trains a machine learning model. However, depending on the machine learning framework being used and the dependencies it requires, the run configuration may become complex. Azure Machine Learning also provides a higher level abstraction called an **Estimator** that encapsulates a run configuration and a script configuration in a single object, and for which there are pre-defined, framework-specific variants that already include the package dependencies for common machine learning frameworks such as Scikit-Learn, PyTorch, and Tensorflow.

## Writing a Script to Train a Model

When using an experiment to train a model, your script should save the trained model in the **outputs** folder. For example, the following code shows how a model trained using Scikit-Learn can be saved in the **outputs** folder using the **joblib** package:

```Python
from azureml.core import Run
import pandas as pd
import numpy as np
import joblib
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression

# Get the experiment run context
run = Run.get_context()

# Prepare the dataset
diabetes = pd.read_csv('data.csv')
X, y = data[['Feature1','Feature2','Feature3']].values, data['Label'].values
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.30)

# Train a logistic regression model
reg = 0.1
model = LogisticRegression(C=1/reg, solver="liblinear").fit(X_train, y_train)

# calculate accuracy
y_hat = model.predict(X_test)
acc = np.average(y_hat == y_test)
run.log('Accuracy', np.float(acc))

# Save the trained model
os.makedirs('outputs', exist_ok=True)
joblib.dump(value=model, filename='outputs/model.pkl')

run.complete()
```

## Using an Estimator

You can use a generic **Estimator** class to define a run configuration for a training script like this:

```Python
from azureml.train.estimator import Estimator
from azureml.core import Experiment

# Create an estimator
estimator = Estimator(source_directory='experiment_folder',
                      entry_script='training_script.py'
                      compute_target='local',
                      conda_packages=['scikit-learn']
                      )

# Create and run an experiment
experiment = Experiment(workspace = ws, name = 'training_experiment')
run = experiment.submit(config=estimator)
```

### Framework-Specific Estimators

The Azure Machine Learning SDK includes framework-specific estimators that further simplify configuration. For example, the following code uses the **SKLearn** estimator, which automatically includes Scikit-Learn and its dependencies in the run environment:

```Python
from azureml.train.sklearn import SKLearn
from azureml.core import Experiment

# Create an estimator
estimator = SKLearn(source_directory='experiment_folder',
                    entry_script='training_script.py'
                    compute_target='local'
                    )

# Create and run an experiment
experiment = Experiment(workspace = ws, name = 'training_experiment')
run = experiment.submit(config=estimator)
```

For more information about using estimators, see [Train models with Azure Machine Learning using estimator](https://aka.ms/AA70rqw).
