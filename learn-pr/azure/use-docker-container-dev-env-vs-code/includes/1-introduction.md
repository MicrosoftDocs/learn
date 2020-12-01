You can use the Remote - Containers extension for Visual Studio Code to develop inside a Docker container. 

Suppose you work at an agency that does software consulting around many different languages and runtimes. All developers are using Visual Studio Code. The agency has dozens of projects in progress, each with its own configuration and runtime requirements. Developers at your agency need to work on any project without having to set up or configure their machines first. 

In this module, you'll add configuration files to an existing project. These files will tell Visual Studio Code how to build an environment where the project will "just work." You'll use the Remote - Containers configuration to configure the runtime. You'll also automate configuration of a development environment that will work for anyone who has Docker and Visual Studio Code.

By the end of this module, you'll be able to configure any project so that it runs inside a Docker container.

## Prerequisites

- A computer that's running one of the following:
  - Windows: Windows 10
  - Mac: macOS 10.9 or later
  - Linux: Ubuntu, Debian, Red Hat, Fedora, or SUSE
- [Visual Studio Code](https://code.visualstudio.com/)
- Basic knowledge of software development, such as what it means to run code or install a new language
- Docker and basic Docker knowledge (familiarity with the concept of images, containers, and registries):
  - Windows: [Docker Desktop](https://www.docker.com/products/docker-desktop) 2.0+ on Windows 10 Pro/Enterprise. Windows 10 Home (2004+) requires Docker Desktop 2.3+ and the [WSL 2 back end](https://aka.ms/vscode-remote/containers/docker-wsl2).
  - Mac: [Docker Desktop](https://www.docker.com/products/docker-desktop) 2.0+.
  - Linux: [Docker CE/EE](https://docs.docker.com/install/#supported-platforms) 18.06+ and [Docker Compose](https://docs.docker.com/compose/install) 1.21+.
- [Git](https://git-scm.com/downloads) and basic knowledge of GitHub, such as what a repository is
