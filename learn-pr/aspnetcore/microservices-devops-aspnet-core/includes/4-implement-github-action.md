In this exercise, you'll implement and test a simple CI/CD pipeline by doing the following:

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
    az ad sp create-for-rbac --sdk-auth
    ```

    A variation of the following output appears:

    <!--TODO: replace image with a JSON block-->
    ![Output from the script in json format](media/create-sp.png)

Copy the whole json output because you'll need this and the credentials for the GitHub Action in next step.

1. Add action secrets to your GitHub repository:

In the GitHub repository you just forked, go to **Settings** > **Secrets** and add the following secrets:

- **AZURE_CREDENTIALS**: Copy paste the output from the previous step.

At this point you should have something like this:

![Image description follows in text](media/add-github-secrets.png)

In the preceding image, you can see that secret named **AZURE_CREDENTIALS** was created. The value is the JSON output from the `az ad sp create-for-rbac` command.

- **REGISTRY_USERNAME**: The user name to access your Azure Registry Container (use **ESHOP_ACRUSER**'s value).

- **REGISTRY_PASSWORD**: The password to access your Azure Registry Container (use **ESHOP_ACRPASSWORD**'s value).

## Create a GitHub Action to implement a CI/CD pipeline

### 1. Disable GitHub actions in your repo

The GitHub action you're about to create will be saved to your your repo and will trigger once you save it by pushing to the **develop** branch. To avoid this, you'll begin by disabling actions temporarily.

Go to the Settings tab in your repo and disable Actions, as shown in the next image.

![View for the Settings > Action permissions, with the Disable Actions option selected.](media/disable-actions.png)

### 2. Create a custom action

Click on the Actions tab in your repository and then click on the "**set up a workflow yourself**" link:

![View for the Actions tab in the GitHub repo, highlighting the link "set up an workflow yourself".](media/set-upg-custom-github-workflow.png)

### 3. Add the action specification

The spec is already included in this document and needs some customization but we'll review it before continuing. It's relatively easy to understand, but we include a general description here, before getting to the actual yaml file:

- It's triggered when a commit is pushed to the **develop** branch.

- Defines several variables that are used by the tasks below, there are a few that you have to set before the action can be run:
  - **CONTEXT_PATH** (use the relative path to the solution folder, use "." if it's the same)
  - **YOUR_CLUSTER_NAME** (use **ESHOP_AKSNAME**'s value)
  - **YOUR_RESOURCE_GROUP_NAME** (use **ESHOP_RG**'s value)
  - **YOUR_CLUSTER_IP** (use **ESHOP_LBIP**'s value)
  - **REGISTRY_LOGIN_SERVER** (use **ESHOP_REGISTRY**'s value)

- It has two jobs
  - **build-and-push-docker-image** that builds the image a pushes it to the ACR.
  - **deploy-to-aks** that upgrades the helm chart, so the new image is deployed.

- The **build-and-push-docker-image** job runs in an **ubuntu-latest** agent and has two steps:
  - **Get code from the repo** that checks out the develop branch and
  - **Build and push Docker images** that builds the image a pushes it to the ACR.
  - **NOTE**: Both of the above steps are standard tasks, taken from [GitHub Action's markeplace](https://github.com/marketplace?type=actions).

- The **deploy-to-aks** job depends on the **build-and-push-docker-image**, runs in **ubuntu-latest** agent, and has five steps:
  - **Azure Kubernetes set context** that sets the AKS credentials in the agent's `.kube/config` file,
  - **Get code from the repo** that checks out the code from the repo,
  - **Helm tool installer** that installs Helm,
  - **Azure Login** that logs in to Azure using the Service Principal's, and
  - **Deploy** that upgrades the chart. There are a few important comments about this one:
    - It's a custom step that runs a script
    - Passes the ACR as the **registry** parameter to Helm, so this particular image is deployed to AKS from your ACR, instead of the initial deployment repository.

You can see the yaml file details next:

```yml
name: eShop build & deploy

on:
  push:
    branches: [ develop ]

env:
  IMAGE_NAME: webspa
  TAG: linux-latest
  CONTEXT_PATH: .
  DOCKER_FILE_PATH: src/Web/WebSPA/Dockerfile
  CHART_PATH: deploy/k8s/helm-simple/webspa
  CLUSTER_NAME: YOUR_CLUSTER_NAME
  CLUSTER_RESOURCE_GROUP: YOUR_RESOURCE_GROUP_NAME
  REGISTRY_LOGIN_SERVER: YOUR_ACR_LOGIN_SERVER
  IP_ADDRESS: YOUR_CLUSTER_IP

jobs:
  build-and-push-docker-image:
    runs-on: ubuntu-latest
    steps:

    - name: Get code from the repo
      uses: actions/checkout@v1
      with:
        ref: develop

    - name: Build and push Docker images
      uses: docker/build-push-action@v1.1.0
      with:
        username: ${{ secrets.REGISTRY_USERNAME }}
        password:  ${{ secrets.REGISTRY_PASSWORD }}
        registry: ${{ env.REGISTRY_LOGIN_SERVER }}
        path:  ${{ env.CONTEXT_PATH }}
        dockerfile: ${{ format('{0}/{1}', env.CONTEXT_PATH , env.DOCKER_FILE_PATH ) }}
        repository:  ${{ env.IMAGE_NAME }}
        tags: ${{ env.TAG }}
        push: true

  deploy-to-aks:
    needs: [build-and-push-docker-image]
    runs-on: ubuntu-latest
    steps:
    - name: Azure Kubernetes set context
      uses: Azure/aks-set-context@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}
        resource-group: ${{env.CLUSTER_RESOURCE_GROUP}}
        cluster-name: ${{env.CLUSTER_NAME}}

    - name: Get code from the repo
      uses: actions/checkout@v1
      with:
        ref: develop

    - name: Helm tool installer
      uses: Azure/setup-helm@v1

    - name: Azure Login
      uses: Azure/login@v1.1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}

    - name: Deploy
      run: |
        helm upgrade --install eshoplearn-webspa --namespace=default --set registry=${{ env.REGISTRY_LOGIN_SERVER }} --set imagePullPolicy=Always --set host=${{env.IP_ADDRESS}} --set protocol=http ${{ format('{0}/{1}', env.CONTEXT_PATH , env.CHART_PATH ) }}
```

Now copy the above yaml content and paste it into the edit view to move to the next step.

## Configure the Action

### 1. Set the environment variables for the Action

Configure the following values in the action yaml editor view:

- Action name: **build-and-deploy.yaml**
- env:
  - CONTEXT_PATH: (you might probably need to update this one to ".")
  - CLUSTER_NAME: use the **ESHOP_AKSNAME**'s value you got when creating the ACR
  - CLUSTER_RESOURCE_GROUP: use **ESHOP_RG**'s value
  - REGISTRY_LOGIN_SERVER: use **ESHOP_REGISTRY**'s value
  - IP_ADDRESS: use **ESHOP_LBIP**'s value

At this point you should see something like this:

![Image description follows in text.](media/configure-github-action.png)

In the preceding image you can see the content of the `build-and-deploy.yaml` file, with the mentioned environment variables set.

To save the file click on the **Start commit** button

This will create a in the commit in the repo, and you can do it directly to **develop**, as shown next:

![Commit confirmation popup view, with option "Commit directly to the develop branch" option selected.](media/commit-action-to-develop.png)

This GitHub Action definition will be part of the repo from now on. If you want to make any change, you'll just have to update the file locally and push to **develop** or create a pull request (PR). If you create a PR, the Action will be triggered when merging to **develop**.

### 2. Enable Actions for your repository

Now you have to enable back Actions in your repo, from the **Settings** tab, as shown in the next image.

![View for the Settings > Action permissions, with the "Enable local and third party Actions..." option selected.](media/enabling-actions.png)

The updated action will the be triggered next time a commit is pushed to **develop**. From now on, unless you disable Actions in your repo, the CI/CD pipeline you just created will be run automatically every time the develop branch is updated.

## Modify the SPA microservice

So you've just finished creating your first CI/CD pipeline and someone from the marketing department wants to start a campaign for the new discount coupon feature, so the customers can get whatever discount they want, if they just guess the correct codes and nobody has used them before (Somehow they think this is a good idea 😂)

Since you can guess this won't last too long, that is, this is just a proof-of-concept (POC), you're doing the minimum possible changes, right in the **develop** branch:

### 1. Add a call out in the home page

Update the `src/Web/WebSPA/Client/src/modules/app.component.html` (line 4) like this:

```html
<header class="esh-app-header" [ngClass]="{'esh-app-header':true, 'esh-app-header--expanded': router.url === '/catalog'}">
    <div class="esh-app-header-promo">
        <span class="esh-app-header-promo-title">All T-SHIRTS</span>
        <span class="esh-app-header-promo-subtitle">On sale this weekend -
            Use the new DISCOUNT-COUPON on checkout and pay whatever you want!</span>
    </div>
    <div class="container">
        ...
    </div>
</header>

<!-- component routing placeholder -->
<router-outlet></router-outlet>

<footer class="esh-app-footer">
    ...
</footer>

```

### 2. Update the discount coupon label in the checkout view

Update the `src/Web/WebSPA/Client/src/modules/orders/orders-new/orders-new.component.html` file (line 95) as shown next:

```html
<div class="container">
    ...
    <form [formGroup]="newOrderForm" (ngSubmit)="submitForm(newOrderForm.value)">
        <section class="u-background-brightest p-5">
            <h2 class="mb-4">Shipping Address</h2>
            ...
            <h2 class="mt-5 mb-4">Payment method</h2>
            ...
            <h2 class="mt-5 mb-4">Order details</h2>
            ...
            <div class="d-flex flex-nowrap justify-content-between align-items-center mb-3 mt-3">
                <div>
                    <div *ngIf="!coupon">
                        <div class="u-text-uppercase">Have a discount code? (DISC-##, up to 30)</div>
                        ...
                    </div>
                </div>
                ...
            </div>

            ...
        </section>
    </form>
</div>
```

### 3. Update the discount code validation message

Update the `src/Web/WebSPA/Client/src/modules/orders/orders-new/orders-new.component.ts` file (line 60), like this:

```ts
import { Component, OnInit } from '@angular/core';
...
@Component({
    selector: 'esh-orders_new .esh-orders_new .mb-5',
    styleUrls: ['./orders-new.component.scss'],
    templateUrl: './orders-new.component.html'
})
export class OrdersNewComponent implements OnInit {
    ...
    checkValidationCoupon(discountCode: string) {
        this.couponValidationMessage = null;
        this.coupon = null;
        this.orderService
            .checkValidationCoupon(discountCode)
            .subscribe(
                coupon => this.coupon = coupon,
                error => this.couponValidationMessage = 'But only some are valid... until used 😉!' );
    }
    ...
}

```

### 4. Update the SPA version in the Helm chart

> **NOTE**
>
> It's important that you update the app version in the Helm chart, so that the pod is replaced when the chart is deployed to AKS with `helm upgrade`.

Update the version to **1.1.0** in the chart, file `deploy/k8s/helm-simple/webspa/Chart.yaml` (line 21) as shown next:

```yaml
apiVersion: v2
name: webspa
description: A Helm chart for Kubernetes
...
# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application.
appVersion: 1.1.0
```

### 5. Save your changes

Just commit and push to develop.

Since we are committing to **develop**, the action will run immediately and the app should be deployed after a few minutes.

## Wait for deployment

If you click in the **Actions** tab in your repo, you should be able to monitor the progress, as shown in the next image.

![Image description follows in text.](media/monitor-github-action-progress.png)

In the preceding image you can see the "Build and push Docker images" step running and the log output.

If you monitor your pods using the command `kubectl get pods -w` you should see something like this:

![Image description follows in text.](media/replacing-pods.png)

In the preceding image you can see that a new `webspa` pod is created while the old one is still running and when the new one is ready the old one is terminated. This should make the transition to the new version as smooth as possible.

You can also check the `webspa` microservice deployment history, with the command `helm history eshoplearn-webspa` to get something like this:

![Helm deployment history for eshoplearn-webspa, showing app version 1.1.0 is deployed.](media/deployment-history.png)

At this point you just have to refresh the browser to see the changes, as shown in the next image.

![WebSPA home page view, showing the "promotion message".](media/changes-deployed.png)

## Rollback a deployment

Once the deployment is completed and customer feedback starts coming in, you receive a "visit" from the Marketing head... and after a very short "conversation" you are "requested" to fix the issue because "the experiment" didn't go well enough, so you just run the following command:

```bash
helm rollback eshoplearn-webspa
```

Checking the deployment history again you know that everything is back to normal 😅:

![Helm deployment history for eshoplearn-webspa, showing app version 1.0.0 is now deployed.](media/deployment-rollback.png)

> **NOTE**
>
> In a real-life scenario you'd include at least one tests step and separate the build (CI) and the deploy (CD) pipelines. You'd usually have multiple environments where each build could be deployed (for example, dev, test, staging). Also the deployment jobs would usually be triggered by different events, typically requiring some sort of approval so you don't get surprises in production.
>
> You'd usually also have the pipeline triggered on each PR, to make sure the PR builds correctly and tests run successfully, before reviewing the PR.

For further information, see the [GitHub Action documentation site](https://help.github.com/actions).
