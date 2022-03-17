Your team is already using the pull request validation and it is giving them good feedback on their changes. You would also like to give your contributors and reviewers the ability to review the changes in an ephemeral environment. In this exercise you will add this.

During the process, you'll:

> [!div class="checklist"]
> * Update the pull request workflow to deploy an ephemeral environment
> * Create another PR for the Bicep file
> * Watch the ephemeral environment get created
> * Create a PR deletion workflow to remove the ephemeral environment
> * Approve the PR
> * Watch the ephemeral environment be deleted

## Update the pull request workflow to deploy an ephemeral environment

As a first step, you will need to update your _pr-validation_ workflow to also create an ephemeral environment.

1. In the Visual Studio Code terminal, check out the main branch of the repository.

```bash
git checkout main
```

1. In the _.github/workflows/pr-validation.yml_ file add the following job at the bottom of the file: 


```yaml
  deploy: 
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: azure/login@v1
        name: Sign in to Azure
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}    
```

    This job first checks out all the code on the GitHub runner and next signs into the Azure environment.

1. Add another step at the bottom of the file to get hold of the unique PR number: 

```yaml
      - name: create resource group name
        id: rgName
        run: |
         echo "github ref_name: ${{ github.ref }}"
         IFS='/' read -ra my_array <<< "${{ github.ref }}"
         export rgname=rg_pr_${my_array[2]}
         echo "::set-output name=rgname::$rgname"  
```

    The github.ref will be something like refs/pull/x/merge. This string is next split into an array based on the forward slashes. You need the x number value which is now at position 2 in that 0-based array. As a last step this number is used to create a name for a resource group and is outputted in a variable, so the next step can use this name.

1. As a next step in the file add the step to create the resource group: 

```yaml
      - uses: Azure/cli@v1
        name: Create resource group
        with: 
          inlineScript: az group create -n ${{steps.rgName.outputs.rgname}} -l westeurope
```

1. Now that the resource group is created, as a last step add a step to deploy the bicep file:

```yaml
      - uses: azure/arm-deploy@v1
        id: deploy
        name: Deploy Bicep file
        with:
          failOnStdErr: false
          deploymentName: ${{ github.run_number }}
          resourceGroupName: ${{ steps.rgName.outputs.rgname }}
          template: ./deploy/main.bicep
          parameters: >
            environmentType=nonprod
```

1. Save your changes and mind the indentation in the yaml file. You full file should look like this: 

```yaml
name: pr-validation

on: [pull_request, workflow_dispatch]
    
jobs:
  my-status-check: 
     uses: ./.github/workflows/lint.yml@main

  deploy: 
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: azure/login@v1
        name: Sign in to Azure
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}    
      - name: create resource group name
        id: rgName
        run: |
         echo "github ref_name: ${{ github.ref }}"
         IFS='/' read -ra my_array <<< "${{ github.ref }}"
         export rgname=rg_pr_${my_array[2]}
         echo "::set-output name=rgname::$rgname"  
      - uses: Azure/cli@v1
        name: Create resource group
        with: 
          inlineScript: az group create -n ${{steps.rgName.outputs.rgname}} -l westeurope
      - uses: azure/arm-deploy@v1
        id: deploy
        name: Deploy Bicep file
        with:
          failOnStdErr: false
          deploymentName: ${{ github.run_number }}
          resourceGroupName: ${{ steps.rgName.outputs.rgname }}
          template: ./deploy/main.bicep
          parameters: >
            environmentType=nonprod
```

1. In the Visual Studio Code terminal, commit your changes and push them to the remote repository:

```bash
   git add .
   git commit -m "create RG"
   git push
```

## Create another PR for the Bicep file

You now have the workflow in place to create an ephemeral environment when a pull request is created or updated. You will now create another pull request to trigger this workflow.

**Note to john: easiest would be if we have 2 branches in the starter repo. So a second one for this PR, since you can't create a second PR for that same branch**

1. In your browser, navigate to the _change2_ branch.

1. Select _Contribute_ and _Open pull request_ to open a new pull request.

1. Leave all the defaults and select _Create pull request_.

1. 

## Watch the ephemeral environment get created

You just created a new feature branch and pushed a change to it, let's inspect the outcome.

1. In your browser, navigate to **Actions**.

1. You should see your new workflow started running.

> [!NOTE]
> It might be that you need to give it some time for the workflow to start running. Refresh your browser window until you see the workflow started running.

1. Select the running workflow to go to its detail.

1. Select the **deploy** stage to see its detail.

1. Select the **create resource group name** step to see its detail. In the log output you will notice that a resource group named **rg_f_4** will be created.

1. In your browser, navigate to the Azure portal.

1. In the top search bar, search for the **rg_f_4** resource group and select the resource group to open it.

1. In the resource group detail you will see the resources from the Bicep file got created.

## Create a PR deletion workflow to remove the ephemeral environment

1. In the Visual Studio Code terminal, check out the main branch.

```bash
git checkout main
```

1. Create a new file **.github/workflows/delete-feature-rg.yml**.

2. In the file, indicate you want to run this workflow on pr closure:

```yaml
name: delete-feature-rg

on: 
  pull_request:
    types: [closed]
```

1. You will now add the different job and different steps of the workflow:

```yaml
jobs:
  remove: 
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: azure/login@v1
        name: Sign in to Azure
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}    
      - name: create resource group name
        id: rgName
        run: |
         echo "github head_ref: ${{ github.head_ref }}"
         IFS='/' read -ra my_array <<< "${{ github.head_ref }}"
         export rgname=rg_f_${my_array[1]}
         echo "::set-output name=rgname::$rgname"  
      - uses: Azure/cli@v1
        name: Delete resource group
        with: 
          inlineScript: az group delete -n ${{steps.rgName.outputs.rgname}} --yes
```

  This workflow looks very similar to the creation workflow you created.
  Notice that for branch deletion we use the _${{ github.head_ref}}_ context variable. On pull request closure this variable has the value of _feature/name_. We use this to delete the resource group in the last step. The _--yes_ flag in the last step will auto-approve the deletion. 

1. In the Visual Studio Code terminal, commit and push your changes.

```bash
git add .
git commit -m 'delete workflow'
git push
```

## Approve the PR

You have now created a pull request that as a next step can be merged into the main branch.

1. Select **Merge pull request**. This will merge the feature4 branch into main.

1. Select **Confirm merge**.

## Watch the ephemeral environment be deleted

Closing the pull request also triggered the _delete_feature_rg_ workflow.

1. In the browser, navigate to **Actions**.

1. You should notice the delete workflow got triggered.

1. Select the workflow and inspect the output.

1. Navigate to the Azure portal and refresh the **Resource group overview**. After a while you will see that the **rg_f_4** resource group got deleted.
