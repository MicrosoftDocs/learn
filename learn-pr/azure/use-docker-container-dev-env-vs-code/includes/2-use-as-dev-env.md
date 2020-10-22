As you've noticed during your time at the agency, it can be a major hassle for developers to get started with new projects, such as having to install and manage very specific or complicated sets of dependencies and tech stacks unique to specific projects. To get a consistent environment set up for everyone in your agency, you can create a development (dev) container and share it with all your teammates. You can do this in Visual Studio Code through the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.

## The Remote-Containers extension for VS Code

VS Code's Remote - Containers extension lets you use a Docker container as a full-featured development environment. You can use this extension to open any folder or repository in a container and take advantage of Visual Studio Code's full feature set, like full IntelliSense (completions), code navigation, and debugging.

## How Remote-Containers works

Remote - Containers lets you grab a dev container with the specific tech stack or dependencies already set up for you, open a project, and your code will just work - you don't need to actually download anything on your local machine. How does this work?

- Workspace files are mounted from the local file system or copied or cloned into the container.
- VS Code extensions are installed and run inside the container, where they have full access to the tools, platform, and file system.
- To you the developer, the experience is the same as if you had just opened the project in VS Code.

This means that you can seamlessly switch your entire development environment just by connecting to a different container. The extension handles all of the setup based on a few configuration files.

![Containers architecture diagram](../media/2-architecture-containers.png)

## Adding a dev container to a project

VS Code has a mechanism for adding a dev container configuration to an existing project by letting you pick a pre-configured environment from the Command Palette. This adds a ".devcontainer" folder to your project.

### About the .devcontainer folder

The ".devcontainer" folder contains two files - a `Dockerfile` and a `devcontainer.json` file. These two files allow you to define the container environment, and control the configuration of your project within that container.

#### Dockerfile

This file defines the environment - such as what runtimes are installed. These are things like Python, Node, Java, ect. You don't need to be an expert in Docker to learn how to use this file to extend your environment. You'll do that in this module.

#### devcontainer.json

This file defines the configuration of your project. It allows you to auto-install various VS Code extensions, as well as run certain commands like "npm install" or "pip3 install" when the project is first loaded. This file allows you to auto-configure the project enviornment so that everything is ready to go the first time someone loads it up.

In the next section, you'll add a Remote Container to a Python project and run it on your own machine - even if you don't have Python installed.
