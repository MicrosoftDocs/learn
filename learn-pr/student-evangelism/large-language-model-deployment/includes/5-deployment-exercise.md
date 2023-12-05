In this exercise, you create an Azure OpenAI deployment. By creating a deployment on your previously provisioned resource, you're able to interact with your large language model (LLM).

> [!NOTE]
> In order to complete this exercise, you need the following:
>
> - An Azure subscription - [Create one for free](https://azure.microsoft.com/free/ai-services).
> - Access granted to Azure OpenAI in the desired Azure subscription. Currently, access to this service is granted only by application. You can apply for access to Azure OpenAI by completing the form at [https://aka.ms/oai/access](https://aka.ms/oai/access).
> - An Azure OpenAI resource. This resource is created in the previous exercise, so, if you haven't already, complete that exercise before continuing.

## Create a deployment

In this exercise, you create a deployment by using Azure OpenAI Studio. You can have more than one Azure OpenAI cloud resource; to ensure you manage the correct one, you need to navigate to Azure OpenAI Studio from the instance blade.

1. Navigate to the [Azure portal](https://portal.azure.com) and locate your newly provisioned Azure OpenAI instance by typing **openai** in the top search bar. From there, select your specific cloud instance.

1. Select **Model deployments** from the left side menu on your cloud instance blade then, select **Manage Deployments**.

    :::image type="content" source="../media/manage-deployments.png" alt-text="Screenshot from the Azure portal newly created OpenAI resource highlighting the model deployments and manage deployments buttons in red boxes.":::

    When you select **Manage Deployments**, you’re taken to Azure OpenAI Studio. Ensure that **Deployments** is selected.

    :::image type="content" source="../media/find-deployments.png" alt-text="Screenshot from the Azure OpenAI studio highlighting the deployments button in a red box.":::

1. Select **Create new deployment** from the toolbar. You should see a modal open where you're asked to fill in values.

    :::image type="content" source="../media/new-deployment.png" alt-text="A screenshot of the modal to create a new deployment.":::

1. In the opened modal, fill in the following fields:

    | **What** | **Value** |
    |---|---|
    | Select a model | Select **gpt-35-turbo** |
    | Model version | Select 0301 |
    | Deployment name | It needs to be unique for this cloud instance. Name it to something that makes sense to you, for example **conversation-model**, as this model type and GPT4 is optimized for conversation. |

1. Select **Create**.

Congratulations, you successfully created a model deployment that enables you to interact with the gpt-35-turbo (ChatGPT) large language model.
