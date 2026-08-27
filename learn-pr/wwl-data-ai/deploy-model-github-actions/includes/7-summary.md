In this module, you took a trained model from registration through automated deployment to production monitoring in Azure Machine Learning.

## What you learned

- You register and version MLflow models, then archive versions that no longer need to appear in default lists.
- You explore the MLOps stages that connect model development to deployment, automation, and monitoring.
- You use protected GitHub environments to scope deployment access and require approval before production promotion.
- You deploy a model to a managed online endpoint and use a blue-green rollout to test a new version before shifting production traffic to it.
- You troubleshoot deployment and scoring failures by checking deployment details and container logs.
- You keep the previous deployment available so you can roll back by redirecting traffic without changing the endpoint URL.
- You automate registration, deployment, and testing with GitHub Actions by using OIDC federated credentials.
- You use operational and model monitoring signals to decide when to roll back, investigate, or retrain.

## Learn more

- [Deploy MLflow models in Azure Machine Learning](/azure/machine-learning/how-to-deploy-mlflow-models)
- [Deploy machine learning models to online endpoints](/azure/machine-learning/how-to-deploy-online-endpoints)
- [Safe rollout for online endpoints](/azure/machine-learning/how-to-safely-rollout-online-endpoints)
- [Connect GitHub Actions to Azure with OpenID Connect](/azure/developer/github/connect-from-azure)
- [Monitor online endpoints](/azure/machine-learning/how-to-monitor-online-endpoints)
- [Monitor the performance of models deployed to production](/azure/machine-learning/how-to-monitor-model-performance)