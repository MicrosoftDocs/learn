In this unit, you complete the following tasks:

- Create a GitHub action to implement a deployment pipeline.
- Increment the coupon service version in the Helm chart.
- Verify that the changes deploy to the Azure Kubernetes Service (AKS) cluster.
- Roll back the deployment.

## Create the deployment action

 The YAML code in this procedure defines a GitHub action that:

- Triggers when a commit is pushed to the coupon service's Helm chart in the `main` branch.
- Has one job, named `deploy-to-aks`, that deploys new images. The job runs the following steps in an `ubuntu-latest` runner:
  1. `Azure Login` signs in to Azure with the service principal credentials.
  1. `Azure Kubernetes set context` sets the Azure Kubernetes Service (AKS) credentials in the runner's *:::no-loc text=".kube/config":::* file.
  1. `Get code from the repository` checks out the code from the repository.
  1. `Helm tool installer` installs [Helm](https://helm.sh/), an open-source package manager for Kubernetes.
  1. `Deploy` executes the `helm upgrade` command, passing the Azure Container Registry instance name as the `registry` parameter. This parameter tells Helm to use your Container Registry instance rather than the public container registry.

Complete the following steps to create a GitHub action that deploys the coupon service:

1. In your forked repository, select the **:::no-loc text="Actions":::** tab.
1. In the left pane, select **:::no-loc text="New workflow":::**.
1. On the **:::no-loc text="Choose a workflow":::** page, select the **:::no-loc text="set up a workflow yourself":::** link.
1. On the next page, paste the following YAML code into the editor.

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
        - name: Azure Login
          uses: azure/login@v1.4.5
          with:
            creds: ${{ secrets.AZURE_CREDENTIALS }}
            
        - name: Azure Kubernetes set context
          uses: Azure/aks-set-context@v2
          with:
            resource-group: 'eshop-learn-rg'
            cluster-name: 'eshop-learn-aks'
    
        - name: Get code from the repository
          uses: actions/checkout@v3
          with:
            ref: main
    
        - name: Helm tool installer
          uses: Azure/setup-helm@v3.5
          
        - name: Deploy
          run: >
            helm upgrade 
            eshoplearn-coupon './deploy/k8s/helm-simple/coupon'
            --install
            --namespace=default 
            --set registry=${{ secrets.REGISTRY_LOGIN_SERVER }} 
            --set imagePullPolicy=Always 
            --set host=${{ secrets.IP_ADDRESS }} 
            --set protocol=http 
    
    ```

1. Replace the default workflow **:::no-loc text="main.yml":::** file name with *:::no-loc text="deploy.yml":::*, and then select **:::no-loc text="Commit changes":::**.

1. On the **:::no-loc text="Commit changes":::** screen, select **:::no-loc text="Commit directly to the main branch":::** and then select **:::no-loc text="Commit changes":::**.

Once you commit the workflows, you can find the *build.yml* and *deploy.yml* GitHub Actions definitions in the repository's *:::no-loc text=".github/workflows":::* directory. To make changes, you can update the appropriate file and push the changes to the `main` branch. Alternatively, you can create a pull request (PR). If you create a PR, the action triggers when the PR merges to the `main` branch.

## Trigger a deployment

To trigger a deployment, you increment the `appVersion` in the coupon service's Helm chart. Helm charts define service specifications in a YAML template format. It's important to increment the app version in the Helm chart to cause the pod to be replaced when you deploy the chart to AKS with `helm upgrade`.

1. From the **:::no-loc text="Code":::** tab in your forked repository, open the *:::no-loc text="deploy/k8s/helm-simple/coupon/Chart.yaml":::* file for editing, and update the `appVersion` property value to `1.1.0`:

   :::code language="yaml" source="../code/deploy/k8s/helm-simple/coupon/chart.yaml" highlight="8":::

1. Commit and push this change to the `main` branch. The deployment workflow triggers automatically, and the app deploys after a few minutes.

## Monitor the deployment

1. To monitor the deployment's progress, select the **:::no-loc text="Actions":::** tab.
1. Select the most recent workflow run listed for the **:::no-loc text="eShop deploy":::** workflow. The run's name is the commit message you used in the previous step.

   :::image type="content" source="../media/5-deploy-github-action/eshop-deploy-workflow.png" alt-text="Screenshot showing the eShop deploy workflow listed on the workflows page." lightbox="../media/5-deploy-github-action/eshop-deploy-workflow.png":::

1. Select the **:::no-loc text="deploy-to-aks":::** task to see details of the `deploy-to-aks` job for this workflow run. Between **:::no-loc text="Set up job":::** and **:::no-loc text="Complete job":::** are the custom steps that the `deploy-to-aks` job defines.

   :::image type="content" source="../media/5-deploy-github-action/deploy-to-aks-task.png" alt-text="Screenshot that shows the deploy-to-aks job selected with a list of all the steps completed." border="true" lightbox="../media/5-deploy-github-action/deploy-to-aks-task.png":::

1. In the terminal, run the following command to monitor the coupon service pods in your AKS cluster. The `--selector` flag filters the list to only pods for the coupon service, and the `--watch` flag instructs `kubectl` to watch for changes. 

    ```bash
    kubectl get pods --selector service=coupon --watch
   ```

   During the deployment, a variation of the following output appears:

   ```output
   NAME                           READY   STATUS              RESTARTS      AGE
   coupon-5b9597995-7s4hh         1/1     Running             1 (7h2m ago)  7h2m
   coupon-74fd48bbd-rqgfd         0/1     ContainerCreating   0             22s
   ```

   In the preceding output, notice that a new `coupon` pod is created. When the new pod is ready, the old one is terminated. This process makes the transition to the new version as smooth as possible.

1. Once the new pod's *:::no-loc text="Ready":::* status displays `1/1`, press **Ctrl+C** to stop the `kubectl` watch mode.

1. Run the following command to check the coupon service deployment history:

   ```bash
   helm history eshoplearn-coupon
    ```

   The history shows that the new coupon service version has been deployed.

   ```console
   REVISION   UPDATED                    STATUS        CHART          APP VERSION   DESCRIPTION
   1          Thu Sep 10 19:19:31 2020   superseded    coupon-0.1.0   1.0.0         Install complete
   2          Thu Sep 10 19:51:10 2020   deployed      coupon-0.1.0   1.1.0         Upgrade complete
   ```

1. Select the **:::no-loc text="Actions":::** tab again. When the deployment completes, you see a variation of the following screen:

   :::image type="content" source="../media/5-deploy-github-action/deployment-action-completed.png" alt-text="Screenshot that shows a list of three workflows." lightbox="../media/5-deploy-github-action/deployment-action-completed.png":::

## Verify the app

Complete the following steps to verify that your app still works:

1. Select the **:::no-loc text="Web SPA application":::** URL in *deployment-urls.txt* to launch the app.
1. Sign in from the **:::no-loc text="LOGIN":::** page.
1. Add your favorite products to the shopping bag by selecting the images.
1. Select the shopping bag icon in the upper right, and select **:::no-loc text="CHECKOUT":::**.
1. You can only use each discount code once, and you already used the 10 USD discount, so enter *:::no-loc text="DISC-5":::* in the **:::no-loc text="HAVE A DISCOUNT CODE?":::** text box for a five USD discount. Then select **:::no-loc text="APPLY":::**.
1. Select **:::no-loc text="PLACE ORDER":::** to complete the purchase.
1. In *deployment-urls.txt*, select the **:::no-loc text="Centralized logging":::** URL.
1. In the Seq logs search text box, enter *Get coupon DISC-5*.
 
   The logs filter to display the **Get coupon DISC-5** entry:

   :::image type="content" source="../media/5-deploy-github-action/seq-logs.png" alt-text="Screenshot that shows the Seq log output for the Get coupon DISC-5 entry." lightbox="../media/5-deploy-github-action/seq-logs.png":::

## Roll back the deployment

One common mitigation for production issues is to revert to a known good deployment. Use the following command to roll back from version 1.1.0 to 1.0.0.

```bash
helm rollback eshoplearn-coupon
```

The output message confirms that the rollback succeeded.

```output
Rollback was a success! Happy Helming!
```

> [!NOTE]
> In a real-life scenario, you deploy the build's artifacts to multiple environments. For example, you might have development, testing, and staging environments. You can trigger deployment workflows by events like merging PRs. You can add quality or approval gates, such as a stakeholder's PR approval, to prevent unexpected deployments to production.

In this unit, you created a GitHub action to deploy the coupon service to AKS. To test the deployment workflow, you incremented the coupon service version in its Helm chart. When the deployment workflow finished, you searched the Seq logs to confirm that the discount code redemption message was present. Finally, you rolled back the AKS coupon service to version 1.0.0.
