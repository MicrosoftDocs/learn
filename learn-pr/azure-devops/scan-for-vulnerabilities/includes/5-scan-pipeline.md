In this part, you add tasks to your Azure Pipelines configuration to run the SonarCloud scanner during the build.

Here you will:

> [!div class="checklist"]
> * Install the SonarCloud Marketplace extension.
> * Create a SonarCloud service connection.
> * Add variables to Azure Pipelines.
> * Add scan tasks to your Azure Pipelines configuration.
> * Analyze the results on SonarCloud.

## Install the Marketplace extension

The SonarCloud Marketplace extension provides the service connection type you need in the next step. The extension also provides the built-in task types that you use in your build pipeline.

1. From a new browser tab, go to [marketplace.visualstudio.com](https://marketplace.visualstudio.com?azure-portal=true).
1. On the **Azure DevOps** tab, search for "SonarCloud."
1. Select **SonarCloud** from the results.

    ![The SonarCloud Marketplace extension](../media/3-sonar-cloud-marketplace-extension.png)

1. Select it and then **Get it Free**.
1. Select your Azure DevOps organization from the drop-down box.
1. Select **Install**.

## Create a SonarCloud service connection

Your pipeline tasks require access to SonarCloud. Here you create a service connection from the Microsoft Azure DevOps portal. A _service connection_ provides secure access to an external service, such as SonarCloud or Azure.

1. From Azure DevOps, navigate to your project.
1. Select **Project settings** in the lower corner.
1. Under **Pipelines**, select **Service connections**.
1. Select **New service connection**, then select **SonarCloud**, and then select **Next**.

    SonarCloud appears here because you installed the SonarCloud extension in the previous step.
1. In the dialog box that appears, enter these fields:

    * **SonarCloud Token**: This is the login token that you worked with in the previous part.
    * **Connection name**: **SonarCloud connection 1**

    You can print your `SONAR_LOGIN` Bash variable if you need to get this value.

    ```bash
    echo $SONAR_LOGIN
    ```

1. Select **Verify and save**.

    Azure DevOps performs a test connection to verify that it can connect to Sonar Cloud. If Azure DevOps is unable to connect, you'll have the chance to sign in a second time.

## Create pipeline variables

You're almost ready to add pipeline tasks to your pipeline configuration. First, you add a few variables to your pipeline.

Recall that the SonarCloud Marketplace extension provides built-in task types that perform the scan. The first task you use, named `SonarCloudPrepare@1`, requires some information specific to your SonarCloud project, such as your project name and project key.

Although you could add these variables to your *azure-pipelines.yml* file, here you add them directly to Azure Pipelines to make your configuration more reusable.

Let's add a few variables to the pipeline.

1. From Azure DevOps, navigate to your pipeline and select **Edit**.
1. Select **Variables** at the top right.
1. Select **New variable**.
1. In the dialog box that appears, set the name to *SonarProjectKey* and the value to your project name, for example, *mara_mslearn-tailspin-spacegame-web*.

    You can print your `SONAR_PROJECT_KEY` Bash variable if you need a refresher.

    ```bash
    echo $SONAR_PROJECT_KEY
    ```

    Notice the **Keep this value secret** option. If you select that option, the value for your variable is encrypted when it's standing still. This is a good way to store secrets like tokens, but you don't need to do that here.
1. Create another variable and name it *SonarProjectName*. Then specify the same project name as its value, for example, *mara_mslearn-tailspin-spacegame-web*.
1. Create another variable, and call it *SonarOrganization*. Set the value to the organization you created when you set up your SonarCloud project. You can find this value from the `-Dsonar.organization` argument in the `sonar-scanner` command that you copied earlier.

    Your final variables resembles this:

    ![Creating task variables from Azure DevOps](../media/5-create-sonar-cloud-task-variables.png)
1. On the menu, select **Save**.

## Add tasks to the pipeline configuration

Here you add the tasks that perform the scan to *azure-pipelines.yml*.

Recall that when you scanned locally, you used the **dotnet-sonarscanner** tool. Here's the `dotnet-sonarscanner begin` command you ran to prepare the scanner to collect build and test data. (You don't need to run this command right now.)

```bash
$HOME/.dotnet/tools/dotnet-sonarscanner begin \
  /k:"$SONAR_PROJECT_KEY" \
  /d:sonar.host.url="https://sonarcloud.io" \
  /d:sonar.login="$SONAR_LOGIN" \
  /d:sonar.cs.opencover.reportsPaths="./Tailspin.SpaceGame.Web.Tests/TestResults/Coverage/coverage.opencover.xml" \
  /d:sonar.exclusions="**/wwwroot/lib/**/*" \
  /o:"$SONAR_ORGANIZATION"
```

Although you could run this same command in your build pipeline, you would need to secure access to the `/d:sonar.login` argument, which defines your access token.

An easier way is to use these built-in task types provided by the SonarCloud extension:

* `SonarCloudPrepare@1`
* `SonarCloudAnalyze@1`
* `SonarCloudPublish@1`

`SonarCloudPrepare@1` maps to the `dotnet-sonarscanner begin` command you ran earlier. This task uses the service connection name you created earlier, rather than directly using your access token. This arrangement ensures that your access token doesn't appear in the build output.

The other two commands map to the `dotnet-sonarscanner end` command, which analyzes the results and uploads the report to SonarCloud.

1. From Visual Studio Code, open *azure-pipelines.yml* and replace its contents with this code. The new parts are highlighted.

    [!code-yml[](code/5-azure-pipelines.yml?highlight=46-57,77,85-89)]

    Notice that `SonarCloudPrepare@1` appears before the project is built or any tests are run. Similarly, `SonarCloudAnalyze@1` and `SonarCloudPublish@1` appear after the project is built and all tests are run. This is the same process you used when you scanned locally from the command line.

    Also notice that `SonarCloudPrepare@1` contains information specific to your account and uses the pipeline variables you created a moment ago.

    ``` bash
    organization: '$(SonarOrganization)'
    projectKey: '$(SonarProjectKey)'
    projectName: '$(SonarProjectName)'
    ```

## Watch Azure Pipelines build the application

Here you push your changes to GitHub and see the pipeline run. Recall that you're currently on the `security-scan` branch.

1. From the integrated terminal, add *azure-pipelines.yml* to the index, commit the changes, and push the branch up to GitHub.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Analyze code using SonarCloud"
    git push origin security-scan
    ```

1. Go to Azure Pipelines project and watch the build.

## Analyze the results

Return to the SonarCloud portal, refresh the page, and then examine the results. You see the same results as when you scanned locally because the project sources haven't changed.

As you resolve issues from the report and add new features to your application, your report changes over time. Issues you resolve are removed from the report. Likewise, new issues might appear as you add features or the security community provides new recommendations.

Andy and Mara discuss their progress over lunch.

**Mara:** I'm glad we were able to help Tim prepare his report for the security consultant. It would have been so much more difficult if we didn't have an automated way to understand potential vulnerabilities.

**Andy:** I agree. Our DevOps investment is paying off. We can also bring this report to leadership. If a high-severity vulnerability appears or we find we have too much technical debt, we can use the report to justify spending time to resolve them before adding new features. Often, new features can wait when security is a high priority.

## Rethinking application config data

Now that you've seen how to detect vulnerabilities from within the pipeline, let's think about some general ways to think about one of the most common attributes of any application, it's configuration data. 

One important rule to follow is to separate concerns. One of the key reasons we would want to move the configuration away from source control is to delineate responsibilities. Let's define some roles:

* Configuration Custodian: Responsible for generating and maintaining the life cycle of configuration values, these include CRUD on keys, ensuring the security of secrets, regeneration of keys and tokens, defining configuration settings such as Log levels for each environment. This role can be owned by operation engineers and security engineering while injecting configuration files through proper DevOps processes and CI/CD implementation. Note that they do not define the actual configuration but are custodians of their management.
* Configuration Consumer: Responsible for defining the schema for the configuration that needs to be in place and then consuming the configuration values in the application or library code. Development and test teams shouldn't be concerned about what the value of keys are. Rather, their concern is what the capability of the key is. For example, a developer may need different connection string variables in the application, but does not need to know the actual value across different environments.
* Configuration Store: The underlying store that holds the configuration. This can be a simple file, but in a distributed application, it needs to be a reliable store that can work across environments. The store is responsible for persisting values that modify the behavior of the application per environment but doesn't contain sensitive information and doesn't require any encryption or hardware security modules.
* Secret Store: While you can store configuration and secrets together, it violates our separation of concern principle, so the recommendation is to use a separate store for persisting secrets. This allows a secure channel for sensitive configuration data such as connection strings, enables the operations team to have credentials, certificate, and tokens in one repository, and minimizes the security risk in case the configuration store gets compromised.
