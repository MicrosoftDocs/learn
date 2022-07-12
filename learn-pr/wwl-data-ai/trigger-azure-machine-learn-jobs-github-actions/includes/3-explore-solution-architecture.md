It’s important to understand the overall picture before moving ahead with the implementation to ensure all the requirements are met. We also want to ensure the approach is easily adaptable in the future. The focus of this exercise is to start to use GitHub Actions as the orchestration and automation tool for the machine learning operations (MLOps) strategy defined in the solution architecture. 

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

Specifically, we’re going to be automating the training portion of the model development, or inner loop, which will ultimately allow us to quickly train and register multiple models for deployment to staging and production environments. 

The Azure Machine Learning workspace, Azure Machine Learning compute, and GitHub repository have all been created for you by the infrastructure team. 

In addition, the code to train the classification model is production-ready and the data needed to train the model is available in an Azure Blob Storage connected to the Azure Machine Learning workspace. 

Your implementation will enable the move from inner to outer loop to be an automated process that happens whenever a data scientist pushes new model code to the GitHub repository, enabling the continuous delivery of machine learning models to downstream consumers of the model, like the web application that will use the diabetes classification model.


