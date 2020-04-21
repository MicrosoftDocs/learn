> [!Note]
> **Sarah: Action items**
> 
> - Add Learning objectives
> - Add Prerequisites
>

Thus far, we have looked at building and fitting machine learning (ML) models "locally." True, the notebooks have been located in the cloud themselves, but the models with all of their predictive and classification power are stuck in those notebooks. To use these models, you would have to load data into your notebooks and get the results there.

In practice, we want those models accessible from a number of locations. And while the management of production ML models has a lifecycle all its own, one part of that is making models accessible from the web. One way to do so is to develop them using third-party cloud tools, such as [Microsoft Azure ML Studio](https://studio.azureml.net/?azure-portal=true) (not to be confused with Microsoft Azure Machine Learning Service, which provides end-to-end lifecycle management for ML models).

Alternatively, we can develop and deploy a function that can be accessed by other programs over the web—a web service—that runs within Azure ML Studio, and we can do so entirely from a Python notebook. In this section, we will use the [azureml](https://github.com/Azure-Samples/Azure-MachineLearning-ClientLibrary-Python?azure-portal=true) package to deploy an Azure ML web service directly from within a Python notebook (or other Python environment).

> [!Note]
> The `azureml` package currently works only with Python 2. If your notebook is not currently running Python 2, you can change it in the menu at the top of the notebook. Select **Kernel** > **Change kernel** > **Python 2**.

## Learning objectives

In this module, you will:

- TBD
- TBD

## Prerequisites

- TBD or None.
