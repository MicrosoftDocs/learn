In this exercise, you create an Azure OpenAI deployment. Creating a deployment on your previously provisioned resource allows you to interact with your large language model (LLM).

> [!NOTE]
> In order to complete this exercise, you need the following:
>
> - An Azure subscription - [Create one for free](https://azure.microsoft.com/free/ai-services).
> - Access to Azure OpenAI in the desired Azure subscription. Currently, access to this service is granted only through applications. Apply for access to Azure OpenAI by completing this form: [https://aka.ms/oai/access](https://aka.ms/oai/access).
> - An Azure OpenAI resource. If you haven't created this yet, refer to the previous exercise before moving on.

## Create a deployment

Let's walk through creating a deployment by using Azure OpenAI Studio. You can have more than one Azure OpenAI cloud resource. To ensure you're managing the right one, navigate to Azure OpenAI Studio from the instance blade.

1. Go to the [Azure portal](https://portal.azure.com) and locate your newly provisioned Azure OpenAI instance by typing **openai** in the top search bar. From there, select your specific cloud instance.

1. Select **Model deployments** from the left side menu, then select **Manage Deployments**.

    :::image type="content" source="../media/manage-deployments.png" alt-text="Screenshot from the Azure portal newly created OpenAI resource highlighting the model deployments and manage deployments buttons in red boxes.":::

    When you select **Manage Deployments**, you'll be directed to Azure OpenAI Studio. Double-check that **Deployments** is selected.

    :::image type="content" source="../media/find-deployments.png" alt-text="Screenshot from the Azure OpenAI studio highlighting the deployments button in a red box.":::

1. Select **Create new deployment** from the toolbar. You should see a modal open.

    :::image type="content" source="../media/new-deployment.png" alt-text="A screenshot of the modal to create a new deployment.":::

1. In the opened modal, fill in the required fields:

    | **What** | **Value** |
    |---|---|
    | Select a model | Select **gpt-35-turbo** |
    | Model version | Select 0301 |
    | Deployment name | It needs to be unique for this cloud instance. Name it to something that makes sense to you, for example **conversation-model**, as this model type and GPT4 is optimized for conversation. |

1. Select **Create**.

Congratulations! You successfully created a model deployment that enables you to interact with the gpt-35-turbo (ChatGPT) LLM.
