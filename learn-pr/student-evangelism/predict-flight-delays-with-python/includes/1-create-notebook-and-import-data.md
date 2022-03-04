The first order of business is to create a new Azure notebook. Azure notebooks are contained in projects, whose primary purpose is to group related notebooks. In this unit, you'll create a new project and then create a notebook inside it.

1. Navigate to [https://notebooks.azure.com](https://notebooks.azure.com/?azure-portal=true) in your browser 

1. Sign in using your Microsoft account. 

1. Click **My Projects** in the menu at the top of the page.

1. Click the **+ New Project** button at the top of the "My Projects" page.

1. Create a new project named "ML Notebooks" or something similar. You may uncheck the "Public" box if you'd like, but making the project public allows the notebooks in it to be shared with others through links, social media, or e-mail. If you're unsure which to choose, you can easily change a project to public or private later on.

    ![Creating a project.](../media/1-add-project.png)

    _Creating a project_

1. Click **+ New** and select **Notebook** from the menu to add a notebook to the project.

    ![Adding a notebook to the project.](../media/1-add-notebook-1.png)

    _Adding a notebook to the project_

1. Give the notebook a name such as "On-Time Flight Arrivals.ipynb," and select **Python 3.6** as the language. This will create a notebook with a Python 3.6 kernel for executing Python code. One of the strengths of Azure notebooks is that you can use different languages by choosing different kernels.

    ![Creating a notebook.](../media/1-add-notebook-2.png)

    _Creating a notebook_

    If you're curious, the **.ipynb** file-name extension stands for "IPython notebook." Jupyter notebooks were originally known as IPython (Interactive Python) notebooks, and they only supported Python as a programming language. The name Jupyter is a combination of Julia, Python, and R — the core programming languages that Jupyter supports.

1. Click the notebook to open it for editing.

    ![Opening the notebook.](../media/1-open-notebook.png)

    _Opening the notebook_

You can create additional projects and notebooks as you work with Azure Notebooks. You can create notebooks from scratch, or you can upload existing notebooks.

Jupyter notebooks are highly interactive, and since they can include executable code, they provide the perfect platform for manipulating data and building predictive models from it.

1. Enter the following command into the first cell of the notebook:

    ```bash
    !curl https://topcs.blob.core.windows.net/public/FlightData.csv -o flightdata.csv
    ```

    > [!TIP]
    > `curl` is a Bash command. You can execute Bash commands in a Jupyter notebook by prefixing them with an exclamation mark. This command downloads a CSV file from Azure blob storage and saves it using the name **flightdata.csv**.

1. Click the **Run** button to execute the `curl` command.

    ![Importing a dataset.](../media/1-import-dataset.png)

    _Importing a dataset_

1. In the notebook's second cell, enter the following Python code to load **flightdata.csv**, create a [Pandas DataFrame](https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.html) from it, and display the first five rows.

    ```python
    import pandas as pd

    df = pd.read_csv('flightdata.csv')
    df.head()
    ```

1. Click the **Run** button to execute the code. Confirm that the output resembles the output below.

    ![Loading the dataset.](../media/1-load-dataset.png)

    _Loading the dataset_

    The **DataFrame** that you created contains on-time arrival information for a major U.S. airline. It has more than 11,000 rows and 26 columns. (The output says "5 rows" because DataFrame's [head](https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.head.html) function only returns the first five rows.) Each row represents one flight and contains information such as the origin, the destination, the scheduled departure time, and whether the flight arrived on time or late. We'll look at the data more closely a bit later in this module.

1. Use the **File** -> **Save and Checkpoint** command to save the notebook.

Use the horizontal scroll bar to scroll left and right and view all the columns in the dataset. How many columns does the dataset contain? Can you guess what each column represents from the column names?