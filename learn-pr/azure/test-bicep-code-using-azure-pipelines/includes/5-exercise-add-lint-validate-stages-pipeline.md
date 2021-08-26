You want to further automate your deployment and build better confidence in what you deploy by adding a validation stages to your pipeline. 

During the process you will: 

- Start from an existing Azure DevOps project.
- Update the existing pipeline to make use of a service principal and service connection for your environment.
- Update the existing pipeline with a _Validate_ stages. 
- Run your pipeline and watch validation fail. 
- Fix the error in your Bicep template.
- Watch your pipeline execution succeed. 

## Add a validation stage to your pipeline

1. Open the **azure-pipelines.yml** file. 

   :::image type="content" source="../media/4-pipeline-yml.png" alt-text="Screenshot of the Visual Studio Code user interface, with the azure-pipelines.yml file highlighted." border="false":::

1. Replace the content of the file with this: 

   :::code language="yaml" source="code/4-azure-pipeline.yml" :::

   This pipeline definition now has 3 stages, one for validating your code with `bicep build`, one for performing a pre-flight check with `az deployment group validate` and one for performing the actual deployment with `az deployment group create`. 

1. Save your file.

1. Add a new file in the deploy folder and call it `bicepconfig.json`. Copy the following into the file:    

   :::code language="json" source="code/4-bicepconfig.json" :::

   > [!NOTE]
   > The *bicepconfig.json* file also controls how Visual Studio Code shows errors and warnings in the editor. It displays red and yellow squiggly lines under misconfigured parts in your Bicep template. This gives you even quicker feedback when you're writing your Bicep code, further reducing the chance of an error.

1. Save your file.

1. Commit and push your changes to your Git repository by using the following commands: 

   ```bash
   git add .
   git commit -m "Added stages"
   git push
   ```

1. In your browser, navigate to your pipeline. 

   :::image type="content" source="../media/4-pipeline.png" alt-text="Screenshot of the Azure DevOps interface, with the Pipelines menu item and the pipeline highlighted." border="false":::

1. Notice that your pipeline run now shows the 3 stages you have in your YAML file. Your first stage will fail, since there are syntax errors in your Bicep template. Select the **Validate** stage to see its details.

   :::image type="content" source="../media/4-stage1-fail.png" alt-text="Screenshot of the Azure DevOps interface pipeline run detail screen, with the failing first stage highlighted." border="false":::

1. Inspect the failure messages. Navigate back to Visual Studio Code and fix the errors. Once fixed save the Bicep template file again, commit and push it to the repository to trigger another run. If all syntax errors were fixed, your first stage should now succeed. If your first stage still does not succeed, inspect the errors again and try and fix them again. Your second stage will fail, but don't worry, we will fix that as a next step. Your fixed Bicep template might look like this: 

   :::code language="bicep" source="code/4-main-fix1.bicep" :::

1. In your browser, navigate to the most recent run of your pipeline. It will now show the second stage failing. Select the failing **PreFlight** stage to see its details.

   :::image type="content" source="../media/4-stage2-fail.png" alt-text="Screenshot of the Azure DevOps interface pipeline run detail screen, with the failing second stage highlighted." border="false":::

1. Inspect the failure message. Navigate back to Visual Studio Code and fix the error. Once fixed save the Bicep template file again, commit and push it to the repository to trigger another run. If all pre-flight errors were fixed, your second stage should now succeed as well as the third and final stage. If your second stage still does not succeed, inspect the error again and try and fix them again. Your fixed Bicep template might look like this: 

   :::code language="bicep" source="code/4-main.bicep" :::

Notice that for fixing this error, your need to remove the dash from the name of the storage account, since this is an illegal charachter for a storage account, as well as add the resourceNameSuffix to it, to make it unique. Both errors will make the pre-flight check fail. 

You now have a pipeline that can successfully detect errors in your Bicep code early in your proces.
