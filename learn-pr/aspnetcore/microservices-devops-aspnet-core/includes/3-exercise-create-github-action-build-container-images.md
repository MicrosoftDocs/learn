In this unit, you'll complete the following tasks:

- Create a GitHub action to implement a build pipeline.
- Modify the coupon service code to trigger the build workflow.
- Monitor the build workflow's progress in real time.

## Create the build action

 The YAML code in this procedure defines a GitHub action that:

- Triggers when a commit is pushed to the coupon service's source code or unit tests in the `main` branch.
- Defines step-specific environment variables.
- Has one *job*, or set of steps that execute on the same workflow runner, named `Build and push image to ACR`.

> [!IMPORTANT]
> Trigger conditions and other artifacts of GitHub Actions or workflows depend on the apps and environments. For ease of understanding, details are kept simple in this example. Both the build and the deploy workflows are scoped to product service changes because all the microservices are kept under a single repository. In an actual production scenario, each microservice would be kept in their own separate repository.

Complete the following steps to create the GitHub Actions build action:

1. Go to your forked repository in [GitHub](https://github.com), select the **:::no-loc text="Actions":::** tab.
1. On the **:::no-loc text="Get started with GitHub Actions":::** page, select the **:::no-loc text="set up a workflow yourself":::** link.

    :::image type="content" source="../media/3-set-up-custom-github-workflow.png" alt-text="Screenshot that shows the Actions tab in the GitHub repository, highlighting the workflow creation link." lightbox="../media/3-set-up-custom-github-workflow.png":::

1. On the next page, paste the following YAML code into the editor.

    ```yaml
    name: Build and deploy an app to AKS
    
    on:
      push:
        branches: ["main"]
      workflow_dispatch:
    
    env:
      # Local environment variables used later in the workflow
      AZURE_CONTAINER_REGISTRY: 'name of your Azure Container Registry'
      CONTAINER_NAME: 'productservice'
      RESOURCE_GROUP: 'rg-eshop'
      CLUSTER_NAME: 'aks-eshop'
      DEPLOYMENT_MANIFEST_PATH: './product.yml'
      DOCKER_PATH: './DockerfileProducts'
    
    jobs:
      buildImage:
        permissions:
          contents: read
          id-token: write
        runs-on: ubuntu-latest
        steps:
          # Checks out the repository this file is in
          - uses: actions/checkout@v3
    
          # Logs in with your Azure credentials stored in GitHub secrets
          - name: Azure login
            uses: azure/login@v1.4.6
            with:
              creds: '${{ secrets.AZURE_CREDENTIALS }}'
    
          # Builds and pushes an image up to your Azure Container Registry
          - name: Build and push image to ACR
            run: |
              az acr build --file ${{ env.DOCKER_PATH }} --image ${{ env.AZURE_CONTAINER_REGISTRY }}.azurecr.io/${{ env.CONTAINER_NAME }}:${{ github.sha }} --registry ${{ env.AZURE_CONTAINER_REGISTRY }} -g ${{ env.RESOURCE_GROUP }} .
    
    ```

    Replace the **name of your Azure Container Registry** with the ACR name you created in the previous unit; for example, **acseshop186748394**.

1. Replace the default workflow **:::no-loc text="main.yml":::** file name with *:::no-loc text="azure-kubernetes-service.yml":::*, and then select **:::no-loc text="Commit changes":::**.

1. On the **:::no-loc text="Commit changes":::** screen, select **:::no-loc text="Commit directly to the main branch":::** and then select **:::no-loc text="Commit changes":::**.

    You've finished creating the build workflow for your CI/CD pipeline.

1. In your terminal, run this command to view the current versions of the product service stored in the ACR:

    ```bash
    az acr repository show-tags -n AZURE_CONTAINER_REGISTRY --repository productservice --orderby time_desc --output table
    ```

    Replacing the **AZURE_CONTAINER_REGISTRY** with the name of your ACR, you should see output similar to the following:

    ```bash
    Result
    ----------------------------------------
    v1
    ```

## Trigger the build

The build workflow triggers automatically as soon as you commit the workflow file. You can also trigger the build manually. 

1. In your repository, select the **:::no-loc text="Actions":::** tab. 
1. On the left, under **:::no-loc text="All workflows":::**, select the **:::no-loc text="Build and deploy an app to AKS":::** workflow, and then select **:::no-loc text="Run workflow":::**.

## Monitor the build

To view the real-time progress of the build:

1. In your repository, select the **:::no-loc text="Actions":::** tab.
1. Select the most recent workflow run listed for the **:::no-loc text="Build and deploy an app to AKS":::** workflow. The name of the run is the commit message you used in the previous step.

1. Select the **:::no-loc text="buildImage":::** job.

    :::image type="content" source="../media/3-github-workflow.png" alt-text="Screenshot showing a GitHub workflow in progress." lightbox="../media/3-github-workflow.png" border="true":::

1. If you wait a few minutes, the steps in the job should complete successfully. 
1. In your terminal, run this command again to view the versions of the product service stored in the ACR.

    ```bash
    az acr repository show-tags -n AZURE_CONTAINER_REGISTRY --repository productservice --orderby time_desc --output table
    ```

    You should see output similar to the following, that shows a new image version has been added to the ACR from the GitHub workflow:

    ```bash
    Result
    ----------------------------------------
    8c75edb7a349ec570bd4eac397015bc3c547186e
    v1
    ```
