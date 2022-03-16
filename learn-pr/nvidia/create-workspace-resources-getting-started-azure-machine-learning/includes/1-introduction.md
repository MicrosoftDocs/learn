In this module, you'll learn how to create workspace resources for getting started with Azure Machine Learning.  These will include deployment of an Azure Storage Account for storing and retrieving image data, an Azure Machine Learning Studio instance with an associated compute instance for image training / validation, and an Azure Machine Learning studio Datastore for referencing image data.

### Prerequisites

- [Azure Free Trial Account](https://azure.microsoft.com/free/)

:::image type="content" source="../media/1-manufacturing-line.png" alt-text="An object detection algorithm running on a manufacturing line" lightbox="../media/1-manufacturing-line.png":::

## Scenario: Deploy resources to develop a custom object detection model using NVIDIA and Azure Machine Learning

You're a data scientist who has been assigned the task of improving automation in a manufacturing facility.  You have started investigating an opportunity to increase operational efficiency and mitigate downtime by employing a custom object detection model that can identify items on the production line.  This will involve applying concepts related to computer vision in a production setting to be employed at the edge in a secure network environment.  Azure Machine Learning studio has been identified as a choice tool for this task due to its ability to provide a GUI-based integrated development environment in the Microsoft Azure cloud for constructing and operationalizing Machine Learning workflows.  Pairing this offering with accelerated cloud-compute instances equipped with NVIDIA GPU hardware acceleration will enable the ability to efficiently develop optimized models for use in production.  You'll begin by deploying the necessary resources to support the development of a custom object detection model that will service your industry use case.

## What will you learn?

After you finish this module, you'll be able to:

- Create an Azure Storage account for storing and loading image data
- Create workspace resources for getting started with Azure Machine Learning
  - Create an Azure Machine Learning  Studio workspace
  - Create an Azure Machine Learning  Studio compute instance for use in model in training / validation
  - Create an Azure Machine Learning  Studio Datastore

## What is the main goal?

This module will show you how to get started with development of machine learning workflows using resources in Microsoft Azure to store, load, and train image data to create a custom object detection model for use in production.