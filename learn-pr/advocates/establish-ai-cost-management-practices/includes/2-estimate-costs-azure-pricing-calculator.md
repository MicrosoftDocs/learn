In this exercise, you'll explore the Azure Pricing Calculator and use it to estimate the cost of a Large Language Model in Azure OpenAI. No Azure subscription is required.

## Add Azure OpenAI to a pricing estimate

1. Open the Azure Pricing Calculator website <https://azure.microsoft.com/pricing/calculator>
1. You don't need to have an existing Azure subscription to use the Azure pricing calculator. However, if you choose to sign in with an account that has access to Microsoft Azure, you'll be able to see pricing specific to your Azure agreement and you'll be able to save and share your cost estimates. 
1. On the **Products** tab, select the "**AI + machine learning**" section.
1. Note the different products available. Find Azure OpenAI and select the "Add to estimate" button. 
1. On the tab titled Your Estimate, make your choices under the following options:

    - **Region** - Not all models are available in all regions, and your choice of region may impact your pricing. Use the link provided to check the service availability.
    - **Model type** - Select "Language Models".
    - **Model** - Choose any language model listed.
    - **Pricing Strategy** - Select "Standard (On-Demand)".
    - **Deployment type** - If available, choose Global.

1. Next, enter values in the Input, Cached Input (if available), and Output boxes, to represent units of 1,000 tokens. 
1. Finally, you can choose your level of **Support** and your **Licensing Program**. You can also change the displayed **Currency** and Export your estimate to Microsoft Excel. If you have logged in, you can **Save** or **Share** your cost estimate.   

Try different selections and note how they impact your estimated monthly cost.

## Estimate the cost of an Azure OpenAI Search RAG Sample

1. Navigate to the **Example scenarios** tab of the Azure Pricing Calculator website <https://azure.microsoft.com/pricing/calculator>
1. Select the **Azure OpenAI Search RAG Sample**. This provides you with the architecture for a solution that creates a ChatGPT-like frontend experience over your own documents, using RAG (Retrieval Augmented Generation). It uses Azure OpenAI Service to access GPT models, and Azure AI Search for data indexing and retrieval.
1. Select the **Add to estimate** button. The listed products will all be added to a new cost estimate.
1. Expand the individual products and choose different options to see how they impact your estimated monthly cost.
