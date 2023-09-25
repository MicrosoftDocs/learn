In this unit, you'll get the new **Tailspin.SpaceGame.Web** code that has the model classes removed. Instead of referencing the models directly, the code will reference them from the package you created in the previous unit.

Here's a list of the steps:

> [!div class="checklist"]
> * Get the new code from a branch of the original **Tailspin.SpaceGame.Web** repository.
> * Reference the new Models package, version 1.0.0.
> * To look for this package in your Azure Artifacts feed, change the build pipeline.
> * Watch the pipeline successfully build the app.

## Fetch the branch from GitHub

Fetch the `models-package` branch from GitHub and check out, or switch to, that branch.

This branch contains the _Space Game_ project you worked with in the previous modules, but the **Models** directory has been removed.

1. Switch to your copy of Visual Studio Code that shows the **Tailspin.SpaceGame.Web** project.
1. From the terminal, to fetch a branch named `models-package` from the Microsoft repository, run the following `git` commands. Then, switch to that branch.

    ```bash
    git fetch upstream models-package
    git checkout -B models-package upstream/models-package
    ```

    The format of these commands allows you to get starter code from the Microsoft repository on GitHub, known as `upstream`. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

1. As an optional step, verify that the **Models** directory no longer exists in the file explorer. Instead, you should have **Controllers**, **Views**, and other directories.

## Reference the Models package

1. Open the **Tailspin.SpaceGame.Web.csproj** file and add the following `ItemGroup`:

    [!code-xml[](code/6-tailspin.spacegame.web.csproj?highlight=2)]

    Be sure to place the `ItemGroup` inside the `Project` node. Your file should resemble this:

    ```xml
    <Project Sdk="Microsoft.NET.Sdk.Web">

      <PropertyGroup>
        <TargetFramework>net6.0</TargetFramework>
        <ProjectGuid>{A0C4E31E-AC75-4F39-9F59-0AA19D9B8F46}</ProjectGuid>
      </PropertyGroup>
    
      <ItemGroup>
        <PackageReference Include="Tailspin.SpaceGame.Web.Models" Version="1.0.0" />
      </ItemGroup>
    
      <ItemGroup>
        <Folder Include="wwwroot\images\avatars\" />
      </ItemGroup>
    </Project>
    ```

1. Modify the version, "1.0.0", to include the pre-release prefix that was generated during the build process. Here's an example:

    ```xml
    <PackageReference Include="Tailspin.SpaceGame.Web.Models" Version="1.0.0-CI-20200610-165738" />
    ```

    This references the **Tailspin.SpaceGame.Web.Models** package that you created in Azure Artifacts. Notice the version number, 1.0.0, plus the pre-release suffix. This matches the initial version that you published to Azure Artifacts in the previous unit.

1. Save the file.

    > [!NOTE]
    > When you save the file, Visual Studio Code might ask you to restore dependencies. Select the **Restore** button to restore the dependencies.

## Modify the pipeline configuration

The `models-package` branch provides an initial *azure-pipelines.yml* file. Here, you'll modify the pipeline configuration to pull the **Tailspin.SpaceGame.Web.Models** package from Azure Artifacts.

1. From Visual Studio Code, open *azure-pipelines.yml*.

1. Modify *azure-pipelines.yml* as shown here:

    [!code-yml[](code/6-azure-pipelines-yaml.yml?highlight=39-45)]

    The highlighted code shows where the pipeline restores dependencies, and looks in your Azure Artifacts feed for the dependencies that might be there.

1. Stage, commit, and push your changes to GitHub.

    ```bash
    git add .
    git commit -m "Add reference to Models package"
    git push origin models-package
    ```

1. Go to Azure Pipelines and watch the build run. The build picks up your Models package from Azure Artifacts and builds the project successfully.
