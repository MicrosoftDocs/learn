In this unit, you complete the following tasks:

- Create a GitHub action to implement a build pipeline.
- Modify the coupon service code to trigger the build workflow.
- Monitor the build workflow's progress in real time.
- Update a failing unit test to fix the build.

## Create the build action

 The YAML code in this procedure defines a GitHub action that:

- Triggers when a commit is pushed to the coupon service's source code or unit tests in the `main` branch.
- Defines step-specific .NET Core CLI environment variables. For example, the `Run unit tests` step defines `DOTNET_CLI_TELEMETRY_OPTOUT` and `DOTNET_NOLOGO` environment variables to opt out of usage data collection and suppress the first-run telemetry message.
- Has one *job*, or set of steps that execute on the same workflow runner, named `build-and-push-docker-image`.

The `build-and-push-docker-image` job in the GitHub action takes the following steps:

- Executes the xUnit tests for the coupon service.
- Builds the Docker image and pushes it to a private Azure Container Registry instance used for the modified coupon container image. You don't have permission to modify the Microsoft-owned container registry for the original image.
- Runs three steps in an `ubuntu-latest` runner, two of which use the following actions available from the [GitHub Actions Marketplace](https://github.com/marketplace?type=actions):
  - `Get code from the repository` uses the `actions/checkout@v1` action to check out the `main` branch.
  - `Build and push Docker image` uses the `docker/build-push-action@v1.1.0` action to build the container image and push it to Container Registry.

> [!IMPORTANT]
> Trigger conditions and other artifacts of GitHub Actions or workflows depend on the apps and environments. For ease of understanding, details are kept simple in this example. Both the build and the deploy workflows are scoped to coupon service changes because all the microservices are kept under a single repository. In an actual production scenario, each microservice would be kept in a separate repository.

Complete the following steps to create the GitHub Actions build action:

1. In your forked repository, select the **:::no-loc text="Actions":::** tab.
1. On the **:::no-loc text="Get started with GitHub Actions":::** page, select the **:::no-loc text="set up a workflow yourself":::** link.

    :::image type="content" source="../media/4-build-github-action/set-up-custom-github-workflow.png" alt-text="Screenshot that shows the Actions tab in the GitHub repository, highlighting the workflow creation link." lightbox="../media/4-build-github-action/set-up-custom-github-workflow.png":::

1. On the next page, paste the following YAML code into the editor.

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
            tags: 'linux-net6-coupon'
            push: true
    ```

1. Replace the default workflow **:::no-loc text="main.yml":::** file name with *:::no-loc text="build.yml":::*, and then select **:::no-loc text="Commit changes":::**.

    :::image type="content" source="../media/4-build-github-action/action-file-name.png" alt-text="Screenshot of the GitHub action file name text box and Commit changes button." lightbox="../media/4-build-github-action/action-file-name.png":::

1. On the **:::no-loc text="Commit changes":::** screen, select **:::no-loc text="Commit directly to the main branch":::** and then select **:::no-loc text="Commit changes":::**.

You've finished creating the build workflow for your CI/CD pipeline.

## Trigger the build

The Marketing department wants to start a campaign to track discount code usage, so they can better understand which discount codes are the most effective in boosting sales. To support this campaign, make the following changes in the code.

1. In your forked repository, select the **:::no-loc text="Code":::** tab, and navigate to and open the *:::no-loc text="src/Services/Coupon/Coupon.API/Controllers/CouponController.cs":::* file.
1. Select the edit icon to open the file for editing.

   :::image type="content" source="../media/4-build-github-action/edit-file-icon.png" alt-text="Screenshot of the GitHub edit file icon." lightbox="../media/4-build-github-action/edit-file-icon.png":::

1. Near the end of the file, replace the comment `// Add LogInformation call` with the following code that logs the discount code being applied.

   ```csharp
   _logger.LogInformation("Applying coupon {CouponCode}", code);
   ```

1. Select **:::no-loc text="Commit changes":::**, select the **:::no-loc text="Commit directly to the main branch":::** radio button, and then select **:::no-loc text="Commit changes":::** again.

   The build workflow triggers automatically.

## Monitor the build

To view the real-time progress of the build:

1. In your repository, select the **:::no-loc text="Actions":::** tab.
1. Select the most recent workflow run listed for the **:::no-loc text="eShop build":::** workflow. The name of the run is the commit message you used in the previous step.

   :::image type="content" source="../media/4-build-github-action/eshop-build-workflow.png" alt-text="Screenshot that shows the most recent eShop build on the workflows page." lightbox="../media/4-build-github-action/eshop-build-workflow.png":::

1. Select the **:::no-loc text="build-and-push-docker-image":::** task.
1. Wait a few minutes. Observe that the build fails on the `Run unit tests` step, and the `Build and push Docker image` step doesn't run because the previous step failed.

   :::image type="content" source="../media/4-build-github-action/failed-unit-tests.png" alt-text="Screenshot that shows build and push docker image selected, and a failure next to Run unit tests in the workflow steps." lightbox="../media/4-build-github-action/failed-unit-tests.png":::

## Fix the build

1. From the **:::no-loc text="Code":::** tab, open the *:::no-loc text="tests/Services/Coupon/Coupon.API.Tests/Controllers/CouponControllerTests.cs":::* file for editing.
1. The `Assert.True(false);` line causes the unit test to fail. Change that line to `Assert.True(true);`, and commit the change.

   This edit causes the test to always pass. This test is for illustrative purposes only. Real tests should test actual functionality.

1. The build workflow triggers automatically. When the build completes successfully, all steps are prefixed with a check mark. Expand any task to show the output generated during its execution, as in the following example:

   :::image type="content" source="../media/4-build-github-action/build-workflow-success.png" alt-text="Screenshot showing output for a successful build." lightbox="../media/4-build-github-action/build-workflow-success.png":::

> [!NOTE]
> You could move the `dotnet test` command to the *:::no-loc text="Dockerfile":::*. This example runs `dotnet test` in GitHub Actions so you can:
>
> - Understand how to run .NET Core CLI commands in GitHub Actions.
> - Understand how the failure of a step can prevent execution of the remaining build steps.

In this unit, you used GitHub Actions to build the coupon service. You added logging to the coupon service, and saw how committing that code triggered the build workflow. You learned how to monitor the build's progress in real time. Finally, you fixed a failing unit test and triggered a successful build.
