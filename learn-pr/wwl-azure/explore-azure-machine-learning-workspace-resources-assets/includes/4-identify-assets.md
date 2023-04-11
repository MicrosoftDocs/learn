

As a data scientist, you'll mostly work with **assets** in the Azure Machine Learning workspace. Assets are created and used at various stages of a project and include:

- Models
- Environments
- Data
- Components

## Create and manage models

The end product of training a model is the model itself. You can train machine learning models with various frameworks, like Scikit-learn or PyTorch. A common way to store such models is to package the model as a Python pickle file (`.pkl` extension).

Alternatively, you can use the open-source platform MLflow to store your model in the MLModel format.

> [!Tip]
> Learn more about [logging workflow artifacts as models using MLflow and the MLModel format](/azure/machine-learning/concept-mlflow-models?azure-portal=true).

Whatever format you choose, binary file(s) will represent the model and any corresponding metadata. To persist those files, you can create or register a model in the workspace. 

When you create a **model** in the workspace, you'll specify the *name* and *version*. Especially useful when you deploy the registered model, versioning allows you to track the specific model you want to use. 

## Create and manage environments

When you work with cloud compute, it's important to ensure that your code runs on any compute that is available to you. Whether you want to run a script on a compute instance, or a compute cluster, the code should execute successfully. 

Imagine working in Python or R, using open-source frameworks to train a model, on your local device. If you want to use a library such as Scikit-learn or PyTorch, you'll have to install it on your device. 

Similarly, when you write code that uses any frameworks or libraries, you'll need to ensure the necessary components are installed on the compute that will execute the code. To list all necessary requirements, you can create **environments**. When you create an environment, you have to specify the *name* and *version*.

Environments specify software packages, environment variables, and software settings to run scripts. An environment is stored as an image in the Azure Container Registry created with the workspace when it's used for the first time. 

Whenever you want to run a script, you can specify the environment that needs to be used by the compute target. The environment will install all necessary requirements on the compute before executing the script, making your code robust and reusable across compute targets.

## Create and manage data

Whereas datastores contain the connection information to Azure data storage services, **data assets** refer to a specific file or folder. 

You can use data assets to easily access data every time, without having to provide authentication every time you want to access it. 

When you create a data asset in the workspace, you'll specify the path to point to the file or folder, and the *name* and *version*.

## Create and manage components

To train machine learning models, you'll write code. Across projects, there may be code you can reuse. Instead of writing code from scratch, you'll want to reuse snippets of code from other projects.

To make it easier to share code, you can create a **component** in a workspace. To create a component, you have to specify the *name*, *version*, code, and *environment* needed to run the code.

You can use components when creating **pipelines**. A component therefore often represents a step in a pipeline, for example to normalize data, to train a regression model, or to test the trained model on a validation dataset.
