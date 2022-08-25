In the Microsoft Purview governance portal a **data asset**, or an **asset**, is a piece of data housed in a data source. For example, a table in a SQL database, or a file in an Azure Storage account. In the exercise before these, we explored the assets available in the data catalog, and saw that these assets have many features, including:
    - Certification
    - Classification
    - Security label
    - Lineage
    - etc...

In this section, we'll cover more of these aspects in detail, and talk about how we can edit and manage these aspects in the Data catalog, and the importance of maintaining and updating data assets in your environment.

## Capture and maintain assets

### Scanning

Assets are ingested into the data catalog as part of the scanning process. The data map scans your resources, and adds the metadata about these sources into the data catalog. Only the metadata is added-- data is not actually moved or copied from your sources. This metadata includes information like column name, data type, and any classifications or security labels that can be applied.

Metadata can also be gathered from multiple sources about a single data asset. For example:
A file is stored in an Azure blob storage account, and the file is consumed and transformed using Azure Data Factory. If both the Azure Storage account and Azure Data Factory are connected to Microsoft Purview, both will provide metadata about this file to give you a complete picture.

### Asset normalization

Sometimes, different sources connected to Microsoft Purview update the same data asset with similar, but slightly different qualified names. For example:

You scan in an Azure Blob with the qualified name https://myaccount.file.core.windows.net/myshare/folderA/folderB/my-file.parquet. 
This blob is also consumed by an Azure Data Factory pipeline that will then add lineage information to the asset. The ADF pipeline may be configured to read the file as https://myAccount.file.core.windows.net//myshare/folderA/folderB/my-file.parquet.

The names are different, but ultimately the piece of data is the same, so Microsoft Purview uses a normalization process to ensure all metadata from both Azure Storage and Azure Data Factory is included under a single data asset.

### Editing assets

Once an asset is ingested to the data catalog they can be updated and enhanced to provide information that can be used to identify useful data sources.

Asset descriptions allow you to give a synposis of what the asset represents, and allows you to use right text to create useful descriptions.

### Asset certification

<!-- Pattern for complex chunks (repeat as needed) -->
## Classifications, sensitivity labels, and glossary
We'll discuss the business glossary in the next section.
Visual (image, table, list)
### Classifications and custom classifcations

### How to apply classifications

### Sensitivity labels
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

## Asset lifecycle