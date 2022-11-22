To plan for scale and for automation, you've worked together with several stakeholders to decide on a **machine learning operations** (**MLOps**) architecture.

![Diagram of machine learning operations architecture.](../media/01-01-architecture.png)

> [!Note]
> The diagram is a simplified representation of a MLOps architecture. To view a more detailed architecture, explore the various use cases in the [MLOps (v2) solution accelerator](https://github.com/Azure/mlops-v2).

The architecture includes:

1. **Setup**: Create all necessary Azure resources for the solution.
2. **Model development (inner loop)**: Explore and process the data to train and evaluate the model.
3. **Continuous integration**: Package and register the model.
4. **Model deployment (outer loop)**: Deploy the model.
5. **Continuous deployment**: Test the model and promote to production environment.
6. **Monitoring**: Monitor model and endpoint performance.

Most importantly for the current challenge is to take a model from model development to model deployment. The step in between these two loops is to package and register the model. After the data science team has trained a model, it's essential to package the model, and to register it in the Azure Machine Learning workspace. Once the model is registered, it's time to deploy the model. 

There are several approaches to package the model. After reviewing some options like working with pickle files, you've decided with the data science team to work with **MLflow**. When you register the model as an MLflow model, you can opt for no-code deployment in the Azure Machine Learning workspace. when you use no-code deployment, you don't need to create the scoring script and environment for the deployment to work. 

When you want to deploy a model, you have a choice between an **online endpoint** for real-time predictions or a **batch endpoint** for batch predictions. As the model will be integrated with a web app where the practitioner will input medical data expecting to get a direct response, you choose to deploy the model to an online endpoint. 

You can deploy the model manually in the Azure Machine Learning workspace. However, you expect to deploy more models in the future. And you want to easily redeploy the diabetes classification model whenever the model has been retrained. You therefore want to automate the model deployment wherever possible.

> [!Note]
> Though automation is a critical aspect of MLOps, it's crucial to maintain a human-in-the-loop. It's a best practice to verify the model before automatically deploying it.