Azure Machine Learning is a platform for creating and managing the end-to-end life cycle of machine learning systems. Azure Machine Learning is **framework agnostic**, giving you the flexibility to work with the technologies you prefer, such as _TensorFlow, PyTorch, ONNX, MLFlow, and Scikit-learn._

Azure Machine Learning enables users familiar with ML frameworks to quickly train and deploy models using code, while giving others powerful visual tools. All your training scripts, models, logs, and computes are centralized in a shared workspace in Azure Machine Learning, which assists you in every step of building and deploying machine learning systems—meaning you can focus on models while Azure Machine Learning does the rest.

Azure Machine Learning has a comprehensive suite of features to support logging, monitoring, and governance of data and models, ensuring your models are performing as intended and effectively communicated to stakeholders.

## What is Azure Machine Learning studio?

Azure Machine Learning studio is a browser-based service that provides no-code and code-first solutions to visually create, train, and manage models through a web UI. Azure Machine Learning studio allows the _Python_ SDK to seamlessly integrate with the natively supported _Jupyter Notebooks_ for collaborative notes and coding. Data within Azure Machine Learning studio is simple to manage with intuitive data visualization and AI-assisted image or text labeling features.

:::image type="content" source="../media/2-studio.gif" alt-text="Screenshot of an experiment in Azure Machine Learning studio." lightbox="../media/2-studio.gif":::

## Creating a model

Models can be created in Azure Machine Learning in several ways. Training can take place on a local machine or the Azure cloud, such as a virtual machine or compute cluster.

### Code with Python

With the _Azure Machine Learning SDK for Python_, you can interact with the service from multiple environments—including Jupyter Notebooks. Notebooks provide a collaborative environment for runnable code, visualizations, and comments. Included in studio are sample notebooks you can use to get started with Azure Machine Learning. 

:::image type="content" source="../media/2-notebooks.gif" alt-text="Screenshot of Azure Machine Learning notebooks." lightbox="../media/2-notebooks.gif":::

### AutoML

_Automated Machine Learning (AutoML)_ automates creating the best machine learning models, helping you find the best model for your data—no matter your data science expertise. **Specializing in classification, regression, and time-series forecasting,** AutoML experiments with different features, algorithms, and parameters depending on the task—then provides scores on models it thinks are the best fit. These models can then be deployed as is, or exported to an ONNX format that can run on various platforms and devices. AutoML’s versatility and speed mean it’s often used as a starting point by both experienced and novice data scientists.

You can use AutoML in the Azure Machine Learning studio or through the Python SDK.

In the following image, we can see an overview of the AutoML pipeline building and recommending a model.

![azure automl pipeline](../media/2-pipeline.gif)

### Designer

If you prefer a no-code option, _Azure Machine Learning Designer_ within the Azure Machine Learning studio gives you a **visual canvas with drag and drop controls to manipulate datasets and modules.** Modules within Azure Machine Learning Designer are algorithms that can have a range of purposes, from data ingress functions to training, scoring, and validation processes. These linked modules create effective ML pipelines to build, test, and deploy ML models, as seen in the following example.

:::image type="content" source="../media/2-designer.gif" alt-text="Screenshot of Azure Machine Learning designer." lightbox="../media/2-designer.gif":::

## Compute

The computing resources you need for your ML environment can be allocated or attached through Azure Machine Learning. From the compute that powers your Jupyter notebooks for exploratory data analysis, to the clusters you'll use for training and the managed endpoints you'll deploy to for production inferencing at scale, all can be created and managed through Azure Machine Learning.

## Managing data

With Azure Machine Learning, the time-intensive process of data preparation and ingestion can be streamlined and collaboratively worked on. The platform smoothly integrates with _Azure Synapse, Azure Databricks,_ and a suite of other Azure services to assist data engineering pipelines to extract, transform, and load (ETL) raw data into datastores.

### Datastores and labeling

Azure Machine Learning securely stores your raw data in the datastore, so you don’t have to rely on external sources for your scripts, and your training sets can be experimented upon without risking the integrity of the original raw data. Once stored, you can clean, transform, and label data to create training sets from the datastore. Azure Machine Learning offers tools to help label tabular, image, and text data—with built-in machine learning systems that can suggest labels or fully automate data labeling. The following example shows a human led multi-label classification project underway in the Azure Machine Learning studio.

:::image type="content" source="../media/2-human-labeling.gif" alt-text="Screenshot of multi-label classification in Azure Machine Learning studio." lightbox="../media/2-human-labeling.gif":::

## MLOps

All models—including those that work perfectly when deployed—require monitoring and retraining over time to maintain high performance. Azure Machine Learning provides _Machine Learning Operations (MLOps)_ capabilities to create repeatable steps for data preparation, training, scoring, and reusable software environments for easy deployment. These reproducible pipelines and environments deliver a **continuous integration/continuous delivery (CI/CD)** experience to your machine learning workflow.

In addition to these features, Azure Machine Learning also provides MLOps monitoring tools to notify you of events within the ML lifecycle—and even react to them. With this control, you can quickly identify and respond to diminishing model performance or issues within datasets. Governance information is also provided within Azure Machine Learning, so you can view a full run history and track team members’ actions within the model life cycle.
