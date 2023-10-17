
Each of the package types has a corresponding manager that takes care of one or more of the following aspects of package management:

 -  Installation and removal of local packages
 -  Pushing packages to a remote package feed
 -  Consuming packages from a remote package feed
 -  Searching feeds for packages

The package manager has cross-platform command-line interface (CLI) tools to manage the local packages and feeds that host the packages. This CLI tooling is part of a local install on a development machine.

## Choosing tools

The command-line nature of the tooling offers the ability to include it in scripts to automate package management. Ideally, one should use the tooling in build and release pipelines for component creating, publishing, and consuming packages from feeds.

Additionally, developer tooling can have integrated support for working with package managers, providing a user interface for the raw tooling. Examples of such tooling are Visual Studio 2017, Visual Studio Code, and Eclipse.
