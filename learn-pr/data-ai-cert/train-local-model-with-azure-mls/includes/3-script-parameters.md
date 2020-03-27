You can increase the flexibility of script-based experiments by using parameters to set variables in the script.

## Working with Script Arguments

To use parameters in a script, you must use a library such as **argparse** to read the arguments passed to the script and assign them to variables. For example, the following code reads an argument named **reg_rate**, which is used to set the regularization rate hyperparameter for the logistic regression algorithm used to train a model.

```Python
from azureml.core import Run
import argparse
import pandas as pd
import numpy as np
import joblib
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression

# Get the experiment run context
run = Run.get_context()

# Set regularization hyperparameter
parser = argparse.ArgumentParser()
parser.add_argument('--reg_rate', type=float, dest='reg', default=0.01)
args = parser.parse_args()
reg = args.reg

# Prepare the dataset
diabetes = pd.read_csv('data.csv')
X, y = data[['Feature1','Feature2','Feature3']].values, data['Label'].values
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.30)

# Train a logistic regression model
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

## Passing Script Arguments to an Estimator

To pass parameter values to a script being run by an estimator, you need to provide a **script_params** value containing a dictionary of arguments, like this:

```Python
from azureml.train.sklearn import SKLearn
from azureml.core import Experiment

# Create an estimator
estimator = SKLearn(source_directory='experiment_folder',
                    entry_script='training_script.py',
                    script_params = {'--reg_rate': 0.1},
                    compute_target='local'
                    )

# Create and run an experiment
experiment = Experiment(workspace = ws, name = 'training_experiment')
run = experiment.submit(config=estimator)
```
