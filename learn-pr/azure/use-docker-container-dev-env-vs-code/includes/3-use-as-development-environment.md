Now that you've installed the Dev Containers extension, let's take a look at how it's going to help developers at your agency. As you've noticed during your time at the agency, it can be a major hassle for developers to get started with new projects. Each one requires developers to install and manage specific or complicated sets of dependencies and technology stacks.

Ideally, each project is contained in its own preconfigured, containerized environment. Docker and Visual Studio Code make containerized development possible through the Dev Containers extension.

## The Dev Containers extension

The [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for Visual Studio Code lets you use a container as a full-featured development environment. You can use this extension to open any folder or repository in a container and take advantage of the full feature set of Visual Studio Code, like IntelliSense (completions), code navigation, and debugging.

## How the extension works

The Dev Containers extension lets you grab a dev container with the specific technology stack or dependencies already set up for you, open a project, and find that your code just works without downloading anything on your local machine. The Dev Containers extension works by connecting Visual Studio Code to a running container. Workspace files are mounted from the local file system, or they're copied or cloned into the container.

Visual Studio Code extensions are installed and run inside the container. There, they have full access to the tools, platform, and file system. To you—the developer—the experience is the same as if you'd opened the project normally in Visual Studio Code.

You can seamlessly switch your entire development environment just by connecting to a different container. The extension handles all of the setup based on a few configuration files contained in a folder called **'.devcontainer'**.

:::image type="content" source="../media/2-architecture-containers.png" alt-text="Diagram that explains the split architecture of the Dev Containers extension.":::

In the next section, you'll add a dev container to a Python project and run it on your own machine, even if you don't have Python installed.
