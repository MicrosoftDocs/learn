So far, we've looked at how to build and fit machine learning models "locally." The notebooks were located in the cloud, but the models with all of their predictive and classification power were stuck in those notebooks. To use these models, you would have to load data into your notebooks and get the results there.

In practice, we want those models to be accessible from a number of locations. While the management of production machine learning models has a lifecycle all its own, one part is to make models accessible from the web. One way to do so is to develop them by using third-party cloud tools, such as [Microsoft Azure Machine Learning](https://ml.azure.com/?azure-portal=true).

At this point, we've run only one machine learning algorithm on each dataset at a time. In addition to the cloud, Azure Machine Learning offers automated machine learning. Automated machine learning is a service where Azure runs the data through many machine learning algorithms and determines which algorithm more accurately classifies customers.

## Learning objectives

In this module, you will:

- Create an Azure Machine Learning resource.
- Upload data into a dataset in Azure Machine Learning Studio.
- Use Azure automated machine learning to find the best model for your data.
- Deploy the best model as a web service.

## Prerequisites

- Review the steps to manipulate and clean data.
- Understand machine learning models for data science.
- Have an active Azure subscription.

[!INCLUDE [Set up your environment](../../includes/set-up-environment.md)]
