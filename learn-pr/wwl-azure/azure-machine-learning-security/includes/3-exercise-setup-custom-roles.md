 A [Machine Learning Workspace](/azure/machine-learning/concept-workspace) is probably one of the most interesting resources to Data Scientists and ML Engineers.

Machine Learning Workspace is the top-level resource where you work with artifacts needed in Azure Machine Learning, such as datasets, models, and user roles.

In this exercise, we will set up an Azure Machine Learning Workspace, which will be used in following exercises and modules.

## Prerequisites

- Azure Account and a Subscription

If you don't have an Azure subscription yet, please follow the instructions in the link below:

[Create a subscription in the Azure portal.](/azure/cost-management-billing/manage/create-subscription#create-a-subscription-in-the-azure-portal)

## Sign in to Azure

Sign in to the [Azure portal.](https://portal.azure.com)

## Create a Resource Group

A Resource Group is where administrators can create logical groups of resources, like storage volumes, virtual machines and ML workspaces, so they can more easily track costs, apply access controls, and monitor activity.

Let's create a Resource Group for this exercise:

1. In the Azure portal, select **Resource Groups**:

    :::image type="content" source="../media/resource-group-1.png" alt-text="Screenshot showing the Azure portal with a red box around resource groups.":::

2. Select **New** or **Create** in the resource groups list:

    :::image type="content" source="../media/resource-group-2.png" alt-text="Screenshot showing the resource groups window with a red box around new.":::

3. Fill in the form to add a new Resource Group

   - Select your previously created subscription.
   - Use **AI-Resource** as the Resource group's name.
   - Select your preferred region.
   - Select **Review and create**, then select **Create**.

    :::image type="content" source="../media/resource-group-3.png" alt-text="Screenshot showing the form to fill in to add a new resource group.":::

## Create ML Workspace

To create an ML Workspace, follow these steps:

1. Select **Home** to go back to the home page

2. Select **Create a resource** in the Azure portal:

    :::image type="content" source="../media/3-workspace-1.png" alt-text="Screenshot showing the Azure portal with a red box around create a resource.":::

3. Select **See all**.

    :::image type="content" source="../media/3-workspace-2.png" alt-text="Screenshot showing the create a resource page with a red box around see all.":::

4. Scroll down until the **AI + Machine Learning** option is visible and select **create**.

    :::image type="content" source="../media/3-workspace-3.png" alt-text="Screenshot showing the AI and machine learning option.":::

5. Fill in the form, selecting your current subscription and the resource group we had previously created (**AI-Resource**). Use **ml-workspace** as the workspace name:

    :::image type="content" source="../media/3-workspace-4.png" alt-text="Screenshot showing the form from step 4 and how to fill it in.":::

6. Select the **Review + create** button to load a review confirmation screen:

    :::image type="content" source="../media/3-workspace-5.png" alt-text="Screenshot showing the confirmation screen from step 5.":::

7. Select **Create** to start deploying your new workspace (this may take a few minutes).

> [!IMPORTANT]
> Notice that the deployment above created other resources:  
>  
> - A [storage account](https://azure.microsoft.com/services/storage/) - used to store files used by the Workspace as well as data for experiments and model training.
>   - An [Application Insights](https://azure.microsoft.com/services/application-insights/) instance, used to monitor predictive services in the Workspace.
>   - An [Azure Key Vault instance](https://azure.microsoft.com/services/key-vault/), used to manage secrets such as authentication keys and credentials used by the Workspace.
>   - A [container registry](https://azure.microsoft.com/services/container-registry/), created as-needed to manage containers for deployed models.

## Create a Custom Role and Assign it to the Workspace

1. Select **Home** to go back to the home page

1. Open **Azure Cloud Shell**

   Select the Cloud Shell Icon:

    :::image type="content" source="../media/powershell-1.png" alt-text="Screenshot showing where to select the cloud shell icon."::: or use the direct URL in your browser:
   https://shell.azure.com.

1. Select **Bash** or **PowerShell** (we will use `bash`):

    :::image type="content" source="../media/powershell-2.png" alt-text="Screenshot showing where to select bash.":::

## Define a Custom Role:

1. Using a text editor of your choice, create a file called `data_scientist_custom_role.json`, replacing the information below:

   | Variable              | Value                |
   | --------------------- | -------------------- |
   |  subscription_id      | Your subscription ID |
   | resource_group_name   | AI-Resource          |
   | workspace_name        | ml-workspace         |
   ```json
   {
     "Name": "Data Scientist Custom",
     "IsCustom": true,
     "Description": "Can run experiment but can't create or delete compute.",
     "Actions": ["*"],
     "NotActions": [
       "Microsoft.MachineLearningServices/workspaces/*/delete",
       "Microsoft.MachineLearningServices/workspaces/write",
       "Microsoft.MachineLearningServices/workspaces/computes/*/write",
       "Microsoft.MachineLearningServices/workspaces/computes/*/delete",
       "Microsoft.Authorization/*/write"
     ],
     "AssignableScopes": [
       "/subscriptions/<subscription_id>/resourceGroups/<resource_group_name>/providers/Microsoft.MachineLearningServices/workspaces/<workspace_name>"
     ]
   }
   ```
1. Upload the role definition file:

   - Select the **upload/Download files** icon
   - Select **Upload**
   - Select the `data_scientist_custom_role.json` file you created above:

    :::image type="content" source="../media/upload.png" alt-text="Screenshot showing where to select upload.":::

1. Create a role definition using the `az role definition create` CLI command (notice that the last argument is the file we just uploaded):
   ```sh
   az role definition create --role-definition data_scientist_custom_role.json
   ```

This adds the "Data Scientist Custom" role, which is limited to running experiments in the `ml-workspace`.

To verify and list existing roles using the Azure portal, select the option **Access Control (IAM)** on your `ml-workspace` then select the **Roles** tab:

:::image type="content" source="../media/custom-role.png" alt-text="Screenshot showing roles defined to the workspace example.":::

><!-- ## Assign Custom Role to a User
>Finally, to assign this role to a user, use the CLI commands below:
>```sh
># Add machine learning extension
>az extension add --name ml
># Assigning custom role to user
>az ml workspace share -w ml-workspace -g AI-Resource --role "Data Scientist Custom" --user user@your-domain.com
>```-->

## Summary

Congratulations!

In this unit you've covered the following topics:

- Creating a Resource group
- Creating a Machine Learning Workspace
- Using the Cloud Shell to run commands and uploading files to your account
- Defining a Custom Role for Machine Learning with access to your workspace

<!-- - Assigning roles to a user -->

## More resources

To read more about Workspaces and Custom Roles visit:

- [What is an Azure Machine Learning workspace?](/azure/machine-learning/concept-workspace)
- [Manage Azure Resource Manager resource groups by using the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal#what-is-a-resource-group)
- [Manage access to an Azure Machine Learning workspace](/azure/machine-learning/how-to-assign-roles)