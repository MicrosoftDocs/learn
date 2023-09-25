


Scripts are ideal when you want to run machine learning workloads in production environments. Imagine you're a data scientist who has developed a machine learning model to predict diabetes. The model is performing as expected and you created a training script. The script is used to retrain the model every month when new data has been collected.

You'll want to monitor the model's performance over time. You want to understand whether the new data every month benefits the model. Next to tracking models that are trained in notebooks, you can also use **MLflow** to track models in scripts. 

**MLflow** is an open-source platform that helps you to track model metrics and artifacts across platforms and is integrated with Azure Machine Learning.

When you use MLflow together with Azure Machine Learning, you can run training scripts locally or in the cloud. You can review model metrics and artifacts in the Azure Machine Learning workspace to compare runs and decide on next steps.

## Learning objectives 

In this module, you learn how to:

- Use MLflow when you run a script as a job.
- Review metrics, parameters, artifacts, and models from a run.
