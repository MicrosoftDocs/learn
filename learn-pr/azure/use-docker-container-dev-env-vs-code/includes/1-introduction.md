You can use the Visual Studio Code Dev Containers extension to develop inside a Docker container.

Suppose you work at an agency that does software consulting around many different languages and runtime environments. All developers are using Visual Studio Code. The agency has dozens of projects in progress, each with its own configuration and runtime requirements. Developers at your agency need to work on any project without having to set up or configure their machines first.

In this module, you'll add configuration files to an existing project. These files will tell Visual Studio Code how to build an environment where the project will "just work." You'll use the Dev Container configuration to configure the runtime environment. You'll also automate configuration of a development environment that will work for anyone who has Docker and Visual Studio Code.

By the end of this module, you'll be able to configure any project so that it runs inside a Docker container.

## Prerequisites

- Basic knowledge of software development, such as what it means to run code or install a new language
- Docker and basic Docker knowledge:
  - Windows: [Docker Desktop](https://www.docker.com/products/docker-desktop) 2.0+ on Windows 10 Pro/Enterprise. Windows 10 Home (2004+) requires Docker Desktop 2.3+ and the [WSL 2 back-end](https://docs.docker.com/desktop/windows/wsl/)
  - Mac: [Docker Desktop](https://www.docker.com/products/docker-desktop) 2.0+
  - Linux: [Docker CE/EE](https://docs.docker.com/install/#supported-platforms) 18.06+ and [Docker Compose](https://docs.docker.com/compose/install) 1.21+
- [Git](https://git-scm.com/downloads) and basic knowledge of what a Git repository is
