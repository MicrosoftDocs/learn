You now have a goal: *Is a launch likely to happen given specific weather conditions?* You have a data set that contains weather data from successful launches and one pushed launch day, as well as the days leading up to and following each launch. Now you can start to code!

## Machine learning in code

You can use various tools and services to solve machine learning problems. These space-themed learning paths use Visual Studio Code, Python, scikit-learn, and Azure.

Watch this Microsoft video to learn how to download and configure a similar environment to the one you'll need.

> [!VIDEO https://www.youtube.com/embed/5E3WMb8_T3s]

When you're setting up your local programming environment, we recommend creating an Anaconda environment to ensure you have exactly what you need for that project. If you have another way or set of tools that you prefer to use, the majority of these modules don't explicitly require Visual Studio Code or Azure.

## Set up the local environment

Before continuing, be sure that you have:

- Visual Studio Code installed with the Python and Jupyter Notebook extensions.
- An Anaconda environment with Pandas, NumPy, scikit-learn, PyDotPlus, and Azure Machine Learning SDK.
- A folder to store all of the code and data.
- The data downloaded and saved to the folder.
- A blank Jupyter notebook saved in the folder.
- The folder open in Visual Studio Code.
- The Visual Studio Code Python environment set to the Anaconda environment.

To set up your local environment:

1. Install [Anaconda](https://www.anaconda.com/products/individual?azure-portal=true)

2. Open the Anaconda prompt.

    :::image type="content" source="../media/anaconda-prompt.png" alt-text="Screenshot that shows the Anaconda prompt." loc-scope="Azure":::

3. In the Anaconda prompt, create a new Anaconda environment:  

    ```bash
    conda create -n myenv python=3.7 pandas numpy jupyter seaborn scikit-learn pydotplus
    ```

4. In the Anaconda prompt, activate the new environment:  

    ```bash
    conda activate myenv
    ```

5. In the Anaconda prompt, install AzureML-SDK:  

    ```bash
    pip install --upgrade azureml-sdk
    ```

6. In the Anaconda prompt, install an Excel reader:

    ```bash
    pip install xlrd
    ```

7. Open the folder in Visual Studio Code.  Select both the upper-right Jupyter kernel Python version and the lower-left Python interpreter, and set them both to use the Anaconda environment:  

    :::image type="content" source="../media/ensure-python.png" alt-text="Screenshot that shows Visual Studio Code with the Anaconda environment." loc-scope="Azure":::

## Import libraries

With your Visual Studio Code local environment set up, you can now import the libraries. They'll help us import and clean the weather data, and create and test the machine learning model.

Copy the following code into a cell and run it to import the libraries.

```python
# Pandas library is used for handling tabular data
import pandas as pd
# NumPy is used for handling numerical series operations (addition, multiplication, and ...)
import numpy as np
# Sklearn library contains all the machine learning packages we need to digest and extract patterns from the data
from sklearn import linear_model, model_selection, metrics
from sklearn.model_selection import train_test_split

# Machine learning libraries used to build a decision tree
from sklearn.tree import DecisionTreeClassifier
from sklearn import tree

# Sklearn's preprocessing library is used for processing and cleaning the data 
from sklearn import preprocessing

# for visualizing the tree
import pydotplus
from IPython.display import Image 
```

## Read data into a variable

Now that we have all of the libraries imported, we can use the pandas library to import our data. Use the command `pd.read_excel` to read the data and save it in a variable. Then, use the `.head()` function to print out the first five rows of the data. This will ensure that we have read everything correctly.

```python
launch_data = pd.read_excel('RocketLaunchDataCompleted.xlsx')
launch_data.head()
```

## Begin exploring data

Finally, we can use the `.columns` function call to view all of the columns in our data. This will show us the attributes that the data has. You'll see some common attributes like names of past rockets that were scheduled to launch, the dates they were scheduled, if they actually launched, and many more. Look at these columns and try to guess which ones will have the greatest impact on determining if a rocket will launch.

```python
launch_data.columns
```