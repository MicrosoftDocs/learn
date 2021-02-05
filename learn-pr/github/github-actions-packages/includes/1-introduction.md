Package registries allow developers to share and use code libraries easily and across development
workstations. If developers are familiar with public package registries, like npm or NuGet, deploying private
packages is another story.

GitHub Packages allow development teams to share code libraries - NPM, NuGet, Maven, RubyGems - and containers
directly within GitHub. These packages can be public, or restricted to specific people using the same secure login
for your code and packages. In conjunction with GitHub Actions - that we'll use in this module - you can automate
the packaging and publication of your code libraries and containers in minutes.

In this module, you learn how to automate building and publishing container images into GitHub Packages.

## Learning objectives

By the end of this module, you will:

- Understand when to use a Package Repository
- Set up a Continuous Integration (CI) workflow with GitHub Actions
- Create a Dockerfile
- Build a container image in CI
- Run locally a container image hosted on GitHub Docker Registry

## Prerequisites

- A GitHub account
- A basic knowledge about Docker and Docker Registry
  