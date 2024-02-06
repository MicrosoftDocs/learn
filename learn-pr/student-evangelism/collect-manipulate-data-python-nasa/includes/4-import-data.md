You now have a goal: *Is a launch likely to happen given specific weather conditions?* You have a data set that contains weather data from:

- Several successful launches
- One pushed launch day
- The days leading up to and following each launch

Now you can start to code!

## Machine learning in code

You can use various tools and services to solve machine learning problems. These space-themed learning paths use Visual Studio Code, Python, scikit-learn, and Azure.

Watch this Microsoft video to learn how to download and configure a similar environment to the one you'll need.

> [!VIDEO https://channel9.msdn.com/Series/Dev-Intro-to-Data-Science/How-do-you-setup-your-local-environment-for-data-exploration-8-of-28/player?format=ny]

When you're setting up your local programming environment, we recommend creating an Anaconda environment to ensure you have exactly what you need for that project. You can use your preferred method or set of tools. Most of these modules don't explicitly require Visual Studio Code or Azure.

## Set up the local environment

Before continuing, be sure that you have:

- [Visual Studio Code](https://aka.ms/LearnOnVSCode?azure-portal=true), [Anaconda](https://www.anaconda.com/products/individual), and [Python](https://www.python.org/downloads/) installed. (We'll create our Anaconda environment in the steps below).
- A local folder you created to store all of the code and data.
- The [Excel file](https://github.com/MicrosoftDocs/mslearn-collect-manipulate-data-python-nasa/blob/main/DATA/NASA/RocketLaunchDataCompleted.xlsx?azure-portal=true) of our data downloaded and saved to your local folder.
- A blank Jupyter notebook saved in the folder. (In your local folder, create a dummy file called *yourfilename*.ipynb).

To set up your local environment:

1. Open the Anaconda prompt.

    :::image type="content" source="../media/anaconda-prompt.png" alt-text="Screenshot that shows the Anaconda prompt." loc-scope="Azure":::

3. In the Anaconda prompt, create a new Anaconda environment with Pandas, NumPy, scikit-learn, PyDotPlus, and Jupyter:  

    ```bash
    conda create -n myenv python=3.8 pandas numpy jupyter seaborn scikit-learn pydotplus
    ```

4. In the Anaconda prompt, activate the new environment:  

    ```bash
    conda activate myenv
    ```

5. In the Anaconda prompt, install AzureML-SDK:  

    ```bash
    pip install --upgrade azureml-sdk
    ```
    In some cases, the install can take several minutes to complete. Let it resolve until it does.

6. In the Anaconda prompt, install an Excel reader (note that xlrd might not work with the Excel data file you downloaded):

    ```bash
    pip install openpyxl
    ```

7. In Visual Studio Code, open the local folder you created to store all of the code and data. Select both the upper-right Jupyter kernel Python version and the lower-left Python interpreter, and set them both to use your Anaconda environment:

    :::image type="content" source="../media/ensure-python.png" alt-text="Screenshot that shows Visual Studio Code with the Anaconda environment." loc-scope="Azure":::

## Import libraries

With your Visual Studio Code local environment created, you can now import the libraries. They'll help us import and clean the weather data, and create and test the machine learning model.

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

Now that we have all of the libraries imported, we can use the pandas library to import our data. Use the command `pd.read_excel` to read the data and save it in a variable. Then, use the `.head()` function to print the first five rows of the data to ensure that we have read everything correctly.

```python
launch_data = pd.read_excel('RocketLaunchDataCompleted.xlsx')
launch_data.head()
```

## Begin exploring data

Finally, we can use the `.columns` function call to view all columns in our data. Doing so shows us the attributes that the data has. You'll see some common attributes like names of past rockets that were scheduled to launch, the dates they were scheduled, whether they actually launched, and more. Look at these columns and try to guess which ones will have the greatest effect in determining whether a rocket will launch.

```python
launch_data.columns
```