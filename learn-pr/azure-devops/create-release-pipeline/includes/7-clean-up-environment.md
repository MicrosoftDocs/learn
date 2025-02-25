Congratulations! You're all done with creating pipelines and resources. In this unit, you're going to clean up your Azure resources and Azure DevOps environment.

## Clean up Azure resources

1. Navigate to [Azure portal](https://portal.azure.com?azure-portal=true).
1. Select **Resource groups** from the left panel.
1. Select your resource group (**tailspin-space-game-rg**).
1. Select **Delete resource group**.
1. Type your resource group name in the text box, and then select **Delete**.
1. Select **Delete** again to confirm deletion.

## Disable pipeline or delete project

Each module in this learning path provides a template you can run to create a clean environment. When you run multiple templates, you will create multiple projects each pointing to the same GitHub repository. This setup can trigger multiple pipelines to run every time you push a change to your GitHub repository consuming free build minutes on our hosted agents. That's why it's important to disable or delete your pipeline before you move on to the next module in this learning path.

### Option 1: Disable your pipeline

Choose this option if you want to keep your project and your build pipeline for future reference. You can re-enable your pipeline later if you need to.

1. In your Azure DevOps project, select **Pipelines** and then select your pipeline.
1. Select the ellipsis button at the far right, and then select **Settings**.

    :::image type="content" source="../../shared/media/azure-pipelines-settings-button.png" alt-text="A screenshot of Azure Pipelines showing the location of the Settings menu.":::
1. Select **Disabled**, and then select **Save**. Your pipeline will no longer process new run requests.

### Option 2: Delete your project

Choose this option if you don't need your DevOps project for future reference. This will delete your Azure DevOps project.

1. Navigate to your Azure DevOps project.
1. Select **Project settings** in the lower-left corner.
1. Under **Overview**, scroll down to the bottom of the page and then select **Delete**.

    :::image type="content" source="../../shared/media/azure-devops-delete-project.png" alt-text="A screenshot of Azure Pipelines showing the location of the Delete button.":::

1. Type your project name in the text box, and then select **Delete**.
