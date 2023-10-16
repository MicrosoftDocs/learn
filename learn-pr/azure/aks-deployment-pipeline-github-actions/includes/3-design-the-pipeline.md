With a good understanding of the concepts behind CI and CD, let's plan our pipeline to support the needs of our project.

Contoso wants a website to be published in AKS after each successful tagged push to the main branch. This design makes it easier to check the version of each deployment that went to production. You use tags for routing when you push container images to an image registry.

The project leads also wants to test the website in a staging environment at every successful push to the main branch, regardless of whether the push is tagged.

Let's design this pipeline.

## Design the pipeline

To begin designing the pipeline, think about the tasks and triggers. Ask the question, "What triggers this pipeline?". 

In our case, the pipeline needs to trigger on two different events:

- A tagged push to the main branch
- A non-tagged push to the main branch

These two events are split into two separate triggers. Otherwise, in a case where the pipeline triggers on both a tagged *or* a non-tagged push to main, our pipeline wouldn't differentiate between actions for a tagged push from a non-tagged push. Therefore, our goal requires two separate triggers. One for deployment to production and the other to the staging environment.

At this point, here's what our pipeline looks like:

:::image type="content" source="../media/3-pipeline-1-trigger.png" alt-text="Diagram that shows two types of pipeline triggers.":::

After the triggers are defined, we need to think about the pipeline flow itself to answer the question, "What happens after one of the triggers is executed?" Generally, the first steps are the same for both triggers.

### Step 1: Clone the repo

The website must be a Docker image in order to run in the AKS environment. So, we need to build the new image with a Dockerfile that's present in the root of the repository.

The first step after receiving the trigger signal is to clone the repository.

:::image type="content" source="../media/3-pipeline-2-build.png" alt-text="Diagram that shows the procession from triggers to the first build step in a pipeline.":::

These first steps are known as the *build steps* because we have to prepare a configuration and build the image before we push it to the AKS instance. The build step is where we set up all the information that's needed for the deploy step.

### Step 2: Build the image

The next logical step is to build an image by using a Dockerfile that's in the root of the repository. But here's where we account for different triggers.

For the *tagged* commit pipeline, we build the image and then tag it by using the *same tag as the push*. For example, if the commit is tagged with `v1.0.0`, we build the image as `contoso/website:v1.0.0`.

Otherwise, if we have a commit that isn't tagged in the main branch, we build the image with the `latest` tag.

:::image type="content" source="../media/3-pipeline-3-build-docker.png" alt-text="Diagram that shows the procession from triggers to the first and second build steps in a pipeline.":::


### Step 3: Push the image to a container registry

After the image is built, we push it to the Contoso Azure Container Registry instance, where AKS cluster is set up to access. There, the cluster downloads the images and runs them via Container Registry.

At this point, the pipeline converges into a single step. Because our Container Registry instance doesn't have internal divisions, we push both images to the same place.

:::image type="content" source="../media/3-pipeline-4-docker-push.png" alt-text="Diagram that shows the procession from triggers to the first, second, and third build steps in the pipeline.":::

### Step 4: Deploy the application

For the *deploy steps*, the final step is to deploy the website to the correct location. 

If the tagged commit triggered the pipeline, we deploy the website to production, in the `production` namespace of the AKS cluster. If the pipeline isn't triggered with a tagged commit, we push to the `staging` namespace of the same cluster.

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Diagram that shows the procession from triggers, through three build steps, to the deploy steps in a pipeline.":::

Now, we've summarized all the tasks to design the workflow pipeline. Next, let's set up our project environment and in other units create GitHub Actions to clone, build, push, and deploy on AKS clusters.
