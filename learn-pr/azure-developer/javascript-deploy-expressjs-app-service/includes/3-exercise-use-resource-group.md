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
* **Resource group name**: `<rgn>Sandbox resource group ID</rgn>` 

## Find the subscription in Visual Studio Code

1. Open Visual Studio Code. 
1. Use the key combination to open the Command Palette: <kbd>Ctrl</kbd> + <kbd>Shirt</kbd> + <kbd>P</kbd>. 
1. In the Command Palette, select `Azure: Sign In to Azure Cloud` to complete the sign in process. 
1. When the listing of Azure clouds displays, select the `Azure Cloud`.
1. When the process is finished, your account displays in the bottom bar, `Azure: youremail@mail.com`.
1. Select your account in the bottom bar and filter the list of subscriptions to the subscription name you found in the previous section.
1. Enable the sandbox subscription. Uncheck any other subscriptions so you can focus while you are completing this module. 

## Install the Azure extensions

1. In Visual Studio Code, use the key combination to open the **Extensions Marketplace** sidebar: <kbd>Ctrl</kbd> + <kbd>Shirt</kbd> + <kbd>X</kbd> : 
1. Filter the marketplace to add both of the following extensions
    * Azure Resources
    * Azure App Service

## Use the Azure resource group extension to find the sandbox resource group

1. In Visual Studio Code, use the key combination to open the **Azure** sidebar: <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. The Azure sidebar has two sections, one for resource groups, and one for App Service.
1. Expand the resource group section, select the sandbox subscription. The resource group displays and is currently empty.

## What did this exercise accomplish? 

* You created your sandbox. Check how much time you have left before the sandbox is removed.
* You signed into Azure from Visual Studio Code and found the sandbox subscription. 