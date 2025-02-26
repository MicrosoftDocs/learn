Integrating GitHub repositories with Azure Pipelines offers a solution for teams that plan to create new or have existing repositories on GitHub but seek to leverage the capabilities of Azure Pipelines for continuous integration and deployment. This approach allows organizations to capitalize on their existing expertise in Azure Pipelines while benefiting from the collaborative features and familiarity of GitHub for version control and code management.

## Planning

While GitHub and Azure Pipelines offer tight integration with each other, they're two independent services with their own organization, user management, and permission model. To implement and managing that integration, you should consider several considerations.

### Naming convention

Consider aligning the way GitHub repos and Azure Pipelines are named and structured. In particular:

 -  If you don't have an Azure DevOps organization yet, create one named the same as your GitHub organization or account. For example, assuming that your GitHub organization is named org1, the resulting Azure DevOps organization URL would be https://dev.azure.com/org1.
 -  In the Azure DevOps organization, create projects named the same as the GitHub repositories. For example, assuming that your GitHub repo is named repo1, the resulting URL would be https://dev.azure.com/org1/repo1.
 -  In the DevOps project, create pipelines named after the corresponding GitHub organization and repository, such as org1.repo1.

Note that this alignment isn't required, but it will help you clearly indicate the relationship between GitHub repos and their respective Azure Pipelines.

### User management

By default, GitHub users don't have access to Azure Pipelines. Similarly, Azure Pipelines aren't aware of GitHub identities. Consequently, it isn't possible to configure Azure Pipelines to automatically notify these users about build or deployment related issues. To remediate this, add the user accounts to the Azure DevOps organization and configure their permissions to match those in the GitHub organization. At that point, you'll be able to set up Azure Pipelines user notifications.

### Azure Pipeline permissions

Azure Pipelines must be able to access GitHub repositories to trigger their builds, and fetch their code during builds. You can grant this access can by using the following methods:

 -  GitHub App authentication with the Azure Pipelines identity
 -  OAuth with your personal GitHub identity
 -  GitHub personal access token (PAT) with your personal GitHub identity

#### GitHub app authentication

The Azure Pipelines GitHub App is the recommended authentication type for continuous integration pipelines, since it doesn't rely on your personal GitHub identity. In addition, this method supports GitHub Checks to display build, test, and code coverage results in GitHub.

#### OAuth

OAuth authorization is suitable when working with personal GitHub accounts. In this case, GitHub status updates are performed in the security context of your personal GitHub identity.

#### GitHub personal access token

As with OAuth, PAT relies on your personal GitHub identity for authentication, but its permissions can be configured in a very granular manner. On the other hand, PAT is subject to expiration and revocation, so you need to ensure that it remains valid for as long as you need to run the corresponding pipelines.

## Implementation

To use the GitHub App, install it in your GitHub organization for all repositories (as the organization owner) or some of them (as the repo admin). Following the installation, any pipelines targeting these repositories will, by default, use this authentication method.

To use OAuth, select Choose a different connection under the list of repositories while creating a pipeline. Then, select Authorize to sign into GitHub and authorize with OAuth. An OAuth connection is saved in your Azure DevOps project. You'll be able to reference later if needed when creating additional pipelines.

To use a PAT, use the GitHub settings page. Set the permissions to repo, admin:repo\_hook, read:user, and user:email. Copy the generated PAT into a new GitHub service connection in your Azure DevOps project settings. Reference the service connection name when creating pipelines.

When creating a pipeline, select the target GitHub repository and then a YAML file in that repository. The repository in which the YAML file is present is called self. By default, this is the repository that the pipeline will build. You can also configure the same pipeline to check out additional repositories.

When you create pipelines for a single repository across multiple Azure DevOps organizations, only the first pipeline can be automatically triggered by GitHub commits or pull requests. The remaining pipelines can access the repository, but invoking them requires manual or scheduled triggers.
