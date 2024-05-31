In this exercise, you create an Azure OpenAI deployment. Creating a deployment on your previously provisioned resource allows you to interact with your large language model (LLM).

> [!NOTE]
> To complete this exercise, you need the following:
>
> - An Azure subscription. [Create one for free](https://azure.microsoft.com/free/ai-services).
> - Access to Azure OpenAI in the desired Azure subscription. Currently, access to this service is granted only through applications. Apply for access to Azure OpenAI by completing this form: [https://aka.ms/oai/access](https://aka.ms/oai/access).
> - An Azure OpenAI resource. If you haven't created this yet, refer to the previous exercise before moving on.

## Create a deployment

Let's walk through creating a deployment by using Azure OpenAI Studio. You can have more than one Azure OpenAI cloud resource. To ensure you're managing the right one, navigate to Azure OpenAI Studio from the instance blade.

1. Go to the [Azure portal](https://portal.azure.com) and locate your newly provisioned Azure OpenAI instance by typing **openai** in the top search bar. From there, select your specific cloud instance.

1. On the left, select **Model deployments** and then select **Manage Deployments**.

    :::image type="content" source="../media/manage-deployments.png" alt-text="Screenshot of the Azure portal, showing the newly created OpenAI resource. The model deployments and manage deployments buttons are highlighted with red boxes.":::

    When you select **Manage Deployments**, you're directed to Azure OpenAI Studio. Double-check that **Deployments** is selected.

    :::image type="content" source="../media/find-deployments.png" alt-text="Screenshot of Azure OpenAI Studio, in which the Deployments tab is highlighted with a red box.":::

1. Select **Create new deployment** from the toolbar. A **Deploy model** window opens.

    :::image type="content" source="../media/new-deployment.png" alt-text="A screenshot of the Deploy model window.":::

1. In the window, fill in the required fields:

    | **What** | **Value** |
    |---|---|
    | Select a model | Select **gpt-35-turbo**. |
    | Model version | Select **0301**. |
    | Deployment name | Add a name that's unique for this cloud instance. The name should make sense to you, for example **conversation-model**, because this model type and GPT-4 are optimized for conversation. |

1. Select **Create**.

Congratulations! You successfully created a model deployment that enables you to interact with the GPT-3.5-Turbo LLM.
