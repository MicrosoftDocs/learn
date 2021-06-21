This exercise takes you through the process of implementing continuous integration and continuous deployment (CI/CD) of a sample containerized Node.js web app into an AKS cluster. You'll also test this functionality by directly modifying one of the app files in order to trigger the automatic build and deployment processes.

> [!NOTE]
> This exercise illustrates the use of Azure DevOps Starter, which considerably simplifies the implementation of CI/CD pipelines. For detailed information regarding authoring such pipelines in Azure DevOps and GitHub, refer to the references provided at the end of this module.

In this exercise, you'll:

* Prepare for the deployment of Azure resources.
* Implement a CI/CD pipeline by using Azure DevOps Starter.
* Validate the CI/CD functionality.
* Delete deployed resources.

## Prerequisites

To perform this exercise, you need:

* An Azure subscription.
* A Microsoft account or an Azure AD account with the Global Administrator role in the Azure AD tenant associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription.
* An Azure DevOps organization associated with the Microsoft account or the Azure AD account referenced in the previous prerequisite. To create an Azure DevOps organization, follow the instructions available at [Create an organization or project collection](https://docs.microsoft.com/azure/devops/organizations/accounts/create-organization?view=azure-devops).
* A GitHub account associated with the Microsoft account or the Azure AD account referenced in the previous prerequisite. To create a GitHub account, follow the instructions available at [Signing up for a new GitHub account](https://docs.github.com/en/free-pro-team@latest/github/getting-started-with-github/signing-up-for-a-new-github-account).

## Prepare for deployment of Azure resources

Before you can proceed with the deployment of Azure resources by using GitHub actions, you need to register the **Microsoft.AlertsManagement** resource provider, which the workflow references during provisioning of an AKS cluster.

1. If needed, start a web browser, go to the [Azure portal](https://portal.azure.com/) and sign in to access the Azure subscription you'll be using in this module.
1. In the Azure portal, open a Bash session of the **Cloud Shell** by selecting its icon in the toolbar next to the search text box.
1. Within the Bash session in the Azure Cloud Shell pane, run the following command to register the **Microsoft.AlertsManagement** resource provider:

    ```bash
    az provider register --namespace Microsoft.AlertsManagement
    ```

1. Run the following command to verify the registration state of the **Microsoft.AlertsManagement** resource provider:

    ```bash
    az provider show --namespace Microsoft.AlertsManagement --query registrationState
    ```

    > [!NOTE]
    > Wait until the command returns the **Registered** value before you proceed to the next task. If necessary, rerun the command.

## Implement a CI/CD pipeline by using Azure DevOps Starter

Now you're ready to proceed with the implementation of a CI/CD pipeline by using Azure DevOps Starter.

1. In the web browser displaying the Azure portal, use the **Search resources, services, and docs** text box at the beginning of the Azure portal page to search for **DevOps Starter** and, in the list of results, in the **Services** section, select **DevOps Starter**.
1. On the **DevOps Starter** blade, select **+ Create**.
1. On the **Start fresh with a new application** tab of the **DevOps Starter** blade, verify the presence of the **Setting up DevOps starter with GitHub** label. If the label states **Setting up DevOps starter with Azure DevOps**, select the **here** link, on the **DevOps starter settings** blade, select **GitHub**, and then select **Done**.
1. On the **Start fresh with a new application** page of the **DevOps Starter** blade, select the **Node.js** tile, and then select **Next: Framework >**.

    :::image type="content" source="../media/5-azure-devops-starter-node.js-app.png" alt-text="Screenshot of the Start fresh with a new application page of the DevOps Starter blade in the Azure portal." border="false":::

1. On the **Choose an application framework** page of the **DevOps Starter** blade, select the **Express.js** tile, and then select **Next: Service >**.

    :::image type="content" source="../media/5-azure-devops-starter-express.js-framework.png" alt-text="Screenshot of the Choose an application framework page of the DevOps Starter blade in the Azure portal." border="false":::

1. On the **Select an Azure service to deploy the application** page of the **DevOps Starter** blade, select the **Kubernetes Service** tile, and then select **Next: Create >**.

    :::image type="content" source="../media/5-azure-devops-starter-kubernetes-service.png" alt-text="Screenshot of the Select an Azure service to deploy the application page of the DevOps Starter blade in the Azure portal." border="false":::

1. On the **Select Repository and Subscription** page of the **DevOps Starter** blade, select the **Authorize** button.

    :::image type="content" source="../media/5-azure-devops-starter-select-repo-sub-authorize.png" alt-text="Screenshot of the Select Repository and Subscription page of the DevOps Starter blade in the Azure portal with the Authorize button." border="false":::

1. In the **Authorize Azure GitHub Actions** pop-up window, select **Authorize AzureGitHub Actions**.

    :::image type="content" source="../media/5-azure-github-actions-authorize.png" alt-text="Screenshot of the Authorize Azure GitHub Actions pop-up window." border="false":::

1. If prompted to confirm access, in the **Password** textbox, enter the password of your GitHub account, and then select **Confirm password**.
1. Back on the **Select Repository and Subscription** page of the **DevOps Starter** blade, specify the following settings:

    | Setting | Value |
    | --- | --- |
    | Organization | The name of the Azure DevOps organization you'll be using in this exercise. |
    | Repository | **cna-devops-05** |
    | Subscription | The name of the Azure subscription you'll be using in this exercise. |
    | Create new or use existing cluster | **Create new** |
    | Cluster name | **cna-devops-05-aks** |
    | Location | Select the Azure region closest to the location of your lab environment where you can create an Azure Kubernetes Service cluster. |
    | Node Virtual Machine Size | The default settings |

    :::image type="content" source="../media/5-azure-devops-starter-select-repo-sub-settings.png" alt-text="Screenshot of the Select Repository and Subscription page of the DevOps Starter blade in the Azure portal." border="false":::

1. On the **Select Repository and Subscription** page of the **DevOps Starter** blade, select **Additional settings**, on the **Additional settings** blade, review the **Kubernetes Service** and **Container Registry** sections, and THEN select **OK** without making any changes.

    :::image type="content" source="../media/5-azure-devops-starter-select-repo-sub-additional-settings.png" alt-text="Screenshot of the Additional settings blade in the Azure portal." border="false":::

1. Back on the **Select Repository and Subscription** page of the **DevOps Starter** blade, select **Review + Create**.

    > [!NOTE]
    > Wait for the provisioning of the Azure DevOps Starter resource to complete. This might take about one minute.

    > [!NOTE]
    > At the time of authoring this module, there is an issue associated with Azure CLI version 2.24.1. This requires modifying the GitHub workflow automatically generated by Azure Devops Starter.

1. Open another tab in the same web browser window, go to [GitHub](https://github.com) and sign in by using your GitHub account.
1. From the GitHub page, go to the list of the repositories and select the newly created repository **cna-devops-05**.

    :::image type="content" source="../media/5-github-repositories.png" alt-text="Screenshot of the cna-devops-05 repository entry in GitHub." border="false":::

1. On the **cna-devops-05** repository page, select the **Actions** tab.
1. On the **Actions** tab, in the list of workflow runs, select the ellipsis next to the **Adding workflow file** entry and then, in the pop-up menu, select **Cancel run**.

    :::image type="content" source="../media/5-github-cancel-run.png" alt-text="Screenshot of the Cancel run menu option of the Adding workflow file workflow run in GitHub." border="false":::

1. From the **Actions** tab of the **cna-devops-05** repository page, select the **Code** tab.
1. On the **Code** tab, select the **.github/workflows** folder and then, in the listing of the content of the **.github/workflows** folder, select the **devops-starter-workflow.yml** entry.
1. On the page displaying the content of the **devops-starter-workflow.yml** file, select the **Edit this file** icon in the form of a pencil.

    :::image type="content" source="../media/5-github-edit-workflow-file.png" alt-text="Screenshot of the the Edit this file menu option of the workflow file in GitHub." border="false":::

1. In the **Edit file** pane, scroll down to the following entry and replace `uses: azure/arm-deploy@v1` with `uses: azure/arm-deploy@main`

    ```yaml
    - name: Create AKS Cluster
      uses: azure/arm-deploy@v1
    ```

1. In the beginning of the page, select **Start commit** and in the **Commit changes** pop-up window, select **Commit changes**.

    :::image type="content" source="../media/5-github-edit-start-commit.png" alt-text="Screenshot of the Edit this file menu option of the workflow file in GitHub." border="false":::

1. Switch back to the web browser tab displaying the Azure portal and on the deployment blade, select **Go to resource**.
1. On the **cna-devops-05** blade, in the **GitHub Workflow** section, select **Authorize** and on the **GitHub Authorization** blade, select **Authorize** again.

    :::image type="content" source="../media/5-azure-devops-starter-select-github-workflow-authorize.png" alt-text="Screenshot of the Authorize button in the GitHub Workflow section of the Azure DevOps starter blade in the Azure portal." border="false":::

1. Back on the **cna-devops-05** blade, monitor the progress of the deployment, including the GitHub workflow and Azure resources.
1. Switch again to GitHub, go back to the **Actions** tab, select the **Update devops-starter-workflow.yml** run entry in the list of jobs, and then select the **Build and push image to container registry** entry to review the detailed status of the build process. Wait until the build completes and then, in the list of jobs, select the **Deploy application to AKS** entry to review the detailed status of the deployment process.

    :::image type="content" source="../media/5-github-build-job-status.png" alt-text="Screenshot of the status of the build job in GitHub." border="false":::

1. Switch back to the web browser window displaying the Azure portal and monitor the build and deployment process from the **cna-devops-05** DevOps starter blade, including the GitHub workflow and Azure resources.

    :::image type="content" source="../media/5-azure-devops-starter-deployment-progress.png" alt-text="Screenshot of the progress of the build and deployment jobs on the Azure DevOps starter blade in the Azure portal." border="false":::

    > [!NOTE]
    > Wait for the deployment to complete. This might take about five minutes.

    :::image type="content" source="../media/5-azure-devops-starter-deployment-completed.png" alt-text="Screenshot of the completed build and deployment jobs on the Azure DevOps starter blade in the Azure portal." border="false":::

    :::image type="content" source="../media/5-github-deployment-completed.png" alt-text="Screenshot of the completed build and deployment jobs in GitHub." border="false":::

## Validate the CI/CD functionality

Now that the GitHub workflow and the corresponding Azure resources are fully deployed, you'll validate the CI/CD functionality.

1. In the web browser displaying the Azure portal, navigate to the **cna-devops-05-rg** resource group and, on the **cna-devops-05-rg** blade, select the entry representing the **cna-devops-05** Kubernetes service.
1. On the **cna-devops-05** Kubernetes service blade, in the **Kubernetes resources** section, select **Services and ingresses**.
1. On the **cna-devops-05 \| Services and ingresses** blade, in the list of services, select the **sampleapp** entry.
1. On the **sampleapp \| Overview** blade, note the values of the external IP address and the port entries.

    > [!NOTE]
    > The sampleapp listens to incoming HTTP requests on TCP port 8080.

1. Open a new browser window and navigate to the URL, which consists of the **http://** prefix, followed by the value of the IP address you identified in the previous step, and ends with the **:8080** suffix.
1. Verify that the web browser displays the **Success!** page.

    :::image type="content" source="../media/5-sampleapp-original.png" alt-text="Screenshot of the sample web app in its original form." border="false":::

1. Switch to the browser tab displaying your GitHub repository and switch to the **Code** tab.
1. On the **Code** tab, in the list of folders, select **Application**, select **views**, and then select **index.pug**.
1. On the page displaying the content of the **index.pug** file, select the **Edit this file** icon in the form of a pencil.

    :::image type="content" source="../media/5-github-edit-index.png" alt-text="Screenshot of the Edit this file menu option of the index.pug file in GitHub." border="false":::

1. In the **Edit file** pane, replace `p GitHub workflow has been successfully setup` with `p GitHub repository has been successfully updated`.
1. At the end of the page, select **Commit changes**.
1. In GitHub, go back to the **Actions** tab, select the **Update index.pug** run entry in the list of jobs, and then select the **Build and push image to container registry** entry to review the detailed status of the build process. Wait until the build completes and then, in the list of jobs, select the **Deploy application to AKS** entry to review the detailed status of the deployment process.

    :::image type="content" source="../media/5-github-build-job-status.png" alt-text="Screenshot of the status of the build job in GitHub." border="false":::

1. After the deployment completes, switch to the browser window displaying the sample web app, refresh the web page, and verify that it contains the text **GitHub repository has been successfully updated**.

    :::image type="content" source="../media/5-sampleapp-updated.png" alt-text="Screenshot of the sample web app in its modified form." border="false":::

## Delete deployed resources

Your testing of CI/CD by using GitHub workflows is complete. To avoid unnecessary costs associated with the use of Azure resources, you'll now delete the resources you provisioned in this exercise.

1. In the web browser displaying the Azure portal, on the **cna-devops-05-rg** resource group blade, select the **Delete resource group** entry in the toolbar.
1. In the **TYPE THE RESOURCE GROUP NAME** text box, enter the name of the resource group, and then select **Delete**.

## Results

Congratulations! You've completed the second exercise of this module. In this exercise, you stepped through the process of implementing continuous integration and continuous deployment (CI/CD) of a sample containerized Node.js web app into an AKS cluster. You also tested this functionality by modifying directly one of the app files in order to trigger the automatic build and deployment processes. After you completed your testing, you deleted the Azure resources deployed in this exercise in order to avoid extra charges.
