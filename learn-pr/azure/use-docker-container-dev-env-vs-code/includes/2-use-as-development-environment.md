As you've noticed during your time at the agency, it can be a major hassle for developers to get started with new projects. Each one requires developers to install and manage specific or complicated sets of dependencies and technology stacks. 

Ideally, each project is contained in its own preconfigured, containerized environment. Docker and Visual Studio Code make containerized development possible through the Remote - Containers extension.

## What is the Remote - Containers extension?

The [Remote - Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for Visual Studio Code lets you use a Docker container as a full-featured development environment. You can use this extension to open any folder or repository in a container and take advantage of the full feature set of Visual Studio Code, like IntelliSense (completions), code navigation, and debugging.

## How the extension works

The Remote - Containers extension lets you grab a dev container with the specific technology stack or dependencies already set up for you, open a project, and find that your code just works. You don't need to download anything on your local machine. Remote - Containers works by connecting Visual Studio Code to a running container. Workspace files are mounted from the local file system, or they're copied or cloned into the container.

Visual Studio Code extensions are installed and run inside the container. There, they have full access to the tools, platform, and file system. To you, the developer, the experience is the same as if you had opened the project normally in Visual Studio Code.

You can seamlessly switch your entire development environment just by connecting to a different container. The extension handles all of the setup based on a few configuration files.

:::image type="content" source="../media/2-architecture-containers.png" alt-text="Diagram that explains the split architecture of the Remote - Containers extension.":::

## How to add a dev container to a project

Visual Studio Code has an interface for selecting a preconfigured definition for a development container. This adds a .devcontainer folder to your project.

The .devcontainer folder contains two files: a Dockerfile and a devcontainer.json file. You can use these files to define the container environment and control the configuration of your project within that container.

### Dockerfile

A Dockerfile defines the environment, such as what runtimes are installed. Examples of runtime environments are Python, Node, and Java. You don't need to be an expert in Docker to learn how to use this file to extend your environment. You'll learn how to work with the Dockerfile in this module.

### devcontainer.json

You can use the devcontainer.json file to automatically configure the project environment so that everything is ready to go the first time someone loads it. You can specify Visual Studio Code settings and extensions, and even automatically install dependencies.

In the next section, you'll add a remote container to a Python project and run it on your own machine - even if you don't have Python installed.
