For this exercise, you create an Azure OpenAI resource and provide the deployment information to the Semantic Kernel. The Semantic Kernel will connect to the endpoint and allow you to run prompts to the large language model (LLM) directly from your code. Let's get started!

1. Navigate to [https://portal.azure.com](https://portal.azure.com).

1. In the search bar, enter "Azure OpenAI" and select the **Azure OpenAI** service.

1. Create a new Azure OpenAI resource using the default settings.

    > [!NOTE]
    > If you already have an Azure OpenAI resource, you can skip this step.

1. After the resource is created, select **Go to resource**.

1. Under **Resource Management**, select **Keys and Endpoint**.

    You use the data here in the next exercises to build your kernel. Remember to keep your keys private and secure!

1. On the **Overview** page, select **Go to Azure OpenAI Studio**.

    A new window should open with the Azure AI webpage.

1. Under **Shared resources** select **Deployments**.

1. Select **Deploy Model** then select **Deploy base model**.

1. Select the **gpt-35-turbo-16k** model and select **Confirm**.

1. Select **Deploy**.

    The model deployment details should appear. Now you're ready to begin building your AI application!

> [!IMPORTANT]
> Be sure not to delete this resource until you've completed this learning path. You need it to complete the exercises.