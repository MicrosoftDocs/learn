You have learned how to provision and deploy app resources to Azure and how to update them with new changes. However, the previous workflows relied on you manually running commands to apply changes to your environment. The Azure Developer CLI (`azd`) also allows you to further automate this process using a CI/CD pipeline with either GitHub Actions or Azure Pipelines. By configuring a CI/CD pipeline, you can automatically update your Azure environment with the latest changes simply by committing and pushing your changes to GitHub.

## Configure the CI/CD pipeline

Most `azd` templates have CI/CD workflow files included with them in either the `.github` folder for GitHub Actions or the `.azdo` folder for Azure Pipelines. The sample template used in this module relies on GitHub Actions, but the `azd` command and workflow is the same regardless of the CI/CD platform. A GitHub repository is required for you to be able to setup CI/CD. You can either create this ahead of time by forking the original `azd` template repository, or you can create a repo using `azd` during the process of configuring the pipeline.

Complete the following steps to configure your template to use a CI/CD piepline:

1. In a command prompt opened to your project root directory, run the following command:

    ```azdeveloper
    azd pipeline
    ```

1. If a GitHub origin is not set for your project, `azd` will how you would like to configure your remote repository Select the option **Create a new private GitHub repository** and then enter a name for the new repo. `azd` will complete the following tasks for you:
    * Creates and configures a Service Principal for the app on the Azure subscription.
    * Steps you through a workflow to create and configure a GitHub repository and commit your project code to it. You can also choose to use an existing GitHub repository.
    * Creates a secure connection between Azure and your repository using GitHub secrets.
    * Runs the GitHub action when you check in the workflow file.

1. `azd` will also ask you if you want to commit and push your local changes to the configured pipeline. Enter *yes* and wait for it to finish.

1. Select the output URL in the console to open a browser tab to the new GitHub repository.

1. Navigate to the **Actions** tab, and you should see a workflow running to package, provision and deploy your code. GitHub Actions is essentially running `azd up` for you, just like you did in your local environment.

Once your pipeline is configured, you can continuously update your Azure environment and deployed app by simply pushing your code changes to GitHub. You can also continue to run the commands locally like you did in the previous steps. Infrastructure as code files are idempotent, meaning no matter how many times you run them, the desired state will remain consistent.
