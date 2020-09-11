In this unit, you'll implement and test a CI/CD pipeline by performing the following tasks:

- Create a GitHub Action to implement a simple CI/CD pipeline
- Modify the coupon service
- Update the coupon service version in the Helm chart
- Verify that the changes where deployed to the AKS cluster
- Roll back a deployment

## Create GitHub Actions to implement CI and CD pipelines

### Create the build Action

Create a GitHub Action for the build with the following steps:

1. Select the **Actions** tab in your repository and select the **set up a workflow yourself** link:

    :::image type="content" source="../media/4-build-github-action/set-up-custom-github-workflow.png" alt-text="Actions tab in the GitHub repository, highlighting the workflow creation link" border="true" lightbox="../media/4-build-github-action/set-up-custom-github-workflow.png":::

1. Replace the YAML in the editor with the following YAML:

    ```yml
    name: eShop build

    on:
      push:
        paths:
        - 'src/Services/Coupon/**'
        branches: [ main ]

    env:
      IMAGE_NAME: coupon.api
      TAG: linux-latest
      CONTEXT_PATH: .
      DOCKER_FILE_PATH: src/Services/Coupon/Coupon.API/Dockerfile.acr
      CHART_PATH: deploy/k8s/helm-simple/coupon
      CLUSTER_NAME: eshop-learn-aks
      CLUSTER_RESOURCE_GROUP: eshop-learn-rg
      REGISTRY_LOGIN_SERVER: <PASTE_VALUE_HERE>
      IP_ADDRESS: <PASTE_VALUE_HERE>

    jobs:
      build-and-push-docker-image:
        runs-on: ubuntu-latest
        steps:
        - name: Get code from the repository
          uses: actions/checkout@v1
          with:
            ref: main

        - name: Build and push Docker image
          uses: docker/build-push-action@v1.1.0
          with:
            username: ${{ secrets.REGISTRY_USERNAME }}
            password:  ${{ secrets.REGISTRY_PASSWORD }}
            registry: ${{ env.REGISTRY_LOGIN_SERVER }}
            path:  ${{ env.CONTEXT_PATH }}
            dockerfile: ${{ format('{0}/{1}', env.CONTEXT_PATH, env.DOCKER_FILE_PATH) }}
            repository:  ${{ env.IMAGE_NAME }}
            tags: ${{ env.TAG }}
            push: true
    ```

    The preceding YAML defines a GitHub Action that:

    - Is triggered when a commit is pushed to the coupon service in the `main` branch.
    - Defines environment variables that are used tasks in the specification. Placeholder values are used for now.
      - `IP_ADDRESS`
      - `REGISTRY_LOGIN_SERVER`
    - Has one job&mdash;a set of steps that execute on the same runner&mdash;named `build-and-push-docker-image`. The job:
        - Builds the Docker image and pushes it to the ACR instance.
        - Runs in an `ubuntu-latest` agent and has two steps, both of which are standard actions available from [GitHub Action's marketplace](https://github.com/marketplace?type=actions):
            - `Get code from the repository` checks out the `main` branch.
            - `Build and push Docker image` builds the image and pushes it to ACR.

    > [!IMPORTANT]
    > Trigger conditions and other artifacts of GitHub Actions or workflows depend on the apps and environments. For ease of understanding, details are kept simple here. Both the build and the deploy workflows are scoped to coupon service changes because all the microservices are kept under a single repository. In an actual production scenario, each microservice is kept in a separate repository.

1. Replace the default Action file name of *main.yml* with *build.yml*:

    :::image type="content" source="../media/4-build-github-action/action-file-name.png" alt-text="GitHub Action file name text box" border="true" lightbox="../media/4-build-github-action/action-file-name.png":::

1. Run the following command in Azure Cloud Shell to get values for the `env` block's environment variables:

    ```bash
    cat ~/clouddrive/aspnet-learn-temp/config.txt
    ```

1. In the Action YAML editor, replace the values for the following environment variables. Use the values from the output in the preceding step.
    - `IP_ADDRESS`
    - `REGISTRY_LOGIN_SERVER`

    At this point, you should see something like this:

    ```yml
    env:
      IMAGE_NAME: coupon.api
      TAG: linux-latest
      CONTEXT_PATH: .
      DOCKER_FILE_PATH: src/Services/Coupon.API/Dockerfile.acr
      CHART_PATH: deploy/k8s/helm-simple/coupon
      CLUSTER_NAME: eshop-learn-aks
      CLUSTER_RESOURCE_GROUP: eshop-learn-rg
      REGISTRY_LOGIN_SERVER: eshoplearn20200908125010311.azurecr.io
      IP_ADDRESS: 203.0.113.55
    ```

    In the preceding snippet, you can see a portion of the *build.yml* file with the mentioned environment variables set.

1. Select the **Start commit** button, select the **Commit directly to the `main` branch** radio button, and select **Commit new file** to save the Action file.

## Modify the coupon service

You've just finished creating the "build" action for your CI/CD pipeline. The Marketing department wants to start a campaign to better track coupon code usage. With this feature, Marketing can better understand which coupon codes are most effective in driving sales. To support this feature, make the following changes in the `main` branch:

1. Select the **Code** tab in your fork of the repository.
1. Edit the *src/Services/Coupon/Coupon.API/Controllers/CouponController.cs* file by clicking the pencil (edit) icon. In the *CouponController.cs* file, replace the comment `// Add LogInformation call` with the following code:

    ```csharp
    _logger.LogInformation("Applying coupon {CouponCode}", code);
    ```

    The preceding code logs the coupon code being applied.
1. Select the **Commit directly to the `main` branch** radio button and select the **Commit changes** button.

    The build workflow is triggered automatically. You can track the progress of the build in real-time by selecting the **Actions** tab, selecting the most recent workflow run listed, and selecting the **build-and-push-docker-image** task. If the build completes successfully, you'll see a variation of the following:

    :::image type="content" source="../media/4-build-github-action/build-workflow-success.png" alt-text="page showing output for a successful build" border="true" lightbox="../media/4-build-github-action/build-workflow-success.png":::
