Deploying a trained machine learning model is only the midpoint of the model's life cycle. After deployment, you still need to promote a model safely and keep watching how it behaves in production. This module walks through that path, from registering a trained model to monitoring it after it serves live traffic.

At Proseware, Inc., a health care technology company, you work with a data science team that trains a classification model to predict whether a patient is likely to miss an upcoming clinic appointment. Clinic staff want to use these no-show risk scores to decide who to call ahead of time and confirm, reducing wasted appointment slots. Your job as the machine learning engineer is to take the trained model from the data science team and get it running reliably in production, with a repeatable, automated process the team can trust as the model evolves.

In this module, you explore how to register and manage MLflow model versions in Azure Machine Learning. You deploy and troubleshoot a managed online endpoint, then safely promote or roll back a model version. You use GitHub environments to protect production promotion and GitHub Actions to automate deployment. You also explore how monitoring signals guide investigation and retraining.

By the end of this module, you're able to take an MLflow model from registration through automated deployment and ongoing monitoring in Azure Machine Learning.

## Learning objectives

In this module, you learn how to:

- Register, version, and archive MLflow models throughout their lifecycle.
- Use GitHub environments to control access and require approval before production promotion.
- Deploy and troubleshoot a managed online endpoint, safely promote a model, and roll back to a previous version.
- Automate model deployment and testing with GitHub Actions.
- Monitor a deployed model and recognize signals that call for investigation or retraining.