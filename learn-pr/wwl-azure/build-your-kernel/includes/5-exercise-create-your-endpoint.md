For this exercise, you create an endpoint for the large language model (LLM) service. The Semantic Kernel SDK uses this endpoint to connect to the LLM and run prompts. The Semantic Kernel SDK supports HuggingFace, OpenAI, and Azure Open AI LLMs. For this example, you use Azure Open AI.

1. Navigate to [https://portal.azure.com](https://portal.azure.com).

2. Create a new Azure OpenAI resource using the default settings.

    > [!NOTE]
    > If you already have an Azure OpenAI resource, you can skip this step.

3. After the resource is created, select **Go to resource**.

4. On the **Overview** page, select **Go to Azure OpenAI Studio**.

:::image type="content" source="../media/model-deployments.png" alt-text="A screenshot of the Azure OpenAI deployments page.":::

1. Select **Create New Deployment** then **Deploy Model**.

2. Under **Select a model**, select **gpt-35-turbo-16k**.

    Use the default Model version

3. Enter a name for your deployment.

4. When the deployment completes, navigate back to your Azure OpenAI resource.

5. Under **Resource Management**, go to **Keys and Endpoint**.

    You'll use the data here in the next exercises to build your kernel
    Remember to keep your keys private and secure!

> [!IMPORTANT]
> Be sure not to delete this resource until you've completed this learning path. You'll need it to complete the exercises.