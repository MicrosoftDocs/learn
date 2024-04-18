

The Azure Extension for Azure Database for PostgreSQL allows you to call custom-built Azure Machine Learning service deployments. This extention allows you to train your own custom model and use its outputs in PostgreSQL.

## Azure Machine Learning

**Azure Machine Learning** is a cloud service for accelerating and managing the machine learning (ML) project lifecycle. Machine learning professionals, data scientists, and engineers can use it in their day-to-day workflows to train and deploy models and manage machine learning operations (MLOps).

You can create a model in Machine Learning or use a model built from an open-source platform, such as PyTorch, TensorFlow, or scikit-learn. MLOps tools help you monitor, retrain, and redeploy models.

## Scenario: Estimating nightly prices for rental properties

Suppose you're the lead developer for Margie's Travel. Your company is embarking on a plan to expand their short-term rental property listing service. One way your company would like to expand the service is by offering an ability to estimate the nightly rate a rental property could fetch. In particular, you would like to use existing rental listing data to train a model to predict the price a renter would be willing to pay to stay at a particular property. You're interested in using Azure Machine Learning to host this model and will host your customer data in Azure Database for PostgreSQL flexible server.

TODO: visual element

## Learning objectives

This module shows how to use the Azure Machine Learning service with Azure Database for PostgreSQL - Flexible Server. In this module, you will:

- Train a model using Azure Machine Learning's Automated Machine Learning
- Deploy a trained model in Azure Machine Learning
- Install the Azure AI Extension on an existing Azure Database for PostgreSQL flexible server instance
- Create a function to generate price estimates for rental listings

By the end of this session, you'll be able to use the Azure AI Extension to call a custom-trained Azure Machine Learning model from Azure Database for PostgreSQL flexible server.
