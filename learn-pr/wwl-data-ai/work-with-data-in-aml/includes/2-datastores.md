In Azure Machine Learning, *datastores* are abstractions for cloud data sources. They encapsulate the information required to connect to data sources, and can be used to ingest data into an experiment or to write outputs from an experiment.

## Types of datastore

Azure Machine Learning supports the creation of datastores for multiple kinds of Azure data source, including:

- Azure Storage (blob and file containers)
- Azure Data Lake Storage
- Azure SQL Database
- Azure Databricks file system (DBFS)

> **More Information**: For a full list of supported datastores, see the [Azure Machine Learning documentation](https://aka.ms/AA70zfl).

## Using datastores

Every workspace has two built-in datastores (an Azure Storage blob container, and an Azure Storage file container) that are used as system storage by Azure Machine Learning. You can also store a limited amount of your own data in these built-in datastores for experiments, model training, and so on.

However, in most machine learning projects, you will likely need to work with data sources of your own - either because you need to store larger volumes of data than the built-in datastores support, or because you need to integrate your machine learning solution with data from existing applications.

You can access datastores directly in code by using the Azure Machine Learning SDK, and use it to upload or download data. You can also mount a datastore in an experiment in order to read or write data.

The ability to define a datastore enables you to reuse data across multiple experiments, regardless of the compute context in which the experiment is running.

## Registering a datastore

To add a datastore to your workspace, you can register it using the graphical interface in Azure Machine Learning Studio, or you can use the Azure Machine Learning SDK. For example, the following code registers an Azure Storage blob container as a datastore named **blob_data**.

```Python
from azureml.core import Workspace, Datastore

ws = Workspace.from_config()

# Register a new datastore
blob_ds = Datastore.register_azure_blob_container(workspace=ws,
    datastore_name='blob_data',
    container_name='data_container',
    account_name='az_store_acct',
    account_key='123456abcde789…')
```

## Managing datastores

You can view and manage datastores in Azure Machine Learning Studio, or you can use the Azure Machine Learning SDK. For example, the following code lists the names of each datastore in the workspace.

```Python
for ds_name in ws.datastores:
    print(ds_name)
```

You can get a reference to any datastore by using the **Datastore.get()** method as shown here:

```Python
blob_store = Datastore.get(ws, datastore_name='blob_data')
```

The workspace always includes a *default* datastore (initially, this is the built-in **workspaceblobstore** datastore), which you can retrieve by using the **get_default_datastore()** method of a **Workspace** object, like this:

```Python
default_store = ws.get_default_datastore()
```

To change the default datastore, use the **set_default_datastore()** method:

```Python
ws.set_default_datastore('blob_data')
```