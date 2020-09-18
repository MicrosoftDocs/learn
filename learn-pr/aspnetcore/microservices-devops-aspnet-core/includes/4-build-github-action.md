In this unit, you'll complete the following tasks:

- Create a GitHub Action to implement a build pipeline
- Modify the coupon service code to trigger the build workflow
- Monitor the build workflow's progress in real time
- Update a failing unit test to fix the build

## Create the build action

Create a GitHub Action for the build with the following steps:

1. Select the **:::no-loc text="Actions":::** tab in your repository and select the **:::no-loc text="set up a workflow yourself":::** link:

    :::image type="content" source="../media/4-build-github-action/set-up-custom-github-workflow.png" alt-text="Actions tab in the GitHub repository, highlighting the workflow creation link" border="true" lightbox="../media/4-build-github-action/set-up-custom-github-workflow.png":::

1. Replace the YAML in the editor with the following YAML:

    ```yaml
    name: eShop build

    on:
      push:
        paths:
        - 'src/Services/Coupon/**'
        - 'tests/Services/Coupon/**'
        branches: [ main ]

    jobs:
      build-and-push-docker-image:
        runs-on: ubuntu-latest
        steps:
        - name: Get code from the repository
          uses: actions/checkout@v1
          with:
            ref: main

        - name: Run unit tests
          run: dotnet test tests/Services/Coupon/*.Tests/*.csproj
          env:
            DOTNET_CLI_TELEMETRY_OPTOUT: true
            DOTNET_NOLOGO: true

        - name: Build and push Docker image
          uses: docker/build-push-action@v1.1.0
          with:
            username: ${{ secrets.REGISTRY_USERNAME }}
            password: ${{ secrets.REGISTRY_PASSWORD }}
            registry: ${{ secrets.REGISTRY_LOGIN_SERVER }}
            path: .
            dockerfile: './src/Services/Coupon/Coupon.API/Dockerfile.acr'
            repository: 'coupon.api'
            tags: 'linux-latest'
            push: true
    ```

    The preceding YAML defines a GitHub Action that:

    - Is triggered when a commit is pushed to the coupon service's source code or unit tests in the `main` branch.
    - Defines step-specific environment variables. For example, the `Run unit tests` step defines `DOTNET_CLI_TELEMETRY_OPTOUT` and `DOTNET_NOLOGO`. With regards to the .NET Core CLI, those environment variables opt out of usage data collection and suppress the first-run telemetry message, respectively.
    - Has one job&mdash;a set of steps that execute on the same workflow runner&mdash;named `build-and-push-docker-image`. The job:
        - Executes the xUnit tests for the coupon service.
        - Builds the Docker image and pushes it to an ACR instance. ACR is a private container registry used for the modified coupon container image. You don't have permission to modify the Microsoft-owned container registry from which the original image was retrieved.
        - Runs in an `ubuntu-latest` runner and has three steps, two of which use actions available from the [GitHub Actions marketplace](https://github.com/marketplace?type=actions):
            - `Get code from the repository` uses the `actions/checkout@v1` action to check out the `main` branch.
            - `Build and push Docker image` uses the `docker/build-push-action@v1.1.0` action to build the container image and push it to ACR.

    > [!IMPORTANT]
    > Trigger conditions and other artifacts of GitHub Actions or workflows depend on the apps and environments. For ease of understanding, details are kept simple here. Both the build and the deploy workflows are scoped to coupon service changes because all the microservices are kept under a single repository. In an actual production scenario, each microservice is kept in a separate repository.

1. Replace the default workflow file name of *:::no-loc text="main.yml":::* with *:::no-loc text="build.yml":::*:

    :::image type="content" source="../media/4-build-github-action/action-file-name.png" alt-text="GitHub Action file name text box" border="true" lightbox="../media/4-build-github-action/action-file-name.png":::

1. Select the **:::no-loc text="Start commit":::** button, select the **:::no-loc text="Commit directly to the `main` branch":::** radio button, and select **:::no-loc text="Commit new file":::** to save the workflow file.

## Trigger a build

You've finished creating the build workflow for your CI/CD pipeline. The Marketing department wants to start a campaign to better track discount code usage. With this feature, Marketing can better understand which discount codes are most effective in boosting sales. To support this feature, make the following changes in the `main` branch:

1. Select the **:::no-loc text="Code":::** tab in your fork of the repository.
1. Select the edit icon to open the *:::no-loc text="src/Services/Coupon/Coupon.API/Controllers/CouponController.cs":::* file in the editor:

    :::image type="content" source="../media/4-build-github-action/edit-file-icon.png" alt-text="GitHub edit file icon" border="true" lightbox="../media/4-build-github-action/edit-file-icon.png":::

1. Replace the comment `// Add LogInformation call` with the following code:

    ```csharp
    _logger.LogInformation("Applying coupon {CouponCode}", code);
    ```

    The preceding code logs the discount code being applied.
1. Select the **:::no-loc text="Commit directly to the `main` branch":::** radio button and select the **:::no-loc text="Commit changes":::** button.

    The build workflow is triggered automatically.

## Monitor the build

View the real-time progress of the build by completing the following steps:

1. Select the **:::no-loc text="Actions":::** tab.
1. Select the most recent workflow run listed for the **:::no-loc text="eShop build":::** workflow. The commit message used in the previous step becomes the run's name.

    :::image type="content" source="../media/4-build-github-action/eshop-build-workflow.png" alt-text="eShop build workflow listed on the workflows page" border="true" lightbox="../media/4-build-github-action/eshop-build-workflow.png":::

1. Select the **:::no-loc text="build-and-push-docker-image":::** task.
1. Wait a few minutes. Notice that:

    - The build fails on the `Run unit tests` step.
    - The `Build and push Docker image` step doesn't run because the previous step failed.

    :::image type="content" source="../media/4-build-github-action/failed-unit-tests.png" alt-text="eShop build workflow listed on the workflows page" border="true" lightbox="../media/4-build-github-action/failed-unit-tests.png":::

## Fix the build

1. From the **:::no-loc text="Code":::** tab, edit the *:::no-loc text="tests/Services/Coupon/Coupon.API.Tests/Controllers/CouponControllerTests.cs":::* file. In the *:::no-loc text="CouponControllerTests.cs":::* file, notice that `Assert.True(false);` causes the unit test to fail. Replace that line with the following code:

    ```csharp
    Assert.True(true);
    ```

    The preceding code causes the test to always pass. This test is for illustrative purposes only. Real tests should test actual functionality.
1. Commit and push this change to the `main` branch.

    The build workflow is triggered automatically.

When the build completes successfully, all steps are prefixed with a green check mark. Expand any task for the output generated during its execution. For example:

:::image type="content" source="../media/4-build-github-action/build-workflow-success.png" alt-text="page showing output for a successful build" border="true" lightbox="../media/4-build-github-action/build-workflow-success.png":::

> [!NOTE]
> It's possible to move the `dotnet test` command to the *:::no-loc text="Dockerfile":::*. In this example, you're running `dotnet test` in the GitHub Action to:
>
> - Understand how to execute .NET Core CLI commands in GitHub Actions.
> - Understand how the failure of a step can prevent execution of the remaining build steps.

In this unit, you created a GitHub Action to build the coupon service. You added logging to the coupon service and saw how committing that code triggered the build workflow. Next, you fixed a failing unit test and triggered the build again. Finally, you learned how to monitor the build's progress in real time.
