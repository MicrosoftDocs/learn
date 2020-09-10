In this unit, you'll implement and test a CI/CD pipeline by performing the following tasks:

- Set up permissions to deploy to ACR and AKS from GitHub
- Create a GitHub Action to implement a simple CI/CD pipeline
- Modify the SPA
- Update the SPA version in the Helm chart
- Verify that the changes where deployed to the AKS cluster
- Rollback a deployment

## Set up permissions to deploy from GitHub

A GitHub Action will be used to deploy to ACR and AKS. You must set up permissions so the GitHub Action agent can connect to Azure. Complete the following steps:

1. Run the following command to create a service principal to allow access from GitHub:

    ```azurecli
    az ad sp create-for-rbac --sdk-auth --name http://eshop-learn-sp
    ```

    A variation of the following output appears:

    ```console
    Creating a role assignment under the scope of "/subscriptions/<SUBSCRIPTION-ID>"
    {
      "clientId": "<CLIENT-ID>",
      "clientSecret": "<CLIENT-SECRET>",
      "subscriptionId": "<SUBSCRIPTION-ID>",
      "tenantId": "<TENANT-ID>",
      "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
      "resourceManagerEndpointUrl": "https://management.azure.com/",
      "activeDirectoryGraphResourceId": "https://graph.windows.net/",
      "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
      "galleryEndpointUrl": "https://gallery.azure.com/",
      "managementEndpointUrl": "https://management.core.windows.net/"
    }
    ```

1. Copy the JSON output from the command shell. You'll need this and the credentials for the GitHub Action in next step.

### Create secrets

1. In the GitHub repository you forked, go to **Settings** > **Secrets**.
1. Select the **New secret** button.
1. Enter `AZURE_CREDENTIALS` and the JSON output you copied in the **Name** and **Value** text boxes, respectively.

    At this point, you should have something like this:

    :::image type="content" source="../media/4-implement-github-action/add-github-secrets.png" alt-text="Image description follows in text" border="true" lightbox="../media/4-implement-github-action/add-github-secrets.png":::
1. Select the **Add secret** button.
1. Create two additional secrets representing the username and password for accessing the ACR instance. Run the following command to get the values to be used for the new secrets:

    ```bash
    cat ~/clouddrive/aspnet-learn-temp/config.txt
    ```

    Name the secrets as follows and use the values provided in the text output.
    - `REGISTRY_USERNAME`
    - `REGISTRY_PASSWORD`

## Create GitHub Actions to implement CI and CD pipelines

### Create the build Action

Create a GitHub Action for the build with the following steps:

1. Select the **Actions** tab in your repository and select the **set up a workflow yourself** link:

    :::image type="content" source="../media/4-implement-github-action/set-up-custom-github-workflow.png" alt-text="Actions tab in the GitHub repository, highlighting the workflow creation link" border="true" lightbox="../media/4-implement-github-action/set-up-custom-github-workflow.png":::

1. Replace the YAML in the editor with the following YAML:

    ```yml
    name: eShop build

    on:
      push:
        paths:
        - './src/Services/Coupon/**'
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

        - name: Build and push Docker images
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
            - `Build and push Docker images` builds the image and pushes it to ACR.

    > [!IMPORTANT]
    > Trigger conditions and other artifacts of GitHub Actions or workflows depend on the apps and environments. For ease of understanding, details are kept simple here. Both the build and the deploy workflows are scoped to coupon service changes because all the microservices are kept under a single repository. In an actual production scenario, each microservice is kept in a separate repository.

1. Replace the default Action file name of *main.yml* with *build.yml*:

    :::image type="content" source="../media/4-implement-github-action/action-file-name.png" alt-text="GitHub Action file name text box" border="true" lightbox="../media/4-implement-github-action/action-file-name.png":::

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

### Create the deployment Action

Create a GitHub Action for the deployment with the following steps:

1. Replace the YAML in the editor with the following YAML:

    ```yml
    name: eShop deploy

    on:
      push:
        paths:
        - './deploy/k8s/helm-simple/coupon/*'
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
      deploy-to-aks:
        runs-on: ubuntu-latest
        steps:
        - name: Azure Kubernetes set context
          uses: Azure/aks-set-context@v1
          with:
            creds: ${{ secrets.AZURE_CREDENTIALS }}
            resource-group: ${{env.CLUSTER_RESOURCE_GROUP}}
            cluster-name: ${{env.CLUSTER_NAME}}

        - name: Get code from the repository
          uses: actions/checkout@v1
          with:
            ref: main

        - name: Helm tool installer
          uses: Azure/setup-helm@v1

        - name: Azure Login
          uses: Azure/login@v1.1
          with:
            creds: ${{ secrets.AZURE_CREDENTIALS }}

        - name: Deploy
          run: |
            helm upgrade --install eshoplearn-coupon --namespace=default --set registry=${{ env.REGISTRY_LOGIN_SERVER }} --set imagePullPolicy=Always --set host=${{env.IP_ADDRESS}} --set protocol=http ${{ format('{0}/{1}', env.CONTEXT_PATH, env.CHART_PATH) }}
    ```

    The preceding YAML defines a GitHub Action that:

    - Is triggered when a commit is pushed to the coupon service's Helm chart in the `main` branch.
    - Defines environment variables that are used tasks in the specification. Placeholder values are used for now.
      - `IP_ADDRESS`
      - `REGISTRY_LOGIN_SERVER`
    - Has one job, named `deploy-to-aks`, that deploys new images. The job runs in an `ubuntu-latest` agent and has five steps:
        - `Azure Kubernetes set context` sets the AKS credentials in the agent's *.kube/config* file.
        - `Get code from the repository` checks out the code from the repository.
        - `Helm tool installer` installs Helm, an open-source package manager for Kubernetes.
        - `Azure Login` logs in to Azure using the service principal credentials.
        - `Deploy` executes the `helm upgrade` command, passing the ACR instance name as the `registry` parameter. This parameter tells Helm to use your ACR instance rather than the public container registry.

1. Replace the default Action file name of *main.yml* with *deploy.yml*.
1. In the Action YAML editor, replace the values for the following environment variables with the same values used for *build.yml*:
    - `IP_ADDRESS`
    - `REGISTRY_LOGIN_SERVER`
1. Commit the *deploy.yml* file directly to the `main` branch.

These two GitHub Action definitions will be part of the repository from now on. To make changes, update the appropriate file locally and push to the `main` branch. Alternatively, create a pull request (PR). If you create a PR, the Action is triggered when merging to `main`.

## Modify the Coupon.API microservice

You've just finished creating your first CI/CD pipeline and someone from the marketing department wants to start a campaign for the new discount coupon feature, so the customers can get whatever discount they want, if they just guess the correct codes and nobody has used them before (Somehow they think this is a good idea 😂)

Since you can guess this won't last too long, that is, this is just a proof-of-concept (POC), you're doing the minimum possible changes, right in the `main` branch:

1. In the *src/Services/Coupon/Coupon.API/Controllers/CouponController.cs* file, replace the comment `// Add LogInformation call` with the following code:

    ```csharp
    _logger.LogInformation("Applying coupon {CouponCode}", code);
    ```

    The preceding code logs the coupon code being applied.
1. Commit and push this change to the `main` branch.

    The build workflow is triggered automatically. If the build completes successfully, you'll see a variation of the following output:

    :::image type="content" source="../media/4-implement-github-action/eshop-build-workflow-success.png" alt-text="page showing output for a successful build" border="true" lightbox="../media/4-implement-github-action/eshop-build-workflow-success.png":::
1. In the *deploy/k8s/helm-simple/coupon/Chart.yaml* file, update the `appVersion` property value to `1.1.0`.

    ```yml
    apiVersion: v2
    name: webspa
    description: A Helm chart for Kubernetes
    ...
    # This is the version number of the application being deployed. This version number should be
    # incremented each time you make changes to the application.
    appVersion: 1.1.0
    ```

    It's important that you update the app version in the Helm chart. This change causes the pod to be replaced when the chart is deployed to AKS with `helm upgrade`.
1. Commit and push this change to the `main` branch.

    The deployment workflow is triggered automatically. The app should be deployed after a few minutes.

## Wait for deployment

If you select the **Actions** tab in your repository, you can monitor the progress, as shown in the next image:

:::image type="content" source="../media/4-implement-github-action/monitor-github-action-progress.png" alt-text="Image description follows in text" border="true" lightbox="../media/4-implement-github-action/monitor-github-action-progress.png":::

In the preceding image, you can see the `Build and push Docker images` step running and the log output.

If you monitor your pods using the command `kubectl get pods -w` you should see something like this:

:::image type="content" source="../media/4-implement-github-action/replacing-pods.png" alt-text="Image description follows in text" border="true" lightbox="../media/4-implement-github-action/replacing-pods.png":::

In the preceding image, you can see that a new `webspa` pod is created while the old one is still running and when the new one is ready the old one is terminated. This should make the transition to the new version as smooth as possible.

You can also check the `webspa` microservice deployment history, with the command `helm history eshoplearn-webspa` to get something like this:

:::image type="content" source="../media/4-implement-github-action/deployment-history.png" alt-text="Helm deployment history for eshoplearn-webspa, showing app version 1.1.0 is deployed" border="true" lightbox="../media/4-implement-github-action/deployment-history.png":::

At this point, you just have to refresh the browser to see the changes, as shown in the next image.

:::image type="content" source="../media/4-implement-github-action/changes-deployed.png" alt-text="WebSPA home page view, showing the 'promotion message'" border="true" lightbox="../media/4-implement-github-action/changes-deployed.png":::

## Rollback a deployment

Once the deployment is completed and customer feedback starts coming in, you receive a "visit" from the Marketing head... and after a very short "conversation" you are "requested" to fix the issue because "the experiment" didn't go well enough, so you just run the following command:

```bash
helm rollback eshoplearn-webspa
```

Checking the deployment history again you know that everything is back to normal 😅:

:::image type="content" source="../media/4-implement-github-action/deployment-rollback.png" alt-text="Helm deployment history for eshoplearn-webspa, showing app version 1.0.0 is now deployed" border="true" lightbox="../media/4-implement-github-action/deployment-rollback.png":::

> **NOTE**
> In a real-life scenario, you'd include at least one tests step and separate the build (CI) and the deploy (CD) pipelines. You'd usually have multiple environments where each build could be deployed (for example, dev, test, staging). Also the deployment jobs would usually be triggered by different events, typically requiring some sort of approval so you don't get surprises in production.
>
> You'd usually also have the pipeline triggered on each PR, to make sure the PR builds correctly and tests run successfully, before reviewing the PR.

For further information, see the [GitHub Action documentation site](https://help.github.com/actions).
