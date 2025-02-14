GitHub Packages use native package tooling commands to publish and install package versions.

### Support for package registries

| **Language** | **Package format**               | **Package client** |
| ------------ | -------------------------------- | ------------------ |
| JavaScript   | package.json                     | npm                |
| Ruby         | Gemfile                          | gem                |
| Java         | pom.xml                          | mvn                |
| Java         | build.gradle or build.gradle.kts | gradle             |
| .NET         | nupkg                            | dotnet CLI         |
| N/A          | Dockerfile                       | Docker             |

When creating a package, you can provide a description, installation and usage instructions, and other details on the package page. It helps people consuming the package understand how to use it and its purposes.

If a new package version fixes a security vulnerability, you can publish a security advisory to your repository.

> [!TIP]
> You can connect a repository to more than one package. Ensure the README and description provide information about each package.

## Publishing a package

Using any supported package client, to publish your package, you need to:

1.  Create or use an existing access token with the appropriate scopes for the task you want to accomplish: [Creating a personal access token](https://docs.github.com/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token). When you create a personal access token (PAT), you can assign the token to different scopes depending on your needs. See "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#about-scopes-and-permissions-for-package-registries)".
2.  Authenticate to GitHub Packages using your access token and the instructions for your package client.
3.  Publish the package using the instructions for your package client.

Choose your package, and check how to authenticate and publish: [Working with a GitHub Packages registry](https://docs.github.com/packages/working-with-a-github-packages-registry). You'll see below examples for NuGet and npm.

### NuGet registry

You can authenticate to GitHub Packages with the dotnet command-line interface (CLI).

Create a *nuget.config* file in your project directory and specify GitHub Packages as a source under packageSources.

```XML
<?xml version="1.0" encoding="utf-8"?>
<configuration>
    <packageSources>
        <clear />
        <add key="github" value="https://nuget.pkg.github.com/OWNER/index.json" />
    </packageSources>
    <packageSourceCredentials>
        <github>
            <add key="Username" value="USERNAME" />
            <add key="ClearTextPassword" value="TOKEN" />
        </github>
    </packageSourceCredentials>
</configuration>
```

> [!NOTE]
> Replace *USERNAME* with the name of your personal account on GitHub, **TOKEN** with your PAT, and **OWNER** with the name of the user or organization account that owns your project's repository.

You can publish a package authenticating with a *nuget.config* file, or using the --api-key command-line option with your GitHub PAT.

```dotnet CLI
dotnet nuget push "bin/Release/OctocatApp.1.0.0.nupkg" --api-key YOUR_GITHUB_PAT --source "github"
```

### npm registry

You can authenticate using npm by either editing your per-user *~/.npmrc* file to include your PAT or by logging in to npm on the command line using your username and personal access token.

Edit your *~/.npmrc* file for your project to include the following line:

<!--- raw content start --->
//npm.pkg.github.com/:_authToken=TOKEN
<!--- raw content end --->

Create a new *~/.npmrc* file if one doesn't exist.

If you prefer to authenticate by logging in to npm, use the npm login command.

<!--- raw content start --->
$ npm login --scope=@OWNER --registry=https://npm.pkg.github.com

> Username: USERNAME
> Password: TOKEN
> Email: PUBLIC-EMAIL-ADDRESS
<!--- raw content end --->

> [!NOTE]
> Replace *USERNAME* with your GitHub username, *TOKEN* with your PAT, and *PUBLIC-EMAIL-ADDRESS* with your email address.

To publish your npm package, see [Working with the npm registry - GitHub Docs](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-npm-registry#publishing-a-package-using-a-local-npmrc-file).

After you publish a package, you can view the package on GitHub. See "[Viewing packages](https://docs.github.com/packages/learn-github-packages/viewing-packages)".

For an example package page, see [Codertocat/hello-world-npm (github.com)](https://github.com/Codertocat/hello-world-npm/packages/10696?version=1.0.1).

For more information, see:

 -  [Working with the Container registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-container-registry).
 -  [Working with a GitHub Packages registry](https://docs.github.com/packages/working-with-a-github-packages-registry).
 -  [About GitHub Security Advisories](https://docs.github.com/github/managing-security-vulnerabilities/about-github-security-advisories).
 -  [Working with the NuGet registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-nuget-registry).
 -  [Working with the npm registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-npm-registry).
