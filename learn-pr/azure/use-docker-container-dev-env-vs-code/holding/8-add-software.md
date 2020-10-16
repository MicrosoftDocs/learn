The preconfigured [VS Code dev containers](https://github.com/microsoft/vscode-dev-containers) give us a lot of options for our team, and we can leverage images from other container registries as well. But what if we want to add additional software beyond just what's available in those images or preconfigured dev containers? Let's see how we can install additional software in our containers.

## Moving beyond postCreateCommand

As we saw in the customize settings module, we can install additional software using the command line or `postCreateCommand` in `devcontainer.json`. However, the most efficient practice that persists your changes even upon a rebuild of your container is to install software through your Dockerfile.

## Installing software via Dockerfile 

Whenever you install something from `apt-get`, run an `apt-get update` first. This command updates the list of packages and package repos so that you have the most current list cached.

A look at installing software via Dockerfile is as follows:

```Dockerfile
FROM mcr.microsoft.com/vscode/devcontainers/typescript-node:0-12
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install git
```

- The `RUN` command creates a new “layer.” Layers are how the container knows what has changed and what in the container needs to be updated when you rebuild it. You should try and keep related logic together in the same `RUN` command so that you don’t create unnecessary layers.
- The `\` denotes a line break at the end of a line. You need it for multi-line commands. 
- The `&&` is how you add an additional command to the `RUN` line.
- The `DEBIAN_FRONTEND` export avoids warnings when you go on to work with your container. When adding other software, you may instead use other flags or parameters, such as `-y`.
     - `-y` makes it so that `apt-get` doesn't prompt you to ensure you want to install what you just tried to install. These prompts will cause the container build to fail because there is nobody there to say `Y` or `N`.