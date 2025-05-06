In this unit, you'll ensure that your Microsoft Azure DevOps organization is set up to complete the rest of this module.

To do this, you'll:

> [!div class="checklist"]
> * Set up an Azure DevOps project for this module.
> * Make sure your project is set up locally so that you can push changes to the pipeline.

## Get the Azure DevOps project

Here, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module by running a template that creates a project for you in Azure DevOps.

The modules in this learning path form a progression, where you follow the Tailspin web team through their DevOps journey. For learning purposes, each module has an associated Azure DevOps project.

### Run the template

Run a template that sets up your Azure DevOps organization.

1. [Get and run the ADOGenerator project](https://github.com/microsoft/AzDevOpsDemoGenerator/blob/main/docs/RunApplication.md) in Visual Studio or the IDE of your choice.

1. When prompted to **Enter the template number from the list of templates**, enter **28** for **Host your own build agent in Azure Pipelines**, then press **Enter**.

1. Choose your authentication method. You can [set up and use a Personal Access Token (PAT)](/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate#create-a-pat) or use device login.

    > [!NOTE]
    > If you set up a PAT, make sure to authorize the necessary [scopes](/azure/devops/integrate/get-started/authentication/oauth#scopes). For this module, you can use **Full access**, but in a real-world situation, you should ensure you grant only the necessary scopes.

1. Enter your Azure DevOps organization name, then press **Enter**.

1. If prompted, enter your Azure DevOps PAT, then press **Enter**.

1. Enter a project name such as *Space Game - web - Agent*, then press **Enter**.

1. Once your project is created, go to your Azure DevOps organization in your browser (at `https://dev.azure.com/<your-organization-name>/`) and select the project.

### Fork the repository

If you haven't already, create a fork of the **mslearn-tailspin-spacegame-web** repository.

1. On GitHub, go to the [mslearn-tailspin-spacegame-web](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web) repository.

1. Select **Fork** at the top-right of the screen.

1. Choose your GitHub account as the **Owner**, then select **Create fork**.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/host-build-agent/6-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps even if you don't complete this module.

[!include[](../../shared/includes/build-local-setup.md)]
