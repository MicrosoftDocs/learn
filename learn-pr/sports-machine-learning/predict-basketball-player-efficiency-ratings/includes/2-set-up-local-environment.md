In *Space Jam: A New Legacy* we see basketball star LeBron James in contrast to his son, Dom, who is passionate about digital technology. With those seemingly different passions in mind, you'll now dive into how coding can play a role in basketball, particularly in understanding players based on their stats.

Before jumping into the module, make sure your environment is set up and ready to go. You'll need a coding editor (we use Visual Studio Code), Python, and Jupyter notebooks. If you're using Visual Studio Code, make sure you have the Python extension installed.

If you haven't yet installed Visual Studio Code, you can find guides on the Visual Studio Code [Learn to Code site](https://aka.ms/LearnOnVSCode?azure-portal=true). On the site, you can also find a Python coding pack for Windows that will install everything you need for this module. If you don't use Windows and you want a guide to help you set up your environment, see [Data science in Visual Studio Code](https://code.visualstudio.com/docs/python/data-science-tutorial?azure-portal=true).

## Create a new Jupyter file in Visual Studio Code

After you set up your environment, create a folder called *space-jam-anl* wherever you store code on your computer. For example, you can place the folder on your desktop: 

:::image type="content" source="../media/new-folder.png" alt-text="Screenshot showing the new space-jam-anl folder created on the desktop.":::

Open Visual Studio Code. Then on the **Welcome** tab, select **Open Folder**. You can also open the folder by selecting **File** > **Open** and then going to the folder you created.

:::image type="content" source="../media/open-folder.png" alt-text="Screenshot showing the open space-jam-anl folder in Visual Studio Code.":::

In the **Explorer**, select the **New File** icon next to the *space-jam-anl* folder, and then create a new file called *space-jam-anl.ipynb*.

:::image type="content" source="../media/new-file.png" alt-text="Screenshot showing where to create the new file in Visual Studio Code.":::

Make sure that the file opens in a notebook, that the Jupyter server is connected, and that the kernel points to the correct Python version.

:::image type="content" source="../media/jupyter-file.png" alt-text="Screenshot of Visual Studio Code, showing the loaded file.":::

## Download data for basketball players

Next, you need some data. You can gather data on your own, but in this module you'll use data we gathered from 46 anonymous basketball players. Download the CSV file at [*player_data.csv* on GitHub](https://aka.ms/LearnWithDrG/Basketball/Data1?azure-portal=true). Save the *player_data.csv* file in your *space-jam-anl* folder.

Select the CSV file to see the data in Visual Studio Code.

:::image type="content" source="../media/csv-in-visual-studio-code.png" alt-text="Screenshot showing the CSV file in Visual Studio Code.":::

## Check the local setup with Python libraries

Now that your local environment and data are ready to go, make sure everything is set up properly.

In the top cell of the *space-jam-anl.ipynb* file, import the pandas library as `pd`. This setting allows you to call pandas functions by using `pd.`.

```python
import pandas as pd
```

If that command finishes successfully, you should see **[1]** next to the cell and no output.

:::image type="content" source="../media/successful-pandas-import.png" alt-text="Screenshot showing a successful pandas import in Visual Studio Code.":::

Next, make sure you can import the data into your coding environment by using the pandas function `read_csv`. 

```python
# Import data from the CSV file to a pandas DataFrame.
player_df = pd.read_csv('player_data.csv')
```

If that command succeeds, you should see **[2]** next to the cell and no output.

:::image type="content" source="../media/successful-data-import.png" alt-text="Screenshot showing a successful data import in Visual Studio Code.":::

Now you're ready to start exploring and cleansing your data.

© 2020 Warner Bros. Ent. All Rights Reserved.