As you've noticed during your time at the agency, it can be a major hassle for developers to get started with new projects. Each one requires the developer to install and manage specific or complicated sets of dependencies and tech stacks. Ideally, each project would be contained in its own pre-configured environment, containerized environment. Containerized development is made possible with Docker and Visual Studio Code (VS Code) through the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.

## The Remote-Containers extension for VS Code

VS Code's Remote - Containers extension lets you use a Docker container as a full-featured development environment. You can use this extension to open any folder or repository in a container and take advantage of VS Code's full feature set, like full IntelliSense (completions), code navigation, and debugging.

## How Remote-Containers works

The Remote-Containers extension lets you grab a dev container with the specific tech stack or dependencies already set up for you, open a project, and your code will just work - you don't need to actually download anything on your local machine. Remote-Containers works by connecting VS Code to a running container.

- Workspace files are mounted from the local file system or copied or cloned into the container.
- VS Code extensions are installed and run inside the container, where they have full access to the tools, platform, and file system.
- To you, the developer, the experience is the same as if you had opened the project normally in VS Code.

You can seamlessly switch your entire development environment just by connecting to a different container. The extension handles all of the setup based on a few configuration files.

![Containers architecture diagram](../media/2-architecture-containers.png)

## Adding a dev container to a project

VS Code has an interface for selecting a pre-configured development container definition. This adds a ".devcontainer" folder to your project.

### About the.devcontainer folder

The ".devcontainer" folder contains two files - a `Dockerfile` and a `devcontainer.json` file. These two files allow you to define the container environment, and control the configuration of your project within that container.

#### Dockerfile

This file defines the environment - such as what runtimes are installed. Examples of runtime environments are Python, Node, Java, ect. You don't need to be an expert in Docker to learn how to use this file to extend your environment. You'll learn how to work with the Dockerfile in this module.

#### devcontainer.json

The "devcontainer.json" file allows you to autoconfigure the project environment so that everything is ready to go the first-time someone loads it up. You can specify VS Code settings, extensions, and even auto install dependencies.

In the next section, you'll add a Remote Container to a Python project and run it on your own machine - even if you don't have Python installed.
