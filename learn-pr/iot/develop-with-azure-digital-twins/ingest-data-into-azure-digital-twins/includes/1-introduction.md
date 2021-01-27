Imagine you're asked to prototype a solution that can model how chocolate-manufacturing components affect the production of chocolate. These components often have a child-parent relationship, and the status of the parent component relies on the values stored in child components or other systems. You can:

- Create and store the model.
- Create instances of the model for each component.
- Store or update important component values from various external systems.

Azure Digital Twins provides a service that abstracts the complexity needed to deliver this solution. You use Azure Digital Twins to store models created by using the Digital Twins Definition Language (DTDL). Models of components can be instantiated and their properties updated by using APIs or the Azure Digital Twins SDK.

## Learning objectives

In this module you will:

- Create an Azure Digital Twins instance
- Create and instantiate Azure Digital Twin models
- Create an Azure function app that publishes data into Digital Twins
- Create an IoT Hub instance that sends telemetry to an Azure function app
- Use REST APIs to publish data to Azure Digital Twins
- Create an Azure Logic Apps instance that publishes data to Azure Digital Twins

## Prerequisites

- Basic understanding of Azure Digital Twins
- Beginner-level experience with: Azure IoT Hub, Functions, and Logic Apps
- An Azure subscription and admin access to it
- Admin access to an Azure Active Directory (Azure AD) tenant
- macOS: [PowerShell for Mac](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-6 )
- Windows OS: PowerShell (built in)
- The [Azure CLI)](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [.NET Core 3.1](https://dotnet.microsoft.com/download)
- [Visual Studio Code](https://code.visualstudio.com)
- [C# for Visual Studio Code extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)
- [Azure Functions for Visual Studio Code extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)
- [Node.js](https://nodejs.org/en/download/)
- [Git](https://git-scm.com/downloads)