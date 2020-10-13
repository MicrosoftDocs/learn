The agency you work at has a lot of developers, and they work with a lot of different languages and runtimes. It's become a hassle to setup new developers or get new projects running because not everyone's development enviornment is the same. They have tasked you with coming up with a solution where each project can define it's own environment so that as long as a developer has Docker installed, the project will "just work" on their machine.

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
