In this exercise, you learn how to create a C\# function that responds to HTTP requests. After creating and testing the code locally in Visual Studio Code, you deploy and test the function in Azure.

Tasks performed in this exercise:

* Create your local project
* Run the function locally
* Deploy and execute the function in Azure
* Clean up resources

This exercise takes approximately **15** minutes to complete.

## Before you start

To complete the exercise, you need:

* An Azure subscription. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).

* [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).

* [.NET 8](https://dotnet.microsoft.com/en-us/download/dotnet/8.0) is the target framework.

* [C# Dev Kit](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csdevkit) for Visual Studio Code.

* [Azure Functions extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) for Visual Studio Code.

* Azure Functions Core Tools version 4.x. Run the following commands in a terminal to install Azure Functions Core Tools on your system. Visit [Azure Function Core Tools on GitHub](https://github.com/Azure/azure-functions-core-tools?tab=readme-ov-file#installing) for installation instructions on other platforms.

    ```
    winget uninstall Microsoft.Azure.FunctionsCoreTools
    winget install Microsoft.Azure.FunctionsCoreTools
    ```

## Getting started

Select the **Launch Exercise** button, it opens the exercise instructions in a new browser window. When you're finished with the exercise, return here for:

> [!div class="checklist"]
> * A quick knowledge check 
> * A summary of what you've learned
> * To earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2320473" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
