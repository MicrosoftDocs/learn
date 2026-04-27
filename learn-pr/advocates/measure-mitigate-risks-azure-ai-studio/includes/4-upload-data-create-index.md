While it’s useful to see how the model handles general questions, the chatbot should ground product-specific answers in the Contoso Camping Store catalog. That means you need a retrieval-augmented generation (RAG) pattern and a searchable index.

RAG is a pattern used in AI that uses a large language model (LLM) to generate answers with your own data. When a user asks a question, the data store is searched based on user input. The user question is then combined with the matching results and sent to the LLM using a prompt (explicit instructions to an AI or machine learning model) to generate the desired answer.

:::image type="content" source="../media/rag-pattern.png" alt-text="Screenshot of the flow of the RAG pattern. The pattern starts with a question and then flows to your data store, matching results, the prompt, the LLM, and finally the response." lightbox="../media/rag-pattern.png":::

For RAG to work well, we need to find a way to search and send your data to the LLM in an efficient and cost-effective manner. This process is achieved by using an index. An index is a data store that allows you to search data efficiently. An index can be optimized for LLMs by creating vectors (text data converted to number sequences using an embedding model). A good index usually has efficient search capabilities like keyword searches, semantic searches, vector searches, or a combination of these examples. This optimized RAG pattern can be illustrated as follows.

:::image type="content" source="../media/rag-pattern-with-index.png" alt-text="Screenshot of the flow of the RAG pattern with an index. The pattern starts with a question and then flows to your index, matching results, the prompt, the LLM, and finally the response." lightbox="../media/rag-pattern-with-index.png":::

Azure AI Foundry supports project data assets and vector indexes for RAG workflows. In hub-based projects, those assets appear under **Data + indexes**. The exact wizard pages can vary slightly over time, but the goal is the same: upload the product files, create a vector index backed by Azure AI Search, and then attach that project index in the chat playground.

An index asset contains important information such as:

- Where your index is stored
- How to access your index
- The modes in which your index can be searched
- Whether your index has vectors
- The embedding model used for vectors

Azure AI Search is the recommended backing store for the index in this project. The classic portal documentation often shows this workflow starting from the **Chat playground**, but in this guided project you create the same project assets from **Data + indexes** so you can inspect them directly. For more information, see [Hub resources overview (classic)](/azure/foundry-classic/concepts/ai-resources), [Build and consume vector indexes in Microsoft Foundry portal (classic)](/azure/foundry-classic/how-to/index-add), and [Retrieval augmented generation (RAG) and indexes](/azure/foundry/concepts/retrieval-augmented-generation).

Let’s now upload the data and then create an index.

## Upload data

Data can come from an existing Azure Storage path, a URL, or an upload from your local machine. In this exercise, you upload the **Products** folder into the project as a data asset.

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

> [!NOTE]
> Uploading a folder creates a project data asset backed by the project's workspace storage. For more information, see [How to add and manage data in your Microsoft Foundry hub-based project (classic)](/azure/foundry-classic/how-to/data-add).

## Create an index

Now that the product data is uploaded, create a project index named **products-index**.

:::image type="content" source="../media/create-an-index.png" alt-text="A screenshot of an index titled products-index created in Azure AI Foundry." lightbox="../media/create-an-index.png":::

1. Stay in **Data + indexes** and open the **Indexes** tab. If your portal instead opens the index wizard from the **Chat playground** under **Add your data**, use that flow - the end result is the same.
1. Select **+ New index**.
1. When prompted for the source data, choose the **Products** data asset you just uploaded.
1. For index storage, choose your **Azure AI Search** resource. If you don't already have one connected, create or connect one now.
1. When prompted to vectorize the data, first select the Azure OpenAI connection and then choose the **embedding deployment** you created in the previous unit (for example, **text-embedding-3-large** or **text-embedding-3-small**). Don't select your chat deployment here - vectorization uses an embedding deployment to convert the source text into vectors. If no embedding deployment is listed, return to the previous unit and deploy one before continuing.
1. For the **Index name** field, enter: *products-index*.
1. Keep the remaining default settings unless your environment requires something different, and then select **Create vector index**.

> [!NOTE]
> Index creation can take several minutes. Wait until the index status shows **Completed** before you continue.

## Test the model with the index

We can now return to the **Chat playground** and validate whether the model grounds product-specific responses in the uploaded data.

:::image type="content" source="../media/add-data-chat-playground.png" alt-text="A screenshot of the add your data section within the chat playground of Azure AI Foundry. The fields for the section are highlighted." lightbox="../media/add-data-chat-playground.png":::

1. Navigate to the **Chat playground**.
1. On the **Chat playground** page, within the **Setup** section, expand the **Add your data** section.
1. Select the option to use an existing project index, and then choose **products-index**.

> [!TIP]
> If **products-index** doesn't appear immediately, wait for the index status to show **Completed**, refresh the playground, and then try again. After you attach the index, start a new chat before retesting so the session picks up the updated grounding configuration cleanly.

In the chat window, test the following prompts individually to validate whether the model references the product data:

| Prompt | Sample Response |
|----------|----------|
| How much is the Contoso TrailMaster X4 Tent?   | The Contoso TrailMaster X4 Tent is priced at $250.|
|  How do I wash the Contoso TrailBlaze Hiking Pants?    | To wash the TrailBlaze Hiking Pants, follow these care and maintenance guidelines: <br><br> 1. **Machine Wash**: Use cold water and a mild detergent to machine wash the pants.<br>2. **Avoid Bleach and Fabric Softeners**: Don't use bleach or fabric softeners during washing as they can damage the fabric.<br>3. **Separate Wash**: For best results, wash the pants separately or with similar colors to prevent any color bleeding or fabric damage.<br>4. **Drying**: Hang the pants to dry naturally. Avoid using a dryer as high heat can damage the fabric and affect the pants' performance.<br>5. **Ironing**: If necessary, iron the pants on a low setting, ensuring that they're completely dry before ironing. Avoid excessive heat. <br><br> By following these instructions, you can maintain the quality and performance of your TrailBlaze Hiking Pants.|
|  Which fuel types should I use with the Contoso CompactCook Camping Stove?    | The Contoso CompactCook Camping Stove is compatible with the following fuel types: <br><br> - Butane <br> - Propane <br> - Isobutane. <br><br>These fuel types provide versatility for your outdoor cooking need.   |

The model should now ground product-specific answers in the retrieved product data you provided instead of relying only on general model knowledge.
