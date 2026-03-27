AI applications depend on both nonsensitive configuration such as model endpoints and batch sizes, and sensitive credentials such as API keys. Azure App Configuration provides a centralized store for managing these settings with label-based environment overrides, Key Vault references for secrets, and sentinel-based dynamic refresh so applications can pick up configuration changes without restarting.

In this exercise, you deploy an Azure App Configuration store and Key Vault preloaded with sample settings and build a Python Flask web application that demonstrates core configuration management patterns using the Azure SDK. You load settings with label stacking and automatic Key Vault reference resolution, list all setting properties and metadata, and trigger a sentinel-based refresh to pick up changes dynamically.

Tasks performed in this exercise:

- Download the project starter files
- Create an Azure App Configuration store and Key Vault with sample settings
- Add code to the starter files to complete the app
- Run the app to perform configuration operations

This exercise takes approximately **30** minutes to complete.

## Before you start

To complete the exercise, you need:

- An Azure subscription. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- [Python 3.12](https://www.python.org/downloads/) or greater.
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli).

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2352904" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>

