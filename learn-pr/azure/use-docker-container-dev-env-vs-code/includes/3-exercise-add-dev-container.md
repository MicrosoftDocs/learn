When setting up the dev container for your agency, there are a few components you'll need to configure: `devcontainer.json` and a Dockerfile. These files typically live in a `.devcontainer` folder at the root of the project.

## devcontainer.json

VS Code's container configuration is stored in a [devcontainer.json](/docs/remote/devcontainerjson-reference.md) file. This file is similar to the `launch.json` file for debugging configurations, but is used for launching (or attaching to) your development container instead. The dev container configuration is either located under `.devcontainer/devcontainer.json` or stored as a `.devcontainer.json` file (note the dot-prefix) in the root of your project.

You can use an image as a starting point for your `devcontainer.json`. An image is like a mini-disk drive with various tools and an operating system pre-installed. You can pull images from a container registry, which is a collection of repositories that store images. Here is a simple example `devcontainer.json` that uses a pre-built TypeScript and Node.js VS Code Development Container image from the popular container registry [Docker Hub](https://hub.docker.com/_/microsoft-vscode-devcontainers):

```json
{
    "image": "mcr.microsoft.com/vscode/devcontainers/typescript-node:0-12"
}
```

You can alter your configuration to do things such as:

* Install additional tools such as Git in the container.
* Automatically install extensions.
* Forward or publish additional ports.
* Set runtime arguments.
* Reuse or [extend your existing Docker Compose setup](https://aka.ms/vscode-remote/containers/docker-compose/extend).
* Add more [advanced container configurations](/docs/remote/containers-advanced.md).

## Dockerfile

A Dockerfile will also live in the `.devcontainer` folder. You can replace the `image` property in `devcontainer.json` with `dockerFile`:

```json
{
    "dockerFile": "Dockerfile"
}
```

When you make changes like installing new software, changes made in the Dockerfile will persist even upon a rebuild of the dev container.

In your Dockerfile, use `FROM` to designate the image, and the `RUN` instruction to install any software. You can use `&&` to string together multiple commands.

```Dockerfile
FROM mcr.microsoft.com/vscode/devcontainers/typescript-node:0-12
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install git
```

> Note: The `DEBIAN_FRONTEND` export avoids warnings when you go on to work with your container.

## How to use Remote - Containers to add configuration files

Rather than creating a `.devcontainer` by hand, selecting the **Remote-Containers: Add Development Container Configuration Files...** command from the Command Palette (`kbstyle(F1)`) will add the needed files to your project as a starting point, which you can further customize for your needs.

The command lets you pick a pre-defined container configuration from a list based on your folder's contents.

All of the predefined container configurations you can pick from come from the [vscode-dev-containers repository](https://aka.ms/vscode-dev-containers), which has examples of `devcontainer.json` and Dockerfiles for different scenarios.

You can also reuse an existing Dockerfile.