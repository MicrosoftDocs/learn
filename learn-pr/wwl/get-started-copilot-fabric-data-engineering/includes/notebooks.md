Copilot for Fabric Data Engineering is a powerful tool that helps you write code faster and more efficiently in your notebooks. It works with Lakehouse tables and files, and it understands the dataframes you're working with. 

There are multiple ways to interact with Copilot for Fabric Data Engineering, including:

- **Magic commands** are special commands that you can use in your notebook cells to perform specific tasks. They start with a double percent sign (`%%`) or a single percent sign (`%`).
- **Copilot chat panel**: You can ask Copilot for help in plain English, and it generates code for you based on your request.

## Magic commands

Chat commands are special commands you can use in your Microsoft Fabric notebooks to interact with Copilot. Here's a list of the most commonly used commands:

| Command | Description |
| ------- | ----------- |
| `%%chat` | Ask questions about the state of your notebook. |
| `%%code` | Code generation for data manipulation or visualization. |
| `%show_chat_history` | Show the chat history. |
| `%clear_chat_history` | Clear the chat history. |
| `%set_output` | Change the default for how magic commands provide output. Choose where to place the generated code, from options like <br>- current cell<br>- new cell<br>- cell output<br>- into a variable<br> |
| `%describe` | Provides summaries and descriptions of loaded dataframes. |
| `%%add_comments` | Add comments to your code. |

In addition, there are also several commands allowing you to fix errors, configure privacy settings, and manage dataframes. Check out the article [Overview of chat-magics in Microsoft Fabric notebooks](/fabric/data-engineering/copilot-notebooks-chat-magics) for more information.

## Example

In this example, we use Copilot for Fabric Data Engineering to load, transform, and save data in a Lakehouse. Let's imagine Contoso Health, a multi-specialty hospital network, wants to expand its services in the EU and wants to analyze projected population data. This example uses the [Eurostat](https://ec.europa.eu/eurostat/web/main/home) (statistical office of the European Union) population projection dataset.

Source: EUROPOP2023 Population on January 1 by age, sex, and type of projection [[proj_23np](https://ec.europa.eu/eurostat/databrowser/product/view/proj_23np?category=proj.proj_23n)], Last updated June 28, 2023.

### Prerequisites

The following prerequisites should be in place before you start:

- Access to a Microsoft Fabric tenant account with an active subscription. [Create a free account](https://azure.microsoft.com/free/).
- Created a Workspace with Fabric enabled: [Create a workspace](/fabric/fundamentals/create-workspaces).
- Created a Lakehouse.
- Created a new notebook and attach it to your Lakehouse.

### Load data

Create a new cell in your notebook and copy the following instruction into it. To indicate that we want Copilot to generate code, use `%%code` as the first instruction in the cell. Execute the cell to generate the code.

> [!NOTE]
> **Crafted instruction**:
>
> _%%code_
> 
> _Download the following file from this URL:_
> 
> _https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/proj_23np$defaultview/?format=TSV_
> 
> _Then write the file to the default lakehouse into a temporary folder. Create the temporary folder if it doesn't exist yet._
 
Copilot generates code, which might differ slightly depending on your environment and the latest updates to Copilot.

```python
#### ATTENTION: AI-generated code can include errors or operations you didn't intend. Review the code in this cell carefully before running it.

import urllib.request
import os

# Step 1: Download the file
url = "https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/proj_23np$defaultview/?format=TSV"
file_path = "/tmp/proj_23np_defaultview.tsv"

urllib.request.urlretrieve(url, file_path)

# Step 2: Create a temporary folder in the default lakehouse
lakehouse_temp_folder = "/lakehouse/default/Files/temp"
os.makedirs(lakehouse_temp_folder, exist_ok=True)

# Step 3: Write the file to the lakehouse temporary folder
import shutil
shutil.move(file_path, os.path.join(lakehouse_temp_folder, "proj_23np.tsv"))

print(f"File successfully written to {os.path.join(lakehouse_temp_folder, 'proj_23np.tsv')}")
```

Execute the cell and observe the output. The file should be downloaded and saved in the temporary folder of your Lakehouse.

Now, create a new cell in your notebook and copy the following instruction into it.

> [!NOTE]
> **Crafted instruction**:
>
> _%%code_
> 
> _Load the file 'Files/temp/proj_23np.tsv' into a spark dataframe._
> 
> _The fields are separated with a tab._
> 
> _Show the contents of the DataFrame using display method._

Observe the output. The dataframe should contain the data from the TSV file. Here's an example of what the generated code might look like:

```python
#### ATTENTION: AI-generated code can include errors or operations you didn't intend. Review the code in this cell carefully before running it.

# Load the file 'Files/temp/proj_23np.tsv' into a spark dataframe.
# The fields have been separated with a tab.
file_path = "Files/temp/proj_23np.tsv"

spark_df = spark.read.format("csv").option("delimiter", "\t").option("header", "true").load(file_path)

# Show the contents of the DataFrame using display method
display(spark_df)
```

Here's an example of what the output might look like:

| freq,projection,sex,age,unit,geo\TIME_PERIOD |      2022  |      2023  |   ...  |      2100  |
| -------------------------------------------- | ---------- | ---------- | ------ | ---------- |
|                         A,BSL,F,TOTAL,PER,AT |   4553444  |   4619179  |   ...  |   4807661  |
|                         A,BSL,F,TOTAL,PER,BE |   5883978  |   5947528  |   ...  |   6331785  |
|                         A,BSL,F,TOTAL,PER,BG |   3527626  |   3605059  |   ...  |   2543673  |
|                                          ... |       ...  |       ...  |   ...  |   5081250  |
|                         A,BSL,F,TOTAL,PER,CY |    463622  |    476907  |   ...  |    504781  |

### Transform data

Let's now go ahead and transform the data. We need to make sure the first field is split into separate columns. Additionally, we also need to make sure to work with correct data types and apply filtering. Create a new cell in your notebook and copy the following instruction into it.

> [!NOTE]
> **Crafted instruction**:
>
> _%%code_
> 
> _Now transform this dataframe spark_df and split the first field 'freq,projection,sex,age,unit,geo\TIME_PERIOD' using a comma into 6 separate fields._
> 
> _Then, remove the fields 'freq', 'age', 'unit'._
> 
> _The fields 'projection', 'sex', 'geo' should be positioned first._
> 
> _The 'projection' field contains codes that should be replaced with the following values:_
> 
> - _'BSL' -> 'Baseline projections'._
> - _'LFRT' -> 'Sensitivity test: lower fertility'._
> - _'LMRT' -> 'Sensitivity test: lower mortality'._
> - _'HMIGR' -> 'Sensitivity test: higher migration'._
> - _'LMIGR' -> 'Sensitivity test: lower migration'._
> - _'NMIGR' -> 'Sensitivity test: no migration'._
> 
> _Filter the 'geo' field and remove values 'EA20' and 'EU27_2020' (these are not countries)._
> 
> _Filter the 'sex' field and remove 'T' (these are totals)._
> 
> _Strip spaces from all field names in the dataframe._
> 
> _Convert the data type of all the year fields to integer._
> 
> _Display (Render) the DataFrame._

Copilot generates code, which might differ slightly depending on your environment and the latest updates to Copilot.

```python
from pyspark.sql.functions import split, col

# Load the file 'Files/temp/proj_23np.tsv' into a spark dataframe.
file_path = "Files/temp/proj_23np.tsv"
spark_df = spark.read.format("csv").option("delimiter", "\t").option("header", "true").load(file_path)

# Split the first field 'freq,projection,sex,age,unit,geo\TIME_PERIOD' into 6 separate fields.
split_col = split(spark_df['freq,projection,sex,age,unit,geo\TIME_PERIOD'], ',')
spark_df = spark_df.withColumn('freq', split_col.getItem(0)) \
                   .withColumn('projection', split_col.getItem(1)) \
                   .withColumn('sex', split_col.getItem(2)) \
                   .withColumn('age', split_col.getItem(3)) \
                   .withColumn('unit', split_col.getItem(4)) \
                   .withColumn('geo', split_col.getItem(5))

# Remove the fields 'freq', 'age', 'unit'
columns_to_drop = ['freq', 'age', 'unit', 'freq,projection,sex,age,unit,geo\TIME_PERIOD']
spark_df = spark_df.drop(*columns_to_drop)

# Reorder the columns, placing 'projection', 'sex', 'geo' first
columns_order = ['projection', 'sex', 'geo']  |  [col for col in spark_df.columns if col not in ['projection', 'sex', 'geo']]
spark_df = spark_df.select(*columns_order)

# Replace projection field codes with values
replace_map = {
    'BSL': 'Baseline projections',
    'LFRT': 'Sensitivity test: lower fertility',
    'LMRT': 'Sensitivity test: lower mortality',
    'HMIGR': 'Sensitivity test: higher migration',
    'LMIGR': 'Sensitivity test: lower migration',
    'NMIGR': 'Sensitivity test: no migration'
}
spark_df = spark_df.replace(replace_map, subset=['projection'])

# Filter the 'geo' field to remove values 'EA20' and 'EU27_2020'
spark_df = spark_df.filter(~spark_df['geo'].isin(['EA20', 'EU27_2020']))

# Filter the 'sex' field to remove 'T'
spark_df = spark_df.filter(spark_df['sex'] != 'T')

# Strip spaces from all field names
spark_df = spark_df.toDF(*(c.replace(' ', '') for c in spark_df.columns))

# Convert the data type of all the year fields to integer
for column in spark_df.columns:
    if column.isnumeric():
        spark_df = spark_df.withColumn(column, col(column).cast('int'))

# Display the DataFrame
display(spark_df)
```

Here's an example of what the output might look like:

|          projection|sex|geo|    2022|    2023|     ...|    2100|
|--------------------|---|---|--------|--------|--------|--------| 
|Baseline projections|  F| AT| 4553444| 4619179|     ...| 4807661|
|Baseline projections|  F| BE| 5883978| 5947528|     ...| 6331785|
|Baseline projections|  F| BG| 3527626| 3605059|     ...| 2543673|
|...                 |...|...|     ...|     ...|     ...|     ...|
|Baseline projections|  F| LU|  320333|  329401|     ...|  498954|


### Save data

Next, we want to save the transformed data to our lakehouse. Create a new cell in your notebook and copy the following instruction into it.

> [!NOTE]
> **Crafted instruction**:
>
> _%%code_
> 
> _Save the dataframe as a new table named 'Population' in the default lakehouse._

Copilot generates code, which might differ slightly depending on your environment and the latest updates to Copilot.

```python
#### ATTENTION: AI-generated code can include errors or operations you didn't intend. Review the code in this cell carefully before running it.

spark_df.write.format("delta").saveAsTable("Population")
```

### Validation

To validate that the data is saved correctly, expand the tables in your Lakehouse and check the contents. You can also use the **Copilot chat panel** to ask questions and get insights, and the AI provides responses or code to copy into your notebook. For example, you can ask:

> [!NOTE]
> **Crafted instruction**:
>
> _What is the projected population for geo BE in 2050?_

Copilot generates code to filter the data for the specified geo and year, and display the result.

```python
# ATTENTION: AI-generated code can include errors or operations you didn't intend. Review the code in this cell carefully before running it.

from pyspark.sql import SparkSession

# Initialize Spark session
spark = SparkSession.builder.getOrCreate()

# Load the Population table into a Spark DataFrame
spark_df = spark.read.table("population")

# Filter for the projected population for geo BE in 2050
result_df = spark_df.filter((spark_df['geo'] == 'BE') & (spark_df['projection'] == 'Baseline projections')).select('2050')

# Show the result
result_df.show()
```

## Best practices
- Copilot is best equipped to handle data engineering and data science topics, so limit your questions to this area.
- Explicitly describe the data you want Copilot to examine. If you describe the data asset - for example, by naming files, tables, or columns - Copilot can more likely retrieve relevant data and generate useful outputs.
- To provide Copilot with more context for performing analysis, load the data into the notebook as DataFrames or pin the data in your lakehouse.