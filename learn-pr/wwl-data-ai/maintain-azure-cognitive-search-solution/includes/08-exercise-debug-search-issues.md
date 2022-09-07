You've built your search solution but have noticed that there are some warnings on the indexer. 

In this exercise, you'll create an Azure Cognitive Search solution, import some sample data, and then resolve a warning on the indexer.

> [!NOTE]
> To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free?azure-portal=true).


## Create your search solution

Before you can begin using a Debug Session, you need to create an Azure Cognitive Search service. 

1. [![Azure resource deploy button.](../media/deploy-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fazure-search-knowledge-mining%2Fmaster%2Fazuredeploy.json) select this button to deploy all the resources you need in the Azure portal.

    :::image type="content" source="../media/arm-template-deployment.png" alt-text="A screenshot of the arm deployment template with fields entered.":::

1. Under **Resource Group**, select **Create new**.
1. Type **acs-cognitive-search-exercise**.
1. Select the closest **Region** to you.
1. For **Resource Prefix**, enter **acslearnex**.
1. For the Location, select the same region you used above.
1. At the bottom of the pane, select **Review + create**.
1. Wait until the resource is deployed, then select **Go to resource group**.

## Import sample data

With your resources created, you can now import your source data.

1. In the listed resources, select **acslearnex-search**.

  :::image type="content" source="../media/import-data.png" alt-text="A screenshot showing the import data menu selected." lightbox="../media/import-data.png":::

1. On the **Overview** pane, select **Import data**.

  :::image type="content" source="../media/import-data-selection-screen.png" alt-text="A screenshot showing the completed fields." lightbox="../media/import-data-selection-screen.png":::
1. On the import data pane, for the Data Source, select **Samples**.
1. In the list of samples, select **hotels-sample**.
1. Select **Next:Add cognitive skills (Optional)**.

    :::image type="content" source="../media/add-enrichments.png" alt-text="A screenshot of the add enrichments options." lightbox="../media/add-enrichments.png":::

1. Expand the **Add enrichments** section.
1. Select **Text Cognitive Skills**.
1. Select **Next:Customize target index**.
1. Leave the defaults, then select **Next:Create an indexer**.
1. Select **Submit**.

## Use a debug session to resolve warnings on your indexer

The indexer will now begin to ingest 50 documents. However, if you check the status of the indexer you'll find that there's 150 warnings.

:::image type="content" source="../media/indexer-warnings.png" alt-text="A screenshot showing 150 warnings on the indexer.":::

1. Select the **Debug sessions**.

    :::image type="content" source="../media/create-new-debug-session.png" alt-text="A screenshot showing the create debus session option.":::

1. Select **+ New Debug Session**.

    :::image type="content" source="../media/connect-storage.png" alt-text="A screenshot showing new de-bug session choosing a connection.":::

1. Select **Choose an existing connection**, select the storage account.

    :::image type="content" source="../media/create-storage-container.png" alt-text="A screenshot showing creating a storage container.":::

1. Create a container named **acs-debug-storage**, then choose **Select**.
1. Select **Save Session**.

    The dependency graph shows you that for each document there's a warning on three skills.

    :::image type="content" source="../media/warning-skill-selection.png" alt-text="A screenshot showing the three warnings on an enriched document.":::

1. Select **V3**.
1. On the skills details pane, select **Errors/Warnings(1)**.
1. Expand the **Message** column so you can see details.

    The details are: 

    *Could not execute skill because one or more skill input was invalid.
    Skill input 'languageCode' has the following language codes '(Unknown)', at least one of which is invalid.* 

    If you look back at the dependency graph, the Language detection skill has outputs to the three skills with warnings. Also the skill input causing the error is `languageCode`. 

1. In the dependency graph, select **Language detection**.

    :::image type="content" source="../media/language-detection-error.png" alt-text="A screenshot showing the Skill Settings for the Language Detection skill.":::

    Looking at the skill settings JSON, note the field being used to deduce the language is the `HotelId`.

    This field will be causing the error as the skill can't work out the language based on an ID.

## Resolve the warning on the indexer

1. Select **source** under inputs.

    :::image type="content" source="../media/language-detection-fix.png" alt-text="A screenshot of the Language Detection SKill screen showing the fixed skill.":::

1. Change the field to `/document/Description`.
1. Select **Save**.
1. Select **Run**.

    :::image type="content" source="../media/rerun-debug-session.png" alt-text="A screenshot showing the need to run after updating a skill.":::

    The indexer should no longer have any warnings. The skillset can now be updated.

1. Select **Commit changes...**

    :::image type="content" source="../media/error-fixed.png" alt-text="A screenshot showing the issue resolved.":::

1. Select **OK**.

Now that you've updated the indexer, you'll need to run it to update the documents with the fixed AI enrichments. You should see that the warnings are now zero.

:::image type="content" source="../media/warnings-fixed-indexer.png" alt-text="A screenshot showing everything resolved."::: 

> [!TIP]
> Now you've completed the exercise, if you've finished exploring Azure Cognitive Search services, delete the Azure resources that you created during the exercise. The easiest way to do this is delete the **acs-cognitive-search-exercise** resource group.