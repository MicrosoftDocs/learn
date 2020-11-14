The Remote-Containers extension for Visual Studio Code allows you to develop inside of a Docker container. 

Suppose that you work at an agency that does software consulting around many different languages and runtimes. All developers are using VS Code. The agency has dozens of projects in progress, each with its own configuration and runtime requirements. Developers at your agency need to work on any project without having to set up or configure their machine first. 

In this module, you will add configuration files to an existing project that will tell Visual Studio Code how to build an environment where the project will "just work". You'll use the Remote-Containers configuration to configure not only the runtime, but also automate configuration of a development environment that will work for anyone who has Docker and Visual Studio Code.

By the end of this module, you will be able to configure any project so that it runs inside of a Docker container.

## Prerequisites

- A computer that's running one of the following:
  - Windows: Windows 10
  - Mac: macOS 10.9 or later
  - Linux: Ubuntu, Debian, Red Hat, Fedora, or SUSE
- [Visual Studio Code](https://code.visualstudio.com/)
- Basic general software development knowledge, such as what it means to run code, install a new language
- Docker and basic Docker knowledge, i.e. familiar with the concept of images, containers, and registries
  - Windows: [Docker Desktop](https://www.docker.com/products/docker-desktop) 2.0+ on Windows 10 Pro/Enterprise. Windows 10 Home (2004+) requires Docker Desktop 2.3+ and the [WSL 2 back-end](https://aka.ms/vscode-remote/containers/docker-wsl2).
  - Mac: [Docker Desktop](https://www.docker.com/products/docker-desktop) 2.0+.
  - Linux: [Docker CE/EE](https://docs.docker.com/install/#supported-platforms) 18.06+ and [Docker Compose](https://docs.docker.com/compose/install) 1.21+.
- [Git](https://git-scm.com/downloads) and basic knowledge of GitHub, i.e. what is a repository
