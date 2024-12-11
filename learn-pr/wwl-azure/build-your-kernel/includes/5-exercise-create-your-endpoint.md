For this exercise, you create an Azure OpenAI resource and provide the deployment information to the Semantic Kernel. The Semantic Kernel will connect to the endpoint and allow you to run prompts to the large language model (LLM) directly from your code. Let's get started!

1. Navigate to [https://portal.azure.com](https://portal.azure.com).

1. In the search bar, enter "Azure OpenAI" and select the **Azure OpenAI** service.

1. Create a new Azure OpenAI resource using the default settings.

    > [!NOTE]
    > If you already have an Azure OpenAI resource, you can skip this step.

1. After the resource is created, select **Go to resource**.

1. On the **Overview** page, select **Go to Azure OpenAI Studio**.

:::image type="content" source="../media/model-deployments.png" alt-text="A screenshot of the Azure OpenAI deployments page.":::

1. Select **Create New Deployment** then **Deploy Model**.

1. Under **Select a model**, select **gpt-35-turbo-16k**.

    Use the default Model version

1. Enter a name for your deployment.

1. When the deployment completes, navigate back to your Azure OpenAI resource.

1. Under **Resource Management**, go to **Keys and Endpoint**.

    You'll use the data here in the next exercises to build your kernel
    Remember to keep your keys private and secure!

> [!IMPORTANT]
> Be sure not to delete this resource until you've completed this learning path. You'll need it to complete the exercises.