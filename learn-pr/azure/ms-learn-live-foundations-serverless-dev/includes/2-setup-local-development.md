## Setup a local development environment

When we choose to develop our function project locally we’re not running an emulator: the tools made available by Microsoft include the same components that also power the Functions infrastructure on Azure.

The easiest way to leverage these tools is though Visual Studio Code, which you can run on Mac, Windows and Linux.

By installing the needed extensions and services, you can get a fully-fledged Functions development environment.

## Objective

Install and configure the tooling required to develop and execute Functions locally without cloud dependencies.

## Required Components for the Functions project

Unfortunately, there is no single-package download that would install all the required components on your system.

### Install Visual Studio Code

Download Visual Studio Code | [https://code.visualstudio.com/download](https://code.visualstudio.com/download) for your operating system and follow the installation instructions.

## Install Node.js

Functions can be written using various programming languages. We are using TypeScript in this series which requires Node.js to be installed.

Please follow the download and installation instructions for your platform at [NodeJS.org](https://nodejs.org).

## Add "Azure Functions Extension for VS Code"

Visual Studio Code's extensions offer support for local Azure functions development.

Find details about the extension at [https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) and add it to your VScode installation.

## Install Azure Functions Core Tools

Azure Functions Core Tools lets you develop and test your functions on your local computer from the command prompt or terminal.

The installation instructions are platform specific. Follow the instructions for your platform at  [https://docs.microsoft.com/azure/azure-functions/functions-run-local?tabs=macos%2Ccsharp%2Cbash](https://docs.microsoft.com/azure/azure-functions/functions-run-local?tabs=macos%2Ccsharp%2Cbash)

## Install "Cosmos DB client SDK"

Our functions will interact with a CosmosDB database. Node.js supports CosmosDB through an additional package.

In your terminal, execute the following command:

`npm install @azure/cosmos`

## Access configuration files

Our functions app will read configuration parameters from either a local configuration file our from Azure's application settings. This is supported by a Node.js package which must be installed separately.

In your terminal, execute the following command:

`npm install @types/node`

## Components required to run the client app

Our project not only contains the server-side of things. We also have a client app built with Angular. You will not make any changes to this app, but to build and run it successfully, additional components are required.

### Angular CLI

[Angular](https://angular.io/) is a framework to create single-page-applications (SPA) using TypeScript.

You can find detailed installation instruction at [angular.io/guide/setup-local](https://angular.io/guide/setup-local).

The short version of the instructions is easy: in your terminal, execute the following command:

`npm install @angular/cli`

### Angular DevKit

Install the Angular dev kit dependency by running the following command in your terminal: 

`npm install --save-dev @angular-devkit/build-angular`

## Optional: Debugger support

If you are planning to dive a bit deeper and explore Angular, debugging support in Visual Studio Code is handy. There are extension for differenr browsers.


[Edge debugger for Angular](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-edge)

[Chrome debugger for Angular](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)

## Optional: Angular language services extension

There are many extension for Visual Studio Code that make Angular development easier. We found this one particularly useful:

[Angular language services extension](https://marketplace.visualstudio.com/items?itemName=Angular.ng-template)
