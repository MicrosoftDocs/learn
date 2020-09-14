In this unit, you'll complete the following tasks:

- Create a GitHub Action to implement a deployment pipeline
- Increment the coupon service version in the Helm chart
- Verify that the changes were deployed to the AKS cluster
- Roll back a deployment

## Create the deployment action

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
      CHART_PATH: deploy/k8s/helm-simple/coupon
      CONTEXT_PATH: .
      CLUSTER_NAME: eshop-learn-aks
      CLUSTER_RESOURCE_GROUP: eshop-learn-rg

    jobs:
      deploy-to-aks:
        runs-on: ubuntu-latest
        steps:
        - name: Azure Kubernetes set context
          uses: Azure/aks-set-context@v1
          with:
            creds: ${{ secrets.AZURE_CREDENTIALS }}
            resource-group: ${{ env.CLUSTER_RESOURCE_GROUP }}
            cluster-name: ${{ env.CLUSTER_NAME }}

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
            helm upgrade --install eshoplearn-coupon --namespace=default --set registry=${{ secrets.REGISTRY_LOGIN_SERVER }} --set imagePullPolicy=Always --set host=${{ secrets.IP_ADDRESS }} --set protocol=http ${{ format('{0}/{1}', env.CONTEXT_PATH, env.CHART_PATH) }}
    ```

    The preceding YAML defines a GitHub Action that:

    - Is triggered when a commit is pushed to the coupon service's Helm chart in the `main` branch.
    - Defines environment variables that are used tasks in the specification.
    - Has one job, named `deploy-to-aks`, that deploys new images. The job runs in an `ubuntu-latest` runner and has five steps:
        - `Azure Kubernetes set context` sets the AKS credentials in the runner's *.kube/config* file.
        - `Get code from the repository` checks out the code from the repository.
        - `Helm tool installer` installs Helm, an open-source package manager for Kubernetes.
        - `Azure Login` logs in to Azure using the service principal credentials.
        - `Deploy` executes the `helm upgrade` command, passing the ACR instance name as the `registry` parameter. This parameter tells Helm to use your ACR instance rather than the public container registry.

1. Replace the default Action file name of *main.yml* with *deploy.yml*.
1. Commit the *deploy.yml* file directly to the `main` branch.

These two GitHub Action definitions are stored in the repository's *.github/workflows* directory. To make changes, update the appropriate file locally and push to the `main` branch. Alternatively, create a pull request (PR). If you create a PR, the Action is triggered when merging to `main`.

## Trigger a deployment

To trigger a deployment, you'll increment the `appVersion` in the coupon service's Helm chart. Helm charts are used to define the service specification in a YAML template format.

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

## Monitor the deployment

1. Select the **Actions** tab in your repository to monitor the deployment's progress.

    :::image type="content" source="../media/5-deploy-github-action/eshop-deploy-workflow.png" alt-text="eShop deploy workflow listed on the workflows page" border="true" lightbox="../media/5-deploy-github-action/eshop-deploy-workflow.png":::

    In the preceding image, you can see the `deploy-to-aks` job was completed in the log output. The `Set up job` and `Complete job` steps are listed. In between those two steps are the custom steps defined within the `deploy-to-ask` job. You'll see a variation of the following screen when the deployment completes:

    :::image type="content" source="../media/5-deploy-github-action/deployment-action-completed.png" alt-text="Actions tab showing a completed build and deployment" border="true" lightbox="../media/5-deploy-github-action/deployment-action-completed.png":::

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

    In the preceding output, notice that a new `coupon` pod was created. While the old pod is still running and when the new pod is ready, the old one is terminated. This should make the transition to the new version as smooth as possible.

1. One the new pod's status is *Running* and its *Ready* status displays `1/1`, press <kbd>Ctrl+C</kbd> to exit `kubectl`.
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

1. Follow these steps to verify your change is deployed:
    1. In the console, run the following command:

        ```bash
        cat ~/clouddrive/aspnet-learn-temp/deployment-urls.txt
        ```

    1. Select the **Web SPA application** URL to launch the app.
    1. Select the **LOGIN** link in the upper right (the credentials are provided on the sign-in page).
    1. Add your favorite products to the shopping bag by selecting the images.
    1. Select the shopping bag icon in the upper right.
    1. Select **CHECKOUT**.
    1. Scroll to the **HAVE A DISCOUNT CODE?** field.
    1. Enter the code *:::no-loc text="DISC-10":::* for a 10 USD discount, and select **APPLY**.
    1. Select **PLACE ORDER** to complete the purchase.
    1. Back in the console, select the **Centralized logging** URL.
    1. Observe an entry in the logs similar to the following content:

        :::image type="content" source="../media/5-deploy-github-action/seq-log.png" alt-text="A screen capture of the Seq log output" border="true" lightbox="../media/5-deploy-github-action/seq-log.png":::

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

For more information, see the [GitHub Action documentation site](https://help.github.com/actions).
