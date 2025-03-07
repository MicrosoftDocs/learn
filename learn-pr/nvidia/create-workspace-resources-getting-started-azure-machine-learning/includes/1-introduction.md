In this module, you learn how to create and deploy workspace resources for getting started with Azure Machine Learning. These resources include an Azure Storage Account for storing and retrieving image data. An Azure Machine Learning studio instance with an associated compute instance for image training and image validation. And to reference the image data, an Azure Machine Learning studio Datastore.

### Prerequisites

- [Azure Free Trial Account](https://azure.microsoft.com/free/)

:::image type="content" source="../media/1-manufacturing-line.png" alt-text="An object detection algorithm is shown running on a manufacturing line." lightbox="../media/1-manufacturing-line.png":::

## Scenario: Deploy resources to develop a custom object detection model using NVIDIA and Azure Machine Learning

You're a data scientist assigned the task of improving automation in a manufacturing facility. You started investigating an opportunity to increase operational efficiency and mitigate downtime by employing a custom object detection model that can identify items on the production line. This investigation involves applying concepts related to computer vision in a production setting to be employed at the edge in a secure network environment. Azure Machine Learning studio is identified as a choice tool for this task due to its ability to provide a GUI-based integrated development environment in the Microsoft Azure cloud for constructing and operationalizing Machine Learning workflows. Pairing this offering with accelerated cloud-compute instances equipped with NVIDIA GPU hardware acceleration enables the ability to efficiently develop optimized models for use in production. You begin by deploying the necessary resources to support the development of a custom object detection model for servicing your industry use case.

## What are you going to learn?

After you finish this module, you're able to:

- Create an Azure Storage account for storing and loading image data.
- Create the following workspace resources for getting started with Azure Machine Learning:
  - An Azure Machine Learning studio workspace.
  - An Azure Machine Learning studio compute instance for use in model training and model validation.
  - An Azure Machine Learning studio Datastore.

## What is the main goal?

This module shows you how to get started with the development of machine learning workflows. You begin by creating resources in Microsoft Azure to store, load, and train image data that allows to create a custom object detection model for use in production.