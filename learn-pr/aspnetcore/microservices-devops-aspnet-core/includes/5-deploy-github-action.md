In this unit, you'll complete the following tasks:

- Create a GitHub Action to implement a deployment pipeline
- Increment the coupon service version in the Helm chart
- Verify that the changes were deployed to the AKS cluster
- Roll back a deployment

## Create the deployment action

Create a GitHub Action for deployment of the coupon service with the following steps:

1. Select the **:::no-loc text="Actions":::** tab again, select the **:::no-loc text="New workflow":::** button, and select the **:::no-loc text="set up a workflow yourself":::** link.
1. Replace the YAML in the editor with the following YAML:

    ```yaml
    name: eShop deploy

    on:
      push:
        paths:
        - 'deploy/k8s/helm-simple/coupon/*'
        branches: [ main ]

    jobs:
      deploy-to-aks:
        runs-on: ubuntu-latest
        steps:
        - name: Azure Kubernetes set context
          uses: Azure/aks-set-context@v1
          with:
            creds: ${{ secrets.AZURE_CREDENTIALS }}
            resource-group: 'eshop-learn-rg'
            cluster-name: 'eshop-learn-aks'

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
          run: >
            helm upgrade 
            --install eshoplearn-coupon
            --namespace=default 
            --set registry=${{ secrets.REGISTRY_LOGIN_SERVER }} 
            --set imagePullPolicy=Always 
            --set host=${{ secrets.IP_ADDRESS }} 
            --set protocol=http './deploy/k8s/helm-simple/coupon'
    ```

    The preceding YAML defines a GitHub Action that:

    - Is triggered when a commit is pushed to the coupon service's Helm chart in the `main` branch.
    - Has one job, named `deploy-to-aks`, that deploys new images. The job runs in an `ubuntu-latest` runner and has five steps:
        1. `Azure Kubernetes set context` sets the AKS credentials in the runner's *:::no-loc text=".kube/config":::* file.
        1. `Get code from the repository` checks out the code from the repository.
        1. `Helm tool installer` installs [Helm](https://helm.sh/), an open-source package manager for Kubernetes.
        1. `Azure Login` logs in to Azure using the service principal credentials.
        1. `Deploy` executes the `helm upgrade` command, passing the ACR instance name as the `registry` parameter. This parameter tells Helm to use your ACR instance rather than the public container registry.

1. Replace the default workflow file name of *:::no-loc text="main.yml":::* with *:::no-loc text="deploy.yml":::*.
1. Commit the *deploy.yml* workflow file directly to the `main` branch.

These two GitHub Action definitions are stored in the repository's *:::no-loc text=".github/workflows":::* directory. To make changes, update the appropriate file locally and push to the `main` branch. Alternatively, create a pull request (PR). If you create a PR, the Action is triggered when merging to `main`.

## Trigger a deployment

To trigger a deployment, you'll increment the `appVersion` in the coupon service's Helm chart. Helm charts are used to define the service specification in a YAML template format.

1. From the **:::no-loc text="Code":::** tab, edit the *:::no-loc text="deploy/k8s/helm-simple/coupon/Chart.yaml":::* file by clicking the edit icon. Update the `appVersion` property value to `1.1.0`:

    :::code language="yaml" source="../code/deploy/k8s/helm-simple/coupon/chart.yaml" highlight="8":::

    It's important that you update the app version in the Helm chart. This change causes the pod to be replaced when the chart is deployed to AKS with `helm upgrade`.
1. Commit and push this change to the `main` branch.

    The deployment workflow is triggered automatically. The app is deployed after a few minutes.

## Monitor the deployment

1. Select the **:::no-loc text="Actions":::** tab in your repository to monitor the deployment's progress.
1. Select the most recent workflow run listed for the **:::no-loc text="eShop deploy":::** workflow. The commit message used in the previous step becomes the run's name.

    :::image type="content" source="../media/5-deploy-github-action/eshop-deploy-workflow.png" alt-text="eShop deploy workflow listed on the workflows page" border="true" lightbox="../media/5-deploy-github-action/eshop-deploy-workflow.png":::

1. Select the **:::no-loc text="deploy-to-aks":::** task:

    :::image type="content" source="../media/5-deploy-github-action/deploy-to-aks-task.png" alt-text="Actions tab showing a completed build and deployment" border="true" lightbox="../media/5-deploy-github-action/deploy-to-aks-task.png":::

    In the preceding image, you can see details of the `deploy-to-aks` job for this particular workflow run. The `Set up job` and `Complete job` steps are listed. In between those two steps are the custom steps defined within the `deploy-to-aks` job.

1. Select the **:::no-loc text="Actions":::** tab again. You'll see a variation of the following screen when the deployment completes:

    :::image type="content" source="../media/5-deploy-github-action/deployment-action-completed.png" alt-text="Actions tab showing a completed build and deployment" border="true" lightbox="../media/5-deploy-github-action/deployment-action-completed.png":::

1. Back in the command shell, run the following command to monitor the coupon service pods in your AKS cluster:

    ```bash
    kubectl get pods --selector service=coupon --watch
    ```

    In the preceding command:

    - The `--selector` flag filters the list to only pods for the coupon service. For this reason, pods for other services in the cluster aren't displayed.
    - The `--watch` flag instructs `kubectl` to watch for changes. When a change is detected, an additional table row is appended to the command shell output. The status of the existing and newly deployed pods is displayed in real time.

    A variation of the following output appears:

    ```console
    NAME                              READY   STATUS              RESTARTS   AGE
    coupon-5b9597995-7s4hh            1/1     Running             1          31m
    coupon-74fd48bbd-rqgfd            0/1     ContainerCreating   0          22s
    ```

    In the preceding output, notice that a new `coupon` pod was created. While the old pod is still running and when the new pod is ready, the old one is terminated. This process makes the transition to the new version as smooth as possible.

1. Once the new pod's *:::no-loc text="Ready":::* status displays `1/1`, press <kbd>Ctrl+C</kbd> to stop `kubectl`'s watch mode.
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

## Verify the deployment

Complete the following steps to verify your change is deployed:

1. Run the following command in the command shell:

    ```bash
    cat ~/clouddrive/aspnet-learn-temp/deployment-urls.txt
    ```

1. Select the **:::no-loc text="Web SPA application":::** URL to launch the app.
1. Log in from the **:::no-loc text="LOGIN":::** page.
1. Add your favorite products to the shopping bag by selecting the images.
1. Select the shopping bag icon in the upper right, and select **:::no-loc text="CHECKOUT":::**.
1. Enter the code *:::no-loc text="DISC-5":::* in the **:::no-loc text="HAVE A DISCOUNT CODE?":::** text box for a five USD discount, and select **:::no-loc text="APPLY":::**.
1. Select **:::no-loc text="PLACE ORDER":::** to complete the purchase.
1. Back in the command shell, select the **:::no-loc text="Centralized logging":::** URL.
1. In the Seq logs search text box, enter *Applying coupon DISC-5* and press <kbd>Enter</kbd>.

    The logs are filtered to display the following entry:

    :::image type="content" source="../media/5-deploy-github-action/seq-logs.png" alt-text="A screen capture of the Seq log output" border="true" lightbox="../media/5-deploy-github-action/seq-logs.png":::

## Roll back the deployment

During production issues, one common mitigation is to revert a deployment to a known good deployment. Use the following command to roll back from version 1.1.0 to 1.0.0.

```bash
helm rollback eshoplearn-coupon
```

The deployment history confirms that everything is back to normal:

```console
Rollback was a success! Happy Helming!
```

> [!NOTE]
> In a real-life scenario, you'll have multiple environments to which the build's artifacts can be deployed. For example, you might have development, testing, and staging environments. The deployment workflows can be triggered by events like merging PRs. Quality or approval gates, such as a stakeholder's PR approval, can be added to prevent unexpected deployments to production.

In this unit, you created a GitHub Action to deploy the coupon service to AKS. To test the deployment workflow, you incremented the coupon service version in its Helm chart. Upon completion of the deployment workflow run, you searched the Seq logs to confirm the discount code redemption message was present. Finally, you reverted the coupon service in AKS to version 1.0.0.
