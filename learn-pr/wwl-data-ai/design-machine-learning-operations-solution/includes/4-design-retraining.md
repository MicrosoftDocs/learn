


When preparing your model for production in a machine learning operations (MLOps) solution, you need to design for retraining. 

Generally, there are two approaches to when you want to retrain a model:

- Based on a **schedule**: when you know you always need the latest version of the model, you can decide to retrain your model every week, or every month, based on a schedule.
- Based on **metrics**: if you only want to retrain your model when necessary, you can monitor the model's performance and data drift to decide when you need to retrain the model.

In either case, you need to design for retraining. To easily retrain your model, you should prepare your code for automation.

## Prepare your code 

Ideally, you should train models with **scripts** instead of notebooks. Scripts are better suited for automation. You can add **parameters** to a script and change input parameters like the training data or hyperparameter values. When you parameterize your scripts, you can easily retrain the model on new data if needed.

Another important thing to prepare your code is to host the code in a central repository. A repository refers to a location where all relevant files to a project are stored. With machine learning projects, Git-based repositories are ideal to achieve **source control**.

When you apply source control to your project, you can easily collaborate on a project. You can assign someone to improve the model by updating the code. You'll be able to see past changes, and you can review changes before they're committed to the main repository.

## Automate your code

When you want to automatically execute your code, you can configure Azure Machine Learning jobs to run scripts. In Azure Machine Learning, you can create and schedule pipelines to run scripts too. 

If you want scripts to run based on a trigger or event happening outside of Azure Machine Learning, you may want to trigger the Azure Machine Learning job from another tool. 

Two tools that are commonly used in MLOps projects are Azure DevOps and GitHub (Actions). Both tools allow you to create automation pipelines and can trigger Azure Machine Learning pipelines. 

As a data scientist, you may prefer to work with the Azure Machine Learning Python SDK. However, when working with tools like Azure DevOps and GitHub, you may prefer to configure the necessary resources and jobs with the Azure Machine Learning CLI extension instead. The Azure CLI is designed for automating tasks and may be easier to use with Azure DevOps and GitHub.

> [!TIP]
> If you want to learn more about MLOps, explore the [introduction to machine learning operations (MLOps)](/training/paths/introduction-machine-learn-operations/?azure-portal=true) or try to build your first [MLOps automation pipeline with GitHub Actions](/training/paths/build-first-machine-operations-workflow/?azure-portal=true)
