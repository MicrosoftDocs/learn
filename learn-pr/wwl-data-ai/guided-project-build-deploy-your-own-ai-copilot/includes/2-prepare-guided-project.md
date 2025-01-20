In this project, you update an existing Node.js solution. This project includes service classes for data storage and conversation that are currently marked with placeholders. In this unit, you prepare the tools needed to complete the project code.

## Project overview

The goal of this project is to create an application that supports AI search functionality for product data. The key tasks you need to complete are:

- Import data into vCore-based Azure Cosmos DB for MongoDB, generating embeddings for category and name fields of each product during the process.
- Create a Vector index on the generated vector column.
- Perform vector searches using prompts and display the closest matching products.
- Use GPT-3.5 to enhance vector search results, enabling your AI copilot to provide more detailed insights.
- Set up REST endpoints in the app to access vector and GPT search functions, allowing users to interact with the web app.
- Test the application container locally to prepare it for deployment on Azure Kubernetes Service (AKS).
- Deploy the application on AKS

## Setup

Before you begin the project setup, verify that you have access to the following tools and resources:

- Visual Studio Code: Ensure Visual Studio Code is installed on your machine.
- Azure Subscription: Have access to an Azure Subscription for creating and using the necessary resources.
- vCore-based Azure Cosmos DB for MongoDB: Access to create or use an existing a vCore-based Azure Cosmos DB for MongoDB account.
- Azure OpenAI Account: Access to create or use an existing Azure OpenAI account.
- Azure OpenAI Deployments: Access to create deployments for embeddings and completions in your Azure OpenAI account.

Without access to these resources, you may be unable to complete the lab.

1. Open Visual Studio Code

    Visual Studio Code is required to complete the guided project exercises. You can [install Visual Studio Code from this page](https://code.visualstudio.com/).

1. Install Node.js

    Node.js is required to run and manage JavaScript dependencies for the application you're deploying. You can [download the latest version of Node here](https://nodejs.org). Verify the installation by opening the terminal in Visual Studio Code and running the command `node -v`

1. Install the Azure CLI 

    You can [install the Azure CLI by following the instructions on this page](/cli/azure/install-azure-cli-windows?tabs=azure-cli#install-or-update). Verify the installation by opening the terminal in Visual Studio Code and running the command `az -v`

1. Install [Docker for Windows](https://docs.docker.com/desktop/install/windows-install/)

1. Install the **Docker** extension for Visual Studio Code

    You can find the extension by navigating to **View** > **Extensions** and enter "Docker" in the search bar.

1. Clone the following repository in Visual Studio Code:

    `https://github.com/MicrosoftLearning/mslearn-cosmosdb-mongodb-vcore`

    Once the repository is cloned, navigate to the project directory **06-guided-project**.

1. Right-click on the **06-guided-project** folder and select **Open in integrated Terminal**.

1. Install project dependencies

    In the terminal, run the following command inside the project directory: `npm install`

1. In Visual Studio Code, open the terminal and enter the command: 

    `az login`

1. Use the following command to run the **create-azure-resources.ps1** script and create the necessary Azure resources:

    `./create-azure-resources.ps1`
    
    When the script completes, verify that the **.env** file is populated with the resource information.

Now you're ready to begin the guided project exercises!