You learned that a compute target is the compute resource used to run a training script or host service deployment. Here you create an Azure Machine Learning Compute (AmlCompute) as our compute resource. The first step is to create a remote compute target

```python
from azureml.core.compute import AmlCompute
from azureml.core.compute import ComputeTarget
import os

# Step 1: name the cluster, set minimal and maximal number of nodes 
compute_name = os.environ.get("AML_COMPUTE_CLUSTER_NAME", "cpucluster")
min_nodes = os.environ.get("AML_COMPUTE_CLUSTER_MIN_NODES", 0)
max_nodes = os.environ.get("AML_COMPUTE_CLUSTER_MAX_NODES", 3)

# Step 2: choose environment variables 
vm_size = os.environ.get("AML_COMPUTE_CLUSTER_SKU", "STANDARD_D2_V2")


provisioning_config = AmlCompute.provisioning_configuration(vm_size = vm_size,
                                                                min_nodes = min_nodes, 
                                                                max_nodes = max_nodes)

# create the cluster
compute_target = ComputeTarget.create(ws, compute_name, provisioning_config)
print('Code executed')
```

## Load Data and Create the Modeling Script

Depending on the location and format of the data source, there are various ways to pipe data into the model. In this example, you upload the data to Azure portal using the code below.

```python
#upload data using get_default_datastore()
ds = ws.get_default_datastore()

ds.upload(src_dir='./data', target_path='mnist', overwrite=True, show_progress=True)
print('Code executed')
```

Then you create a directory to save our training Python code.

```python
#import os if you haven't done so
import os

#create folder
folder_training_script= './trial_model_mnist'
os.makedirs(folder_training_script, exist_ok=True)
```

Finally, let's prepare our model training script. Note that in this script, you are defining three parameters. The first parameter is for finding the data stored on the cloud, or for the path. The other two parameters are used to define the parameter k in the kNN algorithm. 'kmax' limits the maximum value of k, and 'kinterval' decides the interval between each k.

```python
%%writefile $folder_training_script/train.py

# functions needed by downstream code...

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
#

# end of functions needed by downstream code...

import argparse
import os
import numpy as np

from sklearn.linear_model import LogisticRegression
from sklearn.externals import joblib

from azureml.core import Run
# from utils import load_data

# let user feed in 2 parameters, the location of the data files (from datastore), and the regularization rate of the logistic regression model
parser = argparse.ArgumentParser()
parser.add_argument('--data-folder', type=str, dest='data_folder', help='data folder mounting point')
parser.add_argument('--regularization', type=float, dest='reg', default=0.01, help='regularization rate')
args = parser.parse_args()

data_folder = os.path.join(args.data_folder, 'mnist')
print('Data folder:', data_folder)

# load train and test set into numpy arrays
# note we scale the pixel intensity values to 0-1 (by dividing it with 255.0) so the model can converge faster.
X_train = load_data(os.path.join(data_folder, 'train-images.gz'), False) / 255.0
X_test = load_data(os.path.join(data_folder, 'test-images.gz'), False) / 255.0
y_train = load_data(os.path.join(data_folder, 'train-labels.gz'), True).reshape(-1)
y_test = load_data(os.path.join(data_folder, 'test-labels.gz'), True).reshape(-1)
print(X_train.shape, y_train.shape, X_test.shape, y_test.shape, sep = '\n')

# get hold of the current run
run = Run.get_context()

print('Train a logistic regression model with regularizaion rate of', args.reg)
clf = LogisticRegression(C=1.0/args.reg, random_state=42)
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

print('Code executed')
```

Now, you must add a utils script as shown below for loading data and to create an estimator so that it's easier to scale our work in the future. An estimator object is used to submit the run. Create your estimator by running the following code to define these items:

- The name of the estimator object, est.
- The directory that contains your scripts. All the files in this directory are uploaded into the cluster nodes for execution.
- The compute target. In this case, you use the Azure Machine Learning compute cluster you created.
- The training script name, **train.py**.
- Parameters required from the training script.
- Python packages needed for training.

```python
from azureml.train.estimator import Estimator

script_params = {
    '--data-folder': ds.as_mount(),
    '--regularization': 0.8
}

#import scikit-learn package 
est = Estimator(source_directory=folder_training_script,
                script_params=script_params,
                compute_target=compute_target,
                entry_script='train.py',
                conda_packages=['scikit-learn'])

```

## Submit Model, Monitor Run, and Retrieve Results

The last step is running the model. Sign in with your Azure account if you're asked.

```python
#run
run = experiment.submit(config=est)
run

print('Code executed')
```

![Screenshot of Experiment Status](../media/7-experiment-status.png)

You could use widgets module from 'azureml' package to monitor our run.  It can take up to ten minutes for the experiment to process.

```python
# monitor the run
from azureml.widgets import RunDetails
RunDetails(run).show()
```

This Screenshot shows the status when the remote resources are running.

![Screenshot of Job Running](../media/7-job-running.png)

This Screenshot shows the status of the job completed. Highlighted in the red box, you can see that you got the same results as you did earlier in the local machine.

![Screenshot of Job Running](../media/7-job-completion.png)

After this run finishes, you can print the results. The results were logged since you wrote the code in the training script.

```python
#get result
print(run.get_metrics())
```

### Clean up resources

If you are going to continue with this Learning Path, don't run the code below.  If you are done and do not plan to continue with the other modules, you can run the code below to delete the Azure Machine Learning service resources you created. 

```python
      ws.delete(delete_dependent_resources=True)
```