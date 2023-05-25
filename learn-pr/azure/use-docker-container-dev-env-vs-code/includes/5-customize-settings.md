You've set up a dev container for one of your agency's projects. It will now "just work" for anyone who has Docker and the Dev Containers extension. They'll still have to install dependences. They might also need some Visual Studio Code extensions that they don't know about.

Fortunately, you can fully customize and automate all the project setup by using the devcontainer.json file.

## A closer look at devcontainer.json

Let's look at the main options in the `.devcontainer/devcontainer.json` file from the Products Dashboard project. It's a bit long to look at all at once, so let's look at it in sections.

### Build configuration

The `image` property defines how the container will be created, based on what's known as a container [image](https://www.docker.com/resources/what-container/).

```json
"image": "mcr.microsoft.com/devcontainers/python:0-3.11"
},
```

This image is hosted in the [devcontainers/images repo](https://github.com/devcontainers/images/tree/main/src/python), where you can check it out further.

You can also use files known as a Dockerfile or a Docker Compose file to configure your setup. These files can live in your `.devcontainer` folder and allow you to further configure certain setup requirements, like installing additional software. You can learn more in our [dev container documentation](https://containers.dev/guide/dockerfile).

### Features

Development container *Features* are self-contained, shareable units of installation code and dev container configuration. The name comes from the idea that referencing one of them allows you to quickly and easily add more tooling, runtime, or library "Features" into your development container for use by you or your collaborators.

When you use the VS Code command **Dev Containers: Add Dev Container Configuration Files**, you're presented a list of scripts to customize the existing dev container configurations, such as installing Git or the Azure CLI.

### Project settings

A later section of the file deals directly with project configuration.

`customizations` sets product specific properties for [products that support dev containers](https://containers.dev/supporting), like VS Code and GitHub Codespaces.

As an example, you can set `vscode.settings` to copy machine-specific settings into the container. You might have these settings in your own Visual Studio Code setup. By adding them to the `settings`, you ensure that anyone who opens this project gets these specific VS Code settings.

In this Python container, you can [see these settings](https://github.com/devcontainers/images/blob/main/src/python/.devcontainer/devcontainer.json#L22) in its base image `mcr.microsoft.com/devcontainers/python:0-3.11`. They give the user an improved Python editing experience.

- You can use the `extensions` array to specify which Visual Studio Code extensions should be installed in Visual Studio Code when it connects to the container. Your normal Visual Studio Code setup and all the extensions that you already have won't be present when you're using Dev Containers. Extensions are specified here with their IDs.

### postCreateCommand

The `postCreateCommand` property lets you run any commands that you want after the container is created. If you remember from the first exercise, you had to run the `pip3` command to install dependencies. But how would you know to do that? You might not. You can configure it here so that it'll happen automatically and others won't have to worry about it.

In the next exercise, you'll modify the devcontainer.json file to automate several aspects of the project that will set up other developers for immediate success.
