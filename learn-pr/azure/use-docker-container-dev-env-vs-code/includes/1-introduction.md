You work at an agency that does software consulting around many different languages and runtimes. All developers are using VS Code. At any given time, the agency has dozens of projects in progress, each with it's own configuration and runtime requirements. It's become difficult for developers to get projects running on their development machines since they are constantly having to install new runtimes or change versions of an existing runtime. They spend too much time configuring their machine and less time writing code. The agency has recently learned that they might be able to use Docker to solve this problem. They have tasked you with investigating how they can use Docker containers as dev environments in VS Code.

## Learning objectives

In this module, you will:

- Understand how and why you would use a container as a development environment.
- Install the Remote - Containers extension in Visual Studio Code and learn how to use it.
- Explore the files make up your container configuration.
- Customize your container and development experience by forwarding ports, changing settings, and installing additional software.

## Prerequisites

- A computer that's running one of the following:
  - Windows: Windows 10
  - Mac: macOS 10.9 or later
  - Linux: Ubuntu, Debian, Red Hat, Fedora, or SUSE
- [Visual Studio Code](https://code.visualstudio.com/)
- Docker and basic Docker knowledge (i.e. image, container, registry)
  - Windows: [Docker Desktop](https://www.docker.com/products/docker-desktop) 2.0+ on Windows 10 Pro/Enterprise. Windows 10 Home (2004+) requires Docker Desktop 2.3+ and the [WSL 2 back-end](https://aka.ms/vscode-remote/containers/docker-wsl2).
  - Mac: [Docker Desktop](https://www.docker.com/products/docker-desktop) 2.0+.
  - Linux: [Docker CE/EE](https://docs.docker.com/install/#supported-platforms) 18.06+ and [Docker Compose](https://docs.docker.com/compose/install) 1.21+.
