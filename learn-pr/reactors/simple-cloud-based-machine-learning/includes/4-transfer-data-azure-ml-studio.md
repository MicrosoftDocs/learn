> [!Note]
> **Sarah: Action items**
> 
> - There is a missing image in the Reactors source file. Search on "Missing"
> - Need output cell content. Search on TBD.
>

We have our data, but how do we get it into Azure ML Studio in order to use it there? That's where the `azureml` package comes in. It enables us to load data and models into Azure ML Studio from an Azure Notebook (or any Python environment).

The first code cell of this notebook is what establishes the connection with _your_ Azure ML Studio account.

Now that you have your notebook talking to Azure ML Studio, you can export your data to it:

```Python
from azureml import DataTypeIds

dataset = ws.datasets.add_from_dataframe(
              dataframe=df,
              data_type_id=DataTypeIds.GenericCSV,
              name='Forest Fire Data',
              description='Paulo Cortez and Aníbal Morais (Univ. Minho) @ 2007'
          )
```

Here's the output:

```Output
TBD
```

After you run the code, you can see the dataset listed in the **Datasets** section of the Azure Machine Learning Studio workspace. (You might need to switch between browser tabs and refresh the page in order to see the dataset.)

<!--- Missing image.png --->

It's also straightforward to list the datasets available in the workspace and transfer datasets from the workspace to the notebook:

```Python
print('\n'.join([i.name for i in ws.datasets if not i.is_example])) # only list user-created datasets
```

Here's the output:

```Output
TBD
```

You can also interact with and examine the dataset in Azure ML Studio directly from your notebook:

```Python
# Read some more of the metadata
ds = ws.datasets['Forest Fire Data']
print(ds.name)
print(ds.description)
print(ds.family_id)
print(ds.data_type_id)
print(ds.created_date)
print(ds.size)
```

Here's the output:

```Output
TBD
```

```Python
# Read the contents
df2 = ds.to_dataframe()
df2.head()
```

The output is:

```Output
TBD
```
