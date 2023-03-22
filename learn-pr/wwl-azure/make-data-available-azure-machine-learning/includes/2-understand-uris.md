

You can store data on your local device, or somewhere in the cloud. Wherever you store your data, you'll want to access the data when training machine learning models. To find and access data in Azure Machine Learning, you'll use **Uniform Resource Identifiers** (**URIs**).

## Understand URIs

A URI references the location of your data. For Azure Machine Learning to connect to your data, you need to prefix the URI with the appropriate protocol. There are three common protocols when working with data in the context of Azure Machine Learning:

- `http(s)`: Use for data stores publicly or privately in an Azure Blob Storage or publicly available http(s) location.
- `abfs(s)`: Use for data stores in an Azure Data Lake Storage Gen 2.
- `azureml`: Use for data stored in a datastore.

> [!Note]
> A datastore is a reference to an existing storage account on Azure. Therefore, when you refer to data stored in a datastore, you may be referring to data being actually stored in an Azure Blob Storage or Azure Data Lake Storage. When you refer to the datastore however, you won't need to authenticate as the connection information stored with the datastore will be used by Azure Machine Learning.

For example, you may create an Azure Blob Storage in Azure. To store data, you create a container named `training-data`. Within the container, you create a folder `datastore-path`. Within the folder, you store the CSV file `diabetes.csv`. 

:::image type="content" source="../media/blob-storage.png" alt-text="Screenshot of data stored in an Azure Blob Storage.":::

When you want to access the data from the Azure Machine Learning workspace, you can use the path to the folder or file directly. When you want to connect to the folder or file directly, you can use the `http(s)` protocol. If the container is set to private, you'll need to provide some kind of authentication to get access to the data.

When you create a datastore in Azure Machine Learning, you'll store the connection and authentication information in the workspace. Then, to access the data in the container, you can use the `azureml` protocol. 

It's considered a best practice to avoid any sensitive data in your code, like authentication information. Therefore, whenever possible, you should work with datastores and data assets in Azure Machine Learning. However, during experimentation in notebooks, you may want to connect directly to a storage location to avoid unnecessary overhead. 