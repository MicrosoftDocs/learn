Copilot for Fabric Data Engineering assists with writing code in notebooks. It uses notebook context, including attached lakehouses, available schemas, tables, files, existing code, and runtime information.

You can interact with Copilot in two ways:

- **Copilot chat pane**: Ask questions in natural language and work across multiple notebook cells. Copilot can generate, edit, run, explain, and validate code while maintaining the context of your workflow.
- **In-cell Copilot**: Enter a request above an individual code cell. Use this experience for focused tasks such as generating code or explaining, fixing, commenting, and optimizing existing code.

## Use the Copilot chat pane

To start a notebook-wide conversation with Copilot:

1. Create or open a notebook.
1. Attach a lakehouse to provide schema and data context.
1. On the notebook ribbon, select **Copilot**. The chat pane opens on the right side of the notebook.
1. Enter a prompt in the chat box, or select a suggested prompt.
1. Review each requested action. Select **Allow** to let Copilot add or edit code and run cells, or select **Skip** to decline the action.
1. After Copilot completes the task, review the result and the diff view. Select **Keep** to retain the changes or **Undo** to revert them.

Copilot can ask for approval before each action. You can change this behavior in the chat pane's approval settings. High-risk actions, such as installing packages or running multiple cells, always require approval. For more information, see [Use the Copilot for Data Engineering and Data Science chat pane](/fabric/data-engineering/copilot-notebooks-chat-pane).

## In-cell Copilot

In-cell Copilot lets you interact with Copilot directly above any code cell, without leaving your editing context. Select the **Copilot** button that appears above a code cell to open a text box where you can type a request or use a slash command.

The available slash commands are:

| Command | Description |
| ------- | ----------- |
| `/explain` | Provides a plain-language explanation of the cell's code logic. |
| `/fix` | Identifies errors in the cell and suggests corrections. |
| `/comments` | Automatically adds code comments to document logic and data changes. |
| `/optimize` | Suggests improvements for performance and efficiency. |

Use in-cell Copilot when you want to refine a specific cell — for example, understanding what a transformation does, fixing a syntax error, or documenting code before sharing the notebook. For multi-step workflows or cross-cell tasks, switch to the Copilot chat pane instead.

## Use Copilot to prepare data

In this example, you use Copilot for Fabric Data Engineering to load, transform, and save data in a lakehouse. Contoso Health, a multispecialty hospital network, wants to analyze projected population data as it considers expanding its services in the European Union (EU). This example uses a population projection dataset from [Eurostat](https://ec.europa.eu/eurostat/web/main/home), the statistical office of the European Union.

Source: EUROPOP2023 Population on January 1 by age, sex, and type of projection [[proj_23np](https://ec.europa.eu/eurostat/databrowser/product/view/proj_23np?category=proj.proj_23n)], Last updated June 28, 2023.

### Load data

Begin in a notebook that's attached to your lakehouse. Open the **Copilot** chat pane, enter the following prompt, and submit it:

```copilot-prompt
Download the following file from this URL:
https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/proj_23np$defaultview/?format=TSV

Then write the file to the default lakehouse into a temporary folder. Create the temporary folder if it doesn't exist yet.
```
 
When Copilot requests permission to add and run a code cell, review the requested actions and select **Allow**. Copilot generates code that might differ from the following example:

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

After the cell runs, the file appears in the temporary folder of your lakehouse. Review the result and select **Keep** in the Copilot pane.

In the Copilot chat box, enter and submit the following prompt:

```copilot-prompt
Load the file 'Files/temp/proj_23np.tsv' into a spark dataframe.
The fields are separated with a tab.
Show the contents of the DataFrame using display method.
```

Review and allow the requested actions. The resulting dataframe contains the contents of the TSV file. The generated code might resemble this example:

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

Next, ask Copilot to split the combined first field into separate columns, remove unused fields, standardize data types, and filter the data. Enter and submit the following prompt in the chat pane:

```copilot-prompt
Now transform this dataframe spark_df and split the first field 'freq,projection,sex,age,unit,geo\TIME_PERIOD' using a comma into 6 separate fields.

Then, remove the fields 'freq', 'age', 'unit'.

The fields 'projection', 'sex', 'geo' should be positioned first.

The 'projection' field contains codes that should be replaced with the following values:

 _'BSL' -> 'Baseline projections'.
 _'LFRT' -> 'Sensitivity test: lower fertility'.
 _'LMRT' -> 'Sensitivity test: lower mortality'.
 _'HMIGR' -> 'Sensitivity test: higher migration'.
 _'LMIGR' -> 'Sensitivity test: lower migration'.
 _'NMIGR' -> 'Sensitivity test: no migration'.

Filter the 'geo' field and remove values 'EA20' and 'EU27_2020' (these are not countries).

Filter the 'sex' field and remove 'T' (these are totals).

Strip spaces from all field names in the dataframe.

Convert the data type of all the year fields to integer.

Display (Render) the DataFrame.
```

Review and allow the requested actions. Copilot generates code that might differ from the following example:

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
columns_order = ['projection', 'sex', 'geo'] + [column for column in spark_df.columns if column not in ['projection', 'sex', 'geo']]
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

After you transform the data, ask Copilot to save the result to the lakehouse. Enter and submit the following prompt in the chat pane:

```copilot-prompt
Save the dataframe as a new table named 'Population' in the default lakehouse.
```

Review and allow the requested actions. Copilot generates code that might differ from the following example:

```python
#### ATTENTION: AI-generated code can include errors or operations you didn't intend. Review the code in this cell carefully before running it.

spark_df.write.format("delta").saveAsTable("Population")
```

### Validation

To check that the table saved as expected, expand the **Tables** list in your lakehouse and review its contents. You can also use the **Copilot chat pane** for exploratory questions. Copilot responds with explanations or requests permission to add and run code. For example:

```copilot-prompt
What is the projected population for geo BE in 2050?
```

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

## Apply Copilot best practices

- Copilot is currently strongest with data engineering and data science scenarios, so framing questions in those domains tends to yield clearer results.
- Giving Copilot concrete references to your data assets (file paths, table names, column names) usually improves the specificity and usefulness of generated answers.
- Loading data as DataFrames or pinning datasets in your lakehouse supplies richer context, enabling more accurate analysis and transformations.