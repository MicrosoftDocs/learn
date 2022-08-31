In this exercise we're going to create a term in the business glossary, update our term, create a term template, and add a term to an asset.

## Create terms

### Single

1. Open the data catalog and select **Manage glossary** on the home page menu. Or in the left menu when you're in the data catalog, select **Glossary**

1. On the glossary terms page select **+ New term**, and a page will open showing available templates.

1. We'll talk about creating term templates later in this exercise, for now, let's choose the **System default** template and select **Continue**.

1. Give your new term a name, which must be unique in the catalog, and is case sensitive.

1. Add a definition. You can use rich text in the definition to include hyperlinks or even tables.

1. Set the status for the term.

1. Add resources, an approved Acronym, and a parent term if applicable.

1. Open the **Related** tab, and apply related terms and synonyms if applicable.

1. Open the **Contacts** tab to add experts and stewards to your term, if applicable.

1. Select **Create** to create your term.

### Bulk

You can also import many terms into the data catalog at one time using a .csv file. Entries to your csv should look like this:
    - "Name","Nick Name","Status","Definition","Acronym","Resources","Related Terms;Separated by semicolons","Synonyms","Stewards","Experts","Parent Term Name","IsDefinitionRichText(True/False)","Term Template Names"

1. To import these terms to the glossary, open the data glossary and select **Import terms** in the top menu.

1. Select the term template you want to use. For now, let's choose **System default**.

1. There's a sample .csv available for you to download and edit. When you've added your terms as shown, upload the completed file to the import terms window. Then select **Ok**.

1. It may take a few minutes, but the system will upload the file and add all the terms to your glossary.

## Manage terms

1. Open the glossary and search for a term you want to edit. You can select the check box to the right of the term name, and select the **Edit** button at the top of the page.

1. You can also open the term itself and select the **Edit** button inside the term.

1. From here you can update any values to the term.

1. Select **Save** to make sure your edits persist.

1. In the glossary menu you can also select multiple terms and either delete these terms or export them, using the **Delete** or **Export** buttons at the top of the page.

## Create a term template

1. Open the data catalog and select **Manage term templates** in the top menu.

1. Select the **Custom** tab at the top of the manage term templates window.

1. Select **New term template**.

1. Give your template a name and description that will give other users enough information about how to use the term template.

1. Select **New attribute** to add your first attribute to your term.

1. Give your new attribute a name and a description as well.

1. Choose wether or not you want the attribute to be required by selecting **Mark as required**.

1. Choose your field type.

1. For Text, you can provide a default value. For single or multiple choice, provide all the values for choices you'll want.

1. Select **Apply**

1. Add as many other attributes as you'd like your term to have, then select **Create**.

1. Now your new term template will be available when others create terms in the business glossary. You can use these to define terms that provide the best information for your business.

## Add term to an asset

1. To add a term to a data asset, open the data catalog and search or browse for your asset.

1. Select your asset and select **Edit**

1. You can add your term to an entire data asset by selecting it under **Glossary terms** on the **Overview** page.

1. You can also add your term to a specific column in the data asset under **Glossary terms** for that column on the **Schema** page.

1. Select **Save** to save your changes.

1. Now you can see your term listed on the asset description.