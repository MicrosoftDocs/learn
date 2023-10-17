
**Estimated time:** 40 minutes.

**Lab files:** none.

## Scenario

Azure Key Vault provides secure storage and management of sensitive data, such as keys, passwords, and certificates. Azure Key Vault includes support for hardware security modules and a range of encryption algorithms and key lengths. Using Azure Key Vault can minimize the possibility of disclosing sensitive data through source code, a common mistake developers make. Access to Azure Key Vault requires proper authentication and authorization, supporting fine-grained permissions to its content.

In this lab, you'll see how you can integrate Azure Key Vault with an Azure Pipeline by using the following steps:

 -  Create an Azure Key vault to store an ACR password as a secret.
 -  Create an Azure Service Principal to access Azure Key Vault's secrets.
 -  Configure permissions to allow the Service Principal to read the secret.
 -  Configure the pipeline to retrieve the password from the Azure Key Vault and pass it on to subsequent tasks.

## Objectives

After completing this lab, you'll be able to:

 -  Create an Azure Active Directory (Azure AD) Service Principal.
 -  Create an Azure Key Vault.

## Requirements

 -  This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
 -  **Set up an Azure DevOps organization:** If you don't already have an Azure DevOps organization that you can use for this lab, create one by following the instructions available at [Create an organization or project collection](/azure/devops/organizations/accounts/create-organization).
 -  Identify an existing Azure subscription or create a new one.
 -  Verify that you have a Microsoft or Azure AD account with the Owner role in the Azure subscription and the Global Administrator role in the Azure AD tenant associated with the Azure subscription. For details, refer to [List Azure role assignments using the Azure portal](/azure/active-directory/roles/manage-roles-portal) and [View and assign administrator roles in Azure Active Directory](/azure/active-directory/roles/manage-roles-portal#view-my-roles).

## Exercises

During this lab, you'll complete the following exercises:

 -  Exercise 0: Configure the lab prerequisites.
 -  Exercise 1: Setup CI Pipeline to build eShopOnWeb container.
 -  Exercise 2: Remove the Azure lab resources.

[:::image type="content" source="../media/launch-exercise-25d42425.png" alt-text="Screenshot of a launch button, which will take you to the lab.":::
](https://aka.ms/az-400-integrate-azure-key-vault-with-azure-devops)
