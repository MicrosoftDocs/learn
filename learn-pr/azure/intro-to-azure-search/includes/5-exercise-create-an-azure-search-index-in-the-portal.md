- Introduce the actual data set we'll use - a corpus of fitness center data.
- Explain the data set
- Run through the process to create an index
- Run through the process to load data to an index
- Run through the process to rebuild an index

Azure Search is a rich search experience over a variety of content wherever the content is stored.

Your organization has a large amount of exercise videos publicly available through it's website. Users are struggling to find relevant content or are undertaking exercises beyond their fitness level. As such the exercise videos need to be indexed using the following properties video title, exercise difficulty, video length and publication date.  This will make the user experience exponentially greater and result in less complaints about the available content.

In the unit, you'll load and index data in the Azure Search Service we created earlier.

<!-- Activate the sandbox -->
[!INCLUDE [azure-sandbox-activate](../../../includes/azure-sandbox-activate.md)]

## Create an Azure Search index for your data in the Azure portal

[!INCLUDE [TODO - azure-sandbox-activate](../../../includes/azure-sandbox-activate.md)]

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. From the portal, click **contosofitness** tile on the dashboard. This will load the resource we created earlier.

   ![TODO - INSERT SCREENSHOT.](../media/3-exercise-screenshot-2.png)

1. On the **contosofitness** search Overview page, select **Import Data**.

   ![TODO - INSERT SCREENSHOT.](../media/3-exercise-screenshot-2.png)

1. On the **Connect to your data** page, select **Samples**. Select the **contosofitnessdata** sample sql database, click the **Next: Add cognitive search (Optional)** button.

   ![TODO - INSERT SCREENSHOT.](../media/3-exercise-screenshot-2.png)

1. On the **Add cognitive search (Optional)** page, select **Skip to: Customize Target Index**.

   ![TODO - INSERT SCREENSHOT.](../media/3-exercise-screenshot-2.png)

1. On the **Customize Target Index** page use the below information to fill out the form fields. Leave the data fields as their default settings picked up by the indexer.

    | Field      | Value |
    | ------------ | ----- |
    | **Index name** | **contosofitnessindex** |
    | **Key** | Select the **fitnessvideotitle** field |
    | **Suggester name** |  **contosofitnesssugg** |
    | **Search mode** | Select **analyzingInfixMatching** option |

    ![TODO - INSERT SCREENSHOT.](../media/3-exercise-screenshot-2.png)

1. Click the **Next: Create an indexer** button.

1. On the **Create an indexer** page, enter the indexer name **contosofitnessindexer**. Leave the other options at their default settings and click the **Submit** button to begin the indexing process.

   ![TODO - INSERT SCREENSHOT.](../media/3-exercise-screenshot-2.png)

When the process completes, the portal will return you to the search service home page. You'll now run through making a change to the index and rebuilding it.

   ![TO DO - INSERT SCREENSHOT.](../media/3-exercise-screenshot-2.png)

## Edit and then rebuild an Azure Search index using the Azure CLI

**TODO - Create the process to delete a field in the index and rebuild the index using the CLI**

In the next part, you'll learn how to query the data you loaded into the index and how to work with the results.