Microsoft Graph provides programmatic access to agent identities. You can enable automation of agent identity management, bulk operations, and integration with existing governance workflows. This unit introduces how Microsoft Graph can be used to query and manage agent identities.

## What is Microsoft Graph for agent identities?

Microsoft Graph is the unified API for accessing data across Microsoft 365, Windows, and Enterprise Mobility + Security. For agent identities, Microsoft Graph provides:

- **API endpoints** to query agent identities, agent identity blueprints, and related objects
- **Programmatic operations** including list, read, create, update, and delete
- **Metadata retrieval** about agent identities and their relationships
- **Bulk management** capabilities for large-scale agent deployments

The Microsoft Entra Agent ID APIs in Microsoft Graph help you create, secure, and manage AI agent identities operating in your organization.

## Core Microsoft Graph resources for agent identities

The Agent ID platform introduces several Microsoft Graph resource types:

| Component | Microsoft Graph Resource | Purpose |
|-----------|-------------------------|---------|
| **Blueprint** | `agentIdentityBlueprint` | Template defining the agent identity type and permissions |
| **Blueprint principal** | `agentIdentityBlueprintPrincipal` | Record of blueprint's addition to a tenant |
| **Agent identity** | `agentIdentity` | Primary identity for authentication |
| **Agent user** | `agentUser` | Optional account for scenarios requiring a user object |
| **Agent registry** | `agentRegistry` | Centralized repository for agent management |

## Common Microsoft Graph operations

### List agent identities

To retrieve all agent identities in your tenant:

```http
GET /servicePrincipals/microsoft.graph.agentIdentity
```

This query returns a list of agent identities with their properties.

### Query specific agent identity

To get details about a specific agent identity:

```http
GET /servicePrincipals/{agent-identity-id}/microsoft.graph.agentIdentity
```

Replace `{agent-identity-id}` with the object ID of the agent identity.

### Filter and search

Microsoft Graph supports OData query parameters for filtering and searching:

```http
GET /servicePrincipals/microsoft.graph.agentIdentity?$filter=displayName eq 'Contoso Sales Agent'
```

### Retrieve agent identity metadata

You can retrieve detailed metadata including:
- Display name and description
- Status (enabled/disabled)
- Created date
- Agent blueprint relationship
- Assigned permissions and roles
- Owners and sponsors

## Permission requirements for Microsoft Graph operations

To query agent identities programmatically, you need appropriate Microsoft Graph permissions:

### Read agent identities

There are two ways to read information about agent identities.

- **AgentIdentity.Read.All** (application permission) or **AgentIdentity.Read** (delegated permission)
- Alternatively, broader permissions like **Directory.Read.All** include agent identity read access

### Manage agent identities

Similar methods exist to modify agents.

- **AgentIdentity.ReadWrite.All** (application permission) or **AgentIdentity.ReadWrite** (delegated permission)
- For creating blueprints: **AgentIdentityBlueprint.Create**

### Request admin consent

Many agent identity operations require administrator consent. Tenant administrators must grant these permissions before applications can programmatically manage agent identities.

## Relationship between portal operations and Graph API

Operations you perform in the Microsoft Entra admin center typically correspond to Microsoft Graph API calls:

| Portal Action | Microsoft Graph API |
|---------------|---------------------|
| View all agent identities | `GET /servicePrincipals/microsoft.graph.agentIdentity` |
| View agent identity details | `GET /servicePrincipals/{id}/microsoft.graph.agentIdentity` |
| Disable an agent identity | `PATCH /servicePrincipals/{id}` with `accountEnabled: false` |
| Retrieve agent identity permissions | `GET /servicePrincipals/{id}/appRoleAssignments` |
| List blueprints | Query for service principals of type agent identity blueprint |

Understanding this mapping helps you automate manual tasks and integrate agent identity management into your existing IT workflows.
