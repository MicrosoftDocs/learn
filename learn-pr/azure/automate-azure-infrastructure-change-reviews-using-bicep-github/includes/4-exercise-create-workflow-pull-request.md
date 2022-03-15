After speaking to your team you have decided to build in better confidence in what code makes it to the main branch of your repository by requiring pull request validation. In this exercise you will add a workflow that triggers when a pull request is opened and that runs validation steps.

During the process, you'll:

**Note to John: I did a small rewording on the topic titles for the exercise. Flow is the same, though, just some lesser lengthy titles.**

> [!div class="checklist"]
> * Create a workflow for PR create/update, and add Bicep linting to it
> * Create a pull request, and watch the workflow run
> * Fix the errors of the pull request validation
> * Watch the PR check succeed. Close the PR.

## Create a workflow for PR create/update, and add Bicep linting to it

As a first step you will create the workflow that will trigger when a pull request is created or updated.

1. In your Visual Studio Code editor, create a new file **.github/workflows/pr-validation.yml**.

1. You want this workflow to trigger when a pull request is created or updated. At the top of the file add the trigger for this:

```yaml
name: pr-validation

on: 
  pull_request
```

1. When a pull request is opened or edited you want to run a linting step for your Bicep files. There is already a reusable workflow in the repository that you can call from your current workflow. Add the following lines to do so:

```yaml
jobs:
  lint: 
     uses: <your organisation>/biceplearnGHPRs/.github/workflows/lint.yml@main
```

1. In the Visual Studio Code terminal, commit your changes and push them to the repository.

```bash
   git add .
   git commit -m "PR workflow"
   git push
```

> [!NOTE]
> You will notice that you can push this change directly to the main branch. On the starter repository you are working from, you did not define any branch protection on the main branch. In a real life project you will want to add branch protection to the main branch so contributors cannot skip the pull request validation. How to do so is explained in another learn module. We link to more info in the summary.

## Create a pull request, and watch the workflow run

Now that the pull request validation workflow is in place, you will try out this workflow. There is already a branch available with changes that you can create a pull request from.

1. In your browser, navigate to the _change1_ branch.

1. There will be a message stating that this branch is 1 change ahead of the main branch. Select _Contribute_ and next _Open pull request_.

1. Leave all defaults and select _Create pull request_.

1. This will show you the detail page of your pull request. You will notice that an automatic check has been triggered, this is your pull request validation workflow. After a while this test will fail, because there is an error in the Bicep file.

## Fix the errors of the pull request validation

1. Select _details_ to inspect the details of why your pull request validation is failing. In the details you will see there is a syntax error in the Bicep file.

1. In Visual Studio Code, open the _deploy/main.bicep_ file and fix the error on line 13.

1. In the Visual Studio Code terminal, commit your changes and push them to the repository.

```bash
   git add .
   git commit -m "error fix"
   git push
```

## Watch the PR check succeed and close the PR

Now that you have fixed the error, you will watch the pull request validation kick of again.

1. In your browser, navigate to _Pull requests_ and select your pull request from the list.

1. You will notice that the pull request validation will start running again. This time it will succeed.

1. Select _Merge pull request_ to close the pull request and merge the changes in your main branch.

1. Select _Confirm merge_.

1. Select _Delete branch_ to delete the _Changes1_ branch.