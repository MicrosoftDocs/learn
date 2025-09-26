## Container Lifecycle

The standard Docker workflow involves these core operations:

**Docker build** - Creates an image by executing a Dockerfile that defines the container configuration and dependencies.

**Docker pull** - Downloads images from container registries like Docker Hub or Azure Container Registry.

**Docker run** - Instantiates and executes a container from an image, creating a running instance.

When executing `docker run`, Docker automatically pulls missing images from the registry before starting the container, eliminating the need for explicit pull commands in most scenarios.
