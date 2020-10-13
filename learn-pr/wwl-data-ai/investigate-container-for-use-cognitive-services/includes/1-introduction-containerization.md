Imagine you work for a company that creates health care applications for health workers around the world. You are a software developer on the artificial intelligence team. Your application guides health workers on standard treatments for common cases. The application takes great care to make sure good healthcare practices are in place. You will use artificial intelligence and Cognitive Services to automate the collection and generation of this guidance. 

You are asked to build a feature that detects the primary language for notes provided by the health worker. Detecting language is a challenge, but Azure Cognitive Services has a Text Analytics service that makes it far easier. One of its capabilities is language detection. The model in this service is already trained and ready to use.

Your company requires all parts of the application to work on-premises. For many customers, case notes are not permitted to be sent over the internet. In addition, some of your customers have slower internet connections. Most of your customers run the application in a Kubernetes cluster that your service should run in as well. You are responsible for deploying and consuming from the Text Analytics container.

## Learning objectives

In this module, you will:

- Understand how to use Cognitive Services containers.
- Create a Cognitive Services container image, including your environment configurations.
- Deploy a custom container to your Azure Kubernetes Service.
- Secure the container within your Kubernetes deployment.
- Consume from the container with a sample application.

## Pre-requisites

- An Azure subscription. If you don’t have an Azure subscription, create a free account.
- Azure CLI
- Docker engine
- Azure Resource Group
- Text Analytics Service
- Azure Container Registry
- Azure Kubernetes Service
