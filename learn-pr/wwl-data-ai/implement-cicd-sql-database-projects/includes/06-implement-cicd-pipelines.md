Up to this point, every step in the process was manual. Build the project, run SqlPackage, check the deployment report. A CI/CD pipeline turns that sequence into something that happens automatically on every commit, with the same steps, in the same order, every time. No forgotten flags, no typos in connection strings, no "it worked on my machine."

## Design the pipeline structure

Most database pipelines follow a two-stage pattern:

1. **Build**: compile the SQL database project and produce the `.dacpac` artifact.
2. **Deploy**: publish that `.dacpac` to target databases, moving through environments (development, staging, production).

Building once and deploying the same artifact everywhere eliminates the "works in dev, breaks in prod" problem. The `.dacpac` that passed validation in staging is the same file that gets deployed to production.

## Implement a CI/CD pipeline with GitHub Actions

GitHub Actions workflows live in `.github/workflows/` and define your pipeline as YAML. The `azure/sql-action` action handles `.dacpac` deployment to Azure SQL Database.

Here's a workflow that builds on every push to `main` and deploys to production:

```yaml
# .github/workflows/sql-deploy.yml
name: Build and Deploy SQL Project
on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4

    - name: Build SQL project
      run: dotnet build ./Database.sqlproj -o ./output

    - name: Upload dacpac artifact
      uses: actions/upload-artifact@v4
      with:
        name: dacpac
        path: ./output/Database.dacpac

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment: production
    steps:
    - name: Download dacpac artifact
      uses: actions/download-artifact@v4
      with:
        name: dacpac

    - name: Install SqlPackage
      run: dotnet tool install -g microsoft.sqlpackage

    - uses: azure/login@v2
      with:
        client-id: ${{ secrets.AZURE_CLIENT_ID }}
        tenant-id: ${{ secrets.AZURE_TENANT_ID }}
        subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

    - uses: azure/sql-action@v2.3
      with:
        connection-string: ${{ secrets.AZURE_SQL_CONNECTION_STRING }}
        path: './Database.dacpac'
        action: 'publish'
```

&#128221; The `azure/sql-action` supports `.dacpac`, `.sqlproj`, and `.sql` scripts. It works with SQL authentication, Microsoft Entra ID, and service principal authentication.

If your Azure SQL Database has firewall rules enabled, the GitHub Actions runner's IP needs access. When you pair `azure/login` with `azure/sql-action`, the action adds a temporary firewall rule for the runner's IP during deployment and removes it afterward.

## Implement a CI/CD pipeline with Azure DevOps

Azure DevOps provides the `SqlAzureDacpacDeployment` task for `.dacpac` deployment. Here's the equivalent pipeline:

```yaml
# azure-pipelines.yml
trigger:
  - main

pool:
  vmImage: 'windows-latest'

steps:
- task: DotNetCoreCLI@2
  inputs:
    command: 'build'
    projects: './Database.sqlproj'
    arguments: '-o $(Build.ArtifactStagingDirectory)'

- task: PublishBuildArtifacts@1
  inputs:
    PathtoPublish: '$(Build.ArtifactStagingDirectory)/Database.dacpac'
    ArtifactName: 'dacpac'

- task: SqlAzureDacpacDeployment@1
  inputs:
    azureSubscription: 'your-service-connection'
    AuthenticationType: 'server'
    ServerName: 'your-server.database.windows.net'
    DatabaseName: 'your-database'
    SqlUsername: '$(SqlUser)'
    SqlPassword: '$(SqlPassword)'
    deployType: 'DacpacTask'
    DeploymentAction: 'Publish'
    DacpacFile: '$(Build.ArtifactStagingDirectory)/Database.dacpac'
```

For Linux agents or more control over the process, install and use SqlPackage directly:

```yaml
steps:
- script: dotnet tool install --global microsoft.sqlpackage
  displayName: 'Install SqlPackage'

- script: |
    sqlpackage /Action:Publish \
      /SourceFile:$(Build.ArtifactStagingDirectory)/Database.dacpac \
      /TargetConnectionString:"$(ConnectionString)"
  displayName: 'Deploy database'
```

Whether you use GitHub Actions or Azure DevOps, both pipelines need credentials to connect to your database. The next step is making sure those credentials stay out of your YAML files.

A connection string hardcoded in a YAML file is a breach waiting to happen. Both GitHub Actions and Azure DevOps provide mechanisms to store and inject secrets at runtime without exposing them in source control.

### GitHub repository and environment secrets

Store sensitive values as **repository secrets** or **environment secrets**. In your GitHub repository on github.com:

1. Select **Settings** > **Secrets and variables** > **Actions**.
2. Select **New repository secret**.
3. Add a name (like `AZURE_SQL_CONNECTION_STRING`) and the value.

Reference secrets in your workflow with `${{ secrets.SECRET_NAME }}`. Environment secrets are scoped to specific deployment environments, so production credentials are accessible only to jobs targeting production.

### Service principal and OpenID Connect authentication

Better yet, skip passwords entirely. **OpenID Connect (OIDC)** with `azure/login` authenticates using federated credentials, with no client secret stored anywhere. You need three values:

- `AZURE_CLIENT_ID`: The application (client) ID of the service principal.
- `AZURE_TENANT_ID`: Your Microsoft Entra ID tenant ID.
- `AZURE_SUBSCRIPTION_ID`: Your Azure subscription ID.

The service principal authenticates through federated credentials, so there's no password to rotate or leak.

### Azure Key Vault integration

For centralized secrets management, store connection strings and credentials in **Azure Key Vault** and have your pipeline pull them at deployment time. In Azure DevOps, the **Azure Key Vault** task fetches secrets into pipeline variables. In GitHub Actions, use `azure/login` followed by Azure CLI commands to read from the vault.

> [!IMPORTANT]
> Rotate database credentials regularly. Azure Key Vault can integrate with Azure Functions to automate secret rotation, reducing the risk of compromised credentials.

## Implement deployment pipeline controls

A pipeline that deploys to production on every push with no review step is risky for database changes. You need controls that prevent unreviewed changes from reaching production.

### Environment protection rules

Both GitHub and Azure DevOps support **environments** with protection rules that gate deployments:

- **Required reviewers**: one or more team members must approve before the deploy job runs. In GitHub, configure this setting under **Settings** > **Environments** > **Protection rules**.
- **Wait timers**: add a delay between approval and execution, giving the team a window to reconsider.
- **Deployment branches**: restrict which branches can target an environment. For example, only `main` deploys to production.

### Branch policies

Branch policies protect your main branch and serve as the first-line of defense. In Azure DevOps, configure:

- **Minimum number of reviewers** for pull requests.
- **Build validation**, which runs the SQL project build as a PR check before merging.
- **Comment resolution**, requiring all review comments to be addressed.
- **Automatically included reviewers**, so specific people are added to PRs that touch database files.

GitHub provides similar protections through **branch protection rules** or **rulesets**.

### Code owners

A `CODEOWNERS` file (GitHub) or automatically included reviewers policy (Azure DevOps) makes sure the right people review database changes. No SQL file gets merged without the database team seeing it:

```
# .github/CODEOWNERS
/Database/ @db-team
*.sql @db-team @dba-lead
```

This rule requires members of the `db-team` to review any pull request that modifies SQL files or the database project folder.

### Branch control checks

In Azure DevOps, a **branch control check** on service connections locks down which pipelines can access production credentials. Only pipelines running in the context of `main` get access. Even if someone modifies a pipeline on a feature branch to target production, the service connection refuses the request.

## Key takeaways

Use `azure/sql-action` (GitHub Actions) or `SqlAzureDacpacDeployment` (Azure DevOps) to deploy `.dacpac` files from your CI/CD pipeline. Store connection strings and credentials as repository secrets, environment secrets, or in Azure Key Vault, and never hardcode them in YAML files. To authenticate without storing passwords, use OpenID Connect (OIDC) with federated credentials. Gate production deployments with environment protection rules, required reviewers, and deployment branch restrictions. Use `CODEOWNERS` files or automatically included reviewers to ensure that the right people review the database changes. 
