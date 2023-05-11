In this unit, explore the benefits of using Managed Identity and Service Principals in Azure DevOps for service connections and services.

## Understanding managed identity and service principals

> [!IMPORTANT]
> Follow the steps from the previous unit [**Configure agent identities**](/training/modules/manage-identity-projects-pipelines-agents/4-configure-agent-identities) to create a Managed identity. You'll need this identity to complete the steps in this unit.

Managed Identity and Service Principals are two ways to authenticate and authorize access to Azure resources. Both provide a secure way to grant your Azure Pipelines access to Azure services without having to store credentials in the pipeline configuration.

## Convert to a managed identity

1. Navigate to your Azure DevOps project, and then go to 'Project settings' then 'Service connections.'
2. Identify the service connection you want to convert to use a managed identity. Click in Edit and make a note of its settings, such as the scope and roles assigned to it. Also, make sure you know the pipelines using this service connection.
3. Delete the existing service connection by clicking on the ellipsis (three dots) next to the service connection and selecting 'Delete.'
4. Create a new service connection by clicking on 'New service connection' and selecting 'Azure Resource Manager' as the connection type (or choose the connection you need).
5. In the 'Authentication method' section, select 'Managed identity.'
6. Configure the scope and permissions for the managed identity using the settings from your previous service connection. This ensures that the managed identity has the same access and functionality as the original service connection.
7. Provide a name and description for the new service connection, and then click 'Save.'
8. Update your pipeline to use the new service connection with the managed identity. To do this, locate the service connection reference in your pipeline YAML file and replace the old service connection name with the new one (if it has changed).
9. Save and commit the updated pipeline YAML file.

## Challenge yourself

To practice converting to a Managed Identity, complete the following steps:

1. Choose a project in your Azure DevOps environment that requires access to an Azure resource.
2. Create a new service connection using Managed Identity.
3. Configure the appropriate permissions for the Managed Identity in the Azure portal.
4. Update your pipeline to use the newly created service connection with Managed Identity.
5. Execute the pipeline and verify that it runs successfully, accessing the Azure resource with the appropriate level of access.

For more information about managed identities and service connections, see:

- [Use Azure Active Directory service principals & managed identities](https://learn.microsoft.com/azure/devops/integrate/get-started/authentication/service-principal-managed-identity)
