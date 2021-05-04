With a good understanding of the concepts behind CI and CD, let's plan our pipeline based on the needs of our project.

To support a CI pipeline, Contoso wants a website to be published in AKS after a successful tagged push to the main branch. This design makes it easier to check the version of each deployment that went to production. You use tags for routing when you push container images to an image registry.

The project leads also want to test the website in a staging environment at every successful push to the main branch, regardless of whether the push is tagged. Let's design this pipeline.

## Design the pipeline

To begin designing the pipeline, think about tasks and triggers. Ask the question, "What will trigger this pipeline?" In our case, the pipeline is triggered by two different events:

- A tagged push to the main branch
- A non-tagged push to the main branch

Even though it might seem redundant, we need to split those two events into two separate triggers. We could say that in one trigger, the pipeline is triggered by a tagged *or* a non-tagged push to main. But if we used this design, our pipeline wouldn't differentiate a tagged push from a non-tagged push. The goal is to have two separate triggers. One of the triggers deploys the application to production and the other trigger deploys to the staging environment.

At this point, here's what our pipeline looks like:

:::image type="content" source="../media/3-pipeline-1-trigger.png" alt-text="Diagram that shows two types of pipeline triggers.":::

After the triggers are defined, we need to think about the pipeline flow itself to answer the question, "What will happen after one of the triggers is executed?" Generally, the first steps are the same for both triggers.

### Clone the repo

The website must be a Docker image to run in the AKS environment. That means that we'll probably need to build the new image by using a Dockerfile that's present in the root of the repository.

The first step after creating the trigger is to clone the repository, so we have all the files to work with:

:::image type="content" source="../media/3-pipeline-2-build.png" alt-text="Diagram that shows the procession from triggers to the first build step in a pipeline.":::

We'll call these first steps the *build steps* because we have to prepare some configuration and build the image before we push it to the AKS instance. The build part is where we set up all the information that's needed for the deploy step.

The next logical step is to build an image by using a Dockerfile that's in the root of the repository. But here's where the triggers become different.

### Build the image

If the pipeline is triggered by the *tagged* commit, we'll build the image and tag it by using the *same tag as the push*. For example, if the commit is tagged with `v1.0.0`, we'll build the image `contoso/website:v1.0.0`.

Otherwise, if we have a commit that isn't a tagged commit in the main branch, we'll build the image that has the `latest` tag.

:::image type="content" source="../media/3-pipeline-3-build-docker.png" alt-text="Diagram that shows the procession from triggers to the first and second build steps in a pipeline.":::

After the image is built, we need to push it to the Contoso Azure Container Registry instance, which the AKS cluster is set up to access. The cluster can download the images and run them via Container Registry.

### Push the image to a container registry

At this point, the pipeline converges into a single step. Because the Container Registry instance doesn't have internal divisions, we'll push both images to the same place.

:::image type="content" source="../media/3-pipeline-4-docker-push.png" alt-text="Diagram that shows the procession from triggers to the first, second, and third build steps in the pipeline.":::

### Deploy the application

For the *deploy steps*, the final step is to deploy the website to the correct location. 

If the tagged commit triggered the pipeline, we'll deploy the website to production, in the `production` namespace of the AKS cluster.

If the pipeline didn't trigger a tagged commit, we'll push to the `staging` namespace of the same cluster.

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Diagram that shows the procession from triggers, through three build steps, to the deploy steps in a pipeline.":::

Now, we've summarized all the tasks we have to execute to successfully deploy the website to the correct environments. The next step is to create the deploy environment.
