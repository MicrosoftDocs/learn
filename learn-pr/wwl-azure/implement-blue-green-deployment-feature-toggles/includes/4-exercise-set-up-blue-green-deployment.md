In this demonstration, you'll investigate Blue-Green Deployment.

## Steps

Let's now look at how a release pipeline can be used to implement blue-green deployments.

We'll start by creating a new project with a release pipeline that can deploy the **Parts Unlimited** template again.

## An initial app deployment

1.  Navigate to Azure DevOps Demo Generator in a browser: https://azuredevopsdemogenerator.azurewebsites.net and click **Sign in**.
    
    You'll be prompted to sign in if necessary.
2.  In the **Create New Project** window, select your existing Organization, set the **Project Name** to **PU Hosted,** and click **Choose template**.
    
    :::image type="content" source="../media/11-01-choose-template-a9d229dd.png" alt-text="Choose template.":::
    
3.  Click on the **PartsUnlimited** project (not the PartsUnlimited-YAML project), click **Select Template**, and click **Create Project**. When the deployment completes, click **Navigate to the project**.
4.  In the main menu for **PU Hosted**, click **Pipelines**, then click **Builds**, then **Queue,** and finally **Run** to start a build.
    
    The build should succeed.
    
    > [!NOTE]
    > *Warnings might appear but can be ignored for this walkthrough.*
    
    :::image type="content" source="../media/11-02-build-succeeded-58a5cd6c.png" alt-text="Build succeeded with warnings.":::
    
5.  In the main menu, click **Releases**. Because a continuous integration trigger was in place, a release was attempted. However, we haven't yet configured the release so it will have failed. Click **Edit** to enter edit mode for the release.
    
    :::image type="content" source="../media/11-03-release-pipeline-edit-42a741fc.png" alt-text="Release pipeline edit.":::
    
6.  Select the Dev stage from the drop-down list beside **Tasks**, then click to select the **Azure Deployment** task.
7.  In the **Azure resource group deployment** pane, select your Azure subscription, then click **Authorize** when prompted. When authorization completes, choose a **Location** for the web app.
    
    > [!NOTE]
    > *You might be prompted to sign in to Azure at this point.*
    
    :::image type="content" source="../media/11-04-resource-group-deployment-ae04074a.png" alt-text="Resource group deployment.":::
    
8.  Click **Azure App Service Deploy** in the task list to open its settings. Again, select your Azure subscription. Set the **Deployment slot** to **Staging**.
    
    :::image type="content" source="../media/11-05-staging-app-service-deploy-fa348f16.png" alt-text="Staging app service deploy.":::
    
    
    > [!NOTE]
    > *The template creates a production site and two deployment slots: Dev and Staging. We'll use Staging for our Green site.*

9.  In the task list, click **Dev,** and in the **Agent job** pane, select **Azure Pipelines** for the **Agent pool** and **vs2017-win2016** for the **Agent Specification**.

    :::image type="content" source="../media/11-06-agent-job-configuration-bdbacecd.png" alt-text="Agent job configuration.":::


10. From the top menu, click **Pipelines**. Click the **Dev** stage, and in the properties window, rename it to **Green Site**. Click the **QA** stage and click **Delete** and **Confirm**. Click the **Production** stage and click **Delete** and **Confirm**. Click **Save,** then **OK**.

    :::image type="content" source="../media/11-07-green-site-stage-complete-299a2e9b.png" alt-text="Green site stages complete.":::


11. Hover over the **Green Site** stage and click the **Clone** icon when it appears. Change the **Stage name** to **Production**. From the **Tasks** drop-down list, select **Production**.

    :::image type="content" source="../media/11-12-production-tasks-f05fbf09.png" alt-text="Production tasks.":::


12. Click the **Azure App Service Deploy** task and uncheck the **Deploy to slot** option. Click **Save** and **OK**.

    :::image type="content" source="../media/11-13-no-deploy-to-slot-422f9644.png" alt-text="No deploy to slot.":::


    The production site isn't deployed to a deployment slot. It's deployed to the main site.

13. Click **Create release,** then **Create** to create the new release. When created, click the release link to view its status.

    :::image type="content" source="../media/11-08-release-link-9339550b.png" alt-text="Release link.":::


    After a while, the deployment should succeed.

    :::image type="content" source="../media/11-11-deployment-succeeded-0d9526a7.png" alt-text="Deployment succeeded for green site and production.":::


## Test the green site and the production site

14. Open the blade for the **ASPDOTNET** resource group created by the project deployment in the Azure portal. Notice the names of the web apps that have been deployed. Click to open the *Staging*\* web app's blade. Copy the URL from the top left-hand side.

    :::image type="content" source="../media/11-14-url-location-2bfaccfe.png" alt-text="Resource group and URL.":::


15. Open a new browser tab and navigate to the copied URL. It will take the application a short while to compile, but then the Green website (on the Staging slot) should appear.

    :::image type="content" source="../media/11-15-parts-unlimitied-site-on-staging-7dba4d8c.png" alt-text="Parts Unlimited site on staging.":::


> [!NOTE]
> *You can tell that the staging slot is being used because of the **-staging** suffix in the website URL.*

16. Open another new browser tab and navigate to the same URL but without the **-staging** slot. The production site should also be working.

    :::image type="content" source="../media/11-16-production-site-62131e12.png" alt-text="Production site.":::


> [!NOTE]
> *Leave both browser windows open for later in the walkthrough.*

## Configure blue-green swap and approval

Now that both sites are working, let's configure the release pipeline for blue-green deployment.

17. In **Azure DevOps**, in the main menu for the **PU Hosted** project, click **Pipelines**, then click **Releases**, then click **Edit** to return to edit mode.
18. Click the **Production** stage, click **Delete**, then **Confirm** to remove it. Click **+Add** to add an extra stage and click **Empty job** for the template. Set **Swap Blue-Green** for the **Stage name**.

    :::image type="content" source="../media/11-17-new-swap-blue-green-stage-8bafc9ac.png" alt-text="New swap blue-green stage.":::


19. Click **Variables** and modify the **Scope** of **WebsiteName** to **Release**.

    :::image type="content" source="../media/11-28-variable-scope-a98b1cf6.png" alt-text="Variable scope.":::


20. From the **Tasks** drop-down list, click to select the **Swap Blue-Green** stage. Click the **+** to the right-hand side of **Agent Job** to add a new task. In the **Search** box, type **CLI**.

    :::image type="content" source="../media/11-18-cli-search-74d392bc.png" alt-text="CLI search.":::


21. Hover over the **Azure CLI** template and when the **Add** button appears, click it, then click to select the **Azure CLI** task to open its settings pane.

    :::image type="content" source="../media/11-19-azure-cli-settings-pane-ea2d87a9.png" alt-text="Azure CLI settings pane.":::


22. Configure the pane as follows, with your subscription, a **Script Location** of **Inline script**, and the **Inline Script**:

    `Az webapp deployment slot swap -g $(ResourceGroupName) -n $(WebsiteName) --slot Staging --target-slot production`

    :::image type="content" source="../media/11-20-azure-cli-configured-6a2f9609.png" alt-text="Azure CLI configured.":::


23. From the menu above the task list, click **Pipeline**. Click the **Pre-deployment conditions** icon for the **Swap Blue-Green** stage, then in the **Triggers** pane, enable **Pre-deployment approvals**.
24. Configure yourself as an approver, click **Save**, then **OK**.

    :::image type="content" source="../media/11-21-approver-enabled-772691d7.png" alt-text="Approver enabled.":::


## Test the blue-green swap

25. In the **PU Hosted** main menu, click **Repos,** then click **Files** to open the project files. Navigate to the following file.

    :::image type="content" source="../media/11-22-index-view-code-30ec90bd.png" alt-text="Index view code.":::


    We'll make a cosmetic change to see that the website has been updated. We'll change the word **tires** in the main page rotation to **tyres** to target an international audience.

26. Click **Edit** to allow editing, then find the word **tires** and replace it with the word **tyres**. Click **Commit** and **Commit** to save the changes and trigger a build and release.

:::image type="content" source="../media/11-23-update-tyres-25d68ce5.png" alt-text="Update tyres.":::


27. From the main menu, click **Pipelines**, then **Builds**. Wait for the continuous integration build to complete successfully.

    :::image type="content" source="../media/11-24-build-succeeded-2126f9b1.png" alt-text="Build succeeded.":::


28. From the main menu, click **Releases**. Click to open the latest release (at the top of the list).

    :::image type="content" source="../media/11-25-approval-required-5abad44d.png" alt-text="Approval required.":::


    You're now being asked to approve the deployment swap across to Production. We'll check the green deployment first.

29. Refresh the Green site (that is, Staging slot) browser tab and see if your change has appeared. It now shows the altered word.

    :::image type="content" source="../media/11-26-green-site-updated-28dd8757.png" alt-text="Green site updated.":::


30. Refresh the Production site browser tab and notice that it still isn't updated.

    :::image type="content" source="../media/11-27-production-site-unchanged-fd38ab3f.png" alt-text="Production site unchanged.":::


31. As you're happy with the change, in release details, click **Approve**, then **Approve** and wait for the stage to complete.

    :::image type="content" source="../media/11-29-swap-completed-2ae02c71.png" alt-text="Swap completed.":::


32. Refresh the Production site browser tab and check that it now has the updated code.

    :::image type="content" source="../media/11-26-green-site-updated-28dd8757.png" alt-text="Production site updated.":::


## Final notes

If you check the green site, you'll see it has the previous version of the code.

It's the critical difference with Swap, rather than just a typical deployment process from one staged site to another. You have a rapid fallback option by swapping the sites back if needed.
