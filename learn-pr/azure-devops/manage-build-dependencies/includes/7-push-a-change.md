Here we push a change to the Models project, build and publish the package to Azure Artifacts, and then consume the package from the application.

### Update a file in the Models project

1. Open a second instance of Visual Studio Code. Leave the *Tailspin.SpaceGame.Web* project open in the first instance.
1. Open the folder for the **Tailspin.SpaceGame.Web.Models** project in this new instance of Visual Studio Code.
1. From the Models project, open the Score.cs file and add the following highlighted property to the list of properties already there.

    [!code-csharp[](code/7-score-property.cs?highlight=23-25)]

    > [!NOTE]
    > We're making a change to a file in the project to show a scenario where you'll bump up the version number. We won't update any code or database to show this, however.

1. Save the file.

1. Build the project.

    ```bash
    dotnet build --configuration Release
    ```

1. Open the **azure-pipelines.yml** file and change the `majorVersion` from `1` to `2` and save the file.

    ```yml
    majorVersion: '2'
    ```

1. Stage, commit, and push your changes.

    ```bash
    git add .
    git commit -m "add GameStyle property"
    git push
    ```

1. Navigate to your Azure DevOps Pipeline for the **Tailspin.SpaceGame.Web.Models** project and watch it run.

1. Open the Artifacts tab and notice the new version number. Don't worry, your old version is still there for any projects that still reference it.

## Reference the new version of the Models package

Here you'll change the *Tailspin.SpaceGame.Web* project to use the new version of the **Tailspin.SpaceGame.Web.Models** package.

1. Go back to the first project in the other instance of Visual Studio Code.

1. Open the **Tailspin.SpaceGame.Web.csproj** file and bump the `PackageReference` version number for the Tailspin.SpaceGame.Web.Models package to match the version we just created in Azure Artifacts. Save the file.

    ```xml
    <PackageReference Include="Tailspin.SpaceGame.Web.Models" Version="2.0.0" />
    ```

    If you see that Visual Studio asks you to restore packages, you can safely ignore that message. For brevity, we won't build this locally.

1. Stage, commit, and push the changes.

    ```bash
    git add .
    git commit -m "edit reference for Models package to v 2.0.0"
    git push
    ```

1. Navigate to your pipelines in Azure DevOps and watch the app build. You see from the build output that it gets the latest dependency and builds the app.