This module requires an Azure account with an active subscription to complete.
If you don't have one, you can follow [this link to create a free subscription](https://azure.microsoft.com/free/).

or providing an end to end data technology stack we'll be creating many resources and integrating them together as to provide a steady and robust flow of high quality data. In this exercise you'll deploy some foundational services that you'll use in the future exercises. This exercise includes setting up your ADLS Gen2 instance and your Microsoft Purview instance.

## Configure your environment with Visual Studio Code

In order to complete the exercises, you'll need to configure your environment. If you already have these components installed and configured, you don't need to repeat the steps:

1. [Download](https://code.visualstudio.com/Download) and install Visual Studio Code.

1. [Download and install](/azure/azure-functions/functions-run-local#install-the-azure-functions-core-tools) the Azure Functions Core Tools.

1. In Visual Studio Code, install the following extensions:

    - Azure Account: This extension allows you to authenticate to Azure.
    - Azure Functions: This extension allows you to manage Azure Functions.
    - GitHub Pull Requests and Issues: This extension allows you to authenticate to GitHub and manage repositories.
    - Azure Resources: This extension allows you to manage Azure resources.

1. Sign in to GitHub with your GitHub account and navigate to this repository. In the top-right corner of your browser, select the Fork button.

1. On the same page, select Code and copy the HTTPS Clone URL, for example, `https://github.com/<github-username>/serverless-full-stack-apps-azure-sql.git`.

1. Back in Visual Studio Code, select Source Control > ... > Clone and enter the URL copied in a previous step. Select the location you would like the repository to be copied locally.

1. In Visual Studio Code, select File > Open folder and navigate to the location where you cloned the repository. This step will open the folder in your Visual Studio Code session.

1. Select the Explorer blade from the left-hand taskbar. Confirm that you see the repository files.

## Deploy Azure components with PowerShell

It's possible to do this all through the user interface of the Azure portal since all of the required resources can be installed directly from the Azure Marketplace.

???