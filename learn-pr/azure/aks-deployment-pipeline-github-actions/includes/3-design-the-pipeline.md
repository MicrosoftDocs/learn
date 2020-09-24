Now that we know all the concepts behind CI and CD, let's plan and build our pipeline according to the company's needs.

Contoso wants to have a website published in AKS after any successful tagged push to the `main` branch. It makes easier to check the version of each deployment that went to production. Along with that rule, the project leads want to test the website in a staging environment at every successful push to the `main` branch, tagged or not. Let's design this pipeline.

## Design the pipeline

To start designing the pipeline, we need to think about tasks and triggers. The first part of designing any CI pipeline is about the question "what will trigger this pipeline?". In our case, this pipeline will be triggered by two different events:

1. A tagged push to the `main` branch
1. A non-tagged push to the `main` branch

Notice that, even though it might seem redundant, we need to split those two events in two separate triggers. We could say "this pipeline is triggered by a tagged **or** non-tagged push to `main`", however, if we did this thinking, our pipeline wouldn't differentiate one from the other, and that's not what we want. The goal is to have two separate triggers, one of them is going to deploy the application to production, and the other is going to deploy to the staging environment.

As for now, our pipeline looks like this:

:::image type="content" source="../media/3-pipeline-1-trigger.png" alt-text="Pipeline Triggers":::

After the triggers have been defined, we need to think in the pipeline flow itself. The answer to the question "what will happen after one of the triggers is executed?". Generally, the first steps are the same for both triggers.

The website must be a Docker image to run in the AKS environment. This means we'll probably need to build this new image following a Dockerfile present in the root of the repository.

So, the first step after the trigger is to clone the repository so we can have all the files within our grasp:

:::image type="content" source="../media/3-pipeline-2-build.png" alt-text="Build steps of the pipeline":::

We'll call these first steps the "__Build Steps__". That is because we'll have to prepare some configuration and build the image before pushing it to the AKS instance. So the build part is where we set up all the information needed for the deploy step.

As we mentioned, we'll probably have a Docker image that's going to be built using a Dockerfile present in the root of the repository. The next logical step is to build this image. But here's where the triggers start being different.

If the pipeline is triggered by the __tagged__ commit, then we'll build the image and tag it with __the same tag as the push__. Which means that, if the commit was tagged with `v1.0.0`, we'll build the image `contoso/website:v1.0.0`.

Otherwise, if this isn't a tagged commit in the `main` branch, we'll build the image with the `latest` tag.

:::image type="content" source="../media/3-pipeline-3-build-docker.png" alt-text="Adjust the Docker build for each trigger":::

After the image is built, we need to push it to Contoso's ACR (Azure Container Registry), which the AKS cluster is set up to access. This way the cluster can download the images and run them.

This is where the pipeline converges into one single step. Because the ACR doesn't have internal divisions, and we'll push both images to the same place.

:::image type="content" source="../media/3-pipeline-4-docker-push.png" alt-text="Push the image to the ACR":::

The final step is to deploy the website to the right location, those are the "__Deploy Steps__". If the pipeline was triggered by the tagged commit, we'll then deploy the website to production, in the `production` namespace of the AKS cluster.

If the pipeline didn't trigger by a tagged commit, then we'll push to the `staging` namespace of the same cluster.

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Deploy to the right environment":::

This summarizes all the tasks we have to execute to successfully deploy the website to the right environments. The next step is to create the environment on which we're going to deploy this pipeline and application.
