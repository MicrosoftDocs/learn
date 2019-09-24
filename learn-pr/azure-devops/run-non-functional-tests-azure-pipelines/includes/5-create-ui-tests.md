In this section, you run the test plan that Mara and Tim created. The test plan executes load testing with Apache JMeter.

Here's how you'll run the tests:

> [!div class="checklist"]
> * Fetch and check out a Git branch that implements the tests.
> * Modify your pipeline to install JMeter, run the test plan, transform the results to JUnit, and publish the results to Azure Pipelines.
> * Push your branch to GitHub, watch the tests run in Azure Pipelines, and then examine the results.

## Fetch the branch from GitHub

In this section, you fetch the `load-tests` branch from GitHub and check out, or switch to, that branch.

This branch contains the _Space Game_ project that you worked with in previous modules and an Azure Pipelines configuration to start with.

1. In Visual Studio Code, open the integrated terminal.
1. To download a branch named `load-tests` from the Microsoft repository and switch to that branch, run the following `git fetch` and `git checkout` commands:

    ```bash
    git fetch upstream load-tests
    git checkout load-tests
    ```

    Recall that *upstream* refers to the Microsoft GitHub repository. Your project's Git configuration understands the upstream remote, because you set up that relationship when you forked the project from the Microsoft repository and cloned it locally.

    Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

1. Optionally, in Visual Studio Code, open the *azure-pipelines.yml* file, and familiarize yourself with the initial configuration.

    The configuration resembles the basic one that you created in the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true) module. It builds only the application's **Release** configuration.

1. TODO: OPTIONAL - CHECK OUT the test plan and xsl files.

## Modify your pipeline

In this section, you modify the pipeline to run your load tests during the _Staging_ stage.

1. In Visual Studio Code, open the *azure-pipelines.yml* file. Then modify the file like this:

    > [!TIP]
    > You can replace the entire file or just update the part that's highlighted.

    ```yml
    TODO
    ```

    TODO: Talk more about the changes.

1. In the integrated terminal, add **azure-pipelines.yml** to the index, commit the changes, and push the branch up to GitHub.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Run load tests with Apache JMeter"
    git push origin load-tests
    ```

## Watch Azure Pipelines run the tests

Here you watch the pipeline run, including the load tests during the _Staging_ stage.

1. In Azure DevOps, go to the **Space Game - web - Load tests** project.
1. On the project page or in the left pane, select **Pipelines**.
1. Select **Builds**, and then select the running build.
1. Trace the build through each of the steps.
1. TALK ABOUT TEST TAB; YOU SEE ...; THEN SHOW SCREENSHOT