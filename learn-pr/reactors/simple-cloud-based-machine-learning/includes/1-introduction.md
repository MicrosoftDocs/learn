Thus far, we have looked at building and fitting machine learning (ML) models "locally." True, the notebooks have been located in the cloud themselves, but the models with all of their predictive and classification power are stuck in those notebooks. To use these models, you would have to load data into your notebooks and get the results there.

In practice, we want those models accessible from a number of locations. And while the management of production ML models has a lifecycle all its own, one part of that is making models accessible from the web. One way to do so is to develop them using third-party cloud tools, such as [Microsoft Azure Machine Learning Service](https://ml.azure.com/?azure-portal=true).

Additionally, we've so far only run one machine learning algorithm on each dataset at a time. In addition to the Cloud, Azure Machine Learning also offers AutoML: Automated Machine Learning. AutoML is a service where Azure will run the data through many machine learning algorithms and determine which algorithm more accurately classifies customers.

## Learning objectives

In this module, you will:

- Create an Azure Machine Learning Resource
- Upload data into a dataset into Azure Machine Learning Studio
- Use Azure AutoML (Automated Machine Learning) to find the best model for your data
- Deploy the best model as a web service

## Prerequisites

- Review the steps to manipulate and clean data.
- Understand machine learning models for data science.
