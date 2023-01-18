Exercise - Deploy and Configure the environment. 

This module requires a sandbox to complete. A sandbox gives you access to free resources. Your personal subscription will not be charged. The sandbox may only be used to complete training on Microsoft Learn. Use for any other reason is prohibited, and may result in permanent loss of access to the sandbox.

Microsoft provides this lab experience and related content for educational purposes. All presented information is owned by Microsoft and intended solely for learning about the covered products and services in this Microsoft Learn module. 

Setting up your environment and deploying some resources to start with is an important step in building full stack applications. For providing an end to end data technology stack we will be creating many resources and integrating them together as to provide a steady and robust flow of high quality data. In this exercise you will deploy some foundational services that you'll use in the future exercises. This exercise includes setting up your ADLSv2 instance and your Microsoft Purview instance. 

Configure your environment with Visual Studio Code
In order to complete the exercises, you'll need to configure your environment. If you already have these components installed and configured, you don't need to repeat the steps.

Download and install Visual Studio Code.

Download and install the Azure Functions Core Tools.

In Visual Studio Code, install the following extensions:

Azure Account: This extension allows you to authenticate to Azure.
Azure Functions: This extension allows you to manage Azure Functions.
GitHub Pull Requests and Issues: This extension allows you to authenticate to GitHub and manage repositories.
Azure Resources: This extension allows you to manage Azure resources.

Sign in to GitHub with your GitHub account and navigate to this repository. In the top-right corner of your browser, select the Fork button.

On the same page, select Code and copy the HTTPS Clone URL, for example, https://github.com/<github-username>/serverless-full-stack-apps-azure-sql.git.

Back in Visual Studio Code, select Source Control > ... > Clone and enter the URL copied in a previous step. Select the location you would like the repository to be copied locally.

In Visual Studio Code, select File > Open folder and navigate to the location where you cloned the repository. This step will open the folder in your Visual Studio Code session.

Select the Explorer blade from the left-hand taskbar. Confirm that you see the repository files.

Deploy Azure components with Powershell

It is possible to do this all through the user interace of the Azure Portal as all of the required resources can be installed directly from the Azure Marketplace or as a first class citizen of Azure. 