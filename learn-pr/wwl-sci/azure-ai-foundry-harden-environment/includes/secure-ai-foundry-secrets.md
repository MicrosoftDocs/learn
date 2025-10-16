AI workloads depend on credentials, keys, and connection strings to connect models, datasets, and services. In Azure AI Foundry, these secrets are used to authenticate to data sources, APIs, and managed compute. If credentials are stored in configuration files or shared directly between users, they can be exposed or misused.

**Azure Key Vault** centralizes secret management. It lets you store and retrieve keys, passwords, certificates, and tokens securely while controlling access through Microsoft Entra ID. Using Key Vault keeps secrets encrypted, access logged, and permissions aligned with the least-privilege model already applied to your Foundry environment.

## Why secure secret management matters

When multiple teams share an AI environment, it becomes difficult to track where credentials are stored or how they're used. Without a central vault, secrets can end up in scripts, training configurations, or deployment pipelines where they're vulnerable to exposure.

Using Azure Key Vault provides these benefits:

- **Centralized storage** for secrets that support models, datasets, and pipelines
- **Automatic encryption** at rest and in transit
- **Fine-grained access control** through Microsoft Entra ID integration
- **Auditing and monitoring** through Defender for Cloud and Azure diagnostics

Centralized secret management creates a single control point for both operational security and compliance.

## Store and control access to secrets

Each Foundry workspace can connect to one or more Key Vault instances. Grant access only to the identities that need it.

- Assign the **Key Vault Administrator** role to trusted operators who maintain vault configuration.
- Use the **Key Vault Secrets Officer** or **Reader** role for users or service principals that need to retrieve specific secrets.
- Enable **managed identities** for Foundry services and pipelines that require secret access to avoid embedding credentials in code or configuration files.

Apply least privilege by limiting access to *Get* and *List* operations unless broader permissions are required. When temporary administrative access is needed, use **Privileged Identity Management (PIM)** for time-bound elevation.

For guidance on assigning Key Vault roles, see [Assign Azure role-based access control (RBAC) roles for Key Vault](/azure/key-vault/general/rbac-guide?azure-portal=true).

## Integrate Key Vault with Azure AI Foundry

After permissions are configured, connect Foundry to your vault. In the **Azure AI Foundry portal**, go to **Management center** > **Settings** > **Connections**, select **Add connection**, and choose **Azure Key Vault**.

Connections define which vault and managed identity are used to retrieve secrets at runtime. This ensures that model deployments and data connections can authenticate securely without exposing credentials in logs or configuration files.

A typical setup might include:

- A Foundry project linked to a Key Vault that stores API keys and data source connections
- Managed identities assigned to the Foundry workspace and compute resources for automatic secret retrieval
- Secret rotation enforced by Azure Policy or Defender for Cloud recommendations

## Monitor and maintain Key Vault security

Managing secrets securely is an ongoing process. Use these practices to maintain a strong security posture:

- **Enable diagnostic logging** and send logs to Log Analytics or a SIEM for monitoring
- **Review access patterns** to detect unused or suspicious identities
- **Use Azure Policy** to enforce standards like soft delete, purge protection, and private endpoints
- **Integrate with Defender for Cloud** to receive alerts and recommendations related to Key Vault activity

Regular review and rotation keep your secrets aligned with organizational policy and reduce risk over time.

When secrets are centralized in Azure Key Vault and retrieved using managed identities, your credentials stay protected by the same access controls that secure your Azure AI Foundry environment. With secret management in place, the next step is to isolate network communication for your AI workloads using managed virtual networks and private links.

---

## Try it out

Test your Key Vault integration in a development environment to see how secret management works in practice.

> [!TIP]
> If you'd like to follow along with the exercises, you can use your own development environment or create a free **[Azure trial account](https://azure.microsoft.com/free)** to test the configurations safely.

Your organization's Azure AI Foundry workspace already connects to several data sources. You've been asked to secure the connection strings and API keys used by model deployments.

1. In the **[Azure portal](https://portal.azure.com/)**, create or select a **Key Vault**.

1. In **Key Vault**, go to **Access control (IAM)**, then select **Add** > **Add role assignment**.

1. On the **Add role assignment** page, in the **Role** tab, search for, then select **Key Vault Secrets User**.

1. On the **Members** tab, select the option for **Managed identity**, and select the identity for **Azure AI Foundry** from the drop-down, and select the appropriate Azure AI Foundry resource.

1. On the **Review + assign** tab, review your assignment, then select **Review + assign**.

   :::image type="content" source="../media/review-assign-identity-key-vault.png" alt-text="Screenshot showing a Key Vault role assignment granting the Azure AI Foundry workspace the Key Vault Secrets User role." lightbox="../media/review-assign-identity-key-vault.png":::

1. In the **[Azure AI Foundry portal](https://ai.azure.com/)**, open **Management center** > **Connected resources**, select **+ New connection**, and choose **Azure Key Vault**.

1. Select the vault and managed identity you configured, then select **Add connection**.

   :::image type="content" source="../media/foundry-connect-key-vault.png" alt-text="Screenshot showing the Add an Azure Key Vault page with a selected vault, managed identity, and Add connection button." lightbox="../media/foundry-connect-key-vault.png":::

> [!NOTE]
> If the **Add connection** button is unavailable, confirm that no existing Key Vault connection is active. Each workspace supports only one Key Vault connection at a time.

Confirm that your Foundry project retrieves secrets from Key Vault and that no credentials appear in configuration files or logs.

Managed identities and Azure Key Vault work together to keep credentials out of local configuration files while maintaining secure, auditable access for AI workloads.
