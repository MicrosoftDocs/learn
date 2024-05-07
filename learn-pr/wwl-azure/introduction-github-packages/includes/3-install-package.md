You can install any package you have permission to view from GitHub Packages and use the package as a dependency in your project.

You can search for packages globally across all of GitHub or within a particular organization. For details, see [Searching for packages](https://docs.github.com/search-github/searching-on-github/searching-for-packages).

After you find a package, read the package's installation and description instructions on the package page.

You can install a package using any supported package client following the same general guidelines.

1.  Authenticate to GitHub Packages using the instructions for your package client.
2.  Install the package using the instructions for your package client.

### NuGet

To use NuGet packages from GitHub Packages, you must add dependencies to your *.csproj* file. For more information on using a *.csproj* file in your project, see "[Working with NuGet packages](/nuget/consume-packages/overview-and-workflow)".

If you're using Visual Studio, expand your Solution -&gt; Project -&gt; Right-click on Dependencies -&gt; Manage NuGet Packages...

:::image type="content" source="../media/visual-studio-manage-nuget-packages-a3289d20.png" alt-text="Screenshot of Visual Studio option for manage NuGet packages.":::


You can browse, install and update dependencies from multiple registries. For more information, see [Create and remove project dependencies](/visualstudio/ide/how-to-create-and-remove-project-dependencies).

:::image type="content" source="../media/visual-studio-manage-nuget-packages-browse-3c2e2b84.png" alt-text="Screenshot of how to manage NuGet packages, install and update from Visual Studio.":::


Or, you can update your *.csproj* file directly.

1.  Authenticate to GitHub Packages.
2.  Add ***ItemGroup*** and configure the ***PackageReference*** field in the *.csproj* project file.
    
    ```
    <Project Sdk="Microsoft.NET.Sdk">
    
        <PropertyGroup>
            <OutputType>Exe</OutputType>
            <TargetFramework>netcoreapp3.0</TargetFramework>
            <PackageId>OctocatApp</PackageId>
            <Version>1.0.0</Version>
            <Authors>Octocat</Authors>
            <Company>GitHub</Company>
            <PackageDescription>This package adds an Octocat!</PackageDescription>
            <RepositoryUrl>https://github.com/OWNER/REPOSITORY</RepositoryUrl>
        </PropertyGroup>
    
        <ItemGroup>
            <PackageReference Include="OctokittenApp" Version="12.0.2" />
        </ItemGroup>
    </Project>
    ```
    
    > [!NOTE]
    > Replace the **OctokittenApp** package with your package dependency and **1.0.0** with the version you want to use.
3.  Install the packages with the restore command.

### npm

You need to add the *.npmrc* file to your project to install packages from GitHub Packages.

1.  Authenticate to GitHub Packages.
2.  In the same directory as your package.json file, create or edit a .npmrc file.
3.  Include a line specifying GitHub Packages URL and the account owner.
    
    <!--- raw content start --->
@OWNER:registry=https://npm.pkg.github.com
<!--- raw content end --->
    
    > [!NOTE]
    > Replace **OWNER** with the name of the user or organization account.
4.  Add the *.npmrc* file to the repository. See "[Adding a file to a repository](https://docs.github.com/repositories/working-with-files/managing-files/adding-a-file-to-a-repository)".
5.  Configure *package.json* in your project to use the package you're installing.

```JSON
{
    "name": "@my-org/server",
    "version": "1.0.0",
    "description": "Server app that uses the @octo-org/octo-app package",
    "main": "index.js",
    "author": "",
    "license": "MIT",
    "dependencies": {
        "@octo-org/octo-app": "1.0.0"
    }
}
```

6.  Install the package.
7.  (Optional) If you need to install packages from other organizations, you can add extra lines to your *.npmrc* file.

For more information, see:

 -  [Working with a GitHub Packages registry](https://docs.github.com/packages/working-with-a-github-packages-registry).
 -  [Working with the NuGet registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-nuget-registry).
 -  [Working with the npm registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-npm-registry).
