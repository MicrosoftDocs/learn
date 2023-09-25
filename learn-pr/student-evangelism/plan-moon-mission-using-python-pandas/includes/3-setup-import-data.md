Now it's time to get data from the [Lunar Sample and Photo Catalog](https://curator.jsc.nasa.gov/lunar/samplecatalog/index.cfm) into Visual Studio Code. By doing so, you can use Python to gain insight from the thousands of samples collected across the six Apollo missions that have landed on the Moon. 

## Set up your coding environment

In this module, you'll learn how to cleanse and manipulate data related to Moon rock samples. To do the following exercises, you need some kind of Python notebook development environment. If you haven't set up a data science development environment yet, the easiest way to do this is to use GitHub Codespaces.

To start using GitHub Codespaces, follow these steps:
1. Make sure you're signed in to [GitHub](https://github.com?azure-portal=true).
1. Go to [Codespaces](https://github.com/codespaces?azure-portal=true).
1. In the **Explore quick start templates** section, locate the **Jupyter Notebook** template and select **Use this template**. 

>[!NOTE]
>If the Jupyter Notebook template isn't displayed in the quick start templates, select **See all** to list all available templates.

The Jupyter Notebook Codespace launches and should look similar to the following screenshot:

:::image type="content" source="../media/codespaces-welcome.png" alt-text="Screenshot that shows a new Jupyter Notebooks codespaces environment.":::

The Jupyter Notebook Codespace provides a workspace with Visual Studio Code, Python, and Jupyter Notebooks in your browser.  

>[!TIP]
>For personal GitHub accounts, you can use 120 core hours of Codespaces a month for free. For more information on billing, see [About billing for GitHub Codespaces](https://docs.github.com/en/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces). For more information on how to use Codespaces, see [GitHub Codespaces overview](https://docs.github.com/en/codespaces/overview).

> [!NOTE]
> Instead of using GitHub Codespaces, you can set up a development environment on your own computer by following the instructions in the [Visual Studio Code data science setup docs](https://code.visualstudio.com/docs/python/data-science-tutorial).

After you've created your Codespace, follow these steps to get your environment ready:
1. Create a folder called `over-the-moon`. 
2. Open the folder in your Codespace.
3. Create a folder inside that folder called `sample-return`.
4. Create a folder inside that folder called `data`.
5. Create a file called `sample-return.ipynb` in the `sample-return` folder.
6. Open the `sample-return.ipynb` file in your Codespace.

Your environment should look like this:

:::image type="content" source="../media/vscode-sample-return.png" alt-text="Screenshot that shows an example of a GitHub Codespaces Visual Studio Code environment.":::

## Collect and import data

The data that you'll explore during this module is a file full of all the samples collected from the six Apollo missions that landed on the Moon. The [*rocksamples.csv*](https://aka.ms/LearnWithDrG/OverTheMoon/Data2?azure-portal=true) file was created using information from the [Lunar Sample and Photo Catalog](https://curator.jsc.nasa.gov/lunar/samplecatalog/index.cfm?azure-portal=true). 

Copy the contents of the `rocksamples.csv` file in GitHub and save to a new CSV file in Codespaces by following these steps:

1. Open the [`rocksamples.csv`](https://github.com/drguthals/learnwithdrg/blob/main/OverTheMoon/sample-return/data/rocksamples.csv) file in GitHub.
1. In the upper-right corner, select the copy icon. The file contents are copied.
1. In Codespaces, select the `over-the-moon/sample-return/data` folder and then select **New File**. 
1. Name the file `rocksamples.csv`.
1. Paste the copied data into the file. A message may appear asking you if you want to paste data from another source into your file. Select **Allow** to paste the data into your file.

Your Codespaces environment should look like this:

:::image type="content" source="../media/vscode-data.png" alt-text="Screenshot that shows an example of a Codespaces folder structure with data.":::

In the first Python cell in your `sample-return.ipynb` file, import pandas and read the data file in it as a pandas DataFrame:

```python
import pandas as pd 

rock_samples = pd.read_csv('data/rocksamples.csv') 
```
>[!NOTE]
> If you're prompted to choose a Kernel, select **Python Environments** and then the recommended version of Python, such as Python 3.10.4.

To make sure that everything is loaded in correctly, print the top five lines of the new DataFrame by using `head()` and the information summary by using `info()`:

```python
rock_samples.head()
```

| Row  | ID | Mission | Type | Subtype | Weight (g) | Pristine (%) |
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
