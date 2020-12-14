Your customized container is coming along well for your agency. With the power of Remote - Containers, you've been able to add a preconfigured dev container. And through the exercises so far, you've customized your experience through the devcontainer.json file. But what if you want to add software beyond what's available in those images or preconfigured dev containers?

## Introduction to installing additional software

Additional software might include another technology stack for your agency. For instance, you might want to include Node.js in any of your dev containers because you know that's part of many development workflows.

When you ran **Remote-Containers: Add Development Container Configuration Files**, a .devcontainer folder was added to your app. It included a devcontainer.json file and a Dockerfile. These files came from the [Visual Studio Code dev containers](https://github.com/microsoft/vscode-dev-containers) repo. Although this repo gives us many options for our team, we might want to iterate on them by installing more software.

## Methods to install software

You can install software via the integrated terminal. Most container images are based on Debian or Ubuntu, where the `apt` or `apt-get` command is used to install new packages.

> [!IMPORTANT]
> Whenever you install something from `apt-get`, run `apt-get update` first. This command updates the list of packages and package repos so that you have the most current list cached.

But if you make changes to your .devcontainer folder and need to rebuild your container, you'll have to reinstall anything you've installed manually. To avoid this problem, you can use the `postCreateCommand` property in devcontainer.json, as mentioned in the previous unit.

The most efficient practice that persists your changes even after rebuilding is to install software through your Dockerfile.

## Software installation via Dockerfile

A look at installing software via the Dockerfile is as follows:

```Dockerfile
ARG VARIANT=3
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y traceroute
```

- The `RUN` command creates a new *layer*. Layers are how the container knows what has changed and what in the container needs to be updated when you rebuild it. You should try to keep related logic together in the same `RUN` command so that you don't create unnecessary layers.
- The `\` denotes a line break at the end of a line. You need it for multiple-line commands.
- The `&&` is how you add a command to the `RUN` line.
- The `DEBIAN_FRONTEND` export avoids warnings when you go on to work with your container. When you're adding other software, you might instead use other flags or parameters, such as `-y`.
- The `-y` ensures that `apt-get` doesn't prompt you to confirm that you want to finish the installation. These prompts would cause the container build to fail because nobody would be there to select `Y` or `N`.

In the next exercise, you'll modify the Dockerfile to install Node.js. You'll then verify that Node.js is available in the running container.
