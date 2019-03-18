Although you can use any Python IDE to program the Azure Machine Learning service, we're going to use Azure Notebooks because it has the required Python modules pre-installed. If you haven't already setup Azure Notebooks with your Azure account, we'll walk through the process as part of this unit.

## What are Azure Notebooks?

Azure Notebooks is a free hosted service to develop and run Jupyter notebooks in the cloud with no installation. Jupyter (formerly IPython) is an open source project that lets you easily combine markdown text, executable code (Python, R, and F#), persistent data, graphics, and visualizations onto a single, sharable canvas called a _notebook_.

## Sign in to Azure Notebooks

Let's get started with Azure Notebooks.

1. Navigate to [https://notebooks.azure.com](https://notebooks.azure.com/?azure-portal=true) in your browser.

1. Sign in using your Microsoft account. 

## Create a Notebook

1. Click **My Projects** in the top menubar.

1. Click **+ New Project**. Enter "Regression Model" (without quotation marks) for the project name and "regression model" as the project ID. Uncheck the **Public project** box, and then click **Create**.

1. Click the **+** sign to add a notebook to the project.

1. Name the notebook "regressionmodel.ipynb" and select **Python 3.6 Notebook** as the item type. This will create a notebook with a Python 3.6 kernel. One of the strengths of Jupyter notebooks is that you can use different languages by choosing different kernels.

    If you're curious, the **.ipynb** file-name extension stands for "IPython notebook." Jupyter notebooks were originally known as IPython (Interactive Python) notebooks, and they only supported Python as a programming language. The name Jupyter is a combination of Julia, Python, and R — the core programming languages that Jupyter supports.

1. Click the new notebook. This will launch the notebook and allow you to start editing it.

> [!TIP]
> You can create additional projects and notebooks as you work with Azure Notebooks. Projects provide a means for grouping related notebooks. You can create notebooks from scratch, or you can upload existing notebooks. In the next unit, you'll build a notebook from scratch and learn the basics of working with cells.

## Add Python code to retrieve the data

In the notebook, paste in and run the following code to get the MNIST dataset.

```python
# import packages
import os
import urllib.request

#create a fold for the dataset
os.makedirs('./data', exist_ok = True)
# load dataset to the directory, as you can see, you need to load train sets and test sets seperately 
urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz', filename='./data/train-images.gz')
urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz', filename='./data/train-labels.gz')
urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz', filename='./data/test-images.gz')
urllib.request.urlretrieve('http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz', filename='./data/test-labels.gz')

print('Code executed')
```

Now run the code below to split the data into training and test sets.

```python
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

# load the data...

# To help the model to converge faster , you shrink the intensity values (X) from 0-255 to 0-1
X_train = load_data('./data/train-images.gz', False) / 255.0
y_train = load_data('./data/train-labels.gz', True).reshape(-1)

X_test = load_data('./data/test-images.gz', False) / 255.0
y_test = load_data('./data/test-labels.gz', True).reshape(-1)

print('Code executed')
```

Now let's display some images from the dataset. This may take a couple of minutes to run.

```python
%matplotlib inline
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

Here is an example of the dataset. The numbers on top are the labels, and the handwritten pictures are in the second row.

![Screenshot of Hard-written picture Example](../media/2-hand-written.png)