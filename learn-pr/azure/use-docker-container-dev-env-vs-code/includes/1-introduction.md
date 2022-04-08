You can use the Remote - Containers extension for Visual Studio Code to develop inside a Docker container. 

Suppose you work at an agency that does software consulting around many different languages and runtime environment. All developers are using Visual Studio Code. The agency has dozens of projects in progress, each with its own configuration and runtime requirements. Developers at your agency need to work on any project without having to set up or configure their machines first.

In this module, you'll add configuration files to an existing project. These files will tell Visual Studio Code how to build an environment where the project will "just work". You'll use the Remote - Containers configuration to configure the runtime environments. You'll also automate configuration of a development environment that will work for anyone who has Docker and Visual Studio Code.

By the end of this module, you'll be able to configure any project so that it runs inside a Docker container.

## Prerequisites

- Basic knowledge of software development, such as what it means to run code or install a new language
- Docker and basic Docker knowledge:
  - Windows: [Docker Desktop](https://www.docker.com/products/docker-desktop)
  - Mac: [Docker Desktop](https://www.docker.com/products/docker-desktop) 4.6+
  - Linux: [Docker CE/EE](https://docs.docker.com/install/#supported-platforms) 20.10+ and [Docker Compose](https://docs.docker.com/compose/install) 2.0.0+.
- [Git](https://git-scm.com/downloads) and basic knowledge of what a Git repository is.
