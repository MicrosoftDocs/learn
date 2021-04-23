Before developing modern applications with Azure, there are some tools you should install and configure on your development machine.

In the bus-catching scenario, you'll use several of these tools to build out the microservices architecture.

## Tools for success

Here, you'll learn how to download the latest recommended tools and extensions. You'll also set up the code sample on your local machine, and you'll select a language for the rest of the learning path (Python, Node.js, or .NET Core).

### Visual Studio Code

Throughout the learning path, you'll use Visual Studio Code as your main IDE. If you have another IDE of choice, you are free to use it for the exercises, but note that the instructions will be catered to capabilities and options in Visual Studio Code.

1. Visual Studio Code is available on all operating systems. Navigate to the [Visual Studio Code Download](https://code.visualstudio.com/Download) page and download/install the application applicable to your operating system.

1. Download and install the [Azure Functions Core Tools](https://docs.microsoft.com/azure/azure-functions/functions-run-local?tabs=windows%2Ccsharp%2Cbash#install-the-azure-functions-core-tools).

1. Open the **Extensions** blade from the left-hand taskbar. We recommend installing the following extensions:

    1. Azure Account
    1. Azure Functions
    1. GitHub
    1. Azure Resources
    1. SQL Server (mssql)
    1. Live Server

1. Sign in to GitHub in Visual Studio Code using your GitHub account. If you do not have a GitHub account, [create one here](https://github.com/join).

1. You'll need to fork and clone the GitHub repository so you can access it in Visual Studio Code. To do this step, sign in to GitHub with your GitHub account and navigate to [this repository](https://github.com/Azure-Samples/serverless-full-stack-apps-azure-sql). In the top-right corner of your browser, select the **Fork** button.

1. Select **Code** and copy the HTTPS Clone URL, for example, *`https://github.com/<github-username>/serverless-full-stack-apps-azure-sql.git`*.

1. Back in Visual Studio Code, select the **Source Control** blade from the left-hand taskbar.

1. Select **...** in the Source Control blade.

1. Select **Clone** from the drop-down menu and enter the URL copied in a previous step. Select the location you would like the repository to be copied locally.

1. In Visual Studio Code, select **File** > **Open folder** and navigate to the location where you cloned the repository. This step will open the folder in your Visual Studio Code session.

1. Select the **Explorer** blade from the left-hand taskbar. Confirm that you see the repository files.

### Azure Data Studio

Azure Data Studio is a source-open application for managing various data services (SQL Server, Azure SQL, PostgreSQL, etc.) on any platform (Windows, Mac, Linux). In this module and learning path, you'll use Azure Data Studio to manage Azure SQL Database and access notebook capabilities.

1. Navigate to the [Azure Data Studio Download](https://docs.microsoft.com/sql/azure-data-studio/download-azure-data-studio) page and download/install the application applicable to your operating system.

1. Azure Data Studio is similar to Visual Studio Code in its layout. Select **File** > **Open folder**  and navigate to the location where you cloned the repository. This step will open the folder in Azure Data Studio.

1. Select the **Explorer** blade from the left-hand taskbar. Confirm that you see the repository files.
