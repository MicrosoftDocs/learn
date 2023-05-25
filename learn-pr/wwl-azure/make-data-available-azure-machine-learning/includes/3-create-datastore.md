

In Azure Machine Learning, **datastores** are abstractions for cloud data sources. They encapsulate the information needed to connect to data sources, and securely store this connection information so that you don’t have to code it in your scripts.

When you create a datastore with an existing storage account on Azure, you have the choice between two different authentication methods:

- **Credential-based**: Use a *service principal*, *shared access signature* (*SAS*) token or *account key* to authenticate access to your storage account.
- **Identity-based**: Use your *Azure Active Directory identity* or *managed identity*.

## Understand types of datastores

Azure Machine Learning supports the creation of datastores for multiple kinds of Azure data source, including:

- Azure Blob Storage
- Azure File Share
- Azure Data Lake (Gen 1)
- Azure Data Lake (Gen 2)

## Use the built-in datastores

Every workspace has four built-in datastores (two Azure Storage blob containers, and two Azure Storage file shares), which are used as system storages by Azure Machine Learning. There’s also another datastore that gets added to your workspace if you make use of the open datasets provided as samples (for example, by creating a designer pipeline based on a sample dataset).

In most machine learning projects, you'll likely need to work with data sources of your own – either because you need to store larger volumes of data than the built-in datastores support, or because you need to integrate your machine learning solution with data from existing applications.

## Create a datastore

Datastores are attached to workspaces and are used to store connection information to storage services. When you create a datastore, you provide a name that can be used to retrieve the connection information. 

Datastores will allow you to easily connect to storage services without having to provide all necessary details every time you want to read or write data. It also creates a protective layer if you want users to use the data, but not connect to the underlying storage service directly.

### Create a datastore for an Azure Blob Storage container

You can create a datastore through the graphical user interface, the Azure command-line interface (CLI), or the Python software development kit (SDK). 

Depending on the storage service you want to connect to, there are different options for Azure Machine Learning to authenticate. 

For example, when you want to create a datastore to connect to an Azure Blob Storage container, you may use an account key:

```python
blob_datastore = AzureBlobDatastore(
    			name = "blob_example",
    			description = "Datastore pointing to a blob container",
    			account_name = "mytestblobstore",
    			container_name = "data-container",
    			credentials = AccountKeyCredentials(
        			account_key="XXXxxxXXXxXXXXxxXXX"
    			),
)
ml_client.create_or_update(blob_datastore)
```

Alternatively, you can create a datastore to connect to an Azure Blob Storage container by using a SAS token to authenticate:

```python
blob_datastore = AzureBlobDatastore(
name="blob_sas_example",
description="Datastore pointing to a blob container",
account_name="mytestblobstore",
container_name="data-container",
credentials=SasTokenCredentials(
sas_token="?xx=XXXX-XX-XX&xx=xxxx&xxx=xxx&xx=xxxxxxxxxxx&xx=XXXX-XX-XXXXX:XX:XXX&xx=XXXX-XX-XXXXX:XX:XXX&xxx=xxxxx&xxx=XXxXXXxxxxxXXXXXXXxXxxxXXXXXxxXXXXXxXXXXxXXXxXXxXX"
),
)
ml_client.create_or_update(blob_datastore)
```

> [!Tip]
> Learn more about [how to create datastores to connect to other types of cloud storage solutions](/azure/machine-learning/how-to-datastore?azure-portal=true). 