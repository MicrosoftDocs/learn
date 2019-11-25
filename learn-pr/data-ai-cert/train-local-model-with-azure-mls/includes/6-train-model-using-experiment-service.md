You learned that a *compute target* is the compute resource to run a training script or to host a service deployment. Here you will create an Azure Machine Learning Compute (AmlCompute) as the compute resource. An AmlCompute is a compute target optimized for machine learning workloads that's managed directly by Azure Machine Learning service. You don't need to connect or configure these targets - the system takes care of them for you.

The first step is to create a remote compute target:

```python
from azureml.core.compute import AmlCompute
from azureml.core.compute import ComputeTarget
import os

# Step 1: name the cluster and set the minimal and maximal number of nodes 
compute_name = os.environ.get("AML_COMPUTE_CLUSTER_NAME", "cpucluster")
min_nodes = os.environ.get("AML_COMPUTE_CLUSTER_MIN_NODES", 0)
max_nodes = os.environ.get("AML_COMPUTE_CLUSTER_MAX_NODES", 3)

# Step 2: choose environment variables 
vm_size = os.environ.get("AML_COMPUTE_CLUSTER_SKU", "STANDARD_D2_V2")

provisioning_config = AmlCompute.provisioning_configuration(
    vm_size = vm_size, min_nodes = min_nodes, max_nodes = max_nodes)

# create the cluster
compute_target = ComputeTarget.create(ws, compute_name, provisioning_config)

print('Compute target created')
```

## Retrieve the MNIST data

If you did not already do 'Exercise - Load the data for a simple logistic regression model', you will need to run the code below to get the data for this experiment.  

```python
import os
import urllib.request

#create a folder for the dataset
os.makedirs('./data', exist_ok = True)

# load dataset to the directory--as you can see, you must load train sets and test sets separately
urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz', filename='./data/train-images.gz')
urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz', filename='./data/train-labels.gz')
urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz', filename='./data/test-images.gz')
urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz', filename='./data/test-labels.gz')

print('Done')
```

## Load data and create a modeling script

Depending on the location and format of the data source, there are various ways to pipe data into the model. For example, we can use the created `Workspace` object to obtain the default datastore and upload the data into Azure Blob storage.

```python
#upload data by using get_default_datastore()
ds = ws.get_default_datastore()
ds.upload(src_dir='./data', target_path='mnist', overwrite=True, show_progress=True)

print('Done')
```

> [!IMPORTANT]
> If you have more than 300 MB of content or 2000 files in the current notebook folder, you might get the following error:
>
> ![Screenshot of error when you the current folder has > 300 MB.](../media/6-experiment_over300mberror.png)
>
> This happens because Azure Machine Learning runs training scripts by copying the entire script folder to the target compute context, and then takes a snapshot. The storage limit for experiment snapshots is 300 MB and/or 2000 files.
>
> There are a number of ways to resolve this issue.  If you don't need all the files and can work within the default space constraints, the easiest solution is to exit the notebook, create a new folder with only what you need, open that folder and create the notebook there. On a local machine, you can stop the Jupyter Notebook service, change to the new folder at a command prompt and restart Jupyter Notebook.  On Azure Notebook, just create a new project and copy what you need to it. Then create your notebook there.  
>
> If you cannot get the data within the constraints, then read through [the documentation](https://docs.microsoft.com/azure/machine-learning/service/how-to-save-write-experiment-files#limits) to explore other options.

Then you create a directory to save your training Python code:

```python
import os

# create the folder
folder_training_script = './trial_model_mnist'
os.makedirs(folder_training_script, exist_ok=True)

print('Done')
```

Finally, let's prepare our model training script (note that in this script, you are defining two parameters):

- The first parameter is for finding the data in the cloud or for setting the path to the data.
- The other parameter is the **regularization** parameter in the algorithm.

```python
%%writefile $folder_training_script/train.py

import argparse
import os
import numpy as np
import glob

from sklearn.linear_model import LogisticRegression
from sklearn.externals import joblib

from azureml.core import Run
# from utils import load_data

import gzip
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


# let user feed in 2 parameters, the dataset to mount or download, and the regularization rate of the logistic regression model
parser = argparse.ArgumentParser()
parser.add_argument('--data-folder', type=str, dest='data_folder', help='data folder mounting point')
parser.add_argument('--regularization', type=float, dest='reg', default=0.01, help='regularization rate')
args = parser.parse_args()

###
data_folder = os.path.join(args.data_folder, 'mnist')
print('Data folder:', data_folder)

# load the train and test set into numpy arrays
X_train = load_data(os.path.join(data_folder, 'train-images.gz'), False) / 255.0
X_test = load_data(os.path.join(data_folder, 'test-images.gz'), False) / 255.0

#print variable set dimension
print(X_train.shape, X_test.shape, sep = '\n')

y_train = load_data(os.path.join(data_folder, 'train-labels.gz'), True).reshape(-1)
y_test = load_data(os.path.join(data_folder, 'test-labels.gz'), True).reshape(-1)

#print the response variable dimension
print( y_train.shape, y_test.shape, sep = '\n')

# get hold of the current run
run = Run.get_context()

print('Train a logistic regression model with regularization rate of', args.reg)
clf = LogisticRegression(C=1.0/args.reg, solver="liblinear", multi_class="auto", random_state=42)
clf.fit(X_train, y_train)

print('Predict the test set')
y_hat = clf.predict(X_test)

# calculate accuracy on the prediction
acc = np.average(y_hat == y_test)
print('Accuracy is', acc)

run.log('regularization rate', np.float(args.reg))
run.log('accuracy', np.float(acc))

os.makedirs('outputs', exist_ok=True)
# note file saved in the outputs folder is automatically uploaded into experiment record
joblib.dump(value=clf, filename='outputs/sklearn_mnist_model.pkl')
```

Notice that the last line of the training script saves the model as a pickle file in the outputs folder of the experiment workspace.  You use this pickle file later to deploy the model.

 An estimator object is used to submit the run. Create your estimator by running the following code to define:

- The name of the estimator object, `est`.
- The directory that contains your scripts. All the files in this directory are uploaded into the cluster nodes for running.
- The compute target. In this case, you use the Azure Machine Learning compute cluster that you created.
- The training script name, **train.py**.
- Parameters that the training script requires.
- Python packages that are necessary for training.

```python
from azureml.train.sklearn import SKLearn

script_params = {
    '--data-folder': ds.as_mount(),
    '--regularization': 0.5
}

#import the Scikit-learn package 
est = SKLearn(source_directory=folder_training_script,
                script_params=script_params,
                compute_target=compute_target,
                entry_script='train.py',
                conda_packages=['scikit-learn'])
```

## Submit the model, monitor the run, and retrieve the results

We need to create an Experiment to run the model training in.

```python
from azureml.core import Experiment

#Create an experiment
experiment = Experiment(workspace = ws, name = "amls-learn-experimentnew5")

print('Experiment created')
```

The last step is running the model. Sign in with your Azure account if prompted to do so.

```python
run = experiment.submit(config=est)
run
```

You can see the running experiment in the portal:

![The screenshot depicts the my-first-experiment status as Queued.](../media/7-experiment-status.png)

You could use the widgets module from the **azureml** package to monitor your run:

```python
# monitor the run
from azureml.widgets import RunDetails

RunDetails(run).show()
```

The following screenshot depicts the status when remote resources are running.

![The screenshot depicts a remotely running job.](../media/7-job-running.png)

The following screenshot depicts the status of the completed job. Highlighted in the red box, you can see that you got the same results as you did earlier on the local machine.

![The screenshot depicts a remotely completed job.](../media/7-job-completion.png)

After this run finishes, you can print the results. The results were logged because you wrote the code in the training script.

```python
#get the result
print(run.get_metrics())
```
