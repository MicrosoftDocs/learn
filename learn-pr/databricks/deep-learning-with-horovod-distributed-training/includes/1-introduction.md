Imagine that you work as a data scientist for a large online retail store. You have trained a deep learning model using Tensorflow and a subset of the available training data on single node GPU machine to predict customer churn. Now you are ready to train the next iteration of the model using all available training data, however, you realize that training time on a single node will be in the order of weeks. You next task is to look for open source frameworks that support distributed training of deep learning models that is both high performing and easy to use.

[!INCLUDE [azure-databricks-free-trial-note](../../../includes/azure-databricks-free-trial-note.md)]

## Learning objectives

In this module, you'll:

* Learn how you can use Azure Databricks and how to run long-running, distributed deep learning training jobs on Spark
* Use Petastorm to enable training and evaluation of deep learning models from datasets in Apache Parquet format

## Prerequisites

- An Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free).
