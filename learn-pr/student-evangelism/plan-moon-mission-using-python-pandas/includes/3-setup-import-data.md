Now it's time to get data from the [Lunar Sample and Photo Catalog](https://curator.jsc.nasa.gov/lunar/samplecatalog/index.cfm?azure-portal=true) into Visual Studio Code. By doing so, you can use Python to quickly gain insight from the thousands of samples collected across the six Apollo missions that have landed on the Moon. 

## Set up your local environment

This module will show you how to cleanse and manipulate data related to Moon rock samples. To do this, you need to set up some kind of Python notebook development environment. If you haven't done this before, we recommend following the steps we present here. The easiest way to do this is to follow the [Visual Studio Code data science setup docs](https://code.visualstudio.com/docs/python/data-science-tutorial?azure-portal=true). 

The three things you need to set up first are:
- Visual Studio Code
- Python
- Miniconda

> [!NOTE]
> If you have already completed one of the *Over the Moon* Learn modules, you can open your *over-the-moon* folder in Visual Studio Code and skip to step 3. 

After you have installed the three previously listed items, follow these steps to get your environment ready:
1. Create a folder called *over-the-moon*. 
2. Open the folder in Visual Studio Code.
3. Create a folder inside that folder called *sample-return*.
4. Create a folder inside that folder called *data*.
5. Create a file called *sample-return.ipynb* in the *sample-return* folder.
6. Open the *sample-return.ipynb* file in Visual Studio Code.

> [!NOTE]
> Make sure you are using the conda environment that you set up earlier.

Your environment should look like this: 

:::image type="content" source="../media/vscode-sample-return.png" alt-text="Screenshot that shows an example of a local Visual Studio Code environment.":::

## Collect and import data

The data that you'll explore during this module is a file full of all the samples collected from the six Apollo missions that landed on the Moon. The [*rocksamples.csv*](https://aka.ms/LearnWithDrG/OverTheMoon/Data2?azure-portal=true) file was created using information from the [Lunar Sample and Photo Catalog](https://curator.jsc.nasa.gov/lunar/samplecatalog/index.cfm?azure-portal=true). 

Download the [*rocksamples.csv*](https://aka.ms/LearnWithDrG/OverTheMoon/Data2?azure-portal=true) file and save it to your data folder.

> [!TIP]
> To download a CSV file in GitHub:
> 1. In the list of files in the GitHub repository, select the file.
> 1. In the upper-right corner, select **Raw**. The file opens as a raw CSV file in your browser.
> 1. Right-click anywhere in the browser window, and then select **Save as**.
> 1. In the **File save as** dialog box, you can choose the file name (*rocksamples*), the file type (*CSV*), and where to download the file to (your project data folder).
>

After you download the CSV file and save it to your data folder, your Visual Studio Code environment should look like this:

:::image type="content" source="../media/vscode-data.png" alt-text="Screenshot that shows an example of a local environment folder structure with data.":::

In the first Python cell in your *sample-return.ipynb* file, import pandas and read the data file in it as a pandas DataFrame:

```python
import pandas as pd 

rock_samples = pd.read_csv('data/rocksamples.csv') 
```

To make sure that everything is loaded in correctly, print the top five lines of the new DataFrame by using `head()` and the information summary by using `info()`:

```python
rock_samples.head()
```

|   | ID | Mission | Type | Subtype | Weight (g) | Pristine (%) |
|---|---|---|---|---|---|---|
| 0 | 10001 | Apollo11 | Soil | Unsieved | 125.8 | 88.36 |
| 1 | 10002 | Apollo11 | Soil | Unsieved | 5629.0 | 93.73 |
| 2 | 10003 | Apollo11 | Basalt | Ilmenite | 213.0 | 65.56 |
| 3 | 10004 | Apollo11 | Core | Unsieved | 44.8 | 71.76 |
| 4 | 10005 | Apollo11 | Core | Unsieved | 53.4 | 40.31 |

```python
rock_samples.info()
```

> [!NOTE]
> The output is truncated to include only the table summary of data.

```output
 #   Column       Non-Null Count  Dtype  
---  ------       --------------  -----  
 0   ID           2229 non-null   int64  
 1   Mission      2229 non-null   object 
 2   Type         2229 non-null   object 
 3   Subtype      2226 non-null   object 
 4   Weight(g)    2229 non-null   float64
 5   Pristine(%)  2229 non-null   float64
```

From this output, we can see that 2,229 samples were collected from the Apollo missions. Looking at a sample of the data, we can see that each row contains:
- *ID* - The unique ID used to keep track of the sample at NASA.
- *Mission* - The mission responsible for retrieving the sample.
- *Type* - The type of sample (type of rock or other classification).
- *Subtype* - A more specific type classification.
- *Weight (g)* - The original weight of the sample, in grams.
- *Pristine (%)* - The percentage of the sample that remains (some sample is used up during research).
