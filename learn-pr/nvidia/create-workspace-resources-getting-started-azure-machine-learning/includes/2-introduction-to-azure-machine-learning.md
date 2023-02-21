Azure Machine Learning  is a platform for creating and managing the end-to-end life cycle of machine learning systems. Azure Machine Learning is **framework agnostic**, giving you the flexibility to work with the technologies you prefer, such as _TensorFlow, PyTorch, ONNX, MLFlow, and Scikit-learn._

## Introduction to Azure Machine Learning 

Azure Machine Learning  enables users familiar with Machine Learning  frameworks to quickly train and deploy models using code, while giving others powerful visual tools. All your training scripts, models, logs, and computes are centralized in a shared Workspace in Azure Machine Learning, which assists you in every step of building and deploying machine learning systems—meaning you can focus on models while Azure Machine Learning  does the rest.

Azure Machine Learning  has a comprehensive suite of features to support logging, monitoring, and governance of datasets and models, ensuring your models are performing as intended and effectively communicated to stakeholders.

## What is Azure Machine Learning studio?

Azure Machine Learning studio is a browser-based service that provides no-code and code-first solutions to visually create, train, and manage models through a web UI. Azure Machine Learning  studio allows _Python_ and _R_ SDK to seamlessly integrate with the natively supported _Jupyter Notebooks_ for collaborative notes and coding. Data within Azure Machine Learning studio is simple to manage with intuitive data visualization and AI-assisted image or text labeling features.

:::image type="content" source="../media/2-studio.gif" alt-text="Azure Machine Learning studio is shown in action." lightbox="../media/2-studio.gif":::

## Creating a model

Models can be created in Azure Machine Learning  in several ways. Training can take place on a local machine or the Azure cloud, such as a virtual machine or compute cluster.

### AutoML

_Automated Machine Learning (AutoML)_ automates creating the best machine learning models, helping users find the best model for their data—no matter their data science expertise. **Specializing in classification, regression, and time-series forecasting,** AutoML experiments with different features, algorithms, and parameters depending on the task—then provides scores on models it thinks are the best fit. These models can then be exported to an ONNX format that can run on various platforms and devices. AutoML’s versatility and speed mean it’s often used as a starting point by both experienced and novice data scientists.

In the following image, there's an overview of the AutoML pipeline building and recommending a model.

![An Azure machine learning automl pipeline is displayed.](../media/2-pipeline.gif)

## Compute

The computing resources you need for your Machine Learning environment can be allocated or attached through Azure Machine Learning. From the compute that powers your Jupyter notebooks for exploratory data analysis, to the clusters you'll use for training and the kubernetes clusters you'll deploy to for production inferencing at scale, it can be managed through Azure Machine Learning.

## Managing data

With Azure Machine Learning, you can streamline and collaboratively work on the time-intensive process of data preparation and ingestion. The platform smoothly integrates with _Azure Synapse, Azure Databricks,_ and a suite of other Azure services to assist data engineering pipelines to extract, transform, and load (ETL) raw data into datastores.

### Datastores and labeling

Azure Machine Learning  securely stores your raw data in the datastore, so you don’t have to rely on external sources for your scripts, and your training sets can be experimented upon without risking the integrity of the original raw data. Once stored, you can clean, transform, and label data to create training sets from the datastore. Azure Machine Learning  offers tools to help label tabular, image, and text data—with built-in machine learning systems that can suggest labels or fully automate data labeling.
