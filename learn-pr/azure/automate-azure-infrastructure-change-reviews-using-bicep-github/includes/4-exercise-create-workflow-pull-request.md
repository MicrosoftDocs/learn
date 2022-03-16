After speaking to your team you have decided to build in better confidence in what code makes it to the main branch of your repository by requiring pull request validation. In this exercise you will add a workflow that triggers when a pull request is opened and that runs validation steps.

During the process, you'll:

> [!div class="checklist"]
> * Create a workflow for pull request create and update events.
> * Add Bicep linting to the workflow.
> * Create a pull request, and watch the workflow run.
> * Fix the errors identified by the pull request validation.
> * Re-run the workflow, and close the pull request.

## Create a workflow to run when pull requests are created and updated

1. In Visual Studio Code, create a new file named *pr-validation.yml* in the *.github/workflows* folder.

1. Add a pull request name and trigger:

   :::code language="yaml" source="code/4-workflow.yml" range="1-4" :::

   This code ensures that the workflow is executed when a pull request is created or updated.

## Add a lint job to your workflow

When a pull request is opened or edited you want to run a linting step for your Bicep files. There's a reusable *lint* workflow in the repository that you can call from this workflow.

1. Add the following lines to reuse the *lint* workflow defined in your repository:

   :::code language="yaml" source="code/4-workflow.yml" range="6-8" :::

   Ensure you replace *YOUR*GITHUB*USERNAME* with your own GitHub username. This enables GitHub Actions to find the correct workflow definition file. Also, if you didn't use the name *toy-website-auto-review* for your repository, ensure you replace the repository name too.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add first version of pull request workflow"
   git push
   ```

   > [!NOTE]
   > You're pushing your change directly to the main branch. You can do this because you didn't define any branch protection on the main branch. In a real project, you should add branch protection to the main branch so contributors cannot commit or merge without creating a pulll request and running the automated pull request validation checks. For more information on branch protection, see the module [Review Azure infrastructure changes by using Bicep and pull requests](xref:learn.azure.review-azure-infrastructure-changes-using-bicep-pull-requests).

## Create a pull request

Now that the pull request validation workflow is in place, let's see how pull requests use your workflow. We've pre-created a branch in your repository with some Bicep changes, which you can use to create your pull request.

1. In your browser, navigate to the *change1* branch. (TODO)

1. There will be a message stating that this branch is 1 change ahead of the main branch. Select *Contribute* and next *Open pull request*.

1. Leave all defaults and select *Create pull request*.

   The pull request detail page is displayed.

1. Look at the **Checks** section of the pull request details.

   Notice that an automatic check has been triggered, which runs your pull request validation workflow.
   
   Wait until the check completes. The check fails.

## Fix the errors of the pull request validation

1. Select *details* to inspect the details of why your pull request validation is failing. In the details you will see there is a syntax error in the Bicep file.

   Keep your browser open.

1. In Visual Studio Code, open the *deploy/main.bicep* file and fix the error on line 13.

   TODO code example

1. In the Visual Studio Code terminal, commit your changes and push them to the repository.

   ```bash
   git add .
   git commit -m "Fix syntax error in Bicep file"
   git push
   ```

## Monitor and merge the pull request

1. Reopen your browser to the pull request details page.

   Notice that the pull request validation is running again. Wait for the check to complete. This time, it succeeds. There are no syntax or linting errors in the Bicep file, so you're ready to merge the pull request.

1. Select *Merge pull request* to close the pull request and merge the changes in your main branch.

1. Select *Confirm merge*.

1. Select *Delete branch* to delete the *Changes1* branch.
