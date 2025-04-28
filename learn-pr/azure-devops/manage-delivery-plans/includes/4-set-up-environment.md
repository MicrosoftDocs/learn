In this section, you make sure that your Azure DevOps organization is set up to complete the rest of this module.

To meet these objectives, you:

> [!div class="checklist"]
> * Set up an Azure DevOps project for this module.

## Get the Azure DevOps project

Set up your Azure DevOps organization to complete the rest of this module by running a template that creates a project in Azure DevOps.

The modules in this learning path are part of a progression. You follow the Tailspin web team through their DevOps journey. For learning purposes, each module has an associated Azure DevOps project.

### Run the template

Run a template that sets up your Azure DevOps organization.

1. [Get and run the ADOGenerator project](https://github.com/microsoft/AzDevOpsDemoGenerator/blob/main/docs/RunApplication.md) in Visual Studio or the IDE of your choice.

1. When prompted to **Enter the template number from the list of templates**, enter **37** for **Manage Agile software delivery plans across teams**, then press **Enter**.

1. Choose your authentication method. You can [set up and use a Personal Access Token (PAT)](s/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops#create-a-pat) or use device login.

    > [!NOTE]
    > If you set up a PAT, make sure to authorize the necessary [scopes](/azure/devops/integrate/get-started/authentication/oauth?view=azure-devops#scopes). In this case, you can use **Full access**.

1. Enter your Azure DevOps organization name, then press **Enter**.

1. If prompted, enter your Azure DevOps PAT, then press **Enter**.

1. Enter a project name such as *Space Game - web - Delivery plans*, then press **Enter**.

1. Once your project is created, go to your Azure DevOps organization in your browser (at https://dev.azure./com/<your organization name>/) and select the project.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/manage-delivery-plans/7-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Be sure to follow the cleanup steps even if you don't complete this module.
