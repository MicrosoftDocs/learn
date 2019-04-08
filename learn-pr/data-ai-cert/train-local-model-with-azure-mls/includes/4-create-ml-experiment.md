You may notice that, depending on your local machine capacity, it takes a long time to fit models with parameters of different values, or to find k that returns best results. In this case, you should try to run the model on a remote cluster.

## Run and Experiment Overview

Before you begin, it is imperative to familiarize ourselves with two concepts: run and experiment.

**Run**, within the context of the Azure Machine Learning service, refers to Python code for a specific task, for example, training a model or tuning hyperparameters (we'll define this in a moment). Run does the job of logging metrics and upload result to Azure platform, it's a more natural way to keep track of jobs in your Workspace.

**Experiment** is a term referring to a composition of a series of runs. In the example, you have one run for the logistic regression model and another for the KNN model, and together they make up an experiment for you to compare results.

## Create an Experiment

Let's run the code below to get the module's loaded.

```python
# Add this to top of code...
%matplotlib inline
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

import azureml
from azureml.core import Workspace, Run

# check core SDK version number
print("Azure ML SDK Version: ", azureml.core.VERSION)
```

If you have created an Azure Machine Learning service Workspace previously, run the code below to get a reference to it.  Replace the `<azure-subscription-id>` with the id from the Overview screen of the Azure Machine Learning service Workspace in the Azure portal.

You may be prompted in the notebook output to log into Azure with a provided link.  The login code will be provided in the output as well.  Follow the link and enter the code to login. 

```python
ws = Workspace.get(name='myworkspace',
                      subscription_id='<azure-subscription-id>', 
                      resource_group='myresourcegroup' 
                     )
```

If you do not have an Azure Machine Learning service Workspace already, you can create one with the code below. The value you need is the subscription ID. You can find it in the [subscriptions list in the Azure portal](https://ms.portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade). Find the subscription ID that you want to use and replace the `<azure-subscription-id>` below with the subscription ID value. The SDK will ask you to sign into your Azure account if you are not already signed in.

```python
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

Now, you create an experiment and a run within this workspace using the following code:

```python
#Create an experiment
experiment = Experiment(workspace = ws, name = "my-first-experiment")
#Create a run
run = experiment.start_logging()
run.log("trial",1)
run.complete()
print('Code executed')
```

View logged results

When the run finishes, you can view the experiment run in the Azure portal. To print a URL that navigates to the results for the last run, use the following code:

```python
print(run.get_portal_url())
```

Use the link to view the logged values in the Azure portal in your browser.

![Screenshot of Experiment Result](../media/5-experiment-result.png)