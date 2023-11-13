You created a template and provisioned its resources on Azure. However, the previous workflows relied on manual commands to apply changes to your environment. The starter template also provides configuration files to further automate this process using a CI/CD pipeline with either GitHub Actions or Azure Pipelines. By configuring a CI/CD pipeline, you can automatically update your Azure environment with the latest changes simply by committing and pushing your changes to GitHub.

## Configure the pipeline

Most `azd` templates include CI/CD workflow files in either the `.github` folder for [GitHub Actions](/training/modules/introduction-to-github-actions/) or the `.azdo` folder for [Azure Pipelines](/training/paths/deploy-applications-with-azure-devops/) (or both). The sample template created in this module was initialized with both. These workflow files use a standard structure for their respective platforms, so an in-depth exploration of CI/CD workflow configurations is beyond the scope of this module. However, a deep understanding of GitHub Actions or Azure Pipelines isn't required to complete this module, since `azd` abstracts much of the work behind simple commands that use the workflow configuration files.

The `azd` command and workflow to configure a CI/CD pipeline is the same regardless of whether you choose GitHub Actions or Azure Pipelines. A GitHub repository is required for you to be able to set up CI/CD. You can either create the new repository by forking the original `azd` template repository and setting it as a remote, or you can create a repo using `azd` during the pipeline configuration process, which is the approach you'll use in this example.

Complete the following steps to configure a CI/CD pipeline for your template:

1. In a command prompt set to your project root directory, run the following command:

    ```azdeveloper
    azd pipeline config
    ```

1. If a GitHub origin isn't set for your project, `azd` asks how you would like to configure your remote repository. Select the option **Create a new private GitHub repository** and then enter a name for the new repo. `azd` completes the following tasks for you:
    * Creates a GitHub repository and commits your project code to it.
    * Creates and configures a service principal for the app on the Azure subscription.
    * Configures a secure connection between Azure and your repository using the service principal and GitHub secrets.

1. `azd` also asks you if you want to commit and push your local changes to the configured pipeline. Enter *yes* and wait for it to finish.

1. Select the output URL in the console to open a browser tab to the new GitHub repository.

1. Navigate to the **Actions** tab to find a workflow running that will authenticate, package, provision and deploy your code. The workflow uses the same `azd auth login`, `azd provision` and `azd deploy` commands you used previously. You can explore the details of this workflow in the `.github` folder of your project.

    :::image type="content" source="../media/azd-actions.png" alt-text="A screenshot showing a GitHub actions workflow running.":::

With the pipeline configured, you can continuously update your Azure environment and deployed app by pushing your code changes to GitHub. You can also continue to run `azd` commands locally like you did in the previous steps.
