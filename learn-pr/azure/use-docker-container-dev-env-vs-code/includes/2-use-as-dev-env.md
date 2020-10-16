As you've noticed during your time at the agency, it can be a major hassle for developers to get started with new projects, such as having to install and manage very specific or complicated sets of dependencies and tech stacks unique to specific projects. To get a consistent environment set up for everyone in your agency, you can create a development (dev) container and share it with all your teammates. You can do this in Visual Studio Code through the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.

## The Remote - Containers extension for VS Code

VS Code's Remote - Containers extension lets you use a Docker container as a full-featured development environment. You can use this extension to open any folder or repository in a container and take advantage of Visual Studio Code's full feature set, like full IntelliSense (completions), code navigation, and debugging.

## How Remote - Containers works

Remote - Containers lets you grab a dev container with the specific tech stack or dependencies already set up for you, open a project, and your code will just work - you don't need to actually download anything on your local machine. How does this work?

- Workspace files are mounted from the local file system or copied or cloned into the container.
- VS Code extensions are installed and run inside the container, where they have full access to the tools, platform, and file system.
- To you the developer, the experience is the same as if you had just opened the project in VS Code.

This means that you can seamlessly switch your entire development environment just by connecting to a different container. The extension handles all of the setup based on a few configuration files.

![Containers architecture diagram](../media/2-architecture-containers.png)

## Remote - Containers extension features

With Remote - Containers, you get features such as:

- Add a dev container to an existing project through a simple menu.
- Open an existing GitHub repo or local project in a dev container.
- Try a sample container, with the dev container already configured and some simple source code, such as [vscode-remote-try-python](https://github.com/microsoft/vscode-remote-try-python).
- Set up a coding experience specific to each dev container, including VS Code extensions, settings, and port forwarding.
- Save the configuration with your project so that it "just works" for the next person who opens it.

In the next exercise, you'll add a Remote - Containers configuration to an existing project and open it within the container.
