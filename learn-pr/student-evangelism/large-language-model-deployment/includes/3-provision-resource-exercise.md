In this exercise, you create an Azure OpenAI service that enables you to interact with different large language models. 

> [!NOTE]
> In order to complete this exercise, you need the following:
>
> - An Azure subscription - [Create one for free](https://azure.microsoft.com/free/ai-services).
> - Access granted to Azure OpenAI in the desired Azure subscription.
>   Currently, access to this service is granted only by application. You can apply for access to Azure OpenAI by completing the form at [https://aka.ms/oai/access](https://aka.ms/oai/access).
>

## Provision a resource in the Azure portal

For this exercise, you'll use Azure portal to provision a resource.

1. Visit the [Azure portal](https://portal.azure.com) in your browser and sign in.  
1. Type **openai** in the search bar at the top of the portal page and select **Azure OpenAI** from the options that appear.

    :::image type="content" source="../media/search-openai.png" alt-text="Screenshot from the Azure portal with the search word openai and the search result Azure OpenAI highlighted in a red box.":::

1. Select **Create** from the toolbar.

    :::image type="content" source="../media/create-button.png" alt-text="Screenshot from the Azure portal with create Azure OpenAI highlighted in a red box.":::

1. Make the following selections, text entries to provide the needed data to create a resource:

    | **What** | **Comment**  |
    |---------|---------|
    |Subscription    |The same subscription you used in applying for Azure OpenAI access.         |
    |Resource Group     |Use an existing resource group or select to create a new one.          |
    |Region      |Select a region close to you for best response times.          |
    |Name     |The name must be globally unique.          |
    |Pricing tier     |Currently S0 is the only available tier          |

    :::image type="content" source="../media/project-details.png" alt-text="Screenshot from the Azure portal with configuration basic details of Azure OpenAI highlighted in red.":::

1. Now that you added the basic information at the first tab you need to perform the following tasks:

   1. Select **Next**, to confirm your basic details and be taken to the next page.
   1. Select **Next**, to confirm your network details and be taken to the tags page.
   1. Select **Next** to confirm your tag details and be taken to the review page.

1. Confirm your configuration settings and select **Create**. This action should start provisioning the resource, wait for the deployment to finish.  

1. Select **Go to resource**, to inspect your created resource. On this page, you can manage your resource and locate important information like the endpoint URL, API keys and more.  

Congrats, you’ve provisioned a resource, in the next exercise you'll deploy a model so you can interact with your large language model of choice.
