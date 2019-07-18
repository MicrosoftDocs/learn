Exercise  - Roberta just ignore this

In [Create a release management workflow](/learn/modules/create-a-release-management-workflow?azure-portal=true), you built a traditional deployment pipeline that deploys a web application to Azure App Service on a development slot, a test slot, and a pre-production staging slot. Here we will build on that workflow to add the *Blue Green* deployment pattern.

> [!div class="checklist"]
> * Add manual step to swap staging and production slots.
> * change a color on the site
> * run pipeline
> * manually swap - add the manual part when it works later
> * check the staging and production sites to see the swap. 

## Add a stage to swap Staging and Production slots

Here you will use the **AzureAppServiceManage@0** task to swap slots. This task can also be used to start, stop, restart, slot delete, install site extensions or enable continuous monitoring for an Azure App Service. Click [here](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/azure-app-service-manage?view=azure-devops?azure-portal=true) for more information on this task.

1. Open the **azure-pipelines.yml** file and add the highlighted stage at the bottom. 

> [!IMPORTANT]
> If you copy and paste the entire contents, go back and edit your **WebAppName**.

  [!code-yml[](code/5-azure-pipelines.yml?highlight=100,131,166-185)]

1. From the integrated terminal, add **azure-pipelines.yml** to the index, commit the change, and push the change up to GitHub.

    > [!TIP]
    > Remember to save **azure-pipelines.yml** before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add Staging to Production swap to the pipeline"
    git push origin release-cadence
    ```

1. From Azure Pipelines, trace the build through each of the steps. (Screenshot) 
1. Navigate to each of the URLs for each of the stages, you will see the web site deployed.

## Make a change to the web site

Here you'll make a visible change to the web site to see the swap more clearly.

1. In the **css** folder under the **wwwroot** directory, open the site.css file.
1. Change this thing... TODO: fine a good visible change.
1. Save the file and add it to the index, commit the change, and push the change up to GitHub.

   ```bash
    git add azure-pipelines.yml
    git commit -m "Changed colors on the home page"
    git push origin release-cadence
    ```

1. From Azure Pipelines, trace the build through each of the steps. (Screenshot)
1. Navigate to each of the URLs for each of the stages, you will see the web site deployed with the color change to Production, but the color change will be missing from Staging. This is because Staging and Production have swapped.

(Screenshot)

At this point, you could roll back the change by swapping with staging again, or you could roll forward by pushing another change through the pipeline.
