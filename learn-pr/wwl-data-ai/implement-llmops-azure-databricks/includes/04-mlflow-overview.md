MLflow is a comprehensive open-source platform that facilitates the entire machine learning lifecycle, including experimentation, reproducibility, and deployment.

When integrated with Azure Databricks, MLflow provides a robust and scalable environment for managing machine learning models from development to production.

## Create endpoints to serve your models

You can use [MLflow's Deployment SDK](https://mlflow.org/docs/latest/python_api/mlflow.deployments.html?azure-portal=true) to create endpoints that deploy and serve LLMs.

MLflow is integrated with Azure Databricks' **Model Serving** feature, which allows you to manage your deployed LLMs. When you want to work with LLMs, you can start experimenting with one of the available foundation models in Azure Databricks:

:::image type="content" source="../media/serving-endpoints.png" alt-text="Screenshot of the serving endpoints readily available in Azure Databricks." lightbox="../media/serving-endpoints.png":::

Alternatively, you can create a new serving endpoint to deploy another LLM you want to work with. You can create an endpoint using MLflow's Deployment SDK, or use the UI where you have to specify which language model you want to create an endpoint for.

:::image type="content" source="../media/create-endpoint.png" alt-text="Screenshot showing how to create a serving endpoint in Azure Databricks." lightbox="../media/create-endpoint.png":::

For example, you add a serving entity by connecting to an OpenAI model like GPT-4:

:::image type="content" source="../media/openai-model.png" alt-text="Screenshot of configuration of an OpenAI model." lightbox="../media/openai-model.png":::

Once you create an endpoint, you can review all metadata and use the URL to interact with the deployed LLM:

:::image type="content" source="../media/endpoint.png" alt-text="Screenshot of serving endpoint overview." lightbox="../media/endpoint.png":::

> [!Tip]
> Learn more about how to [create generative AI model serving endpoints](/azure/databricks/machine-learning/model-serving/create-foundation-model-endpoints#ext-model-endpoint?azure-portal=true).
