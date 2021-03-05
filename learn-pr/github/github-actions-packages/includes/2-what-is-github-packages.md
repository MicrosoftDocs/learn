GitHub Packages is a package management service that makes it easy to publish public or private packages next to your source code.

> [!NOTE]
> If you're discovering GitHub, checkout [Introduction to GitHub](https://docs.microsoft.com/learn/modules/introduction-to-github/) Learn module.

## GitHub Packages is a package registry

GitHub Packages allow you to share your project dependencies within your organization, or publicly.

When you work on a project that has dependencies on packages, it’s important for you to trust them, understand their code, and connect with the community who built them. And inside organizations, you need to quickly find what’s been approved for your use.

GitHub Packages make it easy to use the same familiar GitHub interface to find public packages anywhere on GitHub, or private packages within your organization or repositories.

## A standard package manager

GitHub Packages is compatible with common package management clients, so you can publish packages with your choice of tools. If your repository is more complex, you may need to publish multiple packages of different types. And, with webhooks or with GitHub Actions, you can fully customize your publishing and post-publishing workflows.

Are you publishing an open-source package? Most open-source projects have their code on GitHub. So you can publish prerelease versions of your packages for testing within your community, and then easily promote specific versions to the public registry of your choice.

:::image type="content" source="../media/2-github-packages-npm-package.png" alt-text="GitHub NPM package page, with description, and instructions about how to install it." border="false":::

At the time of writing, GitHub Packages is compatible with the following package managers: 

- NPM, a NodeJS package manager
- NuGet, the .NET package manager,
- RubyGems,
- Maven and Gradle, two packages manager for Java,

## GitHub Packages is also a container registry

From complete applications to CLI utilities, containers are another form of
distributing code. GitHub Packages allow you to publish and distribute container
images. Once published - in public or in private - these images can be used from anywhere you want, including: 

- In your local development environment.
- As a base image from your [GitHub Codespaces](https://github.com/features/codespaces) development environment.
- As a step to execute into your Continuous Integration (CI) / Continuous Deployment (CD) workflow with [GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions/learn-github-actions/finding-and-customizing-actions#referencing-a-container-on-docker-hub).
- On a server or a cloud service.

:::image type="content" source="../media/2-github-packages-docker-image.png" alt-text="GitHub container image page, with image versions listing, statistics and instructions about how to install it." border="false":::

## Unified identity and permissions

Let's say you're working on a project using GitHub for hosting source code, JavaScript for the front end - and NPM - and Java for the backend. 
You now maintain at least three different sets of user credentials and permissions: git, npm and maven repositories.

Now with GitHub Packages, you can use a single set of credentials across your source code repository, your private NPM registry and your Maven or Gradle private registry. Packages published through GitHub inherits the visibility and permissions assigned at the repository. A new team member needs read access to a package and its code? Give her read access on the repository and it's done!

## Build and publish packages from GitHub

[GitHub Actions](https://github.com/features/actions) is another feature of GitHub that allow you to automate your software workflows. You can build, test, and deploy your code right from GitHub. 

> [!TIP]
> If you want to learn more about GitHub Actions, checkout *[Build continuous integration (CI) workflows by using GitHub Actions](https://docs.microsoft.com/learn/modules/github-actions-ci/)* Learn module.

By combining GitHub Actions and GitHub Packages, you can build a workflow that will build and test your code, and then publish it to GitHub Packages by simply pushing code to your repository.

In the next unit, we'll use GitHub Actions to build a container image, and publish it into GitHub Packages.