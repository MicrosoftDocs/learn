The release pipeline provided with your project is designed to build the solution as a Docker container and deploy it to Azure App Service. To support the deployment of multiple containers to a Kubernetes cluster, you will need to modify this pipeline.

In this unit, you'll learn how to:

> [!div class="checklist"]
> * Update the pipeline to trigger on a commit to the main branch.
> * Define variables to be shared across the pipeline.
> * Build and publish Docker images.
> * Publish Kubernetes manifests.
> * Add a task to create an image pull secret for use between your Kubernetes and container registry instances.
> * Deploy updated images to a Kubernetes cluster.

## Update the pipeline to support triggers

1. Log in to your Azure DevOps organization, and then navigate to your project.
1. Select **Pipelines**, and then select your pipeline.
1. Select **Edit** to edit your *azure-pipelines.yml*.

    **Andy:** This was the build stage we had in place for the previous single-container solution. I knew it wasn't going to run properly, so I disabled it. We can start off by re-enabling triggers on commits to the `main` branch.

1. Replace the existing `trigger` line at the top of the file with the snippet below. This will trigger a pipeline run every time a commit is made to the main branch.

    [!code-yml[](code/4-1-azure-pipelines.yml)]

## Define variables accessible across pipeline

**Andy:** We're going to need to add two pipeline variables. One for specifying the name of the leaderboard repository, which is "leaderboard". The other is for the name of the image pull secret used for sharing between AKS and ACR instances during deployment.

1. Add the highlighted code below to the `variables` section.

    [!code-yml[](code/4-2-azure-pipelines.yml?highlight=3,6)]

## Build and publish Docker image to Azure Container Registry

**Andy:** We already have a task for building the web app as a Docker container, which we publish to our container registry. We can just use a second task to do the same for our leaderboard.

1. Add a second `Docker@2` task to build and publish the leaderboard container using the highlighted snippet below. Add this task right after the web container task.

    [!code-yml[](code/4-3-azure-pipelines.yml?highlight=12-21)]

> [!TIP]
> Make sure that the task you add here uses consistent indentation with the previous task as whitespace is important in a YAML file.

## Publish the Kubernetes manifests

**Andy:** I think we can move on to the next stage. Do you see anything missing?

**Mara:** You mentioned that there were some manifest files in the source project that define the deployment, and services Kubernetes will need when we deploy. We should publish those before we finish this stage.

**Andy:** Do we need to? Won't they still be on the local disk?

**Mara:** They would be if we were adding the deployment tasks within the same stage as the build. However, since our deployment tasks happen in their own *Deploy* stage, it will run on a completely fresh environment, probably even on a different agent. We should be sure to publish anything this stage produces that the other stage will need.

**Andy:** That's a great point. Is it easy to do? We just need to ensure the *manifests* folder is copied to the new agent.

**Mara**: That's what the `PublishBuildArtifacts@1` task is for. It's so common that there's even a shorthand for it, `publish`.

1. Add a `publish` task that stores the *manifests* folder for a future stage as shown in the following code snippet. Make sure that the indentation of this task matches that of the previous task.

    [!code-yml[](code/4-4-azure-pipelines.yml?highlight=12-13)]

## Replace the deploy stage

**Mara:** I'm going to replace our existing **Deploy** stage with one that uses a deployment job. A *deployment job* is a special kind of job that allows us to associate our deployment with the Azure DevOps environment created earlier. This will make it easier to track deployment history, which will be especially useful as our solutions get more sophisticated.

1. Remove the existing **Deploy** stage (everything after the build stage) and replace it with the snippet below. Take note of the highlighted line which indicates the deployment environment to be utilized.

    [!code-yml[](code/4-5-azure-pipelines.yml?highlight=9)]

    **Mara:** The first step we'll add in the deployment stage is to download the manifest artifacts published earlier using the `DownloadBuildArtifacts@0` task.

    **Andy:** Let me guess, is there a `download` shorthand for that task?

    **Mara:** Exactly correct! We can use the `current` specifier to indicate that we want the artifact from the current run of the pipeline.

1. Add the highlighted lines as the first step of the **Deploy** stage.

    [!code-yml[](code/4-6-azure-pipelines.yml?highlight=16-17)]

    **Andy:** Now we need to create an image pull secret that will be shared between our ACR and AKS instances. Do you know if there's a task we can use?

    **Mara:** I was just looking that up, and we're in luck. The `KubernetesManifest@0` task supports an action to create the secret needed.

### Kubernetes manifest task

The [Kubernetes manifest task](/azure/devops/pipelines/tasks/reference/kubernetes-manifest-v1?azure-portal=true) is designed to manage all of the mainstream deployment operations required for Kubernetes. It supports multiple `action` options that range from creating secrets to deploying images. In this case, the `createSecret` action will be used, along with the additional parameters defined as follows:

* `action` indicates the feature to run. In this case, `createSecret` creates the shared secret.
* `connectionType` specifies the type of service connection to use. Options: *azureResourceManager* or *kubernetesServiceConnection*.
* `secretName` specifies the name of the secret to create.
* `dockerRegistryEndpoint` specifies the name of the Azure Container Registry Services connection.
* `azureSubscriptionConnection` specifies the name of the ARM Services connection.
* `azureResourceGroup` specifies the name of your resource group.
* `kubernetesCluster` specifies the name of your AKS cluster.
* `namespace` specifies the Kubernetes namespace this action applies to.

1. Add the following snippet to the end of your pipeline. Make sure that both the resource group name and the cluster name match the names of the ones you created earlier. Ensure that the indentation of this task matches that of the *download* task.

    [!code-yml[](code/4-7-azure-pipelines.yml)]

    **Andy:** The final step is to trigger the deployment of our images to the Kubernetes cluster. Based on the documentation, it looks like we can use the same task but with a different action and parameters.

    * `action` indicates the feature to run. In this case, `deploy` to deploy to AKS cluster.
    * `connectionType` specifies the type of service connection to use. Options: *azureResourceManager* or *kubernetesServiceConnection*.
    * `azureSubscriptionConnection` specifies the name of the ARM Services connection.
    * `azureResourceGroup` specifies the name of your resource group.
    * `kubernetesCluster` specifies the name of your AKS cluster.
	* `namespace` specifies the Kubernetes namespace this action applies to.
	* `imagePullSecrets` specifies the list of secrets needed to pull from the container registry.
	* `containers` specifies the list of container images to deploy.

1. Add the following snippet to the end of the pipeline. Make sure that both the resource group name and the cluster name match the names of the ones you created earlier. Ensure that the indentation of this task matches that of the previous task.

	[!code-yml[](code/4-8-azure-pipelines.yml)]

## Run your pipeline

1. Select **Save** from the upper-right corner of the page. Select **Save** to confirm your commit message.
1. Select **Run**, confirm your branch name and then select **Run** to trigger a pipeline run.
1. Select **Pipelines**, and then select your pipeline to view the logs as your pipeline runs.
1. Once the pipeline run is complete, select **Environments** from the left pane, and then select the **Dev** environment to view your deployment jobs.
1. Now let's go check out our deployed web app and API endpoint. To do so, we will need to get the external IP addresses for both the *web* and *leaderboard* services.
1. Navigate to Azure portal, select your AKS cluster, and then select **Services and ingresses**.

    :::image type="content" source="../media/aks-external-ip.png" alt-text="Screenshot of how to find the external IPs for your web and leaderboard services.":::

1. Select the **External IP** for your *web* service to view your site on AKS.

    :::image type="content" source="../media/4-space-game.png" alt-text="Screenshot of the Space Game web site.":::

1. Go back to your Azure portal window where you left off and then copy the **External IP** for your **leaderboard** service. This IP address is where the leaderboard API is publicly hosted.
1. Replace the placeholder in the link below with the external IP you just copied. You can also add a `pageSize=10` query parameter to make it easier to view the JSON response in your browser. Use a URL like the one below in a new browser tab.

    ```
    http://[IP]/api/Leaderboard?pageSize=10
    ```

1. You can view the raw JSON response from the leaderboard API hosted in your AKS cluster. You now have a REST API that you can call from other applications.

    :::image type="content" source="../media/4-leaderboard-api.png" alt-text="Screenshot of a web browser showing the JSON response from the leaderboard service.":::

**Andy:** This turned out great! I think using Kubernetes would be a great way for us to adopt a broader microservices strategy.