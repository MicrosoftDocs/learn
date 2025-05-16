As a data scientist, you want to train the best machine learning model. To implement the model, you want to deploy it to an endpoint and integrate it with an application.

Over time, you want to retrain the model. For example, you can retrain the model when you have more training data.

In general, once you trained a machine learning model, you want to get the model ready for enterprise-scale. To prepare the model and operationalize it, you want to:

- Convert the model training to a **robust** and **reproducible** pipeline.
- Test the code and the model in a **development** environment.
- Deploy the model in a **production** environment.
- **Automate** the end-to-end process.

## Design an MLOps architecture

Bringing a model to production means you need to scale your solution and work together with other teams. Together with other data scientists, data engineers and an infrastructure team, you can decide on using the following approach:

- Store all data in an Azure Blob storage, managed by the data engineer.
- The infrastructure team creates all necessary Azure resources, like the Azure Machine Learning workspace.
- Data scientists focus on what they do best: developing and training the model (inner loop).
- Machine learning engineers deploy the trained models (outer loop).

As a result, your MLOps architecture includes the following parts:

:::image type="content" source="../media/mlops-architecture.png" alt-text="Diagram of an architecture showcasing a typical MLOps project.":::

1. **Setup**: Create all necessary Azure resources for the solution.
1. **Model development (inner loop)**: Explore and process the data to train and evaluate the model.
1. **Continuous integration**: Package and register the model.
1. **Model deployment (outer loop)**: Deploy the model.
1. **Continuous deployment**: Test the model and promote to production environment.
1. **Monitoring**: Monitor model and endpoint performance.

When you're working with larger teams, you're not expected to be responsible of all parts of the MLOps architecture as a data scientist. To prepare your model for MLOps as a data scientist, you should think about how to design for monitoring and retraining.

## Monitor the model's performance

If you want to only retrain when needed, you can monitor the model's performance and anything that can influence it:

- **Track performance**: Monitor key model metrics like accuracy and F1 score to evaluate the effectiveness of your model.
- **Detect data drift**: Data drift occurs when the statistical properties of the input data change over time. Detecting data drift involves monitoring the distributions of input features or target variables to identify any significant changes that could affect model performance.
- **Identify concept drift**: Concept drift refers to changes in the relationship between input features and the target variable. Concept drift can happen when the underlying patterns in the data evolve. Identifying concept drift involves tracking the performance of the model on new data and looking for shifts in feature-label relationships.

## Retrain the model

Generally, there are two approaches to when you want to retrain a model:

- Based on a **schedule**: when you know you always need the latest version of the model, you can decide to retrain your model every week, or every month, based on a schedule.
- Based on **metrics**: if you only want to retrain your model when necessary, you can monitor the model's performance and data drift to decide when you need to retrain the model.

In either case, you need to design for retraining. To easily retrain your model, you should prepare your code for automation.

### Prepare your code

Ideally, you should train models with **scripts** instead of notebooks. Scripts are better suited for automation. You can add **parameters** to a script and change input parameters like the training data or hyperparameter values. When you parameterize your scripts, you can easily retrain the model on new data if needed.

Another important thing to prepare your code is to host the code in a central repository. A repository refers to a location where all relevant files to a project are stored. With machine learning projects, Git-based repositories are ideal to achieve **source control**.

When you apply source control to your project, you can easily collaborate on a project. You can assign someone to improve the model by updating the code. You can explore past changes, and you can review changes before they're committed to the main repository.

### Automate your code

When you want to automatically execute your code, you can configure Azure Machine Learning jobs to run scripts. In Azure Machine Learning, you can create and schedule pipelines to run scripts too.

If you want scripts to run based on a trigger or event happening outside of Azure Machine Learning, you trigger the Azure Machine Learning job from another tool.

Two tools that are commonly used in MLOps projects are Azure DevOps and GitHub (Actions). Both tools allow you to create automation pipelines and can trigger Azure Machine Learning pipelines.

As a data scientist, you can prefer to work with the Azure Machine Learning Python SDK. However, when working with tools like Azure DevOps and GitHub, you can prefer to configure the necessary resources and jobs with the Azure Machine Learning CLI extension instead. The Azure CLI is designed for automating tasks and integrates well with Azure DevOps and GitHub.

> [!TIP]
> If you want to learn more about MLOps, explore the [introduction to machine learning operations (MLOps)](/training/paths/introduction-machine-learn-operations/?azure-portal=true) or try to build your first [MLOps automation pipeline with GitHub Actions](/training/paths/build-first-machine-operations-workflow/?azure-portal=true)
