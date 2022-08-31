In this exercise, we'll edit, certify, move, and delete some assets!

## Edit assets

You can edit assets both individually and in bulk. We'll do both in this example.

### Individual

1. In the [Azure portal](https://portal.azure.com/), open your Microsoft Purview account and select **Open Microsoft Purview Governance Portal**.

    :::image type="content" source="../media/manage-assets-exercise/azure-portal.png" alt-text="<alt text>":::

1. The Microsoft Purview Governance Portal opens automatically to the home page of the Microsoft Purview Data Catalog.

    :::image type="content" source="../media/manage-assets-exercise/data-catalog-homepage-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/data-catalog-homepage.png":::

1. Search for one of your data assets. If you completed the 'Deploy Microsoft Purview and Scan ADLS Gen 2' excercise before this one, and uploaded the dataset, you can use the same one as we're using in our example. We searched for the keyword 'country' and will select the **Queries by Country** asset.

1. Once you have opened your data asset, select the **Edit** option in the asset action bar.

    :::image type="content" source="../media/manage-assets-exercise/edit-queries-by-country-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/edit-queries-by-country.png":::

1. From this menu we will be able to edit all the basic aspects of an asset. From the **Overview** page, you can:
    1. Update the name to a friendlier name
    1. Add a description to your asset
    1. Add classifications to the entire asset
    1. Add glossary terms to the entire asset
    1. If you are a **data curator** you can certify your data asset
    1. Add managed attributes to your asset.

    :::image type="content" source="../media/manage-assets-exercise/edit-asset-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/edit-asset.png":::

1. In the schema tab, you can:
    1. Update the column names to friendly names
    1. Add column-level classifications
    1. Add column-level glossary terms
    1. Update the data type of a column
    1. Add descriptors to individual columns

    :::image type="content" source="../media/manage-assets-exercise/edit-asset-schema.png" alt-text="<alt text>":::

1. In the contacts tab, you can add experts who can answer questions for others about the data asset, or owners who can manage the life cycle of the data asset.

    :::image type="content" source="../media/manage-assets-exercise/edit-asset-schema.png" alt-text="<alt text>":::

1. Once you have made any changes or updates, be sure to save them using the **Save** button at the bottom of the page.

    :::image type="content" source="../media/manage-assets-exercise/save-edits-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/save-edits.png":::

### Bulk

Now that we've made an edit to an individual asset, let's add some information across multiple attributes. Let's add an owner to several attributes at once.

1. Open a data asset, and in th asset action bar, select **Select for bulk edit**

    :::image type="content" source="../media/manage-assets-exercise/select-for-bulk-edit.png" alt-text="<alt text>":::

1. Now you can see new options are available:
    - **Remove from bulk edit** - which you can use to deselect an asset from bulk editing
    - **View selected** - which you can use to see a full list of all your selected assets.

    :::image type="content" source="../media/manage-assets-exercise/new-options.png" alt-text="<alt text>":::

1. Return to the data catalog using the breadcrumb at the top of the asset page.

    :::image type="content" source="../media/manage-assets-exercise/breadcrumb.png" alt-text="<alt text>":::

1. We'll search for "state", so we can find the **QueriesByState** asset. We can open this asset and select **Select for bulk edit** like we did before, but we can also select an asset for bulk edit directly from the search menu. To do this, select the check box next to the asset's name.

    :::image type="content" source="../media/manage-assets-exercise/select-asset-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/select-asset.png":::

1. Now that we've selected at least two assets, select the **View selected** button at the bottom of the page.

    :::image type="content" source="../media/manage-assets-exercise/view-selected-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/view-selected.png":::

1. Here we can see all the assets we've selected listed with some additional details about them. We can deselect any we don't want in the list, we can close the list to select more, we can close and deselect all these assets, or we can select **Bulk edit** at the top of the page. Let's select **Bulk edit** at the top of the page.

    :::image type="content" source="../media/manage-assets-exercise/select-bulk-edit-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/select-bulk-edit.png":::

1. On the Bulk edit page we can select multiple attributes to edit. In our example below, we've already made an update to Owner, so we can select Classification, Term, Expert, or Certified. We'll discuss terms in the next section, so let's select Classification.

    :::image type="content" source="../media/manage-assets-exercise/select-attribute-to-modify-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/select-attribute-to-modify.png":::

1. Next we can select the operation, so we can add, replace with, or remove. Let's select Add.

    :::image type="content" source="../media/manage-assets-exercise/select-operation-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/select-operation.png":::

1. Lastly we'll choose the values, in this case, classification values. We can select multiple values to add at the same time. Let's select **U.S. Zip Codes** and **World Cities**

    :::image type="content" source="../media/manage-assets-exercise/select-classifications-to-add-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/select-classifications-to-add.png":::

1. If you want to add any more attributes, you can select **Select a new attribute**.

    :::image type="content" source="../media/manage-assets-exercise/select-add-new-attribute-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/select-add-new-attribute.png":::

1. Once your updates are ready, select **Apply** to apply the changes to your attributes.

    :::image type="content" source="../media/manage-assets-exercise/select-apply-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/select-apply.png":::

1. It may take a couple minutes for the changes to finish applying. Once they do, we can open one of our new attributes to verify our updates. In the **Overview** of QueriesByState, we can see our two new classifications **U.S. Zip Codes** and **World Cities**

    :::image type="content" source="../media/manage-assets-exercise/bulk-edited-detail-view.png" alt-text="<alt text>" :::

## Asset certification

1. You'll need to have the data curator role in the collection where a data asset lives in order to be able to certify an asset.

    :::image type="content" source="../media/manage-assets-exercise/data-curators.png" alt-text="<alt text>" :::

1. Though it is not required, an asset should be reviewed and have its description and other aspects updated and regularly maintained before it is certified, to verify that it is a good data source for use.

1. To mark an asset as certified, navigate to the asset details of your asset and select **Edit**.

    :::image type="content" source="../media/manage-assets-exercise/edit-queries-by-country-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/edit-queries-by-country.png":::

1. On the **Overview** page, toggle the **Certified** field to **Yes**.

    :::image type="content" source="../media/manage-assets-exercise/select-certified.png" alt-text="<alt text>":::

1. Select **Save** to save your changes.

    :::image type="content" source="../media/manage-assets-exercise/certified-select-save.png" alt-text="<alt text>":::

1. Your asset will now have a **Certified** label visible to all users.

    :::image type="content" source="../media/manage-assets-exercise/certified-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/certified.png":::

## Moving an asset

1. Open the details of your asset to the overview page.

    :::image type="content" source="../media/manage-assets-exercise/asset-details-overview-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/asset-details-overview.png":::

1. Select the ellipsis button next to the **Collection path** of the asset.

    :::image type="content" source="../media/manage-assets-exercise/ellipsis-button-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/ellipsis-button.png":::

1. Select **Move to another collection**

    :::image type="content" source="../media/manage-assets-exercise/move-to-another-collection-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/move-to-another-collection.png":::

1. In the right side panel, choose the target collection you want to move to. You can only see collections where you have write permissions, and the asset can only be added to subcollections of the data source collection.

    :::image type="content" source="../media/manage-assets-exercise/select-a-collection-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/select-a-collection.png":::

1. Select **Move**.

    :::image type="content" source="../media/manage-assets-exercise/select-move-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/select-move.png":::

1. Now we can see our collection path has been modified, and our resource has been moved to the **Finance** subcollection.

    :::image type="content" source="../media/manage-assets-exercise/new-collection-path-inline.png" alt-text="<alt text>" lightbox="../media/manage-assets-exercise/new-collection-path.png":::