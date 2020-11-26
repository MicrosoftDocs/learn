In *Space Jam: A New Legacy* we see NBA star LeBron James, passionate about basketball and his son, Dom, passionate about digital technology. Inspired by their passions that are seemingly so different, we're going to dive into how coding can play a role in basketball, particularly in understanding players based on their stats.

Before jumping into the module, be sure to make sure your environment is setup and ready to go. For this module, you will need a coding editor (we use Visual Studio Code), Python, and Jupyter notebooks (we use the Python extension for Visual Studio Code).

If you haven't yet installed Visual Studio Code, you can find guides on the [Visual Studio Code Learn to Code site](https://aka.ms/LearnOnVSCode?azure-portal=true). Here, you can also find a Coding Pack for Python for Windows that will install everything you need for this module. If you're not on Windows, you can find a guide for setting up your environment on the [Data Science in Visual Studio Code docs page](https://code.visualstudio.com/docs/python/data-science-tutorial?azure-portal=true).

## Set up Visual Studio Code with a new Jupyter file

Once you have your environment setup, you should create a folder called space-jam-anl wherever you store code on your computer. This can be anywhere, for example, on your Desktop. 

![New space-jam-anl folder created on the Desktop](../media/new-folder.png)

Open Visual Studio Code, and from the Welcome tab, click "Open Folder". You can also do this by clicking File -> Open... and navigating to the folder you just created.

![Open the space-jam-anl folder in Visual Studio Code](../media/open-folder.png)

Create a new file in the space-jam-anl folder called space-jam-anl.ipynb by clicking on the new file icon next to the folder name in the Explorer.

![Create the space-jam-anl.ipynb file in Visual Studio Code](../media/new-file.png)

Make sure the file opens into a notebook and that the Jupyter server is connected and the kernel is pointing to the desired Python version.

![Screenshot of Visual Studio Code showing the space-jam-anl.ipynb file loaded.](../media/jupyter-file.png)

## Download data with basketball stats

Next, you will need some data. While you can gather data on your own, we have gathered data from 47 anonymous basketball players to use throughout this module. You can download the data by heading to the [player_data.csv on GitHub](https://aka.ms/LearnWithDrG/SpaceJamANewLegacy/Data1?azure-portal=true) and downloading the CSV file. Make sure you save the data in a file called player_data.csv and save it in the space-jam-anl folder you just created.

Visual Studio Code should show you this data if you click on the CSV file.

![Viewing the CSV file in Visual Studio Code](../media/csv-in-visual-studio-code.png)

## Check local setup with Python libraries

Now that you have your local environment and data ready to go, you should check to make sure everything is setup properly.

In the top cell of the space-jam-anl.ipynb file, import the Pandas library as pd. This will allow you to call Pandas functions using `pd.`.

```python
import pandas as pd
```

If that completes, successfully, you should see a [1] next to the cell and no output.

![Showing a successful Pandas import in Visual Studio Code](../media/successful-pandas-import.png)

Next, you will make sure you can import the data into your coding environment by using the Pandas function `read_csv`. 

```python
# Import data from the CSV file to a DataFrame.
player_df = pd.read_csv('player_data.csv')
```

If that us successful, you should see a [2] next to the cell and no output.

![Showing a successful data import in Visual Studio Code](../media/successful-data-import.png)

Now you're ready to start exploring and cleansing your data!

© 2020 Warner Bros. Ent. All Rights Reserved