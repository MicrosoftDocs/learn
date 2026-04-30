To create Data Factory instances, the user account that you use to sign in to Azure must be a member of the _contributor_ or _owner_ role, or an _administrator_ of the Azure subscription.

To create and manage Data Factory objects including datasets, linked services, pipelines, triggers, and integration runtimes, the following requirements must be met:
- To create and manage child resources in the Azure portal, you must belong to the _Data Factory Contributor_ role at the resource group level or above.
- To create and manage resources with PowerShell or the SDK, the _contributor_ role at the resource level or above is sufficient.

## Data Factory Contributor role

When you're added as a member of this role, you have the following permissions:

- Create, edit, and delete data factories and child resources including datasets, linked services, pipelines, triggers, and integration runtimes.
- Deploy Resource Manager templates. Resource Manager deployment is the deployment method used by Data Factory in the Azure portal.
- Manage App Insights alerts for a data factory.
- At the resource group level or above, lets users deploy Resource Manager template.
- Create support tickets.

If the Data Factory Contributor role doesn't meet your requirement, you can create your own [custom role](/azure/role-based-access-control/custom-roles).

## Authentication with managed identities

Managed identities eliminate the need to manage credentials when connecting Azure Data Factory to other Azure services. Rather than embedding usernames, passwords, or access keys in linked service definitions, you grant the data factory's managed identity direct access to the target resource through Azure RBAC.

Azure Data Factory supports two types of managed identity:

- **System-assigned**: Automatically created when the data factory is provisioned and deleted when the factory is deleted. Each factory has exactly one system-assigned managed identity.
- **User-assigned**: A standalone Azure resource that you create independently and assign to one or more data factories. Useful when you need to share an identity across multiple factories or manage its lifecycle separately.

To grant a managed identity access to a resource, assign the appropriate Azure RBAC role to the managed identity on the target resource. For example, assign the **Storage Blob Data Contributor** role on a storage account, or the **db_datareader** database role on an Azure SQL Database.

For credentials that can't use managed identity authentication, store them in **Azure Key Vault** and reference the secret in your linked service definition. This avoids embedding sensitive values in pipeline configuration.

Learn more about [managed identities for Azure Data Factory](/azure/data-factory/data-factory-service-identity).