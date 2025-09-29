Integrating GitHub repositories with Azure Pipelines combines the collaborative features of GitHub with the robust CI/CD capabilities of Azure Pipelines. This integration allows teams to use GitHub for source control while leveraging Azure Pipelines for automated builds, testing, and deployments.

## Planning your integration

GitHub and Azure Pipelines are separate services with independent user management and permission models. Consider these key aspects when planning your integration:

## Naming conventions

Establish consistent naming patterns between GitHub repositories and Azure Pipelines to improve organization and clarity:

**Azure DevOps organization**: Create an Azure DevOps organization with the same name as your GitHub organization. For example:

- GitHub organization: `contoso`
- Azure DevOps organization: `https://dev.azure.com/contoso`

**Project naming**: Create Azure DevOps Projects that match your GitHub repository names. For example:

- GitHub repository: `contoso/webapp`
- Azure DevOps project: `https://dev.azure.com/contoso/webapp`

**Pipeline naming**: Use descriptive names that reference both the GitHub organization and repository, such as `contoso.webapp.ci` or `contoso.webapp.deploy`.

While this alignment isn't mandatory, it helps teams understand the relationship between repositories and their associated pipelines.

## User management

GitHub users don't automatically have access to Azure Pipelines, and Azure Pipelines doesn't recognize GitHub identities by default. This separation means Azure Pipelines can't automatically send notifications to GitHub users about build or deployment events.

To enable proper user notifications:

1. Add GitHub users to your Azure DevOps organization
2. Configure their permissions to match their GitHub repository access levels
3. Set up notification rules to inform users about pipeline events

This approach ensures team members receive appropriate notifications about builds, deployments, and other pipeline activities.

## Authentication methods

Azure Pipelines needs access to your GitHub repositories to trigger builds and fetch code. Choose from these authentication methods:

**GitHub App authentication** (Recommended):

- Uses Azure Pipelines identity instead of personal accounts
- Supports GitHub Checks for displaying build, test, and coverage results
- More secure and doesn't depend on individual user accounts

**OAuth authentication**:

- Suitable for personal GitHub accounts
- GitHub status updates appear under your personal identity
- Easy to set up for individual developers

**Personal Access Token (PAT)**:

- Offers granular permission control
- Uses your personal GitHub identity
- Requires regular maintenance due to expiration and potential revocation

## Implementation steps

**Setting up GitHub App authentication**:

1. Install the Azure Pipelines GitHub App in your GitHub organization
2. Grant access to all repositories or specific ones (requires organization owner or repository admin rights)
3. New pipelines automatically use this authentication method

**Configuring OAuth authentication**:

1. During pipeline creation, select "Choose a different connection"
2. Select "Authorize" to sign into GitHub with OAuth
3. The OAuth connection is saved for reuse in additional pipelines

**Using Personal Access Tokens**:

1. Generate a PAT in GitHub settings with these permissions: `repo`, `admin:repo_hook`, `read:user`, `user:email`
2. Create a GitHub service connection in Azure DevOps project settings
3. Reference the service connection when creating pipelines

## Pipeline configuration

When creating your pipeline:

1. Select your target GitHub repository
2. Choose a YAML file from the repository (the repository containing the YAML file becomes the "self" repository)
3. Configure additional repositories if needed

> [!IMPORTANT]
> When multiple Azure DevOps organizations access the same GitHub repository, only the first pipeline can use automatic triggers. Additional pipelines require manual or scheduled triggers.
