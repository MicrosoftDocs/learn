You've decided to add your pre-production environment to your pipeline. In this unit, you'll update your pipeline to use templates so that you can reuse the stages across the environments.

During the process, you'll: 

> [!div class="checklist"]
> * Add a pipeline template for the lint stage.
> * Add a pipeline template that defines the stages required to deploy to any environment.
> * Run your pipeline.

## Add a pipeline template for the lint stage

1. In Visual Studio Code, add a new file named *deploy/pipeline-templates/lint.yml*.

   :::code language="yaml" source="code/5-lint.yml" :::

## Add a pipeline template for deployment

1. Add a new file named *deploy/pipeline-templates/deploy.yml*. This represents all of the deployment activities for each environment.

   :::code language="yaml" source="code/5-deploy.yml" :::

   Notice:
   - Template parameters used for the things that differ between environments
   - Conditions on the validate and preview stages
   - Stage names include the environment name
   - In the smoke test stage job variables, appServiceAppHostName includes the new stage name

## Update the pipeline definition to use the templates

1. Update the *azure-pipelines.yml* file to use the new templates:

   :::code language="yaml" source="code/5-pipeline.yml" :::

1. Save, commit, push

## View the pipeline run

1. In your browser, navigate to **Pipelines**.

1. Select the most recent run of your pipeline.

   If the pipeline is still running, wait until it waits for the first approval. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Notice that the pipeline run now shows all the stages you defined in the YAML file. Also notice that execution will stop right before your *DeployPreProd* stage.

1. Approve the deploy to the preproduction environment by selecting the **Review** button.

1. Select the **Approve** button.

1. The pipeline will continue execution until right before the *DeployProd* stage. Once it does, select again the **Review** and the **Approve** buttons to make the pipeline continue. 

1. Once your pipeline has finished execution, select the *Environments*. 

1. Select your *WebsiteProd* environment. 

1. Notice that in the environment details screen, you get an overview of the deployments that have executed against this environment. 

1. Select the 1 deployment that is there. 

1. In the details of the deployment, select the *Changes* tab.

    Notice that the changes tab shows you the commits that happened for the execution of this pipeline. 

You now have a pipeline that deploys to 2 environments. You will have notices however that the pipeline you ended up with is quite extensive and big. In the next section we will make this more concise again, without changing the functionality. 
