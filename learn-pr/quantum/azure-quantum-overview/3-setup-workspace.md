In this unit, we will explain the process of setting up a Workspace on Azure Quantum. 

## Set up an Azure Quantum subscription

Azure Quantum is a service provided by Azure. Like other Azure services, you need to deploy an Azure Quantum resource into your Azure subscription in order to use the service. This resource is called an Azure Quantum Workspace - or Workspace for short.

## Create a workspace

Once you create a Workspace, you'll be able to select which third party providers you would like to be able to use in that Workspace. Every Workspace also comes with the Microsoft provider always enabled. 

<span style="color:red">some **Use screenshots to show the following:
** text</span>

Ensure you have the neccesary information

1. Subscription ID: The ID of the Azure Subscription you want to deploy in. This must be the ID of the subscription you provided when registering to the Private Preview or the resource will not deploy.
2. Resource Group: The resource group to deploy the Azure Quantum workspace in. If it does not exist, it will be created.
Workspace Name: The name of the Azure Quantum Workspace you would like to create.
3. The Resource Group and Workspace Name are for your organization - they can be anything you like and do not affect the operation of the Workspace.

## Install the Azure CLI

Download the quantum-workspace.sh script from the documentation and samples repository

For more details see documentation (private preview) repo: https://dev.azure.com/AzureQuantum-PreviewCustomers/PrivatePreview/_git/Documentation