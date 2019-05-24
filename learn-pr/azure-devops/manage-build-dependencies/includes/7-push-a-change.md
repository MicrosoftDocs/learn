At this point, you have two pipelines &mdash; one that publishes the Models package to Azure Artifacts and one for the _Space Game_ web application. The build configuration for the web application references the Models package so that it can access the model classes.

Here, you'll practice the process of updating the Models package and consuming that change from the web application.

To do that, you'll start by adding a property to one of the model classes, bumping the package version, and then submitting the change to GitHub so that the pipeline can build the package and publish it to Azure Artifacts.

Then you'll update the web application to reference the newer version number of the Models package so that it can use the added property.

## Add a property to the Models package

Here you'll add a property to one of the model classes, named `Score`, that provides the game style, or difficulty, the score is associated with.

1. Open a second instance of Visual Studio Code. Leave the **Tailspin.SpaceGame.Web** project open in the first instance.
1. Open the folder for the **Tailspin.SpaceGame.Web.Models** project in this new instance of Visual Studio Code.
1. From the Models project, open **Score.cs** and add the following highlighted property to the list of properties already there.

    [!code-csharp[](code/7-score-property.cs?highlight=23-25)]

    > [!NOTE]
    > We're making a change to a file in the project to demonstrate where you bump up the version number. However, we won't update the web application to use the new property.

1. Save the file.

1. Build the project to verify your work.

    ```bash
    dotnet build --configuration Release
    ```

    In practice, you might perform additional verification steps, such as running tests or testing the new package with an application that uses it.

## Build and publish the package

Now that you've added the new property to the `Score` class and verified the project builds successfully, you can update the package's version and push your change to GitHub so that Azure Pipelines can build and publish the updated package.

1. Open **azure-pipelines.yml** and change the `majorVersion` from `1` to `2` and save the file.

    ```yml
    majorVersion: '2'
    ```

    Here, we bump the version from 1.0.0 to 2.0.0 to make the change clear. In practice, you would follow the versioning scheme for the kind of package you're working with.

    For example, according to Semantic Versioning, bumping the major version to 2 tells others that the package is not backwards compatible with applications that use version 1 of that package. Those that use the package would need to modify their application to adapt to any breaking changes.

    Popular open source projects provide documentation in the form of a _changelog_ that explains the changes made in each version as well as how to migrate from one major version to the next.

1. Stage, commit, and push your changes.

    ```bash
    git add .
    git commit -m "Add GameStyle property"
    git push
    ```

1. From Azure Pipelines, navigate to the **Tailspin.SpaceGame.Web.Models** project and watch the build run.

1. Open the **Artifacts** tab and note the new version. Don't worry, your old version is still there for any projects that still reference it.

## Reference the new version of the Models package

Here you'll change the **Tailspin.SpaceGame.Web** project to use the new version of the **Tailspin.SpaceGame.Web.Models** package.

1. Go back to the first project in the other instance of Visual Studio Code.

1. Open the **Tailspin.SpaceGame.Web.csproj** file and bump the `PackageReference` version number for the **Tailspin.SpaceGame.Web.Models** package to match the version we just created in Azure Artifacts. Save the file.

    ```xml
    <PackageReference Include="Tailspin.SpaceGame.Web.Models" Version="2.0.0" />
    ```

    If Visual Studio Code asks you to restore packages, you can safely ignore that message. For brevity, we won't build the web application locally.

1. Stage, commit, and push the changes.

    ```bash
    git add .
    git commit -m "Bump Models package to 2.0.0"
    git push
    ```

1. From Azure Pipelines, navigate to the **Tailspin.SpaceGame.Web** project and watch the build run.

    You see from the build output that it gets the latest dependency, builds the application, and publishes the artifact for the web application.