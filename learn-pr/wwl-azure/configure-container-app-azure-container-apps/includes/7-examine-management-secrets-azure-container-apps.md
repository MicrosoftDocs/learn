Azure Container Apps allows your application to securely store sensitive configuration values. Once secrets are defined at the application level, secured values are available to revisions in your container apps. Additionally, you can reference secured values inside scale rules.

- Secrets are scoped to an application, outside of any specific revision of an application.
- Adding, removing, or changing secrets doesn't generate new revisions.
- Each application revision can reference one or more secrets.
- Multiple revisions can reference the same secret(s).

An updated or deleted secret doesn't automatically affect existing revisions in your app. When a secret is updated or deleted, you can respond to changes in one of two ways:

- Deploy a new revision.
- Restart an existing revision.

Before you delete a secret, deploy a new revision that no longer references the old secret. Then deactivate all revisions that reference the secret.

## Defining secrets

Secrets are defined as a set of name/value pairs. The value of each secret is specified directly or as a reference to a secret stored in Azure Key Vault.

### Store secret value in Container Apps

Secrets can be defined via the Azure portal or by using a command line tool.

To define secrets through the portal:

1. Open your container app in the Azure portal.

1. In the left-side menu under Settings, select **Secrets**.

1. Select **Add**.

1. On the Add secret context page, enter the following information:

    - Name: The name of the secret.
    - Type: Select **Container Apps Secret**.
    - Value: The value of the secret.

1. Select **Add**.

## Reference secret from Key Vault

When you define a secret, you create a reference to a secret stored in Azure Key Vault. Container Apps automatically retrieves the secret value from Key Vault and makes it available as a secret in your container app.

To reference a secret from Key Vault, you must first enable a managed identity in your container app and grant the identity access to the Key Vault secrets.

To grant access to Key Vault secrets, create an access policy in Key Vault for the managed identity you created. Enable the "Get" secret permission on this policy.

1. Open your container app in the Azure portal.

1. In the left-side menu under Settings, select **Identity**.

1. On the System assigned tab, select **On**.

1. To enable system-assigned managed identity, select **Save**.

1. Under the Settings section, select **Secrets**.

1. Select **Add**.

1. In the Add secret context pane, enter the following information:

    - Name: The name of the secret.
    - Type: Select Key Vault reference.
    - Key Vault secret URL: The URI of your secret in Key Vault.
    - Identity: The identity to use to retrieve the secret from Key Vault.

1. Select **Add**.
