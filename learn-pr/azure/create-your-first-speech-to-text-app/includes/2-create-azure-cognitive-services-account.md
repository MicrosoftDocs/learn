Azure AI services is a product bundle that allows customers to access multiple services—such as vision, language, and speech—by using a single API key.

For your company's transcription department, you'll focus on Azure AI speech to text features to transcribe your clients' audio files into text that you can return to your clients.

However, before you can create an application that uses Azure AI services like as speech to text, you need to create an Azure AI services account.

In the next unit, you'll complete an exercise that uses the Azure CLI to create an Azure AI services account. However, you can also use the Azure portal, which we describe in the following section.

<a name='create-an-azure-ai-services-account-using-the-azure-portal'></a>

## Create an Azure AI services account using the Azure portal

The multi-service resource is listed under **Azure AI services** > **Azure AI services multi-service account** in the portal. To create a multi-service resource follow these instructions:

1. Sign into the [Azure portal](https://portal.azure.com/?azure-portal=true).

1. Select this link to create a multi-service resource: [https://portal.azure.com/#create/Microsoft.CognitiveServicesAllInOne](https://portal.azure.com/#create/Microsoft.CognitiveServicesAllInOne)

1. On the **Create** page, provide the following information:

    |Project details| Description   |
    |--|--|
    | **Subscription** | Select one of your available Azure subscriptions. |
    | **Resource group** | The Azure resource group that will contain your Azure AI services resource. You can create a new group or add it to a pre-existing group. |
    | **Region** | The location of your Azure AI service instance. Different locations may introduce latency, but have no impact on the runtime availability of your resource. |
    | **Name** | A descriptive name for your Azure AI services resource. For example, *MyAzureAIServicesResource*. |
    | **Pricing tier** | The cost of your Azure AI services account depends on the options you choose and your usage. For more information, see the API [pricing details](https://azure.microsoft.com/pricing/details/cognitive-services/).

    :::image type="content" source="../media/2-resource_create_screen-multi.png" alt-text="Multi-service resource creation screen":::

1. Configure other settings for your resource as needed, read and accept the conditions (as applicable), and then select **Review + create**.

> [!Tip]
> If your subscription doesn't allow you to create an Azure AI services resource, you may need to enable the privilege of that [Azure resource provider](/azure/azure-resource-manager/management/resource-providers-and-types#register-resource-provider) using the [Azure portal](/azure/azure-resource-manager/management/resource-providers-and-types#azure-portal), [PowerShell command](/azure/azure-resource-manager/management/resource-providers-and-types#azure-powershell) or an [Azure CLI command](/azure/azure-resource-manager/management/resource-providers-and-types#azure-cli). If you are not the subscription owner, ask the *Subscription Owner* or someone with a role of *admin* to complete the registration for you or ask for the **/register/action** privileges to be granted to your account.
