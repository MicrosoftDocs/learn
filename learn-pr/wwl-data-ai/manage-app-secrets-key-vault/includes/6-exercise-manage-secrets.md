AI applications typically depend on sensitive credentials such as API keys, connection strings, and certificates to access model endpoints and data stores. Azure Key Vault provides a centralized, secure store for these secrets with RBAC access control, automatic versioning, and audit logging so applications never need to embed credentials in code or configuration files.

In this exercise, you deploy an Azure Key Vault preloaded with sample secrets and build a Python Flask web application that demonstrates core secret management patterns using the Azure SDK. You retrieve secrets and inspect their metadata, list all secret properties without exposing values, create a new secret version to simulate credential rotation, and implement a time-based cache to reduce Key Vault API calls.

Tasks performed in this exercise:

- Download the project starter files
- Create an Azure Key Vault and store sample secrets
- Add code to the starter files to complete the app
- Run the app to perform secret operations

This exercise takes approximately **20** minutes to complete.

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

<a href="https://go.microsoft.com/fwlink/?linkid=2352903" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
