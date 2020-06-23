## Create Azure resources

DevOps Projects creates a CI/CD pipeline in Azure DevOps. You firstly will need to create cloud services that will be used for the module.

1. Sign in to the [Microsoft Azure portal](https://portal.azure.com/).

2. Click on **Deploy to Azure** button below.

   [![The illustration shows how to create Azure resources.](https://camo.githubusercontent.com/9285dd3998997a0835869065bb15e5d500475034/687474703a2f2f617a7572656465706c6f792e6e65742f6465706c6f79627574746f6e2e706e67)](https://azuredeploy.net/)

3. On the web page, provide required information.

   1. Select **directory**
   2. Select your **subscription**
   3. Select "Create New" for **resource group**
   4. Give a name to your **resource group name** or keep it as default
   5. Provide a globally unique value for the **Resource Name Suffix** parameter

4. Review and deploy your resources to Azure

   > [!NOTE]
   > If you encounter any issues in the deployment, it is advised to delete the created Resource Group (if any) and retry with a new value for the `Resource Name Suffix` parameter.

5. Go to Azure portal to review your resources.

## Create Azure DevOps project

1. If you don't have an Azure DevOps organization, you should follow the steps to create one for free.

   1. Open [Azure Pipelines](https://azure.microsoft.com/services/devops/pipelines) and choose **Start free**.
   2. Sign in/up Microsoft
   3. Give a name to your organization and create it.

2. Create a new project in your organization. Give it a descriptive name and you can choose private or public. Then it will take you **Overview page** of your project.

3. Next step is to navigate to **Repos** then click the `Import` button underneath **Import a repository** and provide this url:

   ```
   https://github.com/MicrosoftDocs/mslearn-oxford-implement-cicd-iot-edge.git
   ```

4. Begin import process of the repository into your Azure DevOps project.

## Create a CI pipeline

This repository contains an Azure DevOps build definition which is preconfigured to build the included EdgeSolution in [azure-pipelines.yml](https://github.com/MicrosoftDocs/mslearn-oxford-implement-cicd-iot-edge/blob/master/.azure-pipelines.yml). This build definition relies on an external plugin [Replace Tokens](https://marketplace.visualstudio.com/items?itemName=qetza.replacetokens).

1. Begin by installing the **Replace Tokens** task from the Visual Studio Marketplace by visiting this [link](https://marketplace.visualstudio.com/items?itemName=qetza.replacetoken&wt.mc_id=iotedgedevops-github-pdecarlo) and clicking the "Get it free" button, then install into the organization which contains your newly created Azure DevOps project.

2. Once this task is successfully installed, return to the Azure DevOps project and select **Repos** > Files then edit the `.azure-pipelines.yml` file.

   ![This illustration shows how to edit Azure pipeline.](../media/edit-pipeline.png)

3. Commit your change and go back to **Files**.

4. Set up Build. You should see that a build has kicked off upon editing the Build Definition.

5. Go to **Pipelines**. You will see the build will fail. This is to be expected as Azure DevOps will create the build definition with a name that contains spaces which cause a conflict in the "Azure IoT Edge - Build module images" task. To fix this, select **Pipelines** > Builds then "Rename" the newly created build definition so that it does not contain spaces.

   ![The illustration shows how to fix build fail.](../media/rename-pipeline.png)

### Create build definition variables

1. Now you need to add build variables in order to run the build successfully. You'll need to obtain:

   - Azure Container Registry host name as `acr.host`
   - Azure Container Registry username as `acr.user`
   - Azure Container Registry password as `acr.password`.

2. Go to Azure portal and navigate to resource group you created for this module.

3. Select Container Registry resource and go to **Access keys** under **Settings**.

4. Copy the name of Login server, username and password.

   ![The illustration shows the access keys of Container Registry](../media/access-keys.png)

5. Also you need to obtain the Application Insights instrumentation key which will be represented by `appinsights.instrumentationkey`.

6. Go to Azure portal and navigate to resource group you created for this module.

7. Select the Application Insights and copy the `Instrumentation key` in the Overview page.

   ![The illustration shows the instrumentation key of Application Insight.](../media/instrumentation-key.png)

8. Go back to Azure DevOps project and navigate to **Pipelines**.

9. Select the pipeline you run earlier and edit pipeline. Click Variables and start adding new variables.

    ![The illustration shows adding new variables to the pipeline.](../media/add-variables.png)

10. When you add four variables above with values, save and run the pipeline.

11. You review the status of pipeline by going back **Pipelines**. The build should complete successfully as shown below.

    ![The illustration shows successful build.](../media/successful-build.png)

### Apply branch policy

1. With a successful build definition in place, we can now enforce continuous integration by applying a branch policy to the master branch. Start with selecting **Repos** > **Branches** then click the "..." on the row for the master branch and select "Branch policies".

2. Navigate to Build validation, click "Add build policy" and select the newly created Build pipeline. Keep everything as default then click the "Save" button.

   ![The illustration shows the branch policy added for the pipeline.](../media/branch-policy.png)

   While this policy is enabled, all commits to feature branches will kick off an execution of the newly created Build pipeline and it must succeed in order for a pull request of those changes to be made to the master branch.
