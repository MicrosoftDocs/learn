In this exercise, we edit, certify, move, and delete some assets!

## Edit assets

You can edit assets both individually and in bulk. We're going to do both in this example.

### Individual

1. In the data catalog, search for one of your data assets. If you completed the exercise **Deploy Microsoft Purview and Scan Azure Data Lake Storage (ADLS) Gen 2**, and uploaded the dataset. You can use the same dataset we're using in our example. We searched for the keyword 'country' and selected the **Queries by Country** asset.

1. Once you open your data asset, select the **Edit** option in the asset action bar.

    :::image type="content" source="../media/manage-assets-exercise/edit-queries-by-country-inline.png" alt-text="Screenshot of an asset in Microsoft Purview with the edit button highlighted in the action menu." lightbox="../media/manage-assets-exercise/edit-queries-by-country.png":::

1. From the **Edit** menu, we're able to edit all the basic aspects of an asset. On the **Overview** page, you can:
    1. Update the name to a friendlier name.
    1. Add a description to your asset.
    1. Add classifications to the entire asset.
    1. Add glossary terms to the entire asset.
    1. Certify your data asset, if you're a **data curator**.
    1. Add managed attributes to your asset.

    :::image type="content" source="../media/manage-assets-exercise/edit-asset-inline.png" alt-text="Screenshot of the edit asset page with the Overview tab highlighted." lightbox="../media/manage-assets-exercise/edit-asset.png":::

1. In the **Schema** tab, you can:
    1. Update the column names to friendly names
    1. Add column-level classifications
    1. Add column-level glossary terms
    1. Update the data type of a column
    1. Add descriptors to individual columns

    :::image type="content" source="../media/manage-assets-exercise/edit-asset-schema.png" alt-text="Screenshot of the edit asset page with the Schema tab highlighted.":::

1. In the **Contacts** tab, you can add experts who can answer questions for others about the data asset, or owners who can manage the life cycle of the data asset.

    :::image type="content" source="../media/manage-assets-exercise/edit-asset-contacts.png" alt-text="Screenshot of the edit asset page with the Contacts tab highlighted.":::

1. Once you make changes or updates, be sure to save them using the **Save** button at the bottom of the page.

    :::image type="content" source="../media/manage-assets-exercise/save-edits-inline.png" alt-text="Screenshot of the edit asset page with the Save button highlighted at the bottom." lightbox="../media/manage-assets-exercise/save-edits.png":::

### Bulk

Now that we made an edit to an individual asset, let's add some information across multiple attributes. Let's add an owner to several attributes at once.

1. Open a data asset, and in th asset action bar, select **Select for bulk edit**

    :::image type="content" source="../media/manage-assets-exercise/select-for-bulk-edit.png" alt-text="Screenshot of an asset in Microsoft Purview with the Select for bulk edit button highlighted in the action menu.":::

1. Now you can see new options are available:
    - **Remove from bulk edit** - which you can use to deselect an asset from bulk editing
    - **View selected** - which you can use to see a full list of all your selected assets.

    :::image type="complex" source="../media/manage-assets-exercise/new-options.png" alt-text="Screenshot of the asset page.":::
        "Asset page with the Select for Bulk button is changed to 'Remove from bulk' and the view selected button highlighted at the bottom."
    :::image-end:::

1. Return to the data catalog using the breadcrumb at the top of the asset page.

    :::image type="content" source="../media/manage-assets-exercise/breadcrumb.png" alt-text="Screenshot of the data asset with the Data Catalog breadcrumb highlighted at the top of the page.":::

1. We search for "state", so we can find the **QueriesByState** asset. We can open this asset and select **Select for bulk edit** like we did before. We can also select an asset for bulk edit directly from the search menu by selecting the check box next to the asset's name.

    :::image type="content" source="../media/manage-assets-exercise/select-asset-inline.png" alt-text="Screenshot of the asset search return results, with a check box highlighted on the right  of the top result." lightbox="../media/manage-assets-exercise/select-asset.png":::

1. Now that we selected at least two assets, select the **View selected** button at the bottom of the page.

    :::image type="content" source="../media/manage-assets-exercise/view-selected-inline.png" alt-text="Screenshot of the same returned results, with the view selected button highlighted at the bottom of the page." lightbox="../media/manage-assets-exercise/view-selected.png":::

1. Here we can see all our selected assets listed with some other details about them. We can deselect any assets we don't want in the list. We can close the list to select more. We can close and deselect all these assets, or we can select **Bulk edit** at the top of the page. Let's select **Bulk edit** at the top of the page.

    :::image type="content" source="../media/manage-assets-exercise/select-bulk-edit-inline.png" alt-text="Screenshot of the selected assets page with the bulk edit button highlighted at the top." lightbox="../media/manage-assets-exercise/select-bulk-edit.png":::

1. On the Bulk edit page, we can select multiple attributes to edit. In the following example, we made an update to Owner, so we can select Classification, Term, Expert, or Certified. We'll discuss terms in the next section, so let's select Classification.

    :::image type="content" source="../media/manage-assets-exercise/select-attribute-to-modify-inline.png" alt-text="Screenshot of the Edit bulk asset page with the first dropdown selected, showing all options, with classification highlighted." lightbox="../media/manage-assets-exercise/select-attribute-to-modify.png":::

1. Next we can select the operation, so we can add, replace with, or remove. Let's select Add.

    :::image type="content" source="../media/manage-assets-exercise/select-operation-inline.png" alt-text="Screenshot of the Edit bulk asset page with the second dropdown selected, showing all options, with add highlighted." lightbox="../media/manage-assets-exercise/select-operation.png":::

1. Lastly we choose the values, in this case, classification values. We can select multiple values to add at the same time. Let's select **U.S. Zip Codes** and **World Cities**

    :::image type="content" source="../media/manage-assets-exercise/select-classifications-to-add-inline.png" alt-text="Screenshot of the Edit bulk asset page with the third dropdown selected, a range of options, with some selected." lightbox="../media/manage-assets-exercise/select-classifications-to-add.png":::

1. If you want to add any more attributes, you can select **Select a new attribute**.

    :::image type="content" source="../media/manage-assets-exercise/select-add-new-attribute-inline.png" alt-text="Screenshot of the Edit bulk asset page with the select a new attribute button highlighted at the bottom." lightbox="../media/manage-assets-exercise/select-add-new-attribute.png":::

1. Once your updates are ready, select **Apply** to apply the changes to your attributes.

    :::image type="content" source="../media/manage-assets-exercise/select-apply-inline.png" alt-text="Screenshot of the Edit bulk asset page with the Apply button highlighted at the bottom of the page." lightbox="../media/manage-assets-exercise/select-apply.png":::

1. It might take a couple minutes for the changes to finish applying. Once they do, we can open one of our new attributes to verify our updates. In the **Overview** of QueriesByState, we can see our two new classifications **U.S. Zip Codes** and **World Cities**

    :::image type="content" source="../media/manage-assets-exercise/bulk-edited-detail-view.png" alt-text="Screenshot of the asset page with the overview tab selected and our new classifications shown." :::

## Asset certification

Certifying an asset tells users it's trustworthy data that's ready to use, and boosts the asset in search results in the data catalog.

1. To certify an asset, you need to have the data curator role in the collection where the data asset lives.

    :::image type="content" source="../media/manage-assets-exercise/data-curators.png" alt-text="Screenshot of a collection in Microsoft Purview with data curators shown in the role assignments menu." :::

1. An asset should be reviewed and have its description and other aspects updated and regularly maintained before certifying it. Though a review isn't required, it allows you to verify that it's a good data source for use.

1. To mark an asset as certified, navigate to the asset details of your asset and select **Edit**.

    :::image type="content" source="../media/manage-assets-exercise/edit-queries-by-country-inline.png" alt-text="Screenshot of an asset page in Microsoft Purview, with the edit button selected." lightbox="../media/manage-assets-exercise/edit-queries-by-country.png":::

1. On the **Overview** page, toggle the **Certified** field to **Yes**.

    :::image type="content" source="../media/manage-assets-exercise/select-certified.png" alt-text="Screenshot of the edit asset page, with the overview tab highlighted, and the certified option highlighted.":::

1. Select **Save** to save your changes.

    :::image type="content" source="../media/manage-assets-exercise/certified-select-save.png" alt-text="Screenshot of the edit asset page, with the save button highlighted.":::

1. Your asset now has a **Certified** label visible to all users.

    :::image type="content" source="../media/manage-assets-exercise/certified-inline.png" alt-text="Screenshot of the asset page, now showing a certified tag next to the name of the asset." lightbox="../media/manage-assets-exercise/certified.png":::

## Moving an asset

You can also move an asset into any subcollections below the collection where it was originally scanned.

1. Open the details of your asset to the overview page.

    :::image type="content" source="../media/manage-assets-exercise/asset-details-overview-inline.png" alt-text="Screenshot of an asset page with the Overview tab highlighted." lightbox="../media/manage-assets-exercise/asset-details-overview.png":::

1. Select the ellipsis button next to the **Collection path** of the asset.

    :::image type="content" source="../media/manage-assets-exercise/ellipsis-button-inline.png" alt-text="Screenshot of an asset page with the ellipsis button on the right of the collection path highlighted." lightbox="../media/manage-assets-exercise/ellipsis-button.png":::

1. Select **Move to another collection**

    :::image type="content" source="../media/manage-assets-exercise/move-to-another-collection-inline.png" alt-text="Screenshot of the asset page with the move to another collection option highlighted after selecting the ellipsis button." lightbox="../media/manage-assets-exercise/move-to-another-collection.png":::

1. In the right side panel, choose the target collection you want to move to. You can only see collections where you have write permissions, and the asset can only be added to subcollections of the data source collection.

    :::image type="content" source="../media/manage-assets-exercise/select-a-collection-inline.png" alt-text="Screenshot of the move menu, with the collection dropdown option highlighted, showing all available collections." lightbox="../media/manage-assets-exercise/select-a-collection.png":::

1. Select **Move**.

    :::image type="content" source="../media/manage-assets-exercise/select-move-inline.png" alt-text="Screenshot of the move menu, with the move button highlighted at the bottom of the page." lightbox="../media/manage-assets-exercise/select-move.png":::

1. Now we can see our collection path is modified, and our resource is moved to the **Finance** subcollection.

    :::image type="content" source="../media/manage-assets-exercise/new-collection-path-inline.png" alt-text="Screenshot of the asset page, with the collection path now showing the asset under the new subcollection." lightbox="../media/manage-assets-exercise/new-collection-path.png":::