In this unit, let's use an example to see how to use AutoML to get a recommended model for a certain problem.

![Screenshot of AutoML Example](../media/4-automl-example.png)

As the diagram shows, AutoML automates the model selection and hyperparameter tuning process. To use it, you need to:

- Define the source and format of the model training data
- Configure the compute target to run the experiment
- Define the machine learning objective and constraints
- Launch the AutoML process, which allows Azure Machine Learning Service to automatically select the right algorithm and tune hyper parameters. In the process, AutoML iterates over different combinations of algorithms and hyper parameters until it finds the best model based on the objective
- Retrieve and test the best model

Although you can use any Python IDE to use the Azure Machine Learning service, you're going to use Azure Notebooks because it has the required Python modules pre-installed. If you have note already set up your Azure Notebook service to run the code examples in, the instructions below will explain how to do this. 

What are Azure Notebooks?

Azure Notebooks is a free hosted service to develop and run Jupyter notebooks in the cloud with no installation. Jupyter (formerly IPython) is an open source project that lets you easily combine markdown text, executable code (Python, R, and F#), persistent data, graphics, and visualizations onto a single, sharable canvas called a notebook.

To get started with Azure Notebooks, use this link:

https://docs.microsoft.com/azure/notebooks/quickstart-sign-in-azure-notebooks

Follow the directions on the web page to get yourself set up and started with Azure Notebooks.

There's lot of documentation at that link to help you learn how to use all the features of Azure Notebooks.

Once you have your Azure Notebook environment set up and you are logged in, follow the instructions below to use Azure Machine Learning service with Python.

In Azure Notebook, create a new notebook, choose the `Python 3.6` kernel. Sign in Azure portal if necessary.


## Connect to your workspace

To start off, you need to get the images to use in your experiment.  You can do this with the code below.

```python
import os
import urllib.request

os.makedirs('./data', exist_ok = True)

urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz', filename='./data/train-images.gz')
urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz', filename='./data/train-labels.gz')
urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz', filename='./data/test-images.gz')
urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz', filename='./data/test-labels.gz')

print('Execution Complete')
```

The data load code uses the helper functions below so run that code to define them.

```python
# function needed by downstream code...

# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

import gzip
import numpy as np
import struct


# load compressed MNIST gz files and return numpy arrays
def load_data(filename, label=False):
    with gzip.open(filename) as gz:
        struct.unpack('I', gz.read(4))
        n_items = struct.unpack('>I', gz.read(4))
        if not label:
            n_rows = struct.unpack('>I', gz.read(4))[0]
            n_cols = struct.unpack('>I', gz.read(4))[0]
            res = np.frombuffer(gz.read(n_items[0] * n_rows * n_cols), dtype=np.uint8)
            res = res.reshape(n_items[0], n_rows * n_cols)
        else:
            res = np.frombuffer(gz.read(n_items[0]), dtype=np.uint8)
            res = res.reshape(n_items[0], 1)
    return res


# one-hot encode a 1-D array
def one_hot_encode(array, num_of_classes):
    return np.eye(num_of_classes)[array.reshape(-1)]
```

Now you will load the images to local storage.  Some images are displayed to confirm the code ran correctly.  This may take a couple of minutes to run.

```python
# To help the model to converge faster , you shrink the intensity values (X) from 0-255 to 0-1
X_train = load_data('./data/train-images.gz', False) / 255.0
y_train = load_data('./data/train-labels.gz', True).reshape(-1)

X_test = load_data('./data/test-images.gz', False) / 255.0
y_test = load_data('./data/test-labels.gz', True).reshape(-1)

# Display some images...
%matplotlib inline
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

# now let's show some randomly chosen images from the traininng set.
count = 0
sample_size = 30
plt.figure(figsize = (16, 6))
for i in np.random.permutation(X_train.shape[0])[:sample_size]:
    count = count + 1
    plt.subplot(1, sample_size, count)
    plt.axhline('')
    plt.axvline('')
    plt.text(x=10, y=-10, s=y_train[i], fontsize=18)
    plt.imshow(X_train[i].reshape(28, 28), cmap=plt.cm.Greys)
plt.show()
```

If you have created an Azure Machine Learning service Workspace previously, run the code below to get a reference to it.  Replace the values in between the < and > with the appropriate value. You can get the values from the Overview screen of the Azure Machine Learning service Workspace in the Azure portal.

```python
# import package and use get function to access Workspace
# Be sure to replace the subscription id with your subscription id

from azureml.core import Workspace,Experiment ,Run

ws = Workspace.get(name='myworkspace',
                      subscription_id='<azure-subscription-id>', 
                      resource_group='myresourcegroup' 
                     )
```

If you do not have an Azure Machine Learning service Workspace already, you can create one with the code below. The value you need is the subscription ID. You can find it in the [subscriptions list in the Azure portal](https://ms.portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade). Find the subscription ID that you want to use and replace the `<azure-subscription-id>` below with the subscription ID value. The SDK will ask you to sign into your Azure account if you are not already signed in.  The location should be set to the closest Azure region for your area. 

```python
# Be sure to replace the subscription id with your subscription id

from azureml.core import Workspace
ws = Workspace.create(name='myworkspace',
                 subscription_id='<azure-subscription-id>', 
                 resource_group='myresourcegroup',
                 create_resource_group=True,
                 location='eastus2' 
                 )
```

It takes a few minutes to set up the workspace. After the workspace is set up, you can view the workspace details, such as the associated BLOB storage account, docker container registry account, and key vault, by entering the following code:

```python
ws.get_details()
```

Now, you create an experiment within this workspace using the following code:

```python
from azureml.core import Workspace,Experiment ,Run

#Create an experiment
experiment = Experiment(workspace = ws, name = "my-third-experiment")
```

## Define the machine learning objective and constraints

The first step is to define the machine learning objective, using AutoMLConfig, as shown below.

```python
from azureml.train.automl import AutoMLConfig
import logging

automl_config = AutoMLConfig(task = 'regression',
                             iteration_timeout_minutes = 6,
                             iterations = 3,
                             primary_metric = 'spearman_correlation',
                             n_cross_validations = 5,
                             debug_log = 'automl.log',
                             verbosity = logging.INFO,
                             X = X_train, 
                             y = y_train)

print('Execution Complete')
```

In the example, we are setting the properties below:

- task:  This is the type of model required such as classification, regression, or a forecasting. Once you specify the type AutoML will automatically pick the best algorithm of that type for you. The picture below shows a complete list of the algorithms that AutoML will pick. In this example, we chose to use a regression task.

![Screenshot of AutoML Property Selection](../media/4-automl-property.png)

- primary_metric: This is the metric that you want AutoML to optimize. In the regression example, there are several metrics: *normalized_root_mean_squared_error*, *r2_score*, *normalized_mean_absolute_error*, and *spearman_correlation*. In this example, we use spearman correlation as the primary metric, which basically measures the similarity of two datasets. For more information on how those metrics work, see the documentation [here](https://docs.microsoft.com/azure/machine-learning/service/how-to-configure-auto-train#explore-model-metrics).
- iterations_time_out_minutes: Iterations is how many model pipeline executions you want to use and the time limit for each iteration.
- n_cross_validation_splits: This is the number of cross validation splits.

It's that simple! You just need to specify other information such as the input data path, the input features and output value, and AutoML will pick the best algorithm and hyper parameters for you during the run. 

Depending on what you want to do there may be other AutoML properties you need to set but this example provides the basic idea.

## Launch the AutoML Process

After the objective and the constraints are defined, you can launch the AutoML job as shown below.  This can take several minutes to execute so please be patient.

```python
local_run = experiment.submit(automl_config, show_output = True)

print('Execution Complete')
```

And you will get the following output indicating the models used, the running time for each iteration, the current metrics, and the best metrics.

![Screenshot of AutoML Report](../media/4-automl-report.png)

## Retrieve the Best Model

Azure Machine Learning has a widget to show the information on each run. Using the code below, you can compare the best model across different iterations:

```python
from azureml.widgets import RunDetails
RunDetails(local_run).show()
```

![Screenshot of Retrieving the Best Model](../media/4-automl-retrieve-model.png)

Below you can see a visualization on the primary metric (in this case, spearman correlation) for each iteration, also included in the widget. The orange line below represents the best result for different iterations.

![Screenshot of Visualization of the Best Result for Different Iterations](../media/4-visualize-best-result.png)

It's obvious that the ninth run (the ensemble) has the best result. The best model can also be retrieved by running the following code:

```python
best_run, fitted_model = local_run.get_output()

print(best_run)
print(fitted_model)
```

After you get the best model, you can run the best model on the test dataset.