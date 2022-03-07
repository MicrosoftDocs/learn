Organizations often have different requirements for their machine learning operations process. One common approach is to use a command-line program to manage Azure resources. The Azure CLI (v2) lets you manage the Azure Machine Learning workspace and its assets. Making it easy to reproduce an environment and automate processes.

> [!Important]
> The Azure CLI (v2) for Azure Machine Learning is currently in public preview. The preview version is provided without a service-level agreement, and is not recommend for production workloads.

Suppose you work as a machine learning engineer at a company selling bikes. One of the data scientists at your company created a new machine learning model to predict customer churn. The marketing team wants to use the model to know when to email customers with special promotions. By offering a subset of customers these discounts, your company hopes to retain these customers that may otherwise buy a bike from the competitor.

The data scientist who created the model, trained the model locally on their own computer. Training a machine learning model on a local computer is a typical approach.

Ideally however, the model should be trained in the Azure Machine Learning workspace and the complete process should be tracked and reproducible. When the model is trained with Azure Machine Learning, it will also be easier for the data science team to collaborate.

To create an Azure Machine Learning workspace, you can use the Azure portal, Azure CLI, or Azure Resource Manager templates. To make sure all your work is reproducible and ready for automation for future projects, you will use the Azure CLI.

This module shows you how to set up the Azure CLI (v2) for Azure Machine Learning. You can then create an Azure Machine Learning workspace and any assets within the workspace necessary to train machine learning models.

## Learning objectives

In this module, you'll learn how to:

- Install the Azure CLI and the Azure Machine Learning extension.
- Create an Azure Machine Learning workspace.
- Manage assets in the Azure Machine Learning workspace with the Azure CLI.
