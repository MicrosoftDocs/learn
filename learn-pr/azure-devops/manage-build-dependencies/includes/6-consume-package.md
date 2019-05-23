In this part, you'll get the new Tailspin.SpaceGame.Web code that has *Models* removed. Instead of referencing the models directly, the code will reference them from the package you created in the previous unit. 

Here is a list of the steps:

> [!div class="checklist"]
> * Get the new code from a branch of the original *Tailspin.SpaceGame.Web* repository.
> * Reference the new Models package, version 1.0.0.
> * Change the build pipeline to look for this package in your Azure Artifacts feed.
> * Watch the pipeline successfully build the application.

## Fetch the branch from GitHub

Here you'll fetch the `models-package` branch from GitHub and checkout, or switch to, that branch.

This branch contains the _Space Game_ project you worked with in the previous modules, but the `Models` code has been removed.

1. From a new instance of Visual Studio Code, open the integrated terminal.

1. Run the following `git checkout` command to create a branch named `models-package` using what's called a _tracking branch_ from Microsoft's repository.

    ```bash
    git fetch upstream models-package
    git checkout models-package
    ```

    Here, `upstream` refers to Microsoft's GitHub repository.

    Your project's Git configuration understands the `upstream` remote because you set up that relationship when you forked the project from Microsoft's repository and cloned it locally.

## Reference the Models package

1. Open the **Tailspin.SpaceGame.Web.csproj** file, add the following `PackageReference` and save the file.

    ```xml
        <PackageReference Include="Tailspin.SpaceGame.Web.Models" Version="1.0.0" />
    ```

    This will reference your Tailspin.SpaceGame.Web.Models package that you created in Azure Artifacts. Notice the version number.

> [!NOTE]
> When you save the file, Visual Studio Code may ask you to restore dependencies. We're not going to run this locally, so there is no need to restore the dependencies. Accessing your Azure Artifacts feed locally requires you to add a package source to Visual Studio and to set up authentication. We'll skip that here for brevity.

## Add a pipeline file for the modified build

1. From Visual Studio Code, select **File > New File**. Then select **File > Save** to save the blank file as **azure-pipelines.yml** in your project's root directory, such as `~/mslearn-tailspin-spacegame-web`.

1. Copy the following yaml into that file:

    [!code-yml[](code/6-azure-pipelines-yaml.yml?highlight=36-42)]

      The highlighted code shows where the pipeline will restore dependencies and look in your Azure Artifacts feed for the dependencies that might be there.

1. Stage, commit, and push your work.

    ```bash
    git add .
    git commit -m "reference Azure Artifacts Models package"
    git push origin models-package
    ```

1. Navigate to your Azure Pipelines and watch the pipeline run. It will pick up your Models package from Azure Artifacts and build the project successfully.