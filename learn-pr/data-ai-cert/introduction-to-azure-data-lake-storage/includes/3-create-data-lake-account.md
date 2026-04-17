Azure Data Lake Storage Gen2 isn't a standalone Azure service, but rather a configurable capability of an Azure Storage account. You can enable it on a **Standard general-purpose v2** account (the most common choice) or a **Premium block blob** account for workloads that require higher throughput and lower latency.

To enable Azure Data Lake Storage Gen2 in an Azure Storage account, you can select the option to **Enable hierarchical namespace** in the **Advanced** page when creating the storage account in the Azure portal:

![Screenshot of Advanced Settings for Creating Storage Account.](../media/3-create-storage-account-advanced.png)

Alternatively, if you already have an Azure Storage account and want to enable the Azure data Lake Storage Gen2 capability, you can use the **Data Lake Gen2 upgrade** wizard in the Azure portal page for your storage account resource.

![Screenshot of upgrading a Storage Account to Data Lake Gen2.](../media/3-data-lake-upgrade.png)
