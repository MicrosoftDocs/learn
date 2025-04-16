Azure Machine Learning is a platform for creating and managing the end-to-end life cycle of machine learning systems. Azure Machine Learning is **framework agnostic**, giving you the flexibility to work with the technologies you prefer, such as TensorFlow, PyTorch, ONNX, MLFlow, and Scikit-learn.

Azure Machine Learning allows users familiar with ML frameworks to quickly train and deploy models using code, while giving others powerful visual tools. All your training scripts, models, logs, and computes are centralized in a shared workspace in Azure Machine Learning, which assists you in every step of building and deploying machine learning systems, meaning you can focus on models while Azure Machine Learning does the rest.

Azure Machine Learning has a comprehensive suite of features to support logging, monitoring, and governance of data and models, ensuring your models are performing as intended and effectively communicated to stakeholders.

## What is Azure Machine Learning Studio?

Azure Machine Learning Studio is a browser-based service that provides no-code and code-first solutions to visually create, train, and manage models through a web UI. Azure Machine Learning Studio allows the Python SDK to seamlessly integrate with the natively supported Jupyter Notebooks for collaborative notes and coding. Data within Azure Machine Learning Studio is simple to manage with intuitive data visualization and AI-assisted image or text labeling features.

:::image type="content" source="../media/2-studio.gif" alt-text="Screenshot of an experiment in Azure Machine Learning Studio." lightbox="../media/2-studio.gif":::

## Creating a model

You can create models in Azure Machine Learning in several ways. Training can take place on a local machine or the Azure cloud, such as a virtual machine or compute cluster.

### Code with Python

With the Azure Machine Learning SDK for Python, you can interact with the service from multiple environments, including Jupyter Notebooks. Notebooks provide a collaborative environment for runnable code, visualizations, and comments. Azure Machine Learning Studio includes sample notebooks you can use to get started with Azure Machine Learning.

:::image type="content" source="../media/2-notebooks.gif" alt-text="Screenshot of Azure Machine Learning notebooks." lightbox="../media/2-notebooks.gif":::

### AutoML

_Automated Machine Learning_ (AutoML) automates creating the best machine learning models and helps you find the best model for your data, no matter your data-science expertise. Specializing in classification, regression, and time-series forecasting, AutoML experiments with different features, algorithms, and parameters depending on the task, then provides scores on models it thinks are the best fit. You can then deploy these models as is, or export them to an ONNX format that can run on various platforms and devices. AutoML's versatility and speed mean it's often used as a starting point by both experienced and novice data scientists.

You can use AutoML in the Azure Machine Learning Studio or through the Python SDK.

The following image shows an overview of the AutoML pipeline building and recommending a model.

![Diagram of the Azure AutoML pipeline.](../media/2-pipeline.gif)

### Designer

If you prefer a no-code option, _Azure Machine Learning Designer_ within the Azure Machine Learning Studio gives you a visual canvas with drag-and-drop controls to manipulate datasets and modules. Modules within Azure Machine Learning Designer are algorithms that can have a range of purposes, from data ingress functions to training, scoring, and validation processes. These linked modules create effective ML pipelines to build, test, and deploy ML models, as shown in the following example.

:::image type="content" source="../media/2-designer.gif" alt-text="Screenshot of Azure Machine Learning designer." lightbox="../media/2-designer.gif":::

## Compute

You can allocate or attach the computing resources you need for your ML environment through Azure Machine Learning. From the compute that powers your Jupyter notebooks for exploratory data analysis, to the clusters you'll use for training and the managed endpoints you'll deploy to for production inferencing at scale; you can create and manage all of them through Azure Machine Learning.

## Managing data

With Azure Machine Learning, you can streamline and collaboratively work on the time-intensive process of data preparation and ingestion. The platform smoothly integrates with Azure Synapse, Azure Databricks, and a suite of other Azure services to assist data engineering pipelines to extract, transform, and load (ETL) raw data into datastores.

### Datastores and labeling

Azure Machine Learning securely stores your raw data in the datastore, so you don't have to rely on external sources for your scripts, and you can experiment on your training sets without risking the integrity of the original raw data. Once stored, you can clean, transform, and label data to create training sets from the datastore. Azure Machine Learning offers tools to help label tabular, image, and text data with built-in machine learning systems that can suggest labels or fully automate data labeling. The following example shows a human-led multilabel classification project underway in the Azure Machine Learning Studio.

:::image type="content" source="../media/2-human-labeling.gif" alt-text="Screenshot of multilabel classification in Azure Machine Learning Studio." lightbox="../media/2-human-labeling.gif":::

## MLOps

All models—including those that work perfectly when deployed—require monitoring and retraining over time to maintain high performance. Azure Machine Learning provides _Machine Learning Operations_ (MLOps) capabilities to create repeatable steps for data preparation, training, scoring, and reusable software environments for easy deployment. These reproducible pipelines and environments deliver a _continuous integration/continuous delivery_ (CI/CD) experience to your machine learning workflow.

In addition to these features, Azure Machine Learning also provides MLOps monitoring tools to notify you of events within the ML lifecycle, and even react to them. With this control, you can quickly identify and respond to diminishing model performance or issues within datasets. Governance information is also provided within Azure Machine Learning, so you can view a full run history and track team members' actions within the model life cycle.
