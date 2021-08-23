You want to further automate your deployment and build better confidence in what you deploy by adding a validation stages to your pipeline. 

During the process you will: 

- Start from an existing Azure DevOps project.
- Update the existing pipeline to make use of a service principal and service connection for your environment.
- Update the existing pipeline with a _Validate_ stages. 
- Run your pipeline and watch validation fail. 
- Fix the error in your Bicep template.
- Watch your pipeline execution succeed. 

## Create an Azure DevOps organization

In case you don't have an existing Azure DevOps organization yet that you can use, follow the below steps to create one. In case you already have an Azure DevOps organization, you can skip to the next section. 

<TODO: John, include Azure DevOps org creation>


## Start from an existing Azure DevOps project

We will use the Azure DevOps Demo generator to get you started with your pipeline. The demo generator will already create a couple of resources in Azure DevOps organization for you to get started quickly. 

1. Navigate to [the Azure DevOps Demo Generator](http://azuredevopsdemogenerator.azurewebsites.net)

:::image type="content" source="../media/4-demogenerator.png" alt-text="Screenshot of the Azure DevOps Demo Generator start site." border="false":::

1. Select the **Sign In** button and log in to this site using the same credentials you use to authenticate to your Azure DevOps organization.

:::image type="content" source="../media/4-demogenerator-sign-in.png" alt-text="Screenshot of the Azure DevOps Demo Generator start site, with the Sign In button highlighted." border="false":::

1. In the **Create New Project** window, fill out **ToyWebsite** for the **New Project Name** and select your organization from the **Select Organization** dropdown. 

:::image type="content" source="../media/4-new-project.png" alt-text="Screenshot of the Azure DevOps Demo Generator Create New Project site, with the New Project Name and Select Organization fields highlighted." border="false":::

1. Select the **Choose template** button. 

:::image type="content" source="../media/4-choose-template.png" alt-text="Screenshot of the Azure DevOps Demo Generator Create New Project site, with the Choose template button highlighted." border="false":::

1. Select the **Private** button. 

:::image type="content" source="../media/4-private.png" alt-text="Screenshot of the Azure DevOps Demo Generator Create New Project site, with the Choose template pop up screen and the Private button highlighted." border="false":::

1. Select the **Github** radiobutton and give in the following GitHub url: <TODO>. 

:::image type="content" source="../media/4-github.png" alt-text="Screenshot of the Azure DevOps Demo Generator Create New Project site, with the Choose template pop up screen on the Private tab, the GitHub radiobutton highlighted and the URL filled out and highlighted." border="false":::

1. Select the **Submit** button.

:::image type="content" source="../media/4-submit.png" alt-text="Screenshot of the Azure DevOps Demo Generator Create New Project site, with the Choose template pop up screen on the Private tab, and the Submit button highlighted." border="false":::

This will create a new project called **ToyWebsite** in your Azure DevOps organization. This project will already contain a couple of resources, which we will now explore. 

## Explore the project that was created

1. Navigate to the new **ToyWebsite** project in your Azure DevOps organization. 

:::image type="content" source="../media/4-project.png" alt-text="Screenshot of the Azure DevOps organization, with the ToyWebsite project highlighted." border="false":::

1. Select the **Repos** menu item. 

:::image type="content" source="../media/4-repos.png" alt-text="Screenshot of the Azure DevOps user interface, with the Repos menu item highlighted." border="false":::

1. Open the **deploy** folder, it has a main.bicep file already created for you. It also holds a azure-pipelines.yml file in the root directory. 

:::image type="content" source="../media/4-deploy.png" alt-text="Screenshot of the Azure DevOps Repos, with the deploy folder and the main.bicep file highlighted." border="false":::

1. Select the **Pipelines** menu item and the **All** tab. There is already a pipeline defined, with no runs. Select this pipeline.

:::image type="content" source="../media/4-pipelines.png" alt-text="Screenshot of the Azure DevOps user interface, with the Pipelines menu item and the All tab highlighted." border="false":::

1. Select **Run pipeline** to start a new run.

:::image type="content" source="../media/4-pipeline.png" alt-text="Screenshot of the Azure DevOps user interface pipeline details, with the Run Pipeline button highlighted." border="false":::

1. Select the **Run** button to start the run. 

:::image type="content" source="../media/4-run-pipeline.png" alt-text="Screenshot of the Azure DevOps user interface run pipeline flyout, with the Run button highlighted." border="false":::

1. In the pipeline run detail screen, select your **Run**.

:::image type="content" source="../media/4-run.png" alt-text="Screenshot of the Azure DevOps user interface pipeline run detail, with the pipeline run highlighted." border="false":::

1. In the run detail screen, you will see your pipeline run fail.

:::image type="content" source="../media/4-run-detail.png" alt-text="Screenshot of the Azure DevOps user interface pipeline run detail, with a failure run highlighted." border="false":::

This failure is due to the service connection that is being used. This service connection does not have the correct service principal details yet towards your specific Azure environment. We will first fix this error before moving forward.

## Create a service principal for deployment

<TODO John: Add the necessary steps for SP creation and filling out SC details>

<Note to John: maybe also make the users run the pipeline again to check that the SP was created correctly, before we start adding the validation stages.>

## Add a validation stage to your pipeline

<TODO John: Add steps to clone the repo to the users computer and open VS Code.>

1. Open the **azure-pipelines.yml** file. 

:::image type="content" source="../media/4-pipeline-yml.png" alt-text="Screenshot of the Visual Studio Code user interface, with the azure-pipelines.yml file highlighted." border="false":::

1. Replace the content of the file with this: 

:::code language="yaml" source="code/4-azure-pipeline.yml" :::

    This pipeline definition now has 3 stages, one for validating your code with `bicep build`, one for performing a pre-flight check with `az deployment group validate` and one for performing the actual deployment with `az deployment group create`. 

1. Save your file

1. Add a new file in the deploy folder and call it `bicepconfig.json`. Copy the following into the file:    

:::code language="json" source="code/4-bicepconfig.json" :::

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

:::code language="yaml" source="code/4-main-fix1.bicep" :::

1. In your browser, navigate to the most recent run of your pipeline. It will now show the second stage failing. Select the failing **PreFlight** stage to see its details.

:::image type="content" source="../media/4-stage2-fail.png" alt-text="Screenshot of the Azure DevOps interface pipeline run detail screen, with the failing second stage highlighted." border="false":::

1. Inspect the failure message. Navigate back to Visual Studio Code and fix the error. Once fixed save the Bicep template file again, commit and push it to the repository to trigger another run. If all pre-flight errors were fixed, your second stage should now succeed as well as the third and final stage. If your second stage still does not succeed, inspect the error again and try and fix them again. Your fixed Bicep template might look like this: 

:::code language="yaml" source="code/4-main.bicep" :::

Notice that for fixing this error, your need to remove the dash from the name of the storage account, since this is an illegal charachter for a storage account, as well as add the resourceNameSuffix to it, to make it unique. Both errors will make the pre-flight check fail. 

You now have a pipeline that can successfully detect errors in your Bicep code early in your proces.
