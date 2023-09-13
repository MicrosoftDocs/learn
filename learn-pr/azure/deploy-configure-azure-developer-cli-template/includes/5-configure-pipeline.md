You have learned how to provision and deploy app resources to Azure and how to update them with new changes. However, the previous workflows relied on you manually running commands to apply changes to your environment. The Azure Developer CLI (`azd`) also allows you to further automate this process using a CI/CD pipeline with either GitHub Actions or Azure Pipelines. By configuring a CI/CD pipeline, you can automatically update your Azure environment with the latest changes simply by committing and pushing your changes to GitHub.

## Configure the pipeline

Most `azd` templates have CI/CD workflow files included with them in either the `.github` folder for GitHub Actions or the `.azdo` folder for Azure Pipelines. The sample template used in this module relies on GitHub Actions, but the `azd` command and workflow is the same regardless of the CI/CD platform. A GitHub repository is required for you to be able to setup CI/CD. You can either create the new repository by forking the original `azd` template repository and setting it as a remote, or you can create a repo using `azd` during the pipeline configuration process, which is the approach you'll use in this example.

Complete the following steps to configure a CI/CD pipeline for your template:

1. In a command prompt set to your project root directory, run the following command:

    ```azdeveloper
    azd pipeline config
    ```

1. If a GitHub origin is not set for your project, `azd` will ask how you would like to configure your remote repository. Select the option **Create a new private GitHub repository** and then enter a name for the new repo. `azd` will complete the following tasks for you:

    * Creates a GitHub repository and commits your project code to it.
    * Creates and configures a service principal for the app on the Azure subscription.
    * Configures a secure connection between Azure and your repository using the service principal and GitHub secrets.

1. `azd` will also ask you if you want to commit and push your local changes to the configured pipeline. Enter *yes* and wait for it to finish.

1. Select the output URL in the console to open a browser tab to the new GitHub repository.

1. Navigate to the **Actions** tab to find a workflow running that will authenticate, package, provision and deploy your code. The workflow uses the same `azd auth login`, `azd provision` and `azd deploy` commands you used previously. You can explore the details of this workflow in the `.github` folder of your project.

    :::image type="content" source="../media/azd-actions.png" alt-text="A screenshot showing a GitHub actions workflow running.":::

Once your pipeline is configured, you can continuously update your Azure environment and deployed app by simply pushing your code changes to GitHub. You can also continue to run `azd` commands locally like you did in the previous steps.
