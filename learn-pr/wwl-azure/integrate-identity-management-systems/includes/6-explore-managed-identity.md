Azure Data Factory to Azure SQL Database connectivity scenarios illustrate fundamental identity presentation requirements:

:::image type="content" source="../media/azure-data-factory-sql-identity-43931848.png" alt-text="Diagram showing a connection from Azure Data Factory to an Azure SQL Database.":::

Traditional SQL Authentication implementations require username and password credential management introducing ongoing operational overhead.

### Identity of the service

Numerous Azure services expose native platform-managed identities eliminating credential maintenance requirements including password policy administration.

Microsoft Entra identity permission assignment patterns apply equivalently to service-exposed identities.

Azure Data Factory scenarios support adding ADF managed service identity (MSI) as Azure SQL Database users with database role membership assignment.

### Managed identity types

Azure implements two distinct managed identity classifications:

- **System-assigned:** Service-native identity types automatically provisioned by supporting Azure services. Not all Azure services expose system-assigned managed identities.
- **User-assigned:** Explicitly provisioned managed identities created as independent Azure resources supporting assignment to one or multiple service instances.

For more information, see: [What are managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview)

## Implement workload identities

Azure Pipelines and GitHub Actions support workload identity-based Azure resource access leveraging managed identities or service principals. Managed identity implementations offer advantages enabling deployment without service principal creation permissions or across disparate Microsoft Entra tenants from Azure DevOps user contexts.

Azure DevOps streamlines workload identity federation-based service connection implementation through integrated New service connection interface features. Automatic configuration options generate service principals automatically assigning resource group or subscription permissions to designated targets.

:::image type="content" source="../media/managed-identities-implement-service-connection-54cecc7d.png" alt-text="Screenshot of the new Azure service connection feature.":::

Manual configuration workflows require pre-provisioned user-assigned managed identities or service principals with requisite permissions. Configuration requirements include federated credential specifications referenced during service connection establishment.

:::image type="content" source="../media/managed-identities-add-federated-credential-bd4df761.png" alt-text="Screenshot of the add federated credential feature.":::

**Azure Pipelines configuration:** Select Other federation credential scenarios updating issuer and subject identifier settings referencing service connection attributes.

For more information, refer to [Use an Azure Resource Manager service connection](/azure/devops/pipelines/library/connect-to-azure) and [Set a Resource Manager workload identity service connection](/azure/devops/pipelines/release/configure-workload-identity).

**GitHub Actions configuration:** Select GitHub Actions deploying Azure resources options requiring GitHub organization, repository, and workflow YAML file branch specifications. This establishes federation trust between Microsoft Entra ID tenants and respective DevOps platforms. Trust establishment enables service principal clientId and tenantID secret addition to target GitHub repositories. Workflow secret references enable job-level Azure subscription access.

For more information, refer to [Configuring OpenID Connect in Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure).
