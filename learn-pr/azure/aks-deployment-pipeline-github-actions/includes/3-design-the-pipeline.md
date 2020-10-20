Now that we know all the concepts behind CI and CD, let's plan and then build our pipeline based on our project's needs.

Contoso wants to have a website published in AKS after a successful tagged push to the main branch. This design makes it easier to check the version of each deployment that went to production. Along with that rule, the project leads want to test the website in a staging environment at every successful push to the main branch, tagged or not. Let's design this pipeline.

## Design the pipeline

To begin designing the pipeline, think about tasks and triggers, and ask the question, "What will trigger this pipeline?" In our case, this pipeline is triggered by two different events:

- A tagged push to the main branch
- A non-tagged push to the main branch

Even though it might seem redundant, we need to split those two events into two separate triggers. We could say, in one trigger, that the pipeline is triggered by a tagged *or* a non-tagged push to main. But if we used this design, our pipeline wouldn't differentiate a tagged push from a non-tagged push. The goal is to have two separate triggers. One of the triggers deploys the application to production, and the other trigger deploys to the staging environment.

At this point, here's what our pipeline looks like:

:::image type="content" source="../media/3-pipeline-1-trigger.png" alt-text="Diagram that depicts two types of pipeline triggers.":::

After the triggers are defined, we need to think about the pipeline flow itself. That's the answer to the question, "What will happen after one of the triggers is executed?" Generally, the first steps are the same for both triggers.

## Clone the repo

The website must be a Docker image to run in the AKS environment. That means we'll probably need to build the new image by using a Dockerfile that's present in the root of the repository.

So, the first step after creating the trigger is to clone the repository, so we have all the files to work with:

:::image type="content" source="../media/3-pipeline-2-build.png" alt-text="Diagram that depicts the procession from triggers to the first build step in a pipeline.":::

We'll call these first steps the *build steps* because we have to prepare some configuration and build the image before we push it to the AKS instance. The build part is where we set up all the information that's needed for the deploy step.

As we mentioned, we'll probably have a Docker image that we'll build by using a Dockerfile that's in the root of the repository. The next logical step is to build this image. But here's where the triggers become different.

## Build the image

If the pipeline is triggered by the *tagged* commit, we'll build the image and tag it with the *same tag as the push*. For example, if the commit is tagged with `v1.0.0`, we'll build the image `contoso/website:v1.0.0`.

Otherwise, if we have a commit that isn't a tagged commit in the main branch, we'll build the image that has the `latest` tag.

:::image type="content" source="../media/3-pipeline-3-build-docker.png" alt-text="Diagram that depicts the procession from triggers to the first and second build steps in a pipeline.":::

After the image is built, we need to push it to the Contoso Azure Container Registry instance, which the AKS cluster is set up to access. This way, the cluster can download the images and run them.

## Push the image to a container registry

At this point, the pipeline converges into a single step. Because the Container Registry instance doesn't have internal divisions, we'll push both images to the same place.

:::image type="content" source="../media/3-pipeline-4-docker-push.png" alt-text="Diagram that depicts the procession from triggers to the first, second, and third build steps in the pipeline.":::

## Deploy the application

For the *deploy steps*, the final step is to deploy the website to the right location. 

If the tagged commit triggered the pipeline, we'll deploy the website to production, in the `production` namespace of the AKS cluster.

If the pipeline didn't trigger a tagged commit, we'll push to the `staging` namespace of the same cluster.

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Diagram that depicts the procession from triggers, through three build steps, to the deploy step in a pipeline.":::

Now, we've summarized all the tasks we have to execute to successfully deploy the website to the correct environments. The next step is to create the deploy environment.
