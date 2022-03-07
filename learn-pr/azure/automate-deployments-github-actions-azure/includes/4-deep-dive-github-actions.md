You've deployed all the elements of your solution, but some updates and configurations are required. The next step is to automate the deployment of the updates to your solution.

GitHub Actions help you automate tasks within your software development life cycle. GitHub Actions are event-driven, meaning that you can run a series of commands after a specified event has occurred. For example, every time someone creates a pull request for a repository, you can automatically run a command that executes a software testing script.

Azure DevOps is a similar service that automatically builds and tests code projects to make them available to others. It works with just about any language or project type and could be used in place of GitHub Actions in this solution if desired.

## Understand DevOps and CI/CD concepts

DevOps is a combination of development (Dev) and operations (Ops). DevOps is the union of people, process, and technology to continually provide value to customers. Teams that adopt DevOps culture, practices, and tools become high-performing: building better products faster for greater customer satisfaction.

A Continuous Integration and Continuous Delivery (CI/CD) pipeline is the backbone of a DevOps environment, and most Azure resources can be fully integrated with any CI/CD tool you choose. Two of the most common and widely tools used in Azure are GitHub Actions and Azure DevOps.

## Implement deployment automation with GitHub Actions

In the catching the bus example, there are three key services using GitHub Actions: Azure SQL Database, Azure Functions, and Azure Static Web Apps. Let's review how each service works in the scenario. In the next exercise, you'll get to see the pieces in action.

### Automate deployment of Azure SQL Database using the SQL Action

There is a specific GitHub Action available through Azure called the **SQL Action**. This action was created to work with Azure SQL services. Let's review how the main part of the workflow (YAML) file is constructed. As an example, let's use the catch the bus sample.

Below you are looking at the job within the workflow file. When a push happens or a pull request is merged, this job will run. The workflow uses `Azure/sql-action@v1.2`, which does most of the heavy lifting. You just have to provide the items under `with`: the connection string (stored as a secret in the repository), and the location of the .dacpac file. A .dacpac file contains the necessary database schema that is required for the database. The action will incrementally update the database schema to match the schema of the source .dacpac file.

```yml
  deploy_database_job:
    if: github.event_name == 'push' || (github.event_name == 'pull_request' && github.event.action != 'closed')
    runs-on: ubuntu-latest
    name: Deploy Database Job
    steps:
      - uses: actions/checkout@v2
      - uses: Azure/sql-action@v1.2
        with:
          connection-string: ${{ secrets.AZURE_SQL_CONNECTION_STRING }}
          # uses dacpac to deploy database schema
          dacpac-package: './Database/dacpac/bus-db.dacpac'
```

### Automate deployment of Azure Functions in any language

Similar to Azure SQL, connecting to Azure Functions from GitHub Actions is not difficult. The documentation provides several sample snippets depending on the language you want to use, and then you fill it in. Just like a connection string for Azure SQL is required, you have to include your function's *Publish Profile*, which specifies how to connect to Azure Functions. Additionally, just like you had to specify the 'code' for your database's schema, you also have to specify where in your repository the code is located. Finally, depending on the language, you'll need to specify the version (for example, `NODE_VERSION: '14.x'`).

### Implement CI/CD by default using Azure Static Web Apps

During the deployment of the Azure Static Web App in the previous exercise, you connected your service with GitHub by providing the repository and a GitHub token. Azure Static Web Apps and GitHub Actions are tightly integrated, so the deployment takes care of creating the workflow file.

A typical Azure Static Web Apps workflow file contains two jobs: `build_and_deploy_job` and `close_pull_request_job`. The first job uses the `upload` action to build and deploy the code in the repository. The second job uses the `close` action to close out the pull request and deployment.

By default, the following code makes up the first job. Regardless of how you deploy, the secrets will be created during deployment. Post deployment, you may need to update the `app_location` and `api_location` to match where those pieces are located in your repository.

```yml
      - name: Build And Deploy
        id: builddeploy
        uses: Azure/static-web-apps-deploy@v1
        with:
          azure_static_web_apps_api_token: ${{ secrets.AZURE_STATIC_WEB_APPS_API_TOKEN }}
          repo_token: ${{ secrets.GITHUB_TOKEN }} # Used for Github integrations (i.e. PR comments)
          action: "upload"
          ###### Repository/Build Configurations - These values can be configured to match you app requirements. ######
          # For more information regarding Static Web App workflow configurations, please visit: https://aka.ms/swaworkflowconfig
          app_location: "." # App source code path
          api_location: "." # Api source code path - optional
          output_location: "dist" # Built app content directory - optional
          ###### End of Repository/Build Configurations ######
```

The second job, `close_pull_request_job`, simply calls the `close` action and there are no changes necessary.
