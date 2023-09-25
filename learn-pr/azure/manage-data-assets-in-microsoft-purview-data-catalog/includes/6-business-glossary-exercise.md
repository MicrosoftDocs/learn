In this exercise we're going to create a term in the business glossary, update our term, add a term to an asset, and create a term template.

## Create terms

You can create terms one at a time or in bulk! In this example, we'll do both.

### Single

1. Open the data catalog and select **Manage glossary** on the home page menu. Or in the left menu when you're in the data catalog, select **Glossary**

    :::image type="content" source="../media/business-glossary-exercise/open-business-glossary-inline.png" alt-text="Screenshot of the glossary home page with the manage glossary button highlighted in the menu and glossary highlighted in the left menu." lightbox="../media/business-glossary-exercise/open-business-glossary.png":::

1. On the glossary terms page select **+ New term**, and a page will open showing available templates.

    :::image type="content" source="../media/business-glossary-exercise/select-new-term.png" alt-text="Screenshot of glossary terms page with new term button highlighted.":::

1. We'll talk about creating term templates later in this exercise. For now, let's choose the **System default** template and select **Continue**.

    :::image type="content" source="../media/business-glossary-exercise/select-default-term-template.png" alt-text="Screenshot of new term page with system default and continue buttons highlighted.":::

1. Give your new term a name, which must be unique in the catalog and is case sensitive.

    :::image type="content" source="../media/business-glossary-exercise/give-term-a-name.png" alt-text="Screenshot of new term page with the name box highlighted.":::

1. Add a definition. You can use rich text in the definition to include hyperlinks or even tables.

    :::image type="content" source="../media/business-glossary-exercise/add-a-definition.png" alt-text="Screenshot of new term page with the definition box highlighted.":::

1. Set the status for the term. Set to **Draft** if you'd like to review the term before implementing it. Set the term to **Approved** if it's ready to implement.

    :::image type="content" source="../media/business-glossary-exercise/set-status.png" alt-text="Screenshot of the new term page with the status dropdown menu open, showing all options.":::

1. Add resources, an approved Acronym, and a parent term, if applicable.

    :::image type="content" source="../media/business-glossary-exercise/add-parent-acronym-resources.png" alt-text="Screenshot of new term page with parent, acronym, and resources highlighted.":::

1. Open the **Related** tab, and add any related terms and synonyms.

    :::image type="content" source="../media/business-glossary-exercise/related.png" alt-text="Screenshot of the new term page with the related tab selected and highlighted.":::

1. Open the **Contacts** tab to add experts and stewards to your term. These will be the users that will manage the term, or that others can contact if they have questions.

    :::image type="content" source="../media/business-glossary-exercise/contacts.png" alt-text="Screenshot of the new term page with the contacts tab selected and highlighted.":::

1. Select **Create** to create your term.

    :::image type="content" source="../media/business-glossary-exercise/select-create.png" alt-text="Screenshot of the new term page with the create button highlighted at the bottom.":::

1. Now we can see our new term listed in the product glossary.

    :::image type="content" source="../media/business-glossary-exercise/new-completed-term.png" alt-text="Screenshot of the glossary page, showing the newly created term.":::

### Bulk

You can also import many terms into the data catalog at one time using a .csv file. Entries to your csv should look like this:

```
"Name","Nick Name","Status","Definition","Acronym","Resources","Related Terms;Separated by semicolons","Synonyms","Stewards","Experts","Parent Term Name","IsDefinitionRichText(True/False)","Term Template Names"
```

A full sample CSV will be provided in the steps below.

1. To import these terms to the glossary, open the data glossary and select **Import terms** in the top menu.

    :::image type="content" source="../media/business-glossary-exercise/select-import-terms-inline.png" alt-text="Screenshot of the glossary page with the Import terms button highlighted in the action menu." lightbox="../media/business-glossary-exercise/select-import-terms.png":::

1. Select the term template you want to use. For now, let's choose **System default**.

    :::image type="content" source="../media/business-glossary-exercise/select-default-term-template-for-bulk-inline.png" alt-text="Screenshot of the import terms page with the Continue button highlighted at the bottom." lightbox="../media/business-glossary-exercise/select-default-term-template-for-bulk.png":::

1. There's a sample .csv available for you to download and edit. Download the CSV and use it as a template to complete your terms.

    >[!TIP]
    >When using the sample CSV, remember to remove the first example row before uploading your CSV.

    :::image type="content" source="../media/business-glossary-exercise/download-sample-csv-inline.png" alt-text="Screenshot showing import terms page with the download a sample csv button highlighted." lightbox="../media/business-glossary-exercise/download-sample-csv.png":::

1. When you've added your terms as shown, upload the completed file to the import terms window. Then select **Ok**.

    :::image type="content" source="../media/business-glossary-exercise/upload-terms-and-select-okay-inline.png" alt-text="Screenshot of the import terms page, showing a loaded sample file and the ok button highlighted." lightbox="../media/business-glossary-exercise/upload-terms-and-select-okay.png":::

1. It may take a few minutes, but the system will upload the file and add all the terms to your glossary.

    :::image type="content" source="../media/business-glossary-exercise/importing-terms-inline.png" alt-text="Screenshot of the terms page with an 'import in progress' pop up showing the import progress." lightbox="../media/business-glossary-exercise/importing-terms.png":::

## Manage terms

1. Open the glossary and search for a term you want to edit. You can select the check box to the right of the term name, and select the **Edit** button at the top of the page.

    :::image type="content" source="../media/business-glossary-exercise/select-term-and-edit-inline.png" alt-text="Screenshot of the glossary terms page with the edit button highlighted and a term selected using the check button." lightbox="../media/business-glossary-exercise/select-term-and-edit.png":::

1. You can also open the term itself and select the **Edit** button inside the term.

    :::image type="content" source="../media/business-glossary-exercise/select-edit-inside-term-inline.png" alt-text="Screenshot of a term in the glossary, with the edit button highlighted in the action bar." lightbox="../media/business-glossary-exercise/select-edit-inside-term.png":::

1. From here you can update any values to the term.

1. Select **Save** to make sure your edits persist.

    :::image type="content" source="../media/business-glossary-exercise/save-changes-inline.png" alt-text="Screenshot of the term edit screen with the save button highlighted." lightbox="../media/business-glossary-exercise/save-changes.png":::

1. In the glossary menu you can also select multiple terms and either delete these terms or export them, using the **Delete** or **Export** buttons at the top of the page.

    :::image type="content" source="../media/business-glossary-exercise/export-or-delete-bulk-inline.png" alt-text="Screenshot of the glossary with multiple terms selected, showing the now-available export and delete actions." lightbox="../media/business-glossary-exercise/export-or-delete-bulk.png":::

## Add term to an asset

1. To add a term to a data asset, open the data catalog and search or browse for your asset.

    :::image type="content" source="../media/business-glossary-exercise/select-asset-inline.png" alt-text="Screenshot of a selected asset in the data catalog." lightbox="../media/business-glossary-exercise/select-asset.png":::

1. Select your asset and select **Edit**

    :::image type="content" source="../media/business-glossary-exercise/select-edit-inline.png" alt-text="Screenshot of an asset page with the edit button highlighted in the action menu." lightbox="../media/business-glossary-exercise/select-edit.png":::

    >[!TIP]
    >You can also add a glossary term to multiple assets using bulk editing, like we discussed in the last section.

1. You can add your term to an entire data asset by selecting it under **Glossary terms** on the **Overview** page.

    :::image type="content" source="../media/business-glossary-exercise/add-glossary-term-inline.png" alt-text="Screenshot of the edit asset page on the overview tab, with the glossary terms dropdown highlighted and a single term selected." lightbox="../media/business-glossary-exercise/add-glossary-term.png":::

1. You can also add your term to a specific column in the data asset under **Glossary terms** for that column on the **Schema** page.

    :::image type="content" source="../media/business-glossary-exercise/select-schema-glossary-term-inline.png" alt-text="Screenshot of the edit asset page on the schema tab, with the glossary terms dropdown highlighted in one row and a single term selected." lightbox="../media/business-glossary-exercise/select-schema-glossary-term.png":::

1. Select **Save** to save your changes.

    :::image type="content" source="../media/business-glossary-exercise/select-save-inline.png" alt-text="Screenshot of the edit asset page with the save button highlighted at the bottom." lightbox="../media/business-glossary-exercise/select-save.png":::

1. Now you can see your term listed on the asset description.

    :::image type="content" source="../media/business-glossary-exercise/see-added-glossary-term-inline.png" alt-text="Screenshot of the asset page, showing the newly applied term under glossary terms." lightbox="../media/business-glossary-exercise/see-added-glossary-term.png":::

## Create a term template

1. Open the data catalog and select **Manage term templates** in the top menu.

    :::image type="content" source="../media/business-glossary-exercise/manage-term-templates-inline.png" alt-text="Screenshot of the glossary page, showing the manage term template button highlighted in the action bar." lightbox="../media/business-glossary-exercise/manage-term-templates.png":::

1. Select the **Custom** tab at the top of the manage term templates window.

    :::image type="content" source="../media/business-glossary-exercise/select-custom-inline.png" alt-text="Screenshot of the manage term templates window with the 'Custom' tab highlighted." lightbox="../media/business-glossary-exercise/select-custom.png":::

1. Select **New term template**.

    :::image type="content" source="../media/business-glossary-exercise/select-new-term-template-inline.png" alt-text="Screenshot of the manage term templates page on the custom tab with the new term template button highlighted." lightbox="../media/business-glossary-exercise/select-new-term-template.png":::

1. Give your template a name and description that will give other users enough information about how to use the term template.

    :::image type="content" source="../media/business-glossary-exercise/name-and-description.png" alt-text="Screenshot of new term template page with the template name and description boxes highlighted.":::

1. Select **New attribute** to add your first attribute to your term.

    :::image type="content" source="../media/business-glossary-exercise/select-new-attribute.png" alt-text="Screenshot of new term template page with the new attribute button highlighted.":::

1. Give your new attribute a name and a description as well.

    :::image type="content" source="../media/business-glossary-exercise/attribute-name-and-description.png" alt-text="Screenshot of new attribute page with the name and description buttons highlighted.":::

1. Choose whether or not you want the attribute to be required to create a term by selecting **Mark as required**.

    :::image type="content" source="../media/business-glossary-exercise/mark-as-required.png" alt-text="Screenshot of new attribute page with mark as required check button highlighted.":::

1. Choose your field type.

    :::image type="content" source="../media/business-glossary-exercise/select-field-type.png" alt-text="Screenshot of new attribute page with the field type dropdown highlighted.":::

1. For Text, you can provide a default value. For single or multiple choice, provide all the values for choices you'll want.

    :::image type="content" source="../media/business-glossary-exercise/complete-field.png" alt-text="Screenshot of new attribute page showing a multiple choice field type with several example choices added.":::

1. Select **Apply**

    :::image type="content" source="../media/business-glossary-exercise/select-apply.png" alt-text="Screenshot of new attribute page with the apply button highlighted at the bottom.":::

1. Add as many other attributes as you'd like your term to have, then select **Create**.

    :::image type="content" source="../media/business-glossary-exercise/select-create-for-template.png" alt-text="Screenshot of new term template page with the create button highlighted.":::

1. Now your new term template will be available when others create terms in the business glossary. You can use these to define terms that provide the best information for your business.

    :::image type="content" source="../media/business-glossary-exercise/new-term-template-created-inline.png" alt-text="Screenshot of the glossary page with new term selected, and the newly created term template available to select." lightbox="../media/business-glossary-exercise/new-term-template-created.png":::