## Scenario

Imagine you've been asked to prototype a solution that can model how Chocolate manufacturing components impact the production of Chocolate. These components often have a child-parent relationship and the status of the parent component relies on the values stored in child components or other systems. You need to be able to ceate and store the model, instantiate instances of the model for each component, and store / update important component values from a variety of external systems.

Azure Digital Twins provides a service that abstracts the complexity needed to deliver the solution above. Azure Digital Twins can be used to store models created using the Digital Twins Definition Language (DTDL). Models of components can be instantiated and their properties updated using APIs or the ADT SDK.

## Learning objectives
In this module you will:
  - Create an Azure Digital Twins (ADT) instance
  - Create and instantiate Azure Digital Twin (ADT) models 
  - Create an Azure Function that publishes data into Digital Twins
  - Create an IoT Hub that sends telemetry to an Azure Function
  - Use REST APIs to publish data to Azure Digital Twins
  - Create a Logic App that publishes data to Azure Digital Twins

## Prerequisites
  - Basic understanding of Azure Digital Twins
  - Beginner-level experience with: IoT Hub, Azure Functions, and Logic Apps
  - Azure Subcription
  - Admin Access to Azure AD Tenant & Azure Subscription
  - Mac OS: [PowerShell for Mac](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-6 )
- Windows OS: PowerShell is built-in
  - [Azure Command Line Interface (CLI)](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
  - [.NET Core 3.1](https://dotnet.microsoft.com/download)
  - [Visual Studio Code](https://code.visualstudio.com)
  - [C# VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)
  - [Azure Function VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)
  - [Node.js](https://nodejs.org/en/download/)
  - [Git](https://git-scm.com/downloads)