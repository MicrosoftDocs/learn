After you train your model, the next step is deployment. To deploy your model effectively, you need to use MLflow.

MLflow helps you manage the entire process, from logging parameters and metrics to packaging and sharing your model.

You also need to consider how you want to deploy the model. You can opt  for real-time predictions using Mosaic AI Model Serving or for batch predictions with Azure Databricks jobs. Alternatively, you can integrate with Azure Machine Learning and use its built-in capabilities to deploy your model to a real-time or batch endpoint.

Whatever approach you choose, model deployment ensures your model is ready for production and can deliver the insights you need.

## Use MLflow for model management

Azure Databricks works with MLflow. MLflow is an open-source platform for managing the entire machine learning lifecycle.

With MLflow, you can track experiments, package code, and share and deploy models. MLflow ensures that your models are consistently managed from development to production.

MLflow’s tracking server lets you log parameters, metrics, and artifacts. MLflow's tracking capabilities provide a comprehensive record of model performance and helps with reproducibility.

> [!Tip]
> Learn more about how to [log, load, register, and deploy MLflow models](/azure/databricks/mlflow/models?azure-portal=true).

## Deploy models with Databricks

Deploying models with Azure Databricks involves using **Mosaic AI Model Serving** to create production-grade APIs from custom Python models.

Custom Python models are the models you train using libraries like scikit-learn, XGBoost, PyTorch, and HuggingFace transformers.

After training, you log your trained model in the MLflow format and register the MLflow assets in the Unity Catalog or workspace registry.

Once registered, you can create and query model serving **endpoints**, ensuring your models are ready for real-time predictions by integrating the endpoint in your solutions.

> [!Tip]
> Learn more about how to [deploy and query a custom model](/azure/databricks/machine-learning/model-serving/model-serving-intro?azure-portal=true).

### Generate batch predictions

For use cases where real-time predictions aren't necessary, batch inference can be a more effective deployment strategy. Batch predictions are often used in scenarios such as generating periodic reports or updating data warehouses with new insights.

Azure Databricks can process large datasets in parallel using Apache Spark, making it well-suited for batch inference tasks.

When you run an Azure Databricks job, your model can be applied to large volumes of data in a scheduled manner. You can generate batch predictions or insights that can be stored and accessed as needed.

> [!Tip]
> Learn more about how to [deploy models for batch inference and prediction](/azure/databricks/machine-learning/model-inference/?azure-portal=true).

## Integrate with Azure Machine Learning

Azure Databricks integrates with Azure Machine Learning, enabling you to deploy models to endpoints in the Azure Machine Learning workspace.

Both Azure Databricks and Azure Machine Learning work with MLflow to manage models. You can train a model in Azure Databricks, and save it as an MLflow model. You can then register the MLflow model in the Azure Machine Learning workspace, after which you can easily deploy the model to a batch or real-time endpoint.

> [!Tip]
> Learn more about [Azure Machine Learning endpoints for inference in production](/azure/machine-learning/concept-endpoints?azure-portal=true).
