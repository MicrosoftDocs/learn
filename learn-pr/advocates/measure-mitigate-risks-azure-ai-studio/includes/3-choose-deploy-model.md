Selecting a model from the Model Catalog is the first step toward creating the Contoso Camping Store chatbot. The model catalog in Azure AI Foundry is the central place to discover, compare, and deploy models for generative AI applications. Exact collection labels and available models can change over time, so focus on the model card, deployment options, benchmark data when published, and regional availability when you make your choice.

:::image type="content" source="../media/model-catalog.png" alt-text="A screenshot of the model catalog within Azure AI Foundry. Model suggestions are provided along the top followed by filters. A list of models available display under the filters." lightbox="../media/model-catalog.png":::

The model catalog includes Azure OpenAI models together with a wide range of partner and community models. Some models support serverless deployment, some support managed compute, and some support both. For more information, see [Microsoft Foundry Models overview](/azure/foundry/concepts/foundry-models-overview).

## View model card

There are various factors to consider when choosing a model, such as performance, relevance, cost, deployment options, and regional availability. You can learn more about each model by reviewing its model card. Let's look at the model cards for both **gpt-4o** and a Meta Llama chat model.

1. Within Azure AI Foundry, navigate to the **Model Catalog**.
1. Search for **gpt-4o**, and then select the model to open its model card.
1. Review the model card. Pay particular attention to the model version, supported endpoints, region availability, context limits, and any benchmark data that's available.

The model card for **gpt-4o** helps you confirm that the model supports chat completion and gives you the information you need before deployment.

Let's now look at a model provided as a serverless deployment offering to compare the difference in information available on a model card.

1. Return to the **Model Catalog**.
1. In the search bar, enter: **Llama-3.3-70B-Instruct**.
1. Select the **Llama-3.3-70B-Instruct** model to view its model card. If that specific model isn't available in your region, choose another currently available chat model from the same provider.

The model card for **Llama-3.3-70B-Instruct** has more information about the model, including its license, deployment options, training data, and benchmark comparisons across related models.

> [!NOTE]
> Model availability in the catalog changes over time. If a specific model isn't listed, choose another model from the same provider that's currently available in your region.

## Compare models

While the model card provides detailed information about each model, comparing candidate models helps you weigh tradeoffs such as quality, safety, cost, and throughput before you deploy. You're using an Azure OpenAI chat completion model to create the Contoso Camping Store chatbot, so let's compare two current Azure OpenAI chat models.

:::image type="content" source="../media/model-benchmarks.png" alt-text="A screenshot of the model benchmarks page within the Azure AI Foundry. There's a graph on the page that compares 2 models." lightbox="../media/model-benchmarks.png":::

1. Return to the **Model Catalog**.
1. If your portal shows **Compare models**, select it. If it shows **View leaderboard** instead, open the leaderboard and select models from there.

:::image type="content" source="../media/compare-models.png" alt-text="A screenshot of the Model Catalog filter bar. On the far right is the Compare models button. The Compare models button is highlighted in red." lightbox="../media/compare-models.png":::

1. Compare **gpt-4o** with **gpt-4o-mini**. If either model isn't available in your region, compare two Azure OpenAI chat completion models that are available to you.
1. Review the published benchmark information for quality, safety, cost, and throughput.
1. Open the **Benchmarks** tab or side-by-side comparison view to inspect the metrics in more detail.

> [!NOTE]
> Not every model has published benchmark data. If a model doesn't have a **Benchmarks** tab, Microsoft hasn't published benchmark results for that model yet. Public benchmarks are useful for narrowing down options, but you should still test with your own prompts and data. For more information, see [Compare models using the model leaderboard](/azure/foundry/how-to/benchmark-model-in-catalog).

Across most common chat scenarios, **gpt-4o** is a strong choice for this guided project, so let's deploy it.

## Deploy a model

You can deploy a model from either the model card or your project’s deployment page.

:::image type="content" source="../media/deploy-model.png" alt-text="A screenshot of the model card for the gpt-4o model in Azure AI Foundry. The deploy button is highlighted." lightbox="../media/deploy-model.png":::

> [!NOTE]
> Model availability and quota vary by model and region. Before deployment, verify that your chosen model is available in your target region and that you have enough quota to deploy it. If **gpt-4o** isn't available to you, use another Azure OpenAI chat completion model such as **gpt-4o-mini**, and then use that same deployment throughout the rest of the module. For more information, see [Create and deploy an Azure OpenAI in Microsoft Foundry Models resource (classic)](/azure/foundry-classic/openai/how-to/create-resource#deploy-a-model) and [Manage Azure OpenAI in Microsoft Foundry Models quota (classic)](/azure/foundry-classic/openai/how-to/quota).

1. From the model card for the Azure OpenAI chat model you selected (for example, **gpt-4o**), select **Deploy**.
1. For **Deployment name**, enter: *gpt-4o*, or use another clear name that matches the Azure OpenAI chat model you selected. Reuse that same chat deployment throughout the remaining units.
1. Review the **Deployment type** and keep the default option unless your environment requires a different one.
1. If **Tokens per Minute Rate Limit** is configurable, keep the default value or choose any value that fits your available quota. If the field isn't shown in your portal, continue with the other defaults. You can change the rate limit later from **Quota**.
1. Select **Deploy**.

> [!NOTE]
> Azure OpenAI deployments start with the default content filter, which blocks harmful prompt and completion content at the **medium** severity threshold across the four core harm categories (hate, sexual, violence, and self-harm) for both prompts and completions. **Prompt shields for direct attacks** and **protected material detectors** are also on by default, but **Prompt shields for indirect attacks** are off by default. Because this chatbot uses retrieved product documents, you'll enable indirect-attack protection later with a custom content filter. For more information, see [Configure content filters](/azure/ai-foundry/openai/how-to/content-filters) and [Default Guardrail policies for Azure OpenAI](/azure/ai-foundry/openai/concepts/default-safety-policies).

## Deploy an embedding model

The next unit creates a vector index from the Contoso Camping Store product files. Vector indexes require an **embedding model** to convert your text into vectors at indexing and query time, so deploy one now in the same project.

1. Return to the **Model Catalog**.
1. Search for and select an Azure OpenAI embedding model such as **text-embedding-3-large** (recommended) or **text-embedding-3-small**. If the `text-embedding-3` models aren't available in your region or subscription, use another available embedding model, such as **text-embedding-ada-002**.
1. Select **Deploy**, keep the default deployment name suggested by the portal or choose another clear name, and then select **Deploy**.

> [!NOTE]
> The embedding deployment doesn't need a custom content filter for this module - the chat deployment is what answers user prompts. You'll use the embedding deployment when vectorizing the product data in the next unit. For more information about embedding models in Azure OpenAI, see [Azure OpenAI embeddings models](/azure/ai-foundry/openai/concepts/models#embeddings).

Azure AI Foundry also offers monitoring and evaluation features that help you measure model quality and safety after deployment. For more information, see [Run evaluations from the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-generative-ai-app).

## Chat with a deployed model in the chat playground

In the Azure AI Foundry chat playground, you can observe how your model responds with and without your data. Now that your Azure OpenAI chat model is deployed, let's send a few prompts to see how it behaves before the product catalog is connected.

:::image type="content" source="../media/chat-playground.png" alt-text="A screenshot of the chat playground in Azure AI Foundry. Setup for the model prompt displays on the left. The chat window display to the right." lightbox="../media/chat-playground.png":::

1. On the model deployment details page, select **Open in playground**. If that shortcut isn't shown, open the **Chat playground** manually and select the same chat deployment.
1. In the chat box on the **Chat playground** page, submit the following prompts one at a time to observe the model's generated response:

    | Prompt | Sample Response |
    |----------|----------|
    | Provide a list of 2 national parks to visit during the summer.   | Certainly! Here are two national parks that offer great summer experiences: <br><br> 1. **Glacier National Park** (Montana) - Offers stunning mountain scenery, clear lakes, and the opportunity to drive along the famous Going-to-the-Sun Road. <br> 2. **Olympic National Park** (Washington) - Features diverse ecosystems, including temperate rainforests, alpine areas, and coastal tide pools.|
    |  Recommend a tent that fits a family of 4.    | When recommending a specific tent for a family of four, it's helpful to select one that provides ample space, durability, and comfort. Here's a well-regarded option that has been popular among camping families: **REI Co-op Kingdom 6 Tent**.   |
    |  How much is the Contoso MountainDream Sleeping Bag?    | I'm sorry for any confusion, but as an AI developed by OpenAI, I don't have the capability to access real-time pricing or inventory for products from specific retailers, including any product named "Contoso MountainDream Sleeping Bag."   |

The model isn't configured yet to answer questions about Contoso Camping Store products. You resolve this in the next unit by uploading your data, creating a vector index, and assigning that index to the chat deployment in the playground.
