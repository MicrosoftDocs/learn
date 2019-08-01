1. FETCH BRANCH
1. SERVICE CONNECTION
1. PIPELINE VARIABLES
1. CONFIG YML
    1. It's like the one you already know
1. GIT PUSH
1. WATCH IT BUILD

The team has a plan and is ready to begin implementing their release management workflow.

At this point, the team's pipeline has two stages. The first stage produces the build artifact and the second stage deploys the _Space Game_ web application to Azure App Service. Here, you follow along with Andy and Mara as they modify the pipeline to deploy to the App Service environment that corresponds to the dev stage.

TODO: Note how you might assign triggers that specify which branches to promote to which environments. 

* Create web app on Azure using AppService (CLI)
* Modify stage in build pipeline that deploys to Dev environment (the Dev deployment slot)
* `git add; git commit; git push` and watch it run. Verify app is running.

## Fetch the branch from GitHub

Here, you fetch the `release-workflow` branch from GitHub and checkout, or switch to, that branch.

This branch contains the _Space Game_ project you worked with in the previous modules and an Azure Pipelines configuration to start with.

1. From Visual Studio Code, open the integrated terminal.
1. Run the following `git` commands to fetch a branch named `release-workflow` from Microsoft's repository and switch to that branch.

    ```bash
    git fetch upstream release-workflow
    git checkout release-workflow
    ```

    The format of this command enables you to get starter code from Microsoft's GitHub repository, known as `upstream`. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

TALK ABOUT AUTOMATION LATER
TALK ABOUT HOW THESE ARE ALL PUBLIC, BUT CAN BE PRIVATE


### CREATE SERVICE CONNECTION

* Select **Service Principal Authentication**.

  * **Connection name**: Sandbox
  * **Scope level**: Subscription
  * **Subscription**: Concierge Subscription
  * **Resource Group**: <rgn>[Resource Group Name]</rgn>

TODO: SET VARIABLE FOR WEB APP NAME (and update reference code!)

FORGET THE FOLLOWING. IT'S SCRATCH WORK WE LIKELY DON'T NEED

```bash
az account list --query "[?name=='Concierge Subscription'][].{SubscriptionName:name, SubscriptionID:id, TenantID:tenantId}" --output table
```

```
az account list --query "[?name=='Microsoft Azure Internal Consumption'][].{SubscriptionName:name, SubscriptionID:id, TenantID:tenantId}" --output table
```

## PROMOTE TO DEV ENVIRONMENT

[!code-yml[](code/4-azure-pipelines.yml)]