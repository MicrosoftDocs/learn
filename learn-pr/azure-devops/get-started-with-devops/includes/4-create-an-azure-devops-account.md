Microsoft provides free Azure DevOps accounts for individuals, small teams and open source projects. Enterprises can also sign up for Azure DevOps accounts that can scale to thousands of team members. We're going to sign up for a free Azure DevOps account to see how products can help us on our DevOps journey.

## Create an Azure DevOps account

Follow along with the team by setting up your own Azure DevOps account.

> [!NOTE]
> If you already have an Azure DevOps account, you can skip the following section and move on to **Create a project**.

1. Go to [dev.azure.com](https://dev.azure.com?azure-portal=true).
1. Click the **Start free** button.
1. Sign in using your **Microsoft account**, or if you do not have a Microsoft account, click **Create One!** and complete the steps.

    > [!NOTE]
    > You may have a Microsoft account already. Typically these might end with hotmail.com or outlook.com.
1. Review the Terms of Service, Privacy Statement, and Code of Conduct and click **Continue** if you agree to them.

> [!NOTE]
> As the person creating the Azure DevOps account, you will automatically become the account owner. Please be considerate when deciding on your account name and avoid existing legal entities.

## Create an organization

Next, set up an organization called Tailspin.

1. Click the **Create new organization button** in the right pane.
1. Click **Continue** in the Azure DevOps Terms of Service and Privacy notification window.
1. Create an organization named Tailspin next to the **`dev.azure.com/`** field.
1. Click **Continue**.

## Create a project

Finally, you'll create a project for the _Space Game_ web site.

1. Enter the name **SpaceGame-Web** for your first project.
1. Leave the visibility set to **Private** which means only accounts you add to this project will be able to access it.
1. Click the **Create project** button.

A project in Azure DevOps is generally synonymous with an application in your organization. It is good practice to avoid using product versions or dates. For example, try not to name your project something like Payroll 2.0 or Payroll 2019. A better approach would be to name your project **Payroll** and then 2.0 or 2019 are most likely just branches in your source code repository and iterations for your work items. We'll talk more about code repositories, iterations, and work items in future modules.

Congratulations! In the next module, the team will use Azure Boards to create their first backlog.