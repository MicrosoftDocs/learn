You can automate a load test in Azure Load Testing by creating a CI/CD pipeline. In this exercise you learn how to configure GitHub Actions to deploy a sample web app and start a load test using Azure Load Testing.

In this exercise you:

* Create App Service and Load Testing resources in Azure.
* Create and configure a service principal to enable GitHub Actions workflows to perform actions in your Azure account.
* Deploy a .NET 8 application to Azure App Service using a GitHub Actions workflow.
* Update a GitHub Actions workflow to invoke a URL-based load test.

## Prerequisites

* An **Azure account** with an active subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free).
    * An Azure web portal supported [browser](/azure/azure-portal/azure-portal-supported-browsers-devices).
    * A Microsoft account or a Microsoft Entra account with the Contributor or the Owner role in the Azure subscription. For details, refer to [List Azure role assignments using the Azure portal](/azure/role-based-access-control/role-assignments-list-portal) and [View and assign administrator roles in Azure Active Directory](/azure/active-directory/roles/manage-roles-portal).
* A GitHub account. If you don't have a GitHub account that you can use for this lab, follow instructions available at [Signing up for a new GitHub account](https://github.com/join) to create one.

## Getting started

Select the **Launch Exercise** button, it opens the exercise instructions in a new browser window. When you're finished with the exercise, return here for:

> [!div class="checklist"]
> * A quick knowledge check 
> * A summary of what you've learned
> * To earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2295513" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>

