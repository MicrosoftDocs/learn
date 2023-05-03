In this exercise, we'll use the data catalog to search and browse for data and look at the details of an asset.

## Open the data catalog

1. In the [Azure portal](https://portal.azure.com/), open your Microsoft Purview account and select **Open Microsoft Purview Governance Portal**.

    :::image type="content" source="../media/browse-and-search-exercise/azure-portal.png" alt-text="Screenshot of Microsoft Purview account page in the Azure portal, with the Open Microsoft Purview Governance Portal button highlighted.":::

1. The Microsoft Purview Governance Portal opens automatically to the home page of the Microsoft Purview Data Catalog.

    :::image type="content" source="../media/browse-and-search-exercise/data-catalog-homepage-inline.png" alt-text="Screenshot of the Microsoft Purview governance portal open to the home page, which is the data catalog." lightbox="../media/browse-and-search-exercise/data-catalog-homepage.png":::

1. From here you can use the search bar to search for data assets.

    :::image type="content" source="../media/browse-and-search-exercise/search-from-home-inline.png" alt-text="Screenshot of the data catalog home page, with the search bar in the middle of the page highlighted." lightbox="../media/browse-and-search-exercise/search-from-home.png":::

1. You can also select the **Browse assets** button below the search bar, or the **Browse** tab on the left side menu to browse through your data assets.

    :::image type="content" source="../media/browse-and-search-exercise/browse-from-homepage-inline.png" alt-text="Screenshot of the data catalog page with the Browse Assets button highlighted in the middle of the page, and the browse folder highlighted in the left menu." lightbox="../media/browse-and-search-exercise/browse-from-homepage.png":::

1. You can return to the data catalog from anywhere in the Microsoft Purview governance portal by selecting the Data Catalog icon at the top of the left side menu:

    :::image type="content" source="../media/browse-and-search-exercise/data-catalog-menu.png" alt-text="Screenshot of the Microsoft Purview Left hand menu, with the top icon, the data catalog icon, highlighted.":::

## Browse the data catalog

1. To browse the data catalog, return to the data catalog page, and select the **Browse assets** button below the search bar or the **Browse** tab on the left side menu to browse through your data assets.

    :::image type="content" source="../media/browse-and-search-exercise/browse-from-homepage-inline.png" alt-text="Repeated screenshot of the data catalog page with the Browse Assets button highlighted in the middle of the page, and the browse folder highlighted in the left menu." lightbox="../media/browse-and-search-exercise/browse-from-homepage.png":::

1. You can choose to browse the data catalog either by collection, or by source type.

    >[!TIP]
    >Users can only see data sources and assets in the collections they have access to.

    :::image type="content" source="../media/browse-and-search-exercise/browse-asset-options-inline.png" alt-text="Screenshot of the browse assets page, currently shown sorted by collection with the selection menu highlighted in the middle of the page." lightbox="../media/browse-and-search-exercise/browse-asset-options.png":::

    :::image type="content" source="../media/browse-and-search-exercise/browse-asset-options-source-type-inline.png" alt-text="Screenshot of the browse assets page, currently shown sorted by source type with the selection menu highlighted in the middle of the page." lightbox="../media/browse-and-search-exercise/browse-asset-options-source-type.png":::

1. When you browse by collection and select a collection, you'll see a list of all assets in that collection. You can narrow down results using the asset facets on the left hand menu, or return to the collection list using the collection list button at the top of the left menu.

    :::image type="content" source="../media/browse-and-search-exercise/browsing-by-collection-inline.png" alt-text="Screenshot of the browse assets page, showing all assets in a particular collection. The view collection tree button is highlighted in the left menu." lightbox="../media/browse-and-search-exercise/browsing-by-collection.png":::

1. When you browse by data source type, you select a source type and all the sources of that type that you have access to will be listed. Selecting the source will list all the assets available in that source, and you can use the breadcrumbs above the asset lists and at the top of the source window to return to sources or browsing.

    :::image type="content" source="../media/browse-and-search-exercise/browse-by-source-type-list-inline.png" alt-text="Screenshot of browsing by source types, showing all sources under the ADLS Gen 2 source type." lightbox="../media/browse-and-search-exercise/browse-by-source-type-list.png":::

    :::image type="content" source="../media/browse-and-search-exercise/browse-by-source-type-assets-inline.png" alt-text="Screenshot of browsing by source type, showing all assets under an available ADLS Gen 2 source." lightbox="../media/browse-and-search-exercise/browse-by-source-type-assets.png":::

## Search the data catalog

1. To start a search for data in the data catalog, you can use the search bar in the home page using keywords for name, data type, classification, or glossary terms.

    :::image type="content" source="../media/browse-and-search-exercise/search-from-home-inline.png" alt-text="Screenshot of the data catalog home page, with the search bar highlighted in the middle and the search term country typed in. Several results are shown." lightbox="../media/browse-and-search-exercise/search-from-home.png":::

1. The search bar is also available throughout the Microsoft Purview governance portal. For example, here in the data map, the data catalog search bar is in the top middle of the screen:

    :::image type="content" source="../media/browse-and-search-exercise/catalog-search-bar-inline.png" alt-text="Screenshot of the data map page in the Microsoft Purview governance portal, with the search catalog bar highlighted in the top middle of the page." lightbox="../media/browse-and-search-exercise/catalog-search-bar.png":::

1. Select the **Enter** key to enter your search or select **View search results** at the bottom of the returned results, and Microsoft Purview will return a full list of data assets and glossary terms that match your keywords.

    :::image type="content" source="../media/browse-and-search-exercise/data-catalog-search-page-inline.png" alt-text="Screenshot of a data catalog search with a full list of assets returned from a search for the keyword country." lightbox="../media/browse-and-search-exercise/data-catalog-search-page.png":::

1. In the data catalog search, you can use the asset facets on the left side menu to filter results by other metadata, like collection, classification, and asset type. For some of these classifications, you can choose to filter options by **or** or **and** statements.

    :::image type="content" source="../media/browse-and-search-exercise/and-or-options-inline.png" alt-text="Screenshot of the data catalog search page, with the ellipsis button pressed next to the classifications option to show the filter options.cd" lightbox="../media/browse-and-search-exercise/and-or-options.png":::

1. The data catalog also supports a light search query syntax using keywords. Keywords can be a classification, a glossary term, asset description, or an asset name. Try using these search operators to refine your search:

    | Operator | Definition | Example |
    | -------- | ---------- | ------- |
    | OR | Specifies that an asset must have at least one of the two keywords. Must be in all caps. A white space is also an OR operator.  | The query `hive OR database` returns assets that contain 'hive' or 'database' or both. |
    | AND | Specifies that an asset must have both keywords. Must be in all caps | The query `hive AND database` returns assets that contain both 'hive' and 'database'. |
    | NOT | Specifies that an asset can't contain the keyword to the right of the NOT clause. Must be in all caps  | The query `hive NOT database` returns assets that contain 'hive', but not 'database'. |
    | () | Groups a set of keywords and operators together. When you combine multiple operators, parentheses specify the order of operations. | The query `hive AND (database OR warehouse)` returns assets that contain 'hive' and either 'database' or 'warehouse', or both. |
    | "" | Specifies exact content in a phrase that the query must match to. | The query `"hive database"` returns assets that contain the phrase "hive database" in their properties |
    | field: keyword | Searches the keyword in a specific attribute of an asset. Field search is case insensitive and is limited to the following fields at this time:  name, description, entityType, assetType, classification, term, contact | The query `description: German` returns all assets that contain the word "German" in the description. The query `term:Customer` will return all assets with glossary terms that include "Customer" and all glossary terms that match to "Customer". |

    > [!TIP]
    > Searching "*" will return all the assets and glossary terms in the catalog.

## Looking at an asset

When you select an asset in the data catalog, there's much information to look at. Using the chart below, we'll go through the page to discuss what you can see:

:::image type="complex" source="../media/browse-and-search-exercise/asset-view-inline.png" alt-text="Screenshot of an asset in the Microsoft Purview Data Catalog, each of its parts labeled." lightbox="../media/browse-and-search-exercise/asset-view.png":::
   "1. The breadcrumb list of links at the top of the page. 2. A label that says certified next to the name of the asset. 3. The asset action bar in the middle of the page. 4. Tabs for the asset window. 5. The asset description on the overview page. 6. Classifications on the overview page. 7. Schema classifications on the overview page. 8. On the right side of the page, the navigational hierarchies. 9. On the bottom right of the page, the associated glossary terms."
:::image-end:::

1. **Breadcrumbs** at the top of the page will lead you back through your selections to the data catalog.
1. **Assets can be certified** by data stewards in your Microsoft Purview account. This means the asset is endorsed by the data steward as ready to be used.
1. **The asset action bar** contains several options, that users will only have access to depending on their role:
    1. Edit - allows you to edit the fascets of the asset.
    1. Select for bulk edit - allows you to select this asset to be updated alongside others.
    1. Request access - if you don't have access to a data asset you need, you can request access directly in Microsoft Purview using this button.
    1. Refresh - refresh this asset page.
    1. Delete - delete the asset.
1. **The navigation tabs** inside the asset window provide information views for the asset:
    1. Overview - Provides a summary of basic information about the asset. We'll discuss some of these in the next steps.
    1. Properties - metadata bout the asset including modified time and related assets.
    1. Schema - provides the schema of the data, like column names with their classifications, sensitivity labels, and related glossary terms.
    1. Lineage - if the Microsoft Purview account is connected to other data processing and analytics systems, like data factory, lineage of a data asset will be displayed here so users can see where it comes from and how it's used.
    1. Contacts - experts and owners can be assigned to a data asset, and found here under the contacts page.
    1. Related - other data assets related to this one are listed here.
1. **Asset description** is added by data stewards or owners, and should give a description of the contents.
1. **Classifications** are annotations that can be used to describe an asset or a column, and can be added by data owners and stewards.
1. **Schema classifications** are applied to a specific column in the asset during the scanning process.
1. **The collection path and hierarchy** give context to where a data asset is stored.
1. **Glossary terms** are business terms created by your organization that provide context for an asset.
