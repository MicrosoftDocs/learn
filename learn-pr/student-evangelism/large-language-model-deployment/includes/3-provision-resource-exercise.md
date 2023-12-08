In this exercise, you create an Azure OpenAI Service resource that enables you to interact with different large language models (LLMs). 

> [!NOTE]
> To complete this exercise, you need the following:
>
> - An Azure subscription. [Create one for free](https://azure.microsoft.com/free/ai-services).
> - Access to Azure OpenAI in the desired Azure subscription. Currently, access to this service is granted only through applications. Apply for access to Azure OpenAI by completing this form: [https://aka.ms/oai/access](https://aka.ms/oai/access).

## Provision a resource in the Azure portal

Complete the following steps to provision a resource in the Azure portal:

1. Go to the [Azure portal](https://portal.azure.com) in your browser and sign in.  

1. Type **openai** in the search bar at the top of the portal page and select **Azure OpenAI**.

    :::image type="content" source="../media/search-openai.png" alt-text="Screenshot from the Azure portal with the search word, openai, and the search result, Azure OpenAI, highlighted in a red box.":::

1. Select **Create**.

    :::image type="content" source="../media/create-button.png" alt-text="Screenshot from the Azure portal with create Azure OpenAI highlighted in a red box.":::

1. Add the following information to create a resource:

    | **What** | **Comment**  |
    |---------|---------|
    |Subscription    |Use the same subscription you used to apply for Azure OpenAI access.         |
    |Resource group     |Use an existing resource group or create a new one.          |
    |Region      |Select a region close to you for best response times.          |
    |Name     |The name must be globally unique.          |
    |Pricing tier     |Currently S0 is the only available tier.          |

    :::image type="content" source="../media/project-details.png" alt-text="Screenshot from the Azure portal with configuration basic details of Azure OpenAI highlighted in red.":::

1. Now that the basic information is added, select **Next** to confirm your details and proceed to the next page.

1. Select **Next** to confirm your network details.

1. Select **Next** to confirm your tag details.

1. Confirm your configuration settings and select **Create** to start provisioning the resource. Wait for the deployment to finish.  

1. After deployment, select **Go to resource** to inspect your created resource. Here, you can manage your resource and find important information like the endpoint URL and API keys.  

Congratulations! You successfully provisioned a resource. In the next exercise, you'll deploy a model  to interact with your LLM.
