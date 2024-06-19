At this point, you have two pipelines. One publishes the Models package to Azure Artifacts, and one is for the _Space Game_ web app. The build configuration for the web app references the Models package so that it can access the model classes.

Here, you'll practice updating the Models package and consuming that change from the web app.

To do that, you'll start by adding a property to one of the model classes and then bump the package version. Then, you'll submit the change to GitHub so that the pipeline can build the package and publish it to Azure Artifacts.

You'll then update the web app to reference the newer version number of the Models package so that it can use the added property.

## Create a branch

Let's start by creating a branch to hold our work. Create a branch named `add-game-style`, which is based off the `main` branch.

At this point, you have two copies of Visual Studio Code open, one for the **Tailspin.SpaceGame.Web.Models** project and one for the _Space Game_ web app project, **Tailspin.SpaceGame.Web**. Here, you'll work from the copy for the **Tailspin.SpaceGame.Web.Models** project.

1. From Visual Studio Code, open the integrated terminal.
1. From the terminal, to create a branch named `add-game-style`, run the following `git checkout` command.

    ```bash
    git checkout -B add-game-style
    ```

## Add a property to the Models package

Add a property named `Score`to one of the model classes, which provides the game style (or difficulty) with which the score is associated.

Here, you'll work from the copy of Visual Studio Code for the **Tailspin.SpaceGame.Web.Models** project.

1. From Visual Studio Code, open *Tailspin.SpaceGame.Web.Models/Models/Score.cs*. Add the following highlighted property to the list of properties already there.

    [!code-csharp[](code/7-score-property.cs?highlight=23-25)]

    > [!NOTE]
    > You're making a change to a file in the project to demonstrate where you bump up the version number. However, we won't update the web app to use the new property.

1. Save the file.

1. To verify your work, build the project:

    ```dotnetcli
    dotnet build --configuration Release
    ```

    In practice, you might perform additional verification steps, such as running tests or testing the new package with an app that uses it.

## Build and publish the package

Now that you've added the new property to the `Score` class and verified the project builds successfully, you can update the package's version. You can then push your change to GitHub so that Azure Pipelines can build and publish the updated package.

1. Open *azure-pipelines.yml*, change the `minorVersion` from `0` to `1`, and save the file.

    ```yml
    minorVersion: '1'
    ```

    Here, we bump the version from 1.0.0 to 1.1.0 to make the change clear. In practice, you'd follow the versioning scheme for the kind of package you're working with.

    For example, according to Semantic Versioning, bumping the minor version to 1 (1.1.0) tells others that the package is backward compatible with apps that use version 1.0.0 of that package. Those who use the package might then modify their app to make use of new features.

    Popular open-source projects provide documentation in the form of a _changelog_ that explains the changes made in each version and how to migrate from one major version to the next.

1. Stage, commit, and push your changes:

    ```bash
    git add .
    git commit -m "Add GameStyle property"
    git push origin add-game-style
    ```

1. From Microsoft Azure Pipelines, go to the **Tailspin.SpaceGame.Web.Models** project, and watch the build run.

1. Open the **Artifacts** tab and note the new version. Don't worry; your old version is still there for any projects that still reference it.

    :::image type="content" source="../media/7-artifacts-package-ver2.png" alt-text="A screenshot of the package in Azure Artifacts, showing version 1.1 of the package.":::

1. As you did previously, write down the new version for the next unit.

## Reference the new version of the Models package

Now, change the **Tailspin.SpaceGame.Web** project to use the new version of the **Tailspin.SpaceGame.Web.Models** package.

Here, you'll work from the copy of Visual Studio Code for the _Space Game_ web app project, **Tailspin.SpaceGame.Web**.

1. From Visual Studio Code, open **Tailspin.SpaceGame.Web.csproj**, and change `PackageReference` to the version number of the **Tailspin.SpaceGame.Web.Models** package you created in Azure Artifacts. Then, save the file.

    Here's an example:

    ```xml
    <PackageReference Include="Tailspin.SpaceGame.Web.Models" Version="1.1.0-CI-20210528-202436" />
    ```

    If Visual Studio Code asks you to restore packages, you can safely ignore that message. For brevity, we won't build the web app locally.

1. From the terminal, stage, commit, and push the changes.

    ```bash
    git add .
    git commit -m "Bump Models package to 1.1.0"
    git push origin models-package
    ```

1. From Azure Pipelines, go to the **mslearn-tailspin-spacegame-web** project, and watch the build run.

    You see from the build output that it gets the latest dependency, builds the app, and publishes the artifact for the web app.
