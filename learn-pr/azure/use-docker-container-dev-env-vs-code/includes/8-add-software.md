Your customized container is coming along great for your agency. With the power of Remote-Containers, you've been able to add a preconfigured dev container, and through the exercises so far, you've been able to customize your experience even more through the `devcontainer.json`. But what if we want to add additional software beyond just what's available in those images or preconfigured dev containers? 

## Intro to installing additional software

Additional software could include another tech stack for your agency. For instance, you may want to include Node.js in any of your dev containers since you know that's included in a lot of development workflows. 

When you ran **Remote-Containers: Add Development Container Configuration Files...**, a `.devcontainer` folder was added to your app, which included a `devcontainer.json` and a Dockerfile. These files came from the [VS Code dev containers](https://github.com/microsoft/vscode-dev-containers) repo. While this repo gives us a lot of great options for our team, we still may want to iterate on them even further by installing more software.

## Methods to install software

You could install software via the integrated terminal. Most container images are based on Debian or Ubuntu, where the `apt` or `apt-get` command is used to install new packages.

> [!IMPORTANT]
> Whenever you install something from `apt-get`, run an `apt-get update` first. This command updates the list of packages and package repos so that you have the most current list cached.

But if you make changes to your `.devcontainer` folder and need to rebuild your container, you'll have to reinstall anything you've installed manually. To avoid this problem, you can use the `postCreateCommand` property in `devcontainer.json`, as mentioned in the previous section.

However, the most efficient practice of all that persists your changes even after rebuilding is to install software through your Dockerfile.

## Installing software via Dockerfile 

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

In the next exercise, you'll modify the Dockerfile to install Node.js, which is then a practice you can extend to installing additional software in general in your dev containers.