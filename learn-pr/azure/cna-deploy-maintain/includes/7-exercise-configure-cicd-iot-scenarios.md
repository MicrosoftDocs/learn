This exercise takes you through the process of implementing CI/CD of a sample IoT application to Azure IoT Edge. As in the previous exercise, you'll use Azure DevOps Starter for this purpose. However, you'll rely on Azure DevOps to provide the code repository and implement the corresponding CI/CD pipelines.

> [!NOTE]
> This exercise illustrates how to use Azure DevOps Starter (which simplifies the process for implementing CI/CD pipelines considerably). For detailed information regarding authoring pipelines in Azure DevOps and GitHub, refer to the references provided at the end of this module.

In this exercise, you'll:

* Implement an IoT Edge CI/CD pipeline by using Azure DevOps Starter.
* Validate the CI/CD functionality.
* Delete deployed resources.

## Prerequisites

To perform this exercise, you need:

* An Azure subscription.
* A Microsoft account, or an Azure AD account with the Global Administrator role in the Azure AD tenant associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription.
* An Azure DevOps organization associated with the Microsoft account or the Azure AD account referenced in the previous prerequisite. To create an Azure DevOps organization, refer to the link provided at the end of the module.
* At least one concurrent pipeline in your Azure DevOps organization.

> [!NOTE]
> This requirement results from changes to the policy governing free grants of concurrent pipelines to Azure DevOps projects. For more information, refer to [Change in Azure Pipelines Grant for Public Projects](https://devblogs.microsoft.com/devops/change-in-azure-pipelines-grant-for-public-projects/). You'll find there a link to the form that you can use to request the free grant of parallel jobs in Azure Pipelines. The response is expected within 2-3 business days.

## Implement an IoT Edge CI/CD pipeline by using Azure DevOps Starter

For the sake of simplicity, you'll implement the Azure IoT Edge CI/CD pipeline by using Azure DevOps Starter functionality.

1. If needed, start a web browser.
1. Go to the [Azure portal](https://portal.azure.com/) and sign in to access the Azure subscription you'll be using in this module.
1. In the Azure portal, use the **Search resources, services, and docs** text box at the beginning of the Azure portal page to search for **DevOps Starter**.
1. In the list of results, in the **Services** section, select **DevOps Starter**.
1. On the **DevOps Starter** blade, select **+ Create**.
1. On the **Start fresh with a new application** tab, verify the presence of the **Setting up DevOps starter with Azure DevOps** label. In case the label states **Setting up DevOps starter with GitHub**, select the **here** link. Then on the **DevOps starter settings** blade, select **Azure DevOps**, and then select **Done**.
1. On the **DevOps Starter** blade, on the **Start fresh with a new application** page, select the **Java** tile, and then select **Next: Framework >**.

    :::image type="content" source="../media/7-azure-devops-starter-java.png" alt-text="Screenshot of the Start fresh with a new application page with the Java tile selected." border="false":::

1. On the **Choose an application framework** page, select the **Simple IoT** tile, and then select **Next: Service >**.

    :::image type="content" source="../media/7-azure-devops-starter-simple-iot-framework.png" alt-text="Screenshot of the Choose an application framework page with the Simple IoT tile selected." border="false":::

1. On the **Select an Azure service to deploy the application** page, select the **IoT Edge** tile, and then select **Next: Create >**.

    :::image type="content" source="../media/7-azure-devops-starter-iot-edge-service.png" alt-text="Screenshot of the Select an Azure service to deploy the application page with the IoT Edge tile selected." border="false":::

1. On the **Almost there!** page, specify the following settings:

    | Setting | Value |
    | --- | --- |
    | Project name | **cna-devops-07** |
    | Azure DevOps Organization | The name of the Azure DevOps organization you'll be using in this exercise. |
    | Subscription | The name of the Azure subscription you'll be using in this exercise. |
    | IoT Hub name | The unique name of the Azure IoT Hub you'll be using in this exercise. |
    | Location | The name of the Azure region you'll be using in this exercise. |

    :::image type="content" source="../media/7-azure-devops-starter-almost-there.png" alt-text="Screenshot of the Almost there page." border="false":::

1. On the **Almost there** page, select **Additional settings**.
1. On the **Additional settings** blade, specify the following configuration, leaving all other settings with their default values:

    | Setting | Configuration |
    | --- | --- |
    | Container Registry name | Change the value to a globally unique name consisting of between 5 and 50 alphanumeric characters starting with a letter. |
    | Container Registry SKU | Select the **Basic** entry from the drop-down list. |
    | Container Registry Location | Select the name of the Azure region you'll be using in this exercise.|

    > [!NOTE]
    > The Container Registry name check mark indicates its global uniqueness.

1. On the **Additional settings** blade, select **OK**. and
1. Back on the **DevOps Starter** blade **Almost there** page, select **Review + Create**.

    > [!NOTE]
    > Wait for the Azure DevOps Starter resource provisioning to complete. This might take about a minute.

1. On the **Deployment** blade, select **Go to resource**.
1. Open another web browser tab, navigate to the Azure DevOps portal, and, if necessary, sign in to your Azure DevOps organization.
1. In the Azure DevOps portal, select the **Azure DevOps** logo at the beginning of the page. Then, on the page displaying the list of projects, select **cna-devops-07**.
1. In the **cna-devops-07** project pane, in the menu, select **Pipelines**. Then, in the list of recent pipeline runs, select the entry representing the continuous integration pipeline. 

    > [!NOTE]
    > The initial run will fail. This is expected.

    :::image type="content" source="../media/7-azure-devops-recent-pipeline-run.png" alt-text="Screenshot of the recent pipeline run in the Azure DevOps portal." border="false":::

1. In the continuous integration pipeline pane, select **Edit** to display the graphical pipeline editor pane.

    :::image type="content" source="../media/7-azure-devops-pipeline-edit-start.png" alt-text="Screenshot of the graphical pipeline editor pane in the Azure DevOps portal." border="false":::

    > [!NOTE]
    > At the time of authoring this module, there's an issue associated with provisioning IoT resources from Azure DevOps pipelines. This requires modifying the Azure DevOps pipeline that's automatically generated by Azure DevOps Starter.

1. In the continuous integration pipeline pane, in the **Tasks** pane, in the list of tasks, select both **Azure CLI: Get AR credentials**, and the **+** sign (**Add** sign) for the **Agent job 1** entry.

    :::image type="content" source="../media/7-azure-devops-pipeline-editor-acr-credentials.png" alt-text="Screenshot of the Azure CLI: Get AR credentials task selected in the graphical pipeline editor pane." border="false":::

1. In the **Add tasks** pane, search for the **Use Python version** task. Select it from the list of results, and then select **Add**.

    :::image type="content" source="../media/7-azure-devops-pipeline-editor-use-python-add.png" alt-text="Screenshot of the Tasks pane with the Use Python version task and Add button selected." border="false":::

    > [!NOTE]
    > This will add the **Use Python 3.x** task to the pipeline.

1. In the list of pipeline tasks, select the newly added **Use Python 3.x** task, and then set its **Display name** to **Use Python 3.6** and its **Version spec** to **3.6**.

    :::image type="content" source="../media/7-azure-devops-pipeline-editor-use-python-set.png" alt-text="Screenshot of the Use Python 3.6 task with the display name and version spec set." border="false":::

1. In the continuous integration pipeline pane, in the **Tasks** pane, select the **+** icon (**Add** icon) for the **Agent job 1** entry.
1. In the **Add tasks** pane, search for the **PowerShell** task. Select it from the list of results, and then select **Add**.

    :::image type="content" source="../media/7-azure-devops-pipeline-editor-use-powershell-add.png" alt-text="Screenshot of the PowerShell task with the Add button selected." border="false":::

    > [!NOTE]
    > This will add the PowerShell Script task to the pipeline.

1. In the list of tasks in the pipeline, select the newly added **PowerShell Script** task. Set its **Type** to **Inline** and its **Script** to **pip install -U iotedgedev**.

    :::image type="content" source="../media/7-azure-devops-pipeline-editor-powershell-set.png" alt-text="Screenshot of the PowerShell Script task with the type and script set to the previously mentioned settings." border="false":::

1. In the continuous integration pipeline pane, in the **Tasks** pane, select **Save & queue**. From the drop-down menu, select **Save**, and then in the **Save build pipeline** pane, select **Save**.
1. In the continuous integration pipeline pane, in the menu, in the **Pipelines** section, select **Releases**. Ensure that the **cna-devops-07 - CD** release pipeline is selected, and then select **Edit**.

    :::image type="content" source="../media/7-azure-devops-release-pipeline-edit-button.png" alt-text="Screenshot of the CD pipeline with the Edit button displaying." border="false":::

1. In the CD pipeline pane, on the **Pipeline** tab, from the **qa** stage, select the pre-deployment conditions applicable to this stage.

    :::image type="content" source="../media/7-azure-devops-release-pipeline-qa-pre-deployment-conditions.png" alt-text="Screenshot of the CD pipeline with the pre-deployment conditions of the qa stage." border="false":::

1. In the **Pre-deployment conditions** pane, select **Manual only**.

    :::image type="content" source="../media/7-azure-devops-release-pipeline-qa-manual-only.png" alt-text="Screenshot of the CD pipeline with the qa stage pre-deployment conditions set to Manual only." border="false":::

    > [!NOTE]
    > Selecting **Manual only** will stop automatic deployment following the **dev** stage completion. This change is applied for the sake of simplicity, to eliminate the need for applying changes during the pipeline's **qa** and **prod** stages, which would be equivalent to those you have to apply to the **dev** stage. In general, rather than using the **Manual only** option, you could rely on the results from the smoke test to determine whether  deployment can proceed to the subsequent stage.

1. In the CD pipeline pane, on the **Pipeline** tab, from the **dev** stage, select the link indicating the number of jobs and tasks in that stage.

    > [!NOTE]
    > The deployment pipeline generated by Azure DevOps Starter includes multiple components that will require updating for it to run successfully. You'll apply these updates next.

1. From the list of tasks, select the **Azure Deployment: Create Azure IoT Hub** task, and then select the **+** sign (**Add** sign) for the **Create Device and Deploy** entry.
1. In the **Add tasks** pane, in the **Search** text box, enter **Azure CLI**.
1. From the list of results, select **Azure CLI**, and then select **Add** to add the **Azure CLI**  task directly below the **Azure Deployment: Create Azure IoT Hub** task.
1. Select the newly added **Azure CLI** task.
1. In the task details pane, configure the following settings:

    | Setting | Configuration |
    | --- | --- |
    | Azure Resource Manager connection | From the drop-down list, select the entry representing the existing service connection to the Azure subscription you're using in this exercise. |
    | Script Type | From the drop-down list, select **Shell**. |
    | Script Location | **Inline script** |
    | Inline Script | Enter the script following this table. |

1. Enter the following script in the **Inline Script** field:

    ```bash
    pip install azure-cli==2.20.0
    az extension add --name azure-iot
    az config set extension.use_dynamic_install=yes_without_prompt   
    ```

1. From the list of tasks, select **Azure CLI: Create IoT Edge device**.
1. In the task details, in the **Inline Script** text box, replace the existing script with the following one:

    ```bash
    (az extension add --name azure-iot && TMP_OUTPUT="$(az iot hub device-identity connection-string show --device-id edgeDeviceDEV --hub-name $IOTHUB_NAME)" && RE="\"connectionString\":\s?\"(.*)\"" && if [[ $TMP_OUTPUT =~ $RE ]]; then CS_OUTPUT=${BASH_REMATCH[1]} && echo "Got device connection string"; fi && echo "##vso[task.setvariable variable=CS_OUTPUT]${CS_OUTPUT}" ) || (az iot hub device-identity create --hub-name $IOTHUB_NAME --device-id edgeDeviceDEV --edge-enabled --output none && echo "Created Edge device" && sleep 5 && az iot hub device-twin update --device-id edgeDeviceDEV  --hub-name $IOTHUB_NAME --set tags='{"environment":"dev"}' && echo "Set tag for device" && TMP_OUTPUT="$(az iot hub device-identity connection-string show --device-id edgeDeviceDEV --hub-name $IOTHUB_NAME )" && RE="\"connectionString\":\s?\"(.*)\"" && if [[ $TMP_OUTPUT =~ $RE ]]; then CS_OUTPUT=${BASH_REMATCH[1]} && echo "Got device connection string"; fi && echo "##vso[task.setvariable variable=CS_OUTPUT]${CS_OUTPUT}")
    ```

1. From the list of tasks, select **Azure Deployment: Create VM for dev environment**.
1. In the task details, specify the following settings:

    | Setting | Value |
    | --- | --- |
    | Template link | `https://raw.githubusercontent.com/MicrosoftDocs/mslearn-cloud-native-apps/main/m07u07/edgeDeploy.json` |
    | Override template parameters | **-deviceConnectionString $(CS_OUTPUT) -vmName "cna-devops-07-iothub-edge-simulation-dev" -adminUsername "devops" -adminPasswordOrKey "$(VM_PASSWORD)" -vmSize "Standard_DS1_v2"** |

1. From the list of tasks, select **Azure CLI: Get ACR credentials**, and then select the **+** sign (**Add** sign) for the **Create Device and Deploy** job entry.
1. In the **Add tasks** pane, search for and select **Use Python version**, and then select **Add**.
1. From the list of pipeline tasks, select the newly added **Use Python 3.x** task. Set its **Display name** to **Use Python 3.6**, and its **Version spec** to **3.6**.
1. Once again, select the **+** sign (**Add** sign) for the **Create Device and Deploy** job entry.
1. In the **Add tasks** pane, search for and select the **PowerShell** task, and then select **Add**.
1. In the list of pipeline tasks, select the newly added **PowerShell Script** task. Set its **Type** to **Inline**, and its **Script** to **pip install -U iotedgedev**.
1. Save the changes to the pipeline.

## Validate the CI/CD functionality

Now that the GitHub workflow and the corresponding Azure resources are fully deployed, you'll validate the CI/CD functionality.

1. In the CD pipeline pane, on the menu, select **Repos**, and then in the repository's folder hierarchy, select **edgeSmokeTest.sh**.
1. In the pane displaying the **edgeSmokeTest.sh** file content, select **Edit**.
1. Replace both occurrences of `azure-cli-iot-ext` with `azure-iot`. Add the `# ` string to the front of the line **91** --> `validateDevicesModulesRunning`, and then select **Commit**.
1. In the **Commit** pane, select **Commit** again.

    > [!NOTE]
    > The **validateDevicesModulesRunning:** function fails due to an issue with the underlying module. By commenting it out, you'll be able to observe the successful completion of the release pipeline to the **dev** stage. In real-world scenarios, you should troubleshoot the deployed module's status. But for this exercise, the focus is on the CI/CD functionality.

    :::image type="content" source="../media/7-azure-devops-repo-edgesmoketest-edit.png" alt-text="Screenshot of the edgeSmokeTest.sh script in the cna-devops-07 repository." border="false":::

    > [!NOTE]
    > This will automatically trigger the build pipeline.

1. From the **can-devops-07** main menu, select **Pipelines**.
1. In the **Pipelines** pane, on the **Recent** tab, select the continuous integration pipeline.
1. On the **Runs** tab, select the current run.
1. In the job run pane, select the **Agent job 1**.
1. Monitor the build pipeline progress.

    :::image type="content" source="../media/7-azure-devops-portal-build-progress.png" alt-text="Screenshot of the build pipeline in progress in the Azure DevOps portal." border="false":::

    > [!NOTE]
    > Wait for the build pipeline to complete. This could take about five minutes. Once the pipeline completes, you should see the green check marks next to all of the tasks.

    :::image type="content" source="../media/7-azure-devops-portal-build-completed.png" alt-text="Screenshot of the build pipeline completed." border="false":::

1. In the Azure DevOps portal, in the menu, in the **Pipelines** section, select **Releases**.
1. Ensure that the **cna-devops-07 - CD** release pipeline is selected, and then from the list of releases, select **Release-1**.
1. In the Release-1 pane, select the **Logs** button directly following release pipeline **dev** stage.
1. In the **Release-1 > dev** pane, monitor the logs and the release pipeline's detailed progress.

    :::image type="content" source="../media/7-azure-devops-portal-release-progress.png" alt-text="Screenshot of the release pipeline progress in the Azure DevOps portal." border="false":::

    > [!NOTE]
    > Wait for the deployment to complete, which could take about five minutes.

    :::image type="content" source="../media/7-azure-devops-portal-release-progress-completed.png" alt-text="Screenshot of the release pipeline completed." border="false":::

## Delete deployed resources

Your testing of CI/CD by using GitHub workflows is complete. To avoid unnecessary costs associated with the use of Azure resources, you'll now delete the resources you provisioned in this exercise.

1. In the web browser displaying the Azure portal, on the **cna-devops-07-rg** resource group blade, from the toolbar, select **Delete resource group**.
1. In the **TYPE THE RESOURCE GROUP NAME** text box, enter the name of the resource group, and then select **Delete**.
1. Repeat the previous two steps for any other resource groups created during this exercise.

## Results

Congratulations! You've completed the third and final exercise of this module. In this exercise, you went through the process of implementing a multi-stage CI/CD pipeline that builds and deploys an IoT application to Azure IoT Edge. As in the previous exercise, you used Azure DevOps Starter for this purpose. But this time, you used Azure DevOps to provide the code repository and implement the corresponding CI/CD pipelines. After you completed your testing, you deleted the Azure resources deployed in this exercise to avoid extra charges.
