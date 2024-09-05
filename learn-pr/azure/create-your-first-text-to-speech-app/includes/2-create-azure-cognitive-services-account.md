Learn how to create and manage an Azure AI services multi-service resource. An Azure AI services multi-service resource allows you to access multiple Azure AI services (such as Azure AI Speech, Azure OpenAI, and Azure AI Content Safety) with a single set of credentials.

For your company's video department, you'll focus on Azure AI services' text to speech features to create audio files that you can use for narration in your videos.

However, before you can create an application that uses Azure AI services like text to speech, you need to create an Azure AI services resource. 

In the next unit, you'll complete an exercise that uses the Azure CLI to create an Azure AI services resource. However, you can also use the Azure portal, which we describe in the following section.

<a name='create-an-azure-ai-services-resource-using-the-azure-portal'></a>

## Create an Azure AI services resource using the Azure portal

Azure provides more than one resource kind named *Azure AI services*. Be sure to select the one that is listed under **Azure AI services** > **Azure AI services** in the portal. To create an Azure AI services multi-service resource follow these instructions:

1. Sign into the [Azure portal](https://portal.azure.com/?azure-portal=true).

1. Select this link to create a multi-service resource: [https://portal.azure.com/#create/Microsoft.CognitiveServicesAIServices](https://portal.azure.com/#create/Microsoft.CognitiveServicesAIServices)

1. On the **Create** page, provide the following information:

    |Project details| Description   |
    |--|--|
    | **Subscription** | Select one of your available Azure subscriptions. |
    | **Resource group** | The Azure resource group that will contain your Azure AI services resource. You can create a new group or add it to a pre-existing group. |
    | **Region** | The location of your Azure AI services resource. Different locations may introduce latency, but have no impact on the runtime availability of your resource. |
    | **Name** | A descriptive name for your Azure AI services resource. For example, *MyAzureAIServicesResource*. |
    | **Pricing tier** | The cost of your Azure AI services resource depends on the options you choose and your usage. For more information, see the API [pricing details](https://azure.microsoft.com/pricing/details/cognitive-services/). |

    :::image type="content" source="../media/2-resource-create-screen-multi.png" alt-text="Screenshot of creating a multi-service resource.":::

1. Configure other settings for your resource as needed, read and accept the conditions (as applicable), and then select **Review + create**.

> [!TIP]
> If your subscription doesn't allow you to create an Azure AI services resource, you may need to enable the privilege of that [Azure resource provider](/azure/azure-resource-manager/management/resource-providers-and-types#register-resource-provider) using the [Azure portal](/azure/azure-resource-manager/management/resource-providers-and-types#azure-portal), [PowerShell command](/azure/azure-resource-manager/management/resource-providers-and-types#azure-powershell) or an [Azure CLI command](/azure/azure-resource-manager/management/resource-providers-and-types#azure-cli). If you are not the subscription owner, ask the *Subscription Owner* or someone with a role of *admin* to complete the registration for you or ask for the **/register/action** privileges to be granted to your account.
