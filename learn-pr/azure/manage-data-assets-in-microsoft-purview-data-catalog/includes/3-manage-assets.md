In the Microsoft Purview governance portal a **data asset**, or an **asset**, is a piece of data housed in a data source. For example, a table in a SQL database, or a file in an Azure Storage account. In the exercise before these, we explored the assets available in the data catalog, and saw that these assets have many features, including:
    
- Certification
- Classification
- Security label
- Lineage
- etc.

In this section, we'll cover more of these aspects in detail. We'll talk about how we can edit and manage these aspects in the Data catalog, and the importance of maintaining and updating data assets in your environment.

## Capture and maintain assets

### Scanning

Assets are ingested into the data catalog as part of the scanning process. The data map scans your resources, and adds the metadata about these sources where they can be browsed using the data catalog. Only the metadata is added--data isn't moved or copied from your sources. This metadata includes information like column name, data type, and any classifications or security labels that can be applied.

:::image type="content" source="../media/manage-assets/data-catalog-diagram.png" alt-text="Diagram showing assets housed under the data map and the data catalog searching the data map." border="false":::

Metadata can also be gathered from multiple sources about a single data asset. For example:
A file is stored in an Azure blob storage account and the file is consumed and transformed using Azure Data Factory. If both the Azure Storage account and Azure Data Factory are connected to Microsoft Purview, both will provide metadata about this file to give you a complete picture.

### Asset normalization

Sometimes, different sources connected to Microsoft Purview update the same data asset with similar, but slightly different qualified names. For example:

You scan in an Azure Blob with the qualified name `https://myaccount.file.core.windows.net/myshare/folderA/folderB/my-file.parquet`.
This blob is also consumed by an Azure Data Factory pipeline that will then add lineage information to the asset. The ADF pipeline may be configured to read the file as `https://myAccount.file.core.windows.net//myshare/folderA/folderB/my-file.parquet`.

The names are different, but ultimately the piece of data is the same, so Microsoft Purview uses a normalization process to ensure all metadata from both Azure Storage and Azure Data Factory is included under a single data asset.

### Editing assets

Once an asset is ingested to the data catalog, it isn't static: they can be updated and enhanced to provide information that can be used to identify useful data sources. Things like adding a description, or updating glossary terms.

Both column-level and asset-level updates such as adding a description, glossary term or classification don't affect scan updates. Scans will update new columns and classifications regardless if these changes are made.

Even so, Microsoft Purview works to reflect the truth of the source system whenever possible. For example, if you edit a column and later it's deleted from the source table, a scan will remove the column metadata from the asset in Microsoft Purview.

You can also move an asset from one collection to a subcollection of the collection where the source is house. For example, if you have an ADLS Gen 2 account, but a research team only needs access to a subset of the files, you can create a subcollection for that team, and move the files they need into the subcollection.

Here are the currently editable aspects of an asset:

#### Overview

:::image type="content" source="../media/manage-assets/editing-assets-overview.png" alt-text="Screenshot of the asset editing overview page.":::

1. **Asset description** - should give a synopsis of what an asset represents. You can use rich text formatting to provide hyperlinks, bold text, lists, or tables to provide information to your users.
1. **Classification** - identify the kind of data being represented. Classifications will be applied during the scanning process, depending on your scanning rules, but you can also add them manually, or create and add custom classifications.
1. **Glossary terms** - a vocabulary for business terms created by your organization that can be used to categorize and relate assets across your teams. We'll talk more about them in the next section.
1. **Certified** - a flag that can only be added by a data curator, and should be used to mark data sources that can be trusted. Certified assets are also boosted in results.
1. **Managed attributes** - attributes created by an organization to provide more context or information about an asset.

#### Schema

:::image type="content" source="../media/manage-assets/editing-assets-schema-inline.png" alt-text="Screenshot of the asset editing schema page." lightbox="../media/manage-assets/editing-assets-schema.png":::

1. **Column name** - imported during the scanning process, but can be updated to a friendly name.
1. **Column-level classifications** - exactly like classifications applied to an asset in general, but they can be applied to a specific column of data.
1. **Glossary terms** - glossary terms can also be directly applied to a specific data column.
1. **Data type** - imported during the scanning process, but can be updated.
1. **Asset description** - allows a description on the column level of the asset to provide information about use or context to improve data understanding.

#### Contacts

:::image type="content" source="../media/manage-assets/editing-assets-contacts-inline.png" alt-text="Screenshot of the asset editing contacts page." lightbox="../media/manage-assets/editing-assets-contacts.png":::

Contacts should be users that are responsible for maintaining a data asset, or know about them. These users will be contacted if a user has questions about a data asset, or needs to be granted access.

## Asset lifecycle

Once data is ingested into the Microsoft Purview Data Catalog, it needs to be regularly updated and maintained to ensure it's useful, accurate, and findable by people in the organization.

A well-maintained data catalog won't only give your organization an accurate picture of the data that is stored across the data estate, but will promote better use and security of data across the estate.

Here's what you can do to ensure a good asset lifecycle:

1. Plan your collection structure and permissions well, so users have access to all the data they need, but only the data they need.
1. Define and create classification rules and scan rule sets specific to your organization's needs.
1. Review all assets that are scanned into the data catalog:
    1. Assign individuals to own/manage these assets.
    1. Owners should review and update metadata for accuracy and searchability.
    1. Data should be certified as appropriate to identify good sources of information.
1. Set a review schedule to rescan or review scanned data, depending on the update schedule of the data itself.
1. Delete assets when data is purged according to its retention period.