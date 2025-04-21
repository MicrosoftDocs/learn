Secrets are encrypted environment variables you can create to store tokens, credentials, or any other type of sensitive information your GitHub Actions workflows and actions might rely on. Once created, they become available to use in the workflows and actions that have access to the organization, repository, or repository environment where they're stored.

In this section, you'll explore the different tools and strategies available in GitHub Enterprise Cloud and GitHub Enterprise Server in order to manage the use of encrypted secrets. We'll also explain how to access encrypted secrets in your workflows and actions.

## Manage encrypted secrets at organization level

Creating encrypted secrets at organization level to store sensitive information is a great way to ensure the security of this information, while minimizing management overhead in your enterprise.

Let's say some developers writing workflows in your GitHub organization need the credentials to deploy code to production in some of their workflows. In order to avoid sharing this sensitive piece of information, you could create an encrypted secret containing the credentials at organization level. This way the credentials can be used in the workflows without being exposed.

To create a secret at organization level, go to your organization **Settings** and from the sidebar select **Secrets and variables > Actions > New organization secret**. In the screen that appears, enter a name and a value and choose a repository access policy for your secret:

:::image type="content" source="../media/add-org-secret.png" alt-text="New secret screen for organizations.":::

The access policy appears underneath the secret in the secret list once it's saved:

:::image type="content" source="../media/secret-access-policy.png" alt-text="Encrypted secrets example with access policy displayed.":::

You can select **Update** for more details on the configured permissions for your secret.

## Manage encrypted secrets at repository level

If you need an encrypted secret to be scoped to a specific repository, GitHub Enterprise Cloud and GitHub Enterprise Server also let you create secrets at repository level.

To create a secret at repository level, go to your repository **Settings** and from the sidebar select **Secrets and variables > Actions > New repository secret**. In the screen that appears, enter a name and a value for your secret:

:::image type="content" source="../media/secret-repo.png" alt-text="New secret screen for repositories.":::

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
> When authoring your own actions, make sure not to include any encrypted secrets in your action's source code, because actions are sharable units of work. If your action needs to use encrypted secrets or other user-supplied inputs, it's best to use the core module from the [Actions Toolkit](https://github.com/actions/toolkit).
>

<<<<<<< main
>

<!-- INFOMAGNUS UPDATES for all of sub OD 4.3 go here! Source Material:https://www.google.com/url?q=https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions&sa=D&source=editors&ust=1742484244534691&usg=AOvVaw30HJhmh-nnnssWIlwRCI_5 -->

<!-- Test -->
=======
=======
>>>>>>> main

### Access Encrypted Secrets Within Actions and Workflows

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

#### Best Practices for Using Secrets in Workflows
- **Do not print secrets** in logs using `echo ${{ secrets.SECRET_NAME }}`.
- **Use secrets within script commands**, rather than assigning them to environment variables.
- **Limit access** by defining secrets at the **lowest necessary level**.
- **Rotate secrets periodically** and update workflows accordingly.

## How to Use third party Vaults

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

### Benefits of Using Third-Party Vaults
- **Centralized secret management** reduces security risks.  
- **Automated secret rotation** helps comply with security policies.  
- **Audit logs and access control** enhance security monitoring.  
- **Least privilege access** prevents unauthorized use of secrets.
<<<<<<< main
<!-- Test -->
=======
>>>>>>> main
