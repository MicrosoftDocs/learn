TODO intro para with scenario

During the process you'll:

> [!div class="checklist"]
> * Create variable groups for each environment you want to deploy to.
> *	Update the pipeline templates so it picks the correct variable group for each environment.
> * Add a condition to the pipeline template to skip the what-if step for the test environment.
> * Update the pipeline to send the right parameter value when calling your template.

## Add variable groups

1. Create new variable group named ToyWebsiteNonProd.

1. Set up the variables as follows:

   | Name | Value |
   |-|-|
   | EnvironmentType | Test |
   | ResourceGroupName | ToyWebsiteNonProd |
   | ReviewApiKey | mysecretnonprod |
   | ReviewApiUrl | https://sandbox.contoso.com/reviews |

1. Create another new variable group named ToyWebsiteProdX.

1. Set up the variables as follows:

   | Name | Value |
   |-|-|
   | EnvironmentType | Production |
   | ResourceGroupName | ToyWebsiteProd |
   | ReviewApiKey | mysecretprod |
   | ReviewApiUrl | https://api.contoso.com/reviews |

## Update the Bicep file

1. Open the *main.bicep* file.

1. Add params for review API:

   :::code language="bicep" source="code/7-main.bicep" range="15-20" :::

1. Add app settings for review API:

   :::code language="bicep" source="code/7-main.bicep" range="53-80" highlight="17-24" :::

1. Save

## Update the deployment pipeline template

1. Open the *deploy.yml* file.

1. Remove all but the `environmentName` parameter:

   :::code language="yaml" source="code/7-deploy.yml" range="1-3" :::

1. In the `ValidateBicepCode` job, import the variable group, use variables instead of parameters where possible, and add the API parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="7-29" highlight="6-7, 21-23" :::

   > [!TIP]
   > Make sure you add the `\` at the end of the environmentType

1. Make a similar change to the `PreviewAzureChanges` job:

   :::code language="yaml" source="code/7-deploy.yml" range="33-51" highlight="6-7, 21-23" :::

1. Make a similar change to the `Deploy` job:

   :::code language="yaml" source="code/7-deploy.yml" range="55-84" highlight="6-7, 24, 26-28" :::

1. In the `SmokeTest` job, import the variable group and adjust the way you define the `appServiceAppHostName` variable:

   :::code language="yaml" source="code/7-deploy.yml" range="86-115" highlight="6-9" :::

## Update the pipeline definition to simplify the parameter list

Your template is now ready to handle variations in environments. You will now call this template twice in your pipeline with the right parameter values.

1. In Visual Studio Code open the *azure-pipelines.yml* file.

1. Remove the extra parameters, only leaving the environmentName parameters:

   :::code language="yaml" source="code/7-pipeline.yml" highlight="18-19, 23-24" :::

1. Commit and push your changes to your Git repository by using the following commands: 

   ```bash
   git add .
   git commit -m "TODO"
   git push
   ```

## Watch output for the different environments

1. In your browser, navigate to your pipeline runs.

1. You will notice that your pipeline is now running multiple stages one after the other for each environment: ValidateTest, DeployTest, SmokeTestTest, ValidateProd, PreviewProd, DeployProd, SmokeTestProd. Notice that there is no PreviewTest stage.

1. Navigate to the Test results of your run. You will notice that there are now 4 tests run. Since the Smoke test runs 2 tests and these now run for each environment, you get 4 test results. 

1. Navigate to your **Environments**.

1. Notice that each environment has a status message with the latest build ID of your pipeline. 

1. Select the WebsiteProd environment. It will show the job that deployed to this environment and the commit that is linked to this pipeline run. 

1. In your browser navigate to the Azure portal. 

1. Navigate the the **WebsiteProd** resource group. In the resource group open the App Service Plan.

1. Notice that the production app service plan is of type S1: Standard. This is a different type from the app service plan in your test environment which is a F1: Free plan.

1. Check the config settings made it to the App Services
