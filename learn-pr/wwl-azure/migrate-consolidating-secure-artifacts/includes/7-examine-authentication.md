**Authentication** is critical for securing access to package feeds in Azure Artifacts. Understanding the different authentication mechanisms ensures secure and seamless access for users, build pipelines, and external tools.

## Azure DevOps user authentication

Azure DevOps users will authenticate against **Microsoft Entra ID** (formerly Azure Active Directory) when accessing the Azure DevOps portal.

### Transparent authentication

After being **successfully authenticated**, they won't have to provide any credentials to Azure Artifacts itself.

**Authorization versus authentication:**

- **Authentication:** Verifies user identity through Microsoft Entra ID.
- **Authorization:** The roles for the user, based on its identity, or team and group membership, are for authorization.

**User experience:**

When access is allowed, the user can navigate to the **Azure Artifacts section** of the team project without additional authentication prompts.

## Azure Pipelines authentication

The **authentication** from **Azure Pipelines** to Azure Artifacts feeds is taken care of **transparently**.

### Build identity authentication

It will be based upon the **roles** and their **permissions** for the **build identity**.

**Default build identity:**

- **Project Collection Build Service:** Organization-wide build identity with access to feeds.
- **Project-scoped build identity:** Project-specific identity that may need explicit permissions.

The previous section on **Roles** covered some details on the required roles for the build identity.

**Automatic authorization:**

- **No credentials required:** Pipelines automatically authenticate using the build service identity.
- **Role-based access:** Access is granted based on the build identity's assigned role.
- **Seamless integration:** No configuration needed for feeds in the same organization.

## Internal versus external authentication

The authentication from inside Azure DevOps doesn't need any **credentials** for accessing feeds by itself.

### External feed authentication

However, when accessing **secured feeds outside Azure Artifacts**, such as other package sources, you most likely must provide **credentials** to authenticate to the **feed manager**.

**External feed scenarios:**

- **Third-party registries:** npmjs.com, NuGet.org with authentication.
- **Private registries:** Self-hosted package servers.
- **Other Azure DevOps organizations:** Feeds in different organizations.

**Authentication requirements:**

Each package type has its way of handling the **credentials** and providing access upon authentication. The **command-line tooling** will provide support in the authentication process.

### Service connections for pipelines

For the **build tasks** in **Azure Pipelines**, you'll provide the credentials via a **Service connection**.

**Service connection types:**

- **NuGet service connection:** For external NuGet feeds.
- **npm service connection:** For external npm registries.
- **Generic service connection:** For other feed types with basic authentication.

## Personal Access Tokens (PATs)

**Personal Access Tokens** provide a secure way to authenticate when accessing Azure Artifacts from external tools and scripts.

### Creating a PAT

1.  **User settings:** Navigate to your user settings in Azure DevOps.
2.  **Personal Access Tokens:** Select "Personal access tokens" from the security section.
3.  **New token:** Click "New Token" to create a new PAT.
4.  **Configure scopes:** Select the required scopes for Azure Artifacts.
5.  **Set expiration:** Choose an expiration date for the token.
6.  **Create:** Generate the token and save it securely.

**Required scopes:**

- **Packaging (Read):** For consuming packages from feeds.
- **Packaging (Read & write):** For consuming and publishing packages.
- **Packaging (Read, write, & manage):** For full feed management.

### Using PATs

**In package managers:**

```bash
# npm - store PAT in .npmrc
//pkgs.dev.azure.com/{organization}/_packaging/{feed}/npm/registry/:username={organization}
//pkgs.dev.azure.com/{organization}/_packaging/{feed}/npm/registry/:_password={base64_encoded_PAT}
//pkgs.dev.azure.com/{organization}/_packaging/{feed}/npm/registry/:email=npm@contoso.com
//pkgs.dev.azure.com/{organization}/_packaging/{feed}/npm/:always-auth=true

# NuGet - add source with authentication
nuget sources add -Name "MyFeed" -Source "https://pkgs.dev.azure.com/{organization}/_packaging/{feed}/nuget/v3/index.json" -Username {username} -Password {PAT}

# Maven - configure in settings.xml
<server>
  <id>azure-feed</id>
  <username>{organization}</username>
  <password>{PAT}</password>
</server>
```

### PAT best practices

**Security:**

- **Minimal scopes:** Grant only the scopes needed for the task.
- **Short expiration:** Use short expiration periods (30-90 days).
- **Rotate regularly:** Replace tokens before they expire.
- **Secure storage:** Never commit PATs to source control.

**Environment variables:**

Store PATs in environment variables rather than hardcoding them:

```bash
# Set environment variable
export AZURE_ARTIFACTS_PAT="your_pat_here"

# Use in scripts
echo $AZURE_ARTIFACTS_PAT | base64 | pbcopy
```

## Credential Providers

**Credential providers** simplify authentication by automatically handling credentials for package managers.

### Azure Artifacts Credential Provider

**Installation:**

```bash
# Install for .NET/NuGet
iex "& { $(irm https://aka.ms/install-artifacts-credprovider.ps1) }"

# Or using PowerShell
wget -qO- https://aka.ms/install-artifacts-credprovider.ps1 | sh
```

**How it works:**

- **Automatic authentication:** Prompts for credentials when accessing authenticated feeds.
- **Token caching:** Stores credentials securely for reuse.
- **Interactive and non-interactive modes:** Supports both user interaction and automated scenarios.

**Non-interactive authentication:**

```bash
# Set environment variable for non-interactive mode
export VSS_NUGET_EXTERNAL_FEED_ENDPOINTS='{"endpointCredentials": [{"endpoint":"https://pkgs.dev.azure.com/{organization}/_packaging/{feed}/nuget/v3/index.json", "username":"optional", "password":"{PAT}"}]}'
```

### npm credential provider

**Using vsts-npm-auth:**

```bash
# Install globally
npm install -g vsts-npm-auth

# Run to authenticate
vsts-npm-auth -config .npmrc
```

**Automatic authentication:**

The tool updates your `.npmrc` file with credentials that are automatically refreshed.

## Service principals

**Service principals** provide a secure way to authenticate applications and services without using user credentials.

### Creating a service principal

1.  **Azure Active Directory:** Navigate to Azure AD in the Azure portal.
2.  **App registrations:** Create a new app registration.
3.  **Credentials:** Generate a client secret or certificate.
4.  **Azure DevOps permissions:** Add the service principal to your Azure DevOps organization.
5.  **Feed permissions:** Grant the service principal appropriate role on your feeds.

### Using service principals

**In CI/CD pipelines:**

```yaml
# Azure Pipelines - using service connection
steps:
  - task: NuGetAuthenticate@1
    inputs:
      serviceConnection: "MyServiceConnection"

  - script: |
      dotnet pack
      dotnet nuget push "**/*.nupkg" --source "MyFeed"
    displayName: "Publish package"
```

**Benefits:**

- **No user dependency:** Not tied to a specific user account.
- **Long-lived:** Don't expire like user PATs.
- **Auditable:** Clear separation between user and service accounts.

## Authentication for different scenarios

### Developer workstations

**Interactive authentication:**

- **Microsoft Entra ID:** Single sign-on through Azure DevOps portal.
- **Credential providers:** Automatic prompts for credentials.
- **PATs:** Manual configuration for command-line tools.

### Build and release pipelines

**Automated authentication:**

- **Build service identity:** Automatic for feeds in the same organization.
- **Service connections:** For external feeds and cross-organization access.
- **Service principals:** For production deployments and long-lived automation.

### External tools and scripts

**Programmatic authentication:**

- **PATs:** For scripts and automation.
- **Service principals:** For applications and services.
- **API tokens:** For REST API access.

## Troubleshooting authentication

### Common issues

**401 Unauthorized:**

- **Check credentials:** Verify PAT is correct and not expired.
- **Check scopes:** Ensure PAT has appropriate scopes for the operation.
- **Check permissions:** Verify user/service has correct role on the feed.

**403 Forbidden:**

- **Check permissions:** User is authenticated but doesn't have required role.
- **Check feed visibility:** Ensure user has access to the feed.

**Credential caching issues:**

- **Clear credentials:** Remove cached credentials and re-authenticate.
- **Update credential provider:** Ensure using the latest version.

### Diagnostic commands

```bash
# Test NuGet authentication
nuget sources list

# Test npm authentication
npm whoami --registry=https://pkgs.dev.azure.com/{organization}/_packaging/{feed}/npm/registry/

# Test Azure CLI authentication
az artifacts universal download --organization https://dev.azure.com/{organization} --feed {feed} --name {package} --version {version}
```

## Security best practices

### Credential management

**Never commit credentials:**

- **Use .gitignore:** Exclude credential files from source control.
- **Environment variables:** Store secrets in environment variables.
- **Secret management:** Use Azure Key Vault or similar services.

### Token hygiene

**Regular rotation:**

- **Set expiration:** Always set expiration dates on PATs.
- **Rotate proactively:** Replace tokens before they expire.
- **Revoke unused:** Remove tokens that are no longer needed.

### Monitoring

**Audit access:**

- **Review logs:** Monitor who is accessing feeds and when.
- **Alert on failures:** Set up alerts for repeated authentication failures.
- **Track PAT usage:** Monitor PAT creation and usage patterns.
