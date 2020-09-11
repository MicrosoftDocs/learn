In this unit, you'll implement and test a CI/CD pipeline by performing the following tasks:

- Set up permissions to deploy to ACR and AKS from GitHub
- Create a GitHub Action to implement a simple CI/CD pipeline
- Modify the coupon service
- Update the coupon service version in the Helm chart
- Verify that the changes where deployed to the AKS cluster
- Roll back a deployment

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

    :::image type="content" source="../media/4-build-github-action/add-github-secrets.png" alt-text="Image description follows in text" border="true" lightbox="../media/4-build-github-action/add-github-secrets.png":::
1. Select the **Add secret** button.
1. Create two additional secrets representing the username and password for accessing the ACR instance. Run the following command to get the values to be used for the new secrets:

    ```bash
    cat ~/clouddrive/aspnet-learn-temp/config.txt
    ```

    Name the secrets as follows and use the values provided in the text output:
    - `REGISTRY_USERNAME`
    - `REGISTRY_PASSWORD`

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

### Create the deployment Action

Create a GitHub Action for the deployment with the following steps:

1. Select the **Actions** tab again, select the **New workflow** button, and select the **set up a workflow yourself** link.

1. Replace the YAML in the editor with the following YAML:

    ```yml
    name: eShop deploy

    on:
      push:
        paths:
        - 'deploy/k8s/helm-simple/coupon/*'
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

## Modify the coupon service

You've just finished creating your first CI/CD pipeline. The Marketing department wants to start a campaign to better track coupon code usage. With this feature, Marketing can better understand which coupon codes are most effective in driving sales. To support this feature, make the following changes in the `main` branch:

1. Select the **Code** tab in your fork of the repository.
1. Edit the *src/Services/Coupon/Coupon.API/Controllers/CouponController.cs* file by clicking the pencil (edit) icon. In the *CouponController.cs* file, replace the comment `// Add LogInformation call` with the following code:

    ```csharp
    _logger.LogInformation("Applying coupon {CouponCode}", code);
    ```

    The preceding code logs the coupon code being applied.
1. Select the **Commit directly to the `main` branch** radio button and select the **Commit changes** button.

    The build workflow is triggered automatically. You can track the progress of the build in real-time by selecting the **Actions** tab, selecting the most recent workflow run listed, and selecting the **build-and-push-docker-image** task. If the build completes successfully, you'll see a variation of the following:

    :::image type="content" source="../media/4-build-github-action/eshop-build-workflow-success.png" alt-text="page showing output for a successful build" border="true" lightbox="../media/4-build-github-action/eshop-build-workflow-success.png":::
1. On the **Code** tab, edit the *deploy/k8s/helm-simple/coupon/Chart.yaml* file by clicking the edit icon. Update the `appVersion` property value to `1.1.0`:

    ```yml
    apiVersion: v2
    name: coupon

    # YAML omitted for brevity

    # This is the version number of the application being deployed. This version number should be
    # incremented each time you make changes to the application.
    appVersion: 1.1.0
    ```

    It's important that you update the app version in the Helm chart. This change causes the pod to be replaced when the chart is deployed to AKS with `helm upgrade`.
1. Commit and push this change to the `main` branch.

    The deployment workflow is triggered automatically. The app is deployed after a few minutes.

## Wait for deployment

1. Select the **Actions** tab in your repository to monitor the deployment's progress.

    :::image type="content" source="../media/4-build-github-action/deployment-action-output.png" alt-text="Deployment action output from the deploy-to-aks job" border="true" lightbox="../media/4-build-github-action/deployment-action-output.png":::

    In the preceding image, you can see the `deploy-to-aks` job was completed in the log output. The `Set up job` and `Complete job` steps are listed. In between those two steps are the custom steps defined within the `deploy-to-ask` job. You'll see a variation of the following screen when the deployment completes:

    :::image type="content" source="../media/4-build-github-action/deployment-action-completed.png" alt-text="Actions tab showing a completed build and deployment" border="true" lightbox="../media/4-build-github-action/deployment-action-completed.png":::

1. Run the following command to monitor your pods:

    ```bash
    kubectl get pods -w
    ```

    A variation of the following output appears:

    ```console
    NAME                              READY   STATUS              RESTARTS   AGE
    backgroundtasks-c4fdf75bb-2zfpl   1/1     Running             1          31m
    basket-78bdff857f-s9x9p           1/1     Running             1          31m
    basketdata-66d657d89d-ksr54       1/1     Running             0          31m
    catalog-569786957c-kww64          1/1     Running             3          31m
    coupon-5b9597995-7s4hh            1/1     Running             1          31m
    coupon-74fd48bbd-rqgfd            0/1     ContainerCreating   0          22s
    identity-556cb7b974-j84hh         1/1     Running             2          31m
    nosqldata-5ccc5d7747-h79fw        1/1     Running             0          31m
    ordering-6c456f5d4c-xrjbx         1/1     Running             2          31m
    payment-7677755767-s6s98          1/1     Running             1          31m
    rabbitmq-7877fcd685-5drsq         1/1     Running             0          31m
    seq-669f9cf486-46q6r              1/1     Running             0          31m
    signalr-64d9c95564-b2wjx          1/1     Running             1          31m
    sqldata-6f8c8c577-2vckd           1/1     Running             0          31m
    webshoppingagg-78445b66f5-gpllh   1/1     Running             0          31m
    webspa-64786f994f-xmsc4           1/1     Running             0          31m
    webstatus-8887f6f55-bvq76         1/1     Running             0          31m
    ```

    In the preceding output, you can see that a new `coupon` pod is created while the old one is still running and when the new one is ready the old one is terminated. This should make the transition to the new version as smooth as possible. Press <kbd>Ctrl+C</kbd> to terminate `kubectl`.

1. Run the following command to check the coupon service deployment history:

    ```bash
    helm history eshoplearn-coupon
    ```

    The history shows the new coupon service version has been deployed.

    ```console
    REVISION        UPDATED                         STATUS          CHART           APP VERSION     DESCRIPTION
    1               Thu Sep 10 19:19:31 2020        superseded      coupon-0.1.0    1.0.0           Install complete
    2               Thu Sep 10 19:51:10 2020        deployed        coupon-0.1.0    1.1.0           Upgrade complete
    ```

1. Run the following command:

    ```bash
    cat ~/clouddrive/aspnet-learn-temp/deployment-urls.txt
    ```

<!-- TODO - Have the student buy a product using a coupon code before checking the Seq logs page -->

:::image type="content" source="../media/4-build-github-action/seq-log.png" alt-text="A screen capture of the Seq log output." border="true" lightbox="../media/4-build-github-action/seq-log.png":::

## Roll back a deployment

During production issues, one common mitigation is to revert a deployment to a known good deployment. Use the following command to roll back from version 1.1.0 to 1.0.0.

```bash
helm rollback eshoplearn-coupon
```

The deployment history confirms that everything is back to normal:

```console
Rollback was a success! Happy Helming!
```

> [!NOTE]
> In a real-life scenario, you'd include at least one test step and separate the build (CI) and the deploy (CD) pipelines. You'd usually have multiple environments where each build could be deployed (for example, dev, test, staging). Also, the deployment jobs would usually be triggered by different events, typically requiring some sort of approval so you don't get surprises in production.
>
> You'd usually also have the pipeline triggered on each PR, to make sure the PR builds correctly and tests run successfully, before reviewing the PR.

For further information, see the [GitHub Action documentation site](https://help.github.com/actions).
