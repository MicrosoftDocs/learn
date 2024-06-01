
Now that you know how to register and scan your Azure SQL Databases, you can start the process to get a complete and comprehensive overview of all your data flows, sources, transformations, and dependencies.

The technical metadata of classification collected from the scanning processes is sent to the data ingestion process, which makes data assets visible in the **Data Map**.

## Browse the Microsoft Purview Data Catalog

Browse the Microsoft Purview Data Catalog to explore the discovered assets either by source type or by collection:

- Browse by source type to explore the hierarchies of the data source.

- Browse by collection to get a list of assets in that collection. You can filter the asset list further, for example, by tables, folders, files, or data pipelines. Narrow the results by selecting a different classification, label, or glossary term.

    :::image type="content" source="../media/4-browse-asset.png" alt-text="Screenshot that depicts how to browse the Microsoft Purview Data Catalog." border="true" lightbox="../media/4-browse-asset.png":::

## Search the Microsoft Purview Data Catalog

Use search to speed up the process of data discovery in Microsoft Purview Data Catalog:

- Use the simple search by inserting your cursor in the **Search assets** box and then entering keywords such as data type, classifications, or name. Automatic suggestions display, including recent searches, suggested searches, and asset suggestions.

- Search results are sorted by matches and rankings. Microsoft Purview returns the assets in collections based on the **data reader** permission, returning only the data assets for which the user has **data reader** permission.

- If the top results don’t include the assets you’re searching for, use facets to further filter the search results using different glossary terms, classifications, and other object types, such as dashboards and files.

:::image type="content" source="../media/4-search-asset.png" alt-text="Screenshot that depicts how to search the Microsoft Purview Data Catalog." border="true" lightbox="../media/4-search-asset.png":::

Select an item from the search results to display details about it, such as its schema, lineage, or classification.

To create an advanced search query, use keywords and operators. For example, use the **OR** operator to return results if the assets contain at least one of two keywords.

>[!Tip]
>A space is also considered an **OR** operator.

The search can contain glossary terms, an asset description, or an asset name. To search particular fields by keywords, use the syntax **field:keyword.**

## Asset insights

Use the **asset insights** reports to get a high-level overview of your data estate, including whether it’s distributed by source type or by classification. Use these reports to determine how many assets there are with a specific classification, to get information by source types and top folders, and to display the list of assets for further investigation.

:::image type="content" source="../media/4-asset-insights-pane.png" alt-text="Screenshot that depicts the Asset insights (preview) pane" border="true" lightbox="../media/4-asset-insights-pane.png":::

### Microsoft Purview scanning best practices

For most data sources, the system default scan rule set provides sufficient configuration for scans. In specific situations that require customization, you can create custom scan rule sets. A typical use-case scenario is when you want to match the pattern that isn’t defined in the system default scan rule. In this case, use the custom rule scan set to exclude unwanted classification labels.

>[!Note]
>Every time that you modify the classification or scan rule set, a full scan is triggered.

Use the **scan insights** report to understand the health of the scans and to explore which scans have failed, and on what data source. The report provides a history of the previous activity that you can use when you’re troubleshooting.

### Microsoft Purview glossary insights

Creating and applying glossary terms to data assets can clarify the meaningfulness and usage of those data assets. For example, applying a glossary term to data assets associated with a particular meeting or event can simplify the process of locating and isolating those data assets in a search.

To help your organization achieve more personalized terms, create glossary terms in Microsoft Purview that reflect the common business language in your organization. Creating glossary terms in Microsoft Purview that use your business vocabulary, and then applying them to your data assets, ensures your organization data assets are aligned with your business needs and culture.

Glossary terms can be defined in a hierarchy that matches your business domain, such as finance or marketing. Terms should follow common naming standards to make using them in searches easier. Glossary terms are case-sensitive and allow spaces.

>[!Note] 
>Glossary terms aren’t applied automatically to the newly discovered assets. To make manually assigning terms faster, use the **Bulk Edit** mode.

:::image type="content" source="../media/4-glossary-terms.png" alt-text="Screenshot that depicts the process of creating a glossary term in the Glossary terms pane." border="true" lightbox="../media/4-glossary-terms.png":::

Microsoft Purview provides default attributes that you can use when you create glossary terms. You can also import glossary terms from CSV files. Before you import them, remove any terms in the file that duplicate existing terms or existing terms will be overwritten, which will break the connection they have with existing assets.

Use the **Glossary insight** report to understand information such as the distribution of glossary terms by status, or how many of the glossary terms are attached to particular assets.

### Classification insight

Microsoft Purview can automatically classify your discovered assets using built-in classifications. These classifications are set up as part of either the system default scan rule set, or any custom scan rule that you create. Typically, the default classifications rules meet most customers’ demands. You can also create your own classification rule, by using one of the following:

- Regular expression (regex). This method uses regular expression patterns. Microsoft Purview also provides a feature to generate a suggested regex pattern.

- Dictionary. This method contains lists of values in the dictionary file.

>[!Tip] 
>Microsoft Purview uses the same sensitive-information types as Microsoft 365. This makes it easier to use existing Microsoft 365 security policies and protection across your entire data estate.

Use the **classification insight** report to get an overview of the number of:

- Classified assets.

- Unique classifications found in your data.

- Classified sources found.

- Classified files found.

- Classified tables found.

### Sensitivity labels insight

Use sensitivity labels to indicate the sensitivity of your organization’s data. For example, you can apply a sensitivity label to a project name that’s confidential within your organization, even though that same term isn’t confidential in other organizations.

Applying sensitivity labels to assets ensures that you can properly classify and protect the important assets in your organization. You can apply sensitivity labels manually or automatically based on the sensitivity of discovered data. Also, you can create autolabeling rules to include one or more classifications or types of sensitive information.

The **Sensitivity label insights** report has details about the sensitivity labels found during a scan. It includes the following detailed information:

- Top labels applied across sources

- Top labels applied to files

- Top labels applied to tables

- Labeling activity

:::image type="content" source="../media/4-sensitivity-labels.png" alt-text="Screenshot that depicts the Sensitivity labels insights (preview) pane." border="true" lightbox="../media/4-sensitivity-labels.png":::
