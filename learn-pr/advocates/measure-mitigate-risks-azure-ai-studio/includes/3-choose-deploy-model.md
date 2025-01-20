Selecting a model from the Model Catalog is the first step towards creating the Contoso Camping Store chatbot. The model catalog in Azure AI Foundry is the hub to discover and use a wide range of models for building generative AI applications. The model catalog features hundreds of models across model providers such as Azure OpenAI Service, Mistral, Meta, Cohere, NVIDIA, and Hugging Face, including models that Microsoft trained.

:::image type="content" source="../media/model-catalog.png" alt-text="A screenshot of the model catalog within Azure AI Foundry. Model suggestions are provided along the top followed by filters. A list of models available display under the filters." lightbox="../media/model-catalog.png":::

The model catalog organizes models into three types of collections:
- Curated by Azure AI
- Azure OpenAI models exclusively available on Azure
- Open models from the Hugging Face hub

You can deploy some models in the **Curated by Azure AI** and **Open models from the Hugging Face hub** collections with a managed compute option. Some models are available to be deployed through serverless APIs with pay-as-you-go billing.

## View model card

There’s various factors to consider when choosing a model such as model performance, relevance, and cost, to name a few. You can learn more about the models within the Model Catalog by reviewing the model’s respective model card. Let’s look at the model cards for both **gpt-4o** and **Llama-2-70b-chat**.

1. Within Azure AI Foundry, navigate to the **Model Catalog**.
1. Apply the following filters:
    - Collections > Azure OpenAI
    - Inference tasks > Chat completion

1. Select the **gpt-4o** model to view its model card.

The model card for the **gpt-4o** model provides the model’s description, its various versions, and further descriptions about each model version which includes the extent of its training data and token limitations.

Let’s now look at a model provided as a Model as a Service (MAAS) offering to compare the difference in information available on a model card.

1. Return to the **Model Catalog**.
1. In the search bar, enter: **Llama-2-70b-chat**
1. Select the **Llama-2-70b-chat** model to view its model card.

The model card for the **Llama-2-70b-chat** model has more information about the model, including its cost, information about the training data, and evaluation comparisons across other Llama models.

## Compare models

While the model card provides more details about the available models, comparing your potentially chosen models gets you one step closer to choosing one (or some) for deployment. The **Model Benchmarks** section of Azure AI Foundry provides a single interface to compare benchmarks across models and datasets available in the industry to assess which one meets your business scenario. You're using a **GPT** chat completion model to create the Contoso Camping Store chatbot. However, let’s compare some of the **GPT** chat completion models to analyze how each model scores differently across accuracy, coherence, groundedness, fluency, relevance, and GPT Similarity.

:::image type="content" source="../media/model-benchmarks.png" alt-text="A screenshot of the model benchmarks page within the Azure AI Foundry. There is a graph on the page that compares 2 models." lightbox="../media/model-benchmarks.png":::

1. Return to the **Model Catalog**.
1. In the **Models** filter bar, select **Compare models**.

:::image type="content" source="../media/compare-models.png" alt-text="A screenshot of the Model Catalog filter bar. On the far right is the Compare models button. The Compare models button is highlighted in red." lightbox="../media/compare-models.png":::

1. In the **Selected model** section, click the **X** to remove any of the non-GPT models.
1. If no GPT models are listed, select **Model to compare**.
1. On the **Select a model** screen, search for and select the following GPT models:
    1. gpt-4o
    1. gpt-35-turbo
1. View how each model scores in comparison to the various datasets. Hover over a point in the graph to view the score for the model.
1. Modify the **X-axis** and *Y-axis** options to change the comparison metrics.

Across all comparisons, for each metric, **gpt-4o** has the highest score. Therefore, let’s use **gpt-4o** as the model for the Contoso Camping Store chatbot.

## Deploy a model

You can deploy a model from either the model card or your project’s deployment page.

:::image type="content" source="../media/deploy-model.png" alt-text="A screenshot of the model card for the gpt-4o model in Azure AI Foundry. The deploy button is highlighted." lightbox="../media/deploy-model.png":::

> [!NOTE]
> For Azure OpenAI models, the default quota for models varies by model and region. Certain models might only be available in some regions. Deploying consumes quota that is assigned to your subscription on a per-region, per-model basis in units of Tokens-per-Minute (TPM). When you sign up for Azure AI Foundry, you receive default quota for most of the available models. Then, you assign TPM to each deployment as it is created, thus reducing the available quota for that model by the amount you assigned. You can continue to create deployments and assign them TPMs until you reach your quota limit.

1. Within the **Selected model** section of the **Assess model performance with evaluated metrics** page, select the **gpt-4o** model.
1. Select the **Overview** tab.
1. On the model card, select **Deploy**.
1. For **Deployment name**, enter: *gpt-4o*.
1. For **Azure OpenAI resource**, select your Azure OpenAI resource.
1. Select **Deploy**.

> [!NOTE]
> For Azure OpenAI models such as GPT-4o, Azure AI Foundry provides a safety filter during the deployment to ensure responsible use of AI. A safety filter allows moderation of harmful and sensitive content to promote the safety of AI-enhanced applications.

Azure AI Foundry also offers model monitoring for deployed models. Model monitoring for LLMs uses the latest GPT language models to monitor and alert when the outputs of a model perform poorly against the set thresholds of generation safety and quality. For example, you can configure a monitor to evaluate how well the model's generated answers align with information from the input source (groundedness). The monitor could also evaluate how closely the generated answer matches a ground-truth sentence or document (similarity).

## Chat with a deployed model in the chat playground

In the Azure AI Foundry Chat playground, you can observe how your model responds with and without your data. Now that the **gpt-4o** model is deployed, let’s pass some prompts into the chat to see how the model currently responds both about general facts and towards questions about Contoso products.

:::image type="content" source="../media/chat-playground.png" alt-text="A screenshot of the chat playground in Azure AI Foundry. Setup for the model prompt displays on the left. The chat window display to the right." lightbox="../media/chat-playground.png":::

1. On the model deployment details page, select **Open in playground**.
1. Within the chat box on the **Chat playground** page, individually submit the following prompts to observe the models generated response:

    | Prompt | Sample Response |
    |----------|----------|
    | Provide a list of 2 national parks to visit during the summer.   | Certainly! Here are two national parks that offer great summer experiences: <br><br> 1. **Glacier National Park** (Montana) - Offers stunning mountain scenery, clear lakes, and the opportunity to drive along the famous Going-to-the-Sun Road. <br> 2. **Olympic National Park** (Washington) - Features diverse ecosystems, including temperate rainforests, alpine areas, and coastal tide pools.|
    |  Recommend a tent that fits a family of 4.    | When recommending a specific tent for a family of four, it's helpful to select one that provides ample space, durability, and comfort. Here's a well-regarded option that has been popular among camping families: **REI Co-op Kingdom 6 Tent**.   |
    |  How much is the Contoso MountainDream Sleeping Bag?    | I'm sorry for any confusion, but as an AI developed by OpenAI, I don't have the capability to access real-time pricing or inventory for products from specific retailers, including any product named "Contoso MountainDream Sleeping Bag."   |

The model isn’t configured yet to answer questions about Contoso Camping Store products. You will later resolve by uploading your data, creating an index, and assigning the index to the model.