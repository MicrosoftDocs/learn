Azure Container Registry (ACR) tasks are a suite of features that:

* Provide cloud-based container image building for platforms like Linux, Windows, and Advanced RISC Machines (Arm).
* Extend the early parts of an application development cycle to the cloud with on-demand container image builds.
* Enable automated builds triggered by source code updates, updates to a container's base image, or timers. 

## Task scenarios

ACR Tasks supports several scenarios to build and maintain container images and other artifacts. 

* **Quick task** - Build and push a single container image to a container registry on-demand, in Azure, without needing a local Docker Engine installation. Think `docker build`, `docker push` in the cloud.

* **Automatically triggered tasks** - Enable one or more *triggers* to build an image:
    * Trigger on source code update
    * Trigger on base image update
    * Trigger on a schedule

* **Multi-step task** - Extend the single image build-and-push capability of ACR Tasks with multi-step, multi-container-based workflows.

Each ACR Task has an associated source code context - the location of a set of source files used to build a container image or other artifact. Example contexts include a Git repository or a local filesystem.

## Quick task

The *inner-loop* development cycle is the iterative process of writing code, building, and testing your application before committing to source control. It's really the beginning of container lifecycle management.

Before you commit your first line of code, ACR Tasks's quick task feature can provide an integrated development experience by offloading your container image builds to Azure. With quick tasks, you can verify your automated build definitions and catch potential problems before committing your code.

Using the familiar `docker build` format, the [az acr build](/cli/azure/acr#az-acr-build) command in the Azure CLI takes a context (the set of files to build), sends it to ACR Tasks and, by default, pushes the built image to its registry upon completion.

## Trigger task on source code update

Trigger a container image build or multi-step task when code is committed, or a pull request is made or updated, to a Git repository in GitHub or Azure DevOps Services. For example, configure a build task with the Azure CLI command `az acr task create` by specifying a Git repository and optionally a branch and Dockerfile. When your team updates code in the repository, an ACR Tasks-created webhook triggers a build of the container image defined in the repo.

## Trigger on base image update

You can set up an ACR task to track a dependency on a base image when it builds an application image. When the updated base image is pushed to your registry, or a base image is updated in a public repo such as in Docker Hub, ACR Tasks can automatically build any application images based on it.

## Schedule a task

Optionally schedule a task by setting up one or more timer triggers when you create or update the task. Scheduling a task is useful for running container workloads on a defined schedule, or running maintenance operations or tests on images pushed regularly to your registry. 

## Multi-step tasks

Multi-step tasks, defined in a [YAML file](/azure/container-registry/container-registry-tasks-reference-yaml) specify individual build and push operations for container images or other artifacts. They can also define the execution of one or more containers, with each step using the container as its execution environment. For example, you can create a multi-step task that automates the following:

1.  Build a web application image
1.  Run the web application container
1.  Build a web application test image
1.  Run the web application test container, which performs tests against the running application container
1.  If the tests pass, build a Helm chart archive package
1.  Perform a `helm upgrade` using the new Helm chart archive package

## Image platforms

By default, ACR Tasks builds images for the Linux OS and the amd64 architecture. Specify the `--platform` tag to build Windows images or Linux images for other architectures. Specify the OS and optionally a supported architecture in OS/architecture format (for example, `--platform Linux/arm`). For ARM architectures, optionally specify a variant in OS/architecture/variant format (for example, `--platform Linux/arm64/v8`):

| OS | Architecture |
|---|---|
| Linux | AMD64<br/>Arm<br/>Arm64<br/>386 |
| Windows | AMD64 |
