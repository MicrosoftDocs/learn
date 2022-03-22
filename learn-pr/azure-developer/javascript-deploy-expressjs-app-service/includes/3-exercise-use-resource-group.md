In this exercise, you need to:

* [Install required software on your local computer]()
* [Sign into the Learn sandbox]() with a user account you use for the entire module, both in the sandbox UI and in Visual Studio Code.
    * This sandbox gives you a free subscription and resource group to complete this module from Visual Studio Code.
* [Find the free subscription and resource group in Visual Studio Code]() in the sandbox.

## Install required software

This module uses a locally installed Visual Studio Code to deploy the Express.js app to Azure App Service. To complete that task, install the following software:

* [Visual Studio Code](https://code.visualstudio.com/d)
    * Azure Resource Group extension
    * Azure App Service extension 

While you can have Node.js LTS installed, it isn't used in this module. 

## Sign into the Learn sandbox

Use the **Sign in to activate sandbox** button to sign in. 

Make sure you use the same account to sign into the sandbox that use also use later in this exercise to sign into Azure from Visual Studio Code. 

* **Subscription name**: `Concierge Subscription`

## Find the subscription in Visual Studio Code

1. Open Visual Studio Code. 
1. Use the key combination to open the Command Palette: <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>. 
1. In the Command Palette, select `Azure: Sign In to Azure Cloud` to complete the sign in process. 
1. When the listing of Azure clouds displays, select the `Azure Cloud`.
1. When the process is finished, your account displays in the bottom bar, `Azure: youremail@mail.com`.
1. Select your account in the bottom bar and filter the list of subscriptions to `Concierge Subscription`.
1. If the `Concierge Subscription` isn't in the list, you need to make sure you're in the correct Azure Tenant (authentication group). The Azure Tenant is in the `604c1504-c6a3-4080-81aa-b33091104187` tenant. 
    1. Open the Command Palette: <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>.
    1. Enter `Azure: Select Tenant`.
    1. Select **Enter custom tenent**.
    1. In the text box, enter the sandbox tenant: `604c1504-c6a3-4080-81aa-b33091104187`.
    1. Sign back into Azure for this tenant:
        1. In the Command Palette, select `Azure: Sign In to Azure Cloud` to complete the sign in process. 
        1. When the listing of Azure clouds displays, select the `Azure Cloud`.
        1. When the process is finished, your account displays in the bottom bar, `Azure: youremail@mail.com`.
1. Enable the sandbox subscription, `Concierge Subscription`. Uncheck any other subscriptions so you can focus while you are completing this module. 

## Install the Azure extensions

1. In Visual Studio Code, use the key combination to open the **Extensions Marketplace** sidebar: <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>X</kbd> : 
1. Filter the marketplace to add both of the following extensions
    * Azure Resources
    * Azure App Service

## Use the Azure resource group extension to find the sandbox resource group

1. In Visual Studio Code, use the key combination to open the **Azure** sidebar: <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. The Azure sidebar has two sections
    * Resource groups
    * App Service resources
1. Expand the *Resource groups** section, select the sandbox subscription. Expand the subscription and resource group. 
1. The resource group displays an Azure Storage resource for cloud shell. This was creating automatically when you began using the sandbox. 

## What did this exercise accomplish? 

* You created your sandbox. Check how much time you have left before the sandbox is removed by viewing the top of this Learn exercise.
* You signed into Azure from Visual Studio Code and found the sandbox subscription. 