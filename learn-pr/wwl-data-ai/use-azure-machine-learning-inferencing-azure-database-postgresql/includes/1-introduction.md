

The Azure Extension for Azure Database for PostgreSQL allows you to call custom-built Azure Machine Learning service deployments. This extension enables you to train a custom model and use its outputs in PostgreSQL.

## Azure Machine Learning

**Azure Machine Learning** is a cloud service for accelerating and managing the machine learning (ML) project lifecycle. Machine learning professionals, data scientists, and engineers can use it in their day-to-day workflows to train and deploy models and manage machine learning operations (MLOps).

You can create a model in Machine Learning or use a model built from an open-source platform, such as PyTorch, TensorFlow, or scikit-learn. Machine learning operations tools help you monitor, retrain, and redeploy models.

## Scenario: Estimating nightly prices for rental properties

Suppose you're the lead developer for Margie's Travel. Your company is embarking on a plan to expand its short-term rental property listing service. One way your company would like to extend the service is by offering the ability to estimate the nightly rate a rental property could fetch. In particular, you would like to use existing rental listing data to train a model to predict the price a renter would pay to stay in a specific property. You're interested in using Azure Machine Learning to host this model and will host your customer data in Azure Database for PostgreSQL flexible server.

## Learning objectives

This module shows how to use the Azure Machine Learning service with Azure Database for PostgreSQL - Flexible Server. In this module, you will:

- Train a model using Azure Machine Learning's Automated Machine Learning
- Deploy a trained model in Azure Machine Learning
- Install the `azure_ai` extension on an existing Azure Database for PostgreSQL flexible server instance
- Create a function to generate price estimates for rental listings

By the end of this session, you can use the `azure_ai` extension to call a custom-trained Azure Machine Learning model from an Azure Database for PostgreSQL flexible server.
