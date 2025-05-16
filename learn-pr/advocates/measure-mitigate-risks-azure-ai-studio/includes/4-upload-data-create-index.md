While it’s great to use the model’s capabilities to generate responses to general non-Contoso Camping Store product specific queries, we want to ensure that the model can ground its product-specific inquiries by using the Contoso Camping Store’s product catalog. This process requires that we create a Retrieval Augmented Generation (RAG) chatbot and an index.

RAG is a pattern used in AI that uses a large language model (LLM) to generate answers with your own data. When a user asks a question, the data store is searched based on user input. The user question is then combined with the matching results and sent to the LLM using a prompt (explicit instructions to an AI or machine learning model) to generate the desired answer.

:::image type="content" source="../media/rag-pattern.png" alt-text="Screenshot of the flow of the RAG pattern. The pattern starts with a question and then flows to your data store, matching results, the prompt, the LLM, and finally the response." lightbox="../media/rag-pattern.png":::

For RAG to work well, we need to find a way to search and send your data in an easy and cost efficient manner to the LLMs. This process is achieved by using an index. An index is a data store that allows you to search data efficiently. An index can be optimized for LLMs by creating vectors (text data converted to number sequences using an embedding model). A good index usually has efficient search capabilities like keyword searches, semantic searches, vector searches, or a combination of these examples. This optimized RAG pattern can be illustrated as follows.

:::image type="content" source="../media/rag-pattern-with-index.png" alt-text="Screenshot of the flow of the RAG pattern with an index. The pattern starts with a question and then flows to your index, matching results, the prompt, the LLM, and finally the response." lightbox="../media/rag-pattern-with-index.png":::

Azure AI provides an index asset to use with RAG pattern. The index asset contains important information like:
- Where is your index stored
- How to access your index
- What are the modes in which your index can be searched
- Does your index have vectors
- What is the embedding model used for vector, etc.

The Azure AI index uses Azure AI Search as the primary and recommended index store. Azure AI Search is an Azure resource that supports information retrieval over your vector and textual data stored in search indexes.

Let’s now upload the data and then create an index.

## Upload data

Data can be sourced from an existing Azure Blob Storage connection, a storage URL, or uploaded via the **Add your data** interface. Furthermore, data can be organized into either a single reference file or a folder.

:::image type="content" source="../media/add-your-data.png" alt-text="A screenshot of the add your data window within Azure AI Foundry." lightbox="../media/add-your-data.png":::

Let’s add the Contoso Camping Store product data via an upload of the products folder.

1. Within Azure AI Foundry, in the left navigation under **My assets** select **Data + indexes**.
1. Select **+ New data**.
1. For the **Data source** drop-down, select **Upload files/folders**.
1. Select **Upload files or folders** > **Upload folder**.
1. Browse to where you saved the **Products** folder and select the folder for upload.
1. Select **Next**.
1. For the **Data name** field, enter: *Products*.
1. Select **Create**.

## Create an index

Now that the data is uploaded, let’s create an index.

:::image type="content" source="../media/create-an-index.png" alt-text="A screenshot of an index titled products-index created in Azure AI Foundry." lightbox="../media/create-an-index.png":::

1. Within the left navigation in the **My assets** section, select **Data + indexes**.
1. Select the **Indexes** tab.
1. Select **+ New index**.
1. On the **Source location** page, for the **Data source** field, select **Data in Azure AI Foundry**.
1. Select **Products**.
1. Select **Next**.
1. On the **Index settings** page, for the **Select Azure AI Search service**, select your **AzureAISearch** service.
1. For the **Index name** field, enter: *products-index*.
1. For the **Virtual machine** field, select **Auto select**.
1. Select **Next**.
1. On the **Configure search settings** page, check the box for **Add vector search to this search resource**.
1. Select **Next**.
1. On the **Review and finish** page, select **Create vector index**.

> [!NOTE]
> It takes ~8 minutes to create the index. When the index creation is complete, all 3 steps will reflect **Completed** within the **Status** section.

## Test the model with the index

We can now return to the **Chat playground** to test the model and validate whether it has the capability to ground its responses about Contoso Camping Store products with the provided product data.

:::image type="content" source="../media/add-data-chat-playground.png" alt-text="A screenshot of the add your data section within the chat playground of Azure AI Foundry. The fields for the section are highlighted." lightbox="../media/add-data-chat-playground.png":::

1. Navigate to the **Chat playground**.
1. On the **Chat playground** page, within the **Setup** section, expand the **Add your data** section.
1. Select the **Select available project index** drop-down and select **products-index**.

> [!TIP]
> Wait 2-3 minutes before proceeding to the next step. This should allow sufficient time for the updates to take effect.

In the chat window, test the following prompts individually to validate whether the model references the product data:

| Prompt | Sample Response |
|----------|----------|
| How much is the Contoso TrailMaster X4 Tent?   | The Contoso TrailMaster X4 Tent is priced at $250.|
|  How do I wash the Contoso TrailBlaze Hiking Pants?    | To wash the TrailBlaze Hiking Pants, follow these care and maintenance guidelines: <br><br> 1. **Machine Wash**: Use cold water and a mild detergent to machine wash the pants.<br>2. **Avoid Bleach and Fabric Softeners**: Don't use bleach or fabric softeners during washing as they can damage the fabric.<br>3. **Separate Wash**: For best results, wash the pants separately or with similar colors to prevent any color bleeding or fabric damage.<br>4. **Drying**: Hang the pants to dry naturally. Avoid using a dryer as high heat can damage the fabric and affect the pants' performance.<br>5. **Ironing**: If necessary, iron the pants on a low setting, ensuring that they are completely dry before ironing. Avoid excessive heat. <br><br> By following these instructions, you can maintain the quality and performance of your TrailBlaze Hiking Pants.|
|  Which fuel types should I use with the Contoso CompactCook Camping Stove?    | The Contoso CompactCook Camping Stove is compatible with the following fuel types: <br><br> - Butane <br> - Propane <br> - Isobutane. <br><br>These fuel types provide versatility for your outdoor cooking need.   |

The model should now provide responses about Contoso Camping Store products based on product data provided.