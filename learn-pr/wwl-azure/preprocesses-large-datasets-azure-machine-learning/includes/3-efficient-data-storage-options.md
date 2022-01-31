As many machine-learning models benefit from large amounts of data, store your large dataset efficiently to reduce processing time.

Recall that you received a large dataset from the analytics team. You know you have to store it efficiently to optimize processing time. Whether it is for preparing and exploring the flight data, or to train a machine or deep learning model on the data. 

You'll learn some best practices to store large amounts of data.

## Choose an Azure Data Lake Storage Gen2

Together with the analytics team, you have decided to do all processing and model training in Azure Machine Learning. To easily and securely access the data from the Azure Machine Learning workspace, you want to store the data in Azure.

Although there are several options to store data in Azure, the best solution when working with Azure Machine Learning is to store the data in an **Azure Data Lake Storage Gen2**, no matter the size of the data.

### Take advantage of the hierarchical namespace

Compared to an Azure Blob Storage, the Azure Data Lake Gen2 provides a **hierarchical namespace** to store your files. 

With the hierarchical namespace, you can use a nested folder structure to optimize listing operations. Next to better scalability and performance, structuring your files like this will also allow for fine-granular access. 

> [!TIP]
> Learn more about [the capabilities of Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction).

### Use a nested folder structure

The reason why it's more efficient to use a data lake instead of a flat object storage, is because it's best to avoid putting all your files in one folder. 

If all files are stored in one folder, regardless of which storage solution you choose, reading the files will be demanding for your compute. 

The flight data you received, are a large collection of CSV files that show the flight information for each month. Based on these recommendations, you choose to migrate the data to an Azure Data Lake Storage and create a nested folder structure based on date. Doing so will allow you to easily select for which time period you want to load in the flight data.

### Avoid small files

And finally, when storing your files you should avoid having many small files. Reading a 1000 small files is much slower than reading one file with 1000x the size. 

## Access data in Azure Machine Learning

After migrating the data and allowing Azure Machine Learning to connect to the Azure Data Lake, you want to use the flight data as input when running a job. 

When working with data in Azure Machine Learning, you can either download or mount the data to the Compute Cluster assigned to run the job:

- Download the data if you estimate the dataset will fit onto the virtual machine's disk.
- Mount the data if you expect the dataset to be too large to be downloaded on to the disk.

> [!TIP]
> Learn more about [how to work with Azure Machine Learning datasets](/azure/machine-learning/how-to-train-with-datasets).