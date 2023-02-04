

As a data scientist, you want to focus on training machine learning models. Though you need access to data as input for a machine learning model, you don't want to worry about *how* to get access. To simplify getting access to the data you want to work with, you can use **data assets**.

## Understand data assets

In Azure Machine Learning, data assets are references to where the data is stored, how to get access, and any other relevant metadata. You can create data assets to get access to data in datastores, Azure storage services, public URLs, or data stored on your local device.

The benefits of using data assets are:

- You can **share and reuse data** with other members of the team such that they don't need to remember file locations.
- You can **seamlessly access data** during model training (on any supported compute type) without worrying about connection strings or data paths.
- You can **version** the metadata of the data asset.

There are three main types of data assets you can use:

- **URI file**: Points to a specific file.
- **URI folder**: Points to a folder.
- **MLTable**: Points to a folder or file, and includes a schema to read as tabular data.

> [!Note]
> **URI** stands for **Uniform Resource Identifier** and stands for a storage location on your local computer, Azure Blob or Data Lake Storage, publicly available https location, or even an attached datastore.

## When to use data assets

Data assets are most useful when executing machine learning tasks as Azure Machine Learning jobs. As a job, you can run a Python script that takes inputs and generates outputs. A data asset can be parsed as both an input or output of an Azure Machine Learning job. 

Let’s take a look at each of the types of data assets, how to create them, and how to use the data asset in a job.

## Create a URI file data asset

A URI file data asset points to a specific file. Azure Machine Learning will only store the path to the file, which means you can point to any type of file. When you use the data asset, you'll specify how you want to read the data, which will depend on the type of data you're connecting to. 

The supported paths you can use when creating a URI file data asset are:

- Local: `./<path>`
- Azure Blob Storage: `wasbs://<account_name>.blob.core.windows.net/<container_name>/<folder>/<file>`
- Azure Data Lake Storage (Gen 2): `abfss://<file_system>@<account_name>.dfs.core.windows.net/<folder>/<file>`
- Datastore: `azureml://datastores/<datastore_name>/paths/<folder>/<file>`

> [!Important]
> When you create a data asset and point to a file or folder stored on your local device, a copy of the file or folder will be uploaded to the default datastore `workspaceblobstore`. You can find the file or folder in the `LocalUpload` folder. By uploading a copy, you'll still be able to access the data from the Azure Machine Learning workspace, even when the local device on which the data is stored is unavailable.

To create a URI file data asset, you can use the following code:

```python
from azure.ai.ml.entities import Data
from azure.ai.ml.constants import AssetTypes

my_path = '<supported-path>'

my_data = Data(
    path=my_path,
    type=AssetTypes.URI_FILE,
    description="<description>",
    name="<name>",
    version="<version>"
)

ml_client.data.create_or_update(my_data)
```

When you parse the URI file data asset as input in an Azure Machine Learning job, you'll first need to read the data before you can work with it. 

Imagine you create a Python script you want to run as a job, and you set the value of the input parameter `input_data` to be the URI file data asset (which points to a CSV file). You can read the data by including the following code in your Python script:

```python
import argparse
import pandas as pd

parser = argparse.ArgumentParser()
parser.add_argument("--input_data", type=str)
args = parser.parse_args()

df = pd.read_csv(args.input_data)
print(df.head(10))
```

If your URI file data asset points to a different type of file, you'll need to use the appropriate Python code to read the data. For example, if instead of CSV files, you're working with JSON files, you'd use `pd.read_json()` instead.

## Create a URI folder data asset

A URI folder data asset points to a specific folder. It works similar to a URI file data asset and supports the same paths.

To create a URI folder data asset with the Python SDK, you can use the following code:

```python
from azure.ai.ml.entities import Data
from azure.ai.ml.constants import AssetTypes

my_path = '<supported-path>'

my_data = Data(
    path=my_path,
    type=AssetTypes.URI_FOLDER,
    description="<description>",
    name="<name>",
    version='<version>'
)

ml_client.data.create_or_update(my_data)
```

When you parse the URI folder data asset as input in an Azure Machine Learning job, you'll first need to read the data before you can work with it. 

Imagine you create a Python script you want to run as a job, and you set the value of the input parameter `input_data` to be the URI folder data asset (which points to multiple CSV files). You may want to read all CSV files in the folder and concatenate them, which you can do by including the following code in your Python script:

```python
import argparse
import glob
import pandas as pd

parser = argparse.ArgumentParser()
parser.add_argument("--input_data", type=str)
args = parser.parse_args()

data_path = args.input_data
all_files = glob.glob(data_path + "/*.csv")
df = pd.concat((pd.read_csv(f) for f in all_files), sort=False)
```

Depending on the type of data you're working with, the code you use to read the files may change.

## Create a MLTable data asset

A MLTable data asset allows you to point to tabular data. When you create a MLTable data asset, you specify the schema definition to read the data. As the schema is already defined and stored with the data asset, you don't have to specify how to read the data when you use it. 

Therefore, you'll want to use a MLTable data asset when the schema of your data is complex or changes frequently. Instead of changing how to read the data in every script that uses the data, you only have to change it in the data asset itself.

When you define the schema when creating a MLTable data asset, you can also choose to only specify a subset of the data. 

For certain features in Azure Machine Learning, like Automated Machine Learning, you'll need to use a MLTable data asset, as Azure Machine Learning needs to know how to read the data.

To define the schema, it's recommended to include a **MLTable file** in the same folder as the data you want to read. The MLTable file includes the path pointing to the data you want to read, and how to read the data:

```yml
type: mltable

paths:
  - pattern: ./*.txt
transformations:
  - read_delimited:
      delimiter: ','
      encoding: ascii
      header: all_files_same_headers
```

> [!Tip]
> Learn more on [how to create the MLTable file and which transformations you can include](/azure/machine-learning/reference-yaml-mltable?azure-portal=true).

To create a MLTable data asset with the Python SDK, you can use the following code:

```python
from azure.ai.ml.entities import Data
from azure.ai.ml.constants import AssetTypes

my_path = '<path-including-mltable-file>'

my_data = Data(
    path=my_path,
    type=AssetTypes.MLTABLE,
    description="<description>",
    name="<name>",
    version='<version>'
)

ml_client.data.create_or_update(my_data)
```

When you parse a MLTable data asset as input to a Python script you want to run as an Azure Machine Learning job, you can include the following code to read the data:

```python
import argparse
import mltable
import pandas

parser = argparse.ArgumentParser()
parser.add_argument("--input_data", type=str)
args = parser.parse_args()

tbl = mltable.load(args.input_data)
df = tbl.to_pandas_dataframe()

print(df.head(10))
```

A common approach is to convert the tabular data to a Pandas data frame. However, you can also convert the data to a Spark data frame if that suits your workload better.