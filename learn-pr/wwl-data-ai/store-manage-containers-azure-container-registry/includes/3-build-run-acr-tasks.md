ACR Tasks provide cloud-based container image building without requiring a local Docker installation. This capability addresses common challenges for AI development teams, including inconsistent builds across developer machines and the need for automated continuous integration. This unit covers quick tasks for on-demand builds, automatic triggers for continuous integration, and multi-step workflows for complex build scenarios.

## Understand ACR Tasks

ACR Tasks is a suite of features that offload container image builds to Azure. Instead of building images locally and pushing them to the registry, you send your source code to Azure Container Registry and let the cloud handle the build process. This approach provides several benefits for AI application development:

- **Consistent builds:** Eliminate "works on my machine" problems by building in a controlled cloud environment. Every build uses the same infrastructure regardless of which developer initiates it.
- **No local Docker required:** Build images from source code without installing Docker on developer workstations. This simplifies development setup and enables builds from environments where Docker isn't available.
- **CI/CD integration:** Trigger builds automatically from source code commits or base image updates. ACR Tasks integrates with GitHub and Azure DevOps for automated pipelines.
- **Multi-platform support:** Build images for Linux and Windows, including ARM processor architectures (such as ARM64) for edge AI deployments. ACR handles cross-platform builds without requiring you to maintain different build environments.

ACR Tasks supports three main scenarios: quick tasks for on-demand builds, automatically triggered tasks for continuous integration, and multi-step tasks for complex workflows.

## Quick tasks for on-demand builds

Quick tasks provide the fastest way to build and push a single container image. The `az acr build` command sends your source code context to ACR, builds the image in the cloud, and pushes it to your registry. The process mirrors running `docker build` followed by `docker push`, but everything happens in Azure.

The following command builds an image from a local Dockerfile and pushes it to the registry:

```azurecli
az acr build --registry myregistry --image inference-api:v1.0.0 .
```

The command accepts a build context, which is the location of your source files. ACR uploads the context, runs the Docker build using your Dockerfile, and pushes the resulting image. The period (`.`) at the end specifies the current directory as the build context.

### Context locations

The build context determines where ACR retrieves your source files. Choosing the right context location affects your workflow efficiency and integration with existing tools. ACR Tasks accepts build contexts from multiple locations:

- **Local directory:** Files on your local file system. ACR compresses and uploads the directory contents.
- **Git repository:** Public or private GitHub or Azure DevOps repositories. Specify the repository URL directly.
- **Remote tarball:** Compressed archives on a remote web server accessible via URL.

Building from a Git repository enables builds without cloning the repository locally:

```azurecli
az acr build --registry myregistry \
  --image inference-api:v1.0.0 \
  https://github.com/myorg/inference-api.git
```

### When to use quick tasks

Quick tasks work best when you need immediate, one-time builds without setting up persistent automation. They bridge the gap between local development and full CI/CD pipelines. Quick tasks are ideal for:

- Validating Dockerfile changes before committing to source control
- Building images during development without installing Docker locally
- One-off builds in CI/CD pipelines where you need a simple build step
- Testing new base images or dependency updates

## Automatically triggered tasks

ACR Tasks support automatic triggers that rebuild images when conditions change. These triggers enable continuous integration workflows where images stay current without manual intervention.

### Source code triggers

Source code triggers initiate builds when code is committed or pull requests are created in GitHub or Azure DevOps. ACR creates a webhook in your repository that fires on commits, automatically starting a build.

The following command creates a task that triggers on commits to the main branch:

```azurecli
az acr task create \
  --registry myregistry \
  --name build-inference-api \
  --image inference-api:{{.Run.ID}} \
  --context https://github.com/myorg/inference-api.git#main \
  --file Dockerfile \
  --git-access-token $PAT
```

The `{{.Run.ID}}` syntax creates a unique tag for each build using the ACR task run identifier. This ensures each triggered build produces a distinctly tagged image.

The personal access token (PAT) grants ACR permission to access your repository and create webhooks. Store tokens securely using Azure Key Vault rather than hardcoding them in scripts.

### Base image triggers

Base image triggers automatically rebuild application images when their base image updates. This capability is critical for AI applications that depend on base images containing ML frameworks, CUDA drivers, or other runtime components.

When you update a base image like `python:3.11` or a custom PyTorch image in your registry, ACR detects the change and rebuilds all images that specify that base image in their Dockerfile `FROM` statement. This automation ensures your application images receive security patches and updates from base images without manual intervention.

Base image triggers work for base images stored in the same ACR registry or in Docker Hub and other public registries. For private base images, both the base and application images should be in the same registry for automatic trigger detection.

### Scheduled triggers

Scheduled triggers run tasks on a defined schedule using cron expressions. Use scheduled triggers for:

- Nightly builds that incorporate the latest dependencies
- Periodic rebuilds to pick up base image patches even when detection doesn't trigger automatically
- Regular security scans of images
- Cleanup tasks that remove old untagged images

The following command creates a task that runs daily at midnight UTC:

```azurecli
az acr task create \
  --registry myregistry \
  --name nightly-build \
  --image inference-api:nightly \
  --context https://github.com/myorg/inference-api.git \
  --schedule "0 0 * * *" \
  --file Dockerfile \
  --git-access-token $PAT
```

## Multi-step tasks

Multi-step tasks extend quick tasks with sequential workflows defined in YAML. Each step can build images, run containers, or execute commands, with dependencies between steps. This capability enables build-test-push workflows entirely within ACR.

A multi-step task uses a YAML file that defines the workflow:

```yaml
version: v1.1.0
steps:
  - build: -t {{.Run.Registry}}/inference-api:{{.Run.ID}} .
  - push:
    - {{.Run.Registry}}/inference-api:{{.Run.ID}}
  - cmd: {{.Run.Registry}}/inference-api:{{.Run.ID}} python -m pytest tests/
```

This task builds the image, pushes it to the registry, then runs the container to execute tests. If the tests fail, you know before the image is used in deployment.

Multi-step tasks support:

- Build and test workflows that validate images before pushing
- Sequential operations with dependencies between steps
- Parallel execution of independent steps
- Conditional logic based on previous step results

Create the task from your YAML file:

```azurecli
az acr task create \
  --registry myregistry \
  --name build-test-push \
  --context https://github.com/myorg/inference-api.git \
  --file acr-task.yaml \
  --git-access-token $PAT
```

## Run a container image for testing

ACR Tasks can run a built image to validate it works correctly. This capability helps catch configuration issues before deployment. The `az acr run` command executes a command in a container using an image from your registry.

```azurecli
az acr run --registry myregistry \
  --cmd 'inference-api:v1.0.0 python --version' \
  /dev/null
```

The `/dev/null` context indicates no source files are needed since you're running an existing image. Use this approach to:

- Verify an image starts correctly
- Check that required tools and frameworks are available
- Run smoke tests against the container
- Execute health check commands

## Best practices for ACR Tasks

Follow these practices to get the most from ACR Tasks:

- **Use run variables:** Incorporate `{{.Run.ID}}` or `{{.Run.Date}}` in tags for unique, traceable builds. These variables create distinct tags that link images to specific task runs.
- **Secure access tokens:** Store personal access tokens for Git triggers in Azure Key Vault. Avoid committing tokens to repositories or including them in scripts.
- **Monitor task logs:** Review task output to diagnose build failures using `az acr task logs`. Logs show the complete build process including any errors.
- **Optimize build context:** Use `.dockerignore` to exclude unnecessary files from the context upload. Large contexts slow down builds and consume bandwidth.
- **Layer caching:** ACR Tasks cache layers between builds. Order Dockerfile instructions to maximize cache hits by placing frequently changing instructions late in the file.

## Additional resources

- [ACR Tasks overview](/azure/container-registry/container-registry-tasks-overview)
- [Build and deploy container images with ACR Tasks](/azure/container-registry/container-registry-tutorial-quick-task)
- [Run multi-step build, test, and patch tasks](/azure/container-registry/container-registry-tasks-multi-step)
