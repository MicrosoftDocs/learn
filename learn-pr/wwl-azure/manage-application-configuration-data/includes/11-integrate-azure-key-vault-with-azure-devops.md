**Estimated time:** 40 minutes.

**Lab files:** none.

## Scenario

Azure Key Vault provides secure storage and management of sensitive data, such as keys, passwords, and certificates. Azure Key Vault includes supports for hardware security modules and a range of encryption algorithms and key lengths. Using Azure Key Vault can minimize the possibility of disclosing sensitive data through source code, which is a common mistake made by developers. Access to Azure Key Vault requires proper authentication and authorization, supporting fine-grained permissions to its content.

In this lab, you'll see how you can integrate Azure Key Vault with an Azure Pipeline by using the following steps:

 -  Create an Azure Key Vault to store a MySQL server password as a secret.
 -  Create an Azure service principal to provide access to the Azure Key Vault secrets.
 -  Configure permissions to allow the service principal to read the secret.
 -  Configure the pipeline to retrieve the Azure Key vault password and pass it on to subsequent tasks.

## Objectives

After completing this lab, you'll be able to:

 -  Create an Azure Active Directory (Azure AD) service principal.
 -  Create an Azure key vault.
 -  Tracks pull requests through the Azure Pipeline.

## Requirements

 -  This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
 -  **Set up an Azure DevOps organization:** If you don't already have an Azure DevOps organization that you can use for this lab, create one by following the instructions available at [Create an organization or project collection](/azure/devops/organizations/accounts/create-organization).
 -  Identify an existing Azure subscription or create a new one.
 -  Verify that you have a Microsoft account or an Azure AD account with the Contributor or the Owner role in the Azure subscription. For details, refer to [List Azure role assignments using the Azure portal](/azure/active-directory/roles/manage-roles-portal).

## Exercises

During this lab, you'll complete the following exercises:

 -  Exercise 0: Configure the lab prerequisites.
 -  Exercise 1: Integrate Azure Key Vault with Azure DevOps.
 -  Exercise 2: Remove the Azure lab resources.

[:::image type="content" source="../media/launch-exercise-25d42425.png" alt-text="Screenshot of a launch button, which will take you to the lab.":::
](https://microsoftlearning.github.io/AZ400-DesigningandImplementingMicrosoftDevOpsSolutions/Instructions/Labs/AZ400_M05_L13_Integrating_Azure_Key_Vault_with_Azure_DevOps.html)
