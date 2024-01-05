Before developing modern applications with Azure, there are some tools you should install and configure on your development machine.

In the bus-catching scenario, you'll use several of these tools to build out the microservices architecture.

## Configure your local machine for development with Azure

Here, you'll learn how to download the latest recommended tools and extensions. You'll also set up the code sample on your local machine, and you'll select a language for the rest of the learning path (Python, Node.js, or .NET Core). If you decide to complete other modules in the learning path, you won't need to repeat these steps.

### Execute application lifecycles with Visual Studio Code

Throughout the learning path, you'll use Visual Studio Code as your main development tool. If you have another tool of choice, you're free to use it for the exercises, but note that the instructions will be catered to capabilities and options in Visual Studio Code.

1. Visual Studio Code is available on all operating systems. Go to the [Visual Studio Code Download](https://code.visualstudio.com/Download) page and download/install the application applicable to your operating system.

1. Download and install the [Azure Functions Core Tools](/azure/azure-functions/functions-run-local?tabs=windows%2Ccsharp%2Cbash#install-the-azure-functions-core-tools). These tools allow you to run Azure Functions locally.

1. Open the **Extensions** pane from the left-hand taskbar. We recommend installing the following extensions:

    - [**Azure Account**](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account): This extension allows you to authenticate to Azure.
    - [**Azure Functions**](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions): This extension allows you to manage Azure Functions.
    - [**GitHub Pull Requests and Issues**](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github): This extension allows you to authenticate to GitHub and manage repositories.
    - [**Azure Resources**](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureresourcegroups): This extension allows you to manage Azure resources.
    - [**SQL Server (mssql)**](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql): This extension includes tools for querying SQL Server and Azure SQL resources.
    - [**Live Server**](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer): This extension enables you to run web applications locally with ease.

1. The main code sample is hosted on GitHub. Sign into GitHub in Visual Studio Code using your GitHub account so you can clone, commit, push, and pull from Visual Studio Code. If you don't have a GitHub account, [create one here](https://github.com/join).

1. You'll need to fork and clone the GitHub repository so you can access it in Visual Studio Code. To do this step, sign in to GitHub in a browser with your GitHub account and go to [this repository](https://github.com/Azure-Samples/serverless-full-stack-apps-azure-sql). In the top-right corner of your browser, select **Fork**.

1. Select **Code** and copy the HTTPS Clone URL, for example, *`https://github.com/<github-username>/serverless-full-stack-apps-azure-sql.git`*.

1. Back in Visual Studio Code, select the **Source Control** pane from the left-hand taskbar.

1. Select **...** in the Source Control pane.

1. Select **Clone** from the dropdown menu and enter the URL copied in a previous step. Select the location you would like the repository to be copied locally. This step will download the repository to your local machine.

1. In Visual Studio Code, select **File** > **Open folder** and go to the location where you cloned the repository. This step will open the folder in your Visual Studio Code session.

1. Select the **Explorer** pane from the left-hand taskbar. Confirm that you see the repository files.

### Access and build data solutions with Azure Data Studio

Azure Data Studio is an open-source application for managing various data services (SQL Server, Azure SQL, PostgreSQL, etc.) on any platform (Windows, Mac, Linux). In this module and learning path, you'll use Azure Data Studio to manage Azure SQL Database and access notebook capabilities. A notebook is a document with a file ending in `.ipynb` which mixes runnable code cells and text cells in one file.

1. Go to the [Azure Data Studio Download](/sql/azure-data-studio/download-azure-data-studio) page and download/install the application applicable to your operating system.

1. Azure Data Studio is similar to Visual Studio Code in its layout. Select **File** > **Open folder**  and go to the location where you cloned the repository. This step will open the folder in Azure Data Studio so you can easily access repository files in future exercises.

1. Select the **Explorer** pane from the left-hand taskbar. Confirm that you see the repository files.
