Imagine that you need to connect from an Azure Data Factory (ADF) to an Azure SQL Database. What identity should ADF present to the database?<br>

:::image type="content" source="../media/azure-data-factory-sql-identity-43931848.png" alt-text="Diagram showing a connection from Azure Data Factory to an Azure SQL Database.":::


The traditional answer would have been to use SQL Authentication with a username and password. It leaves yet another credential that needs to be managed on an ongoing basis.

### Identity of the service

Many Azure services expose their own identity. It isn't an identity that you need to manage. For example, you don't need to worry about password policies and so on.

You can assign permissions to that identity, as with any other Microsoft Entra identity.

In the ADF example, you can add the ADF MSI as an Azure SQL Database user and add it to roles within the database.

### Managed identity types

There are two types of managed identities:

 -  **System-assigned** \- It's the types of identities described above. Many, but not all, services expose these identities.
 -  **User-assigned** \- you can create a managed identity as an Azure resource. It can then be assigned to one or more instances of a service.

For more information, see: [What are managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview)

## Implement workload identities

Azure Pipelines and GitHub Actions support workload identities for access to Azure resources. You can use for this purpose managed identities or service principals. The advantage of using the first of these two options is that you can implement it even if you don't have permissions to create service principals or if you're using a different Microsoft Entra tenant than your Azure DevOps user.

Azure DevOps facilitates implementing workload identity federation-based service connections by exposing this feature directly in the New service connection interface. There's even the automatic option, which generates the service principal for you and assigns to it permissions to the resource group or subscription that you designate.

:::image type="content" source="../media/managed-identities-implement-service-connection-54cecc7d.png" alt-text="Screenshot of the new Azure service connection feature.":::


The manual option requires that you pre-provision a user assigned-managed identity or a service principal with the required permissions. You also need to include in its configuration federated credentials, which you need to specify when setting up the service connection.

:::image type="content" source="../media/managed-identities-add-federated-credential-bd4df761.png" alt-text="Screenshot of the add federated credential feature.":::


For Azure Pipelines, select the Other federation credential scenario. You need to update its issuer and subject identifier settings by referencing the service connection attributes.

For more information, refer to [Use an Azure Resource Manager service connection](/azure/devops/pipelines/library/connect-to-azure) and [Set a Resource Manager workload identity service connection](/azure/devops/pipelines/release/configure-workload-identity).

For GitHub Actions, select the GitHub Actions deploying Azure resources option. In this case, you need to provide your GitHub organization, repository, and the branch containing the workflow YAML file. This will establish a federation trust between the Microsoft Entra ID tenant and the respective DevOps platforms. Once you establish this trust, add the service principal's clientId and tenantID as secrets to the target GitHub repository. Reference the secrets in the workflow to allow its jobs to gain access to the Azure subscription.

For more information, refer to [Configuring OpenID Connect in Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure).
