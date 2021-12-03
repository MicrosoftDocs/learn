## Container Lifecycle

The standard steps when working with containers are:

**Docker build** \- You create an image by executing a Dockerfile.

**Docker pull** \- You retrieve the image, likely from a container registry.

**Docker run** \- You execute the container. An instance is created of the image.

You can often execute docker run without needing first to do docker pull.

In that case, Docker will pull the image and then run it. Next time, it won't need to pull it again.
