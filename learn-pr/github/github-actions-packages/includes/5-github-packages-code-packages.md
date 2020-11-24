In the previous unit, you saw how to use GitHub Actions to build and publish container images.

In this module, we'll take a look at the other packages supported by GitHub Packages.
GitHub Packages work with your current project's ecosystem tooling: npm for npm packages, nuget.exe, or dotnet CLI for NuGet packages, etc.

## Authenticating to GitHub Packages

The way you're authenticating into your package manager will depend on your project's ecosystem. Whichever ecosystem you're working with, you will need three pieces of information: 

1. Your GitHub username
1. A Personal Access Token
1. The GitHub Packages endpoint for your package ecosystem.

### Generate a Personal Access Token

To install, publish or delete a package, you need an access token. When using your package
manager, you need to generate a Personal Access Token (PAT). You can generate a PAT via [your profile settings](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token?azure-portal=true).

> [!WARNING]
> Treat your tokens like passwords and keep them secret.

### Log in into GitHub Packages

Before publishing or installing packages from GitHub Packages, you'll need to authenticate in your package manager. The endpoint is like`https://PACKAGE_TYPE.pkg.github.com/OWNER/REPOSITORY`, where `PACKAGE_TYPE` is the type of package ecosystem you're using.

The following table shows you the command tu run to authenticate to GitHub Packages depending on your package ecosystem.

| Your package ecosystem | Command line to authenticate to GitHub Package     |
|------------------------|----------------------------------------------------|
| NuGet                  | `dotnet nuget add source https://nuget.pkg.github.com/OWNER/index.json -n github -u OWNER -p [Your PAT Token]` |
| npm                    | `bash npm login --registry=https://npm.pkg.github.com` |
| RubyGems     | `echo ":github: Bearer GH_TOKEN" >> ~/.gem/credentials` |
| Maven & Gradle | You can directly authenticate while pushing.

If you want to learn more about how to use GitHub Packages with your project's environment, you can [read the documentation here](https://docs.github.com/en/free-pro-team@latest/packages/using-github-packages-with-your-projects-ecosystem?azure-portal=true).

### Installing a package

When you're authenticated, you can easily use published packages in your projects. Each package home page shows you the command to run, depending on your project environment.

:::image type="content" source="../media/5-github-packages-install.png" alt-text="A Package page displays information about how to install it into your project, depending on the project environment." border="false":::

### Managing packages

GitHub Packages offer you several ways to easily manage your packages lifecycle and workflows.

You can manage GitHub Packages through GitHub API and GraphQL API. These APIs allows you to support advanced integrations scenarios. For example, with the Webhook feature of GitHub, you can run code when a new package is published. Imagine you're a maintainer of an open-source project. With webhooks, you could automatically publish a new Tweet or a blog post when a new package is published.

Last but not least, you can use GitHub Actions to automate package management. With [delete-package-versions](https://github.com/marketplace/actions/delete-package-versions?azure-portal=true) action, you can automatically prune oldest versions of your packages while publishing a new version.
