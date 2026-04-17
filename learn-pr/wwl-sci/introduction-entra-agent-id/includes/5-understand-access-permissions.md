Managing agent identities requires specific Microsoft Entra roles and understanding how permissions work in the agent identity model. This unit explains the roles required, how permission inheritance works, and key security restrictions.

## Required roles for managing agent identities

There are several different types of roles that can perform operations on agent identities, from viewing to managing.

### Roles for viewing agent identities

To view agent identities in the Microsoft Entra admin center:
- Any Microsoft Entra user account can view the agent identities list

### Roles for managing agent identities

To manage agent identities (create, update, disable, delete), you need one of the following roles:

- **Agent ID Administrator**: Full permissions to manage agent identities, agent identity blueprints, and related configurations. Use the role for agent identity management (recommended).

- **Cloud Application Administrator**: Can manage enterprise applications and agent identities. This role has broader application management permissions beyond just agent identities.

- **Owner of the agent identity**: If you're designated as an owner of a specific agent identity, you can manage that agent identity without holding a tenant-wide administrator role.

### Roles for creating agent identity blueprints

To create agent identity blueprints, you need:
- **Agent ID Developer** role or **Agent ID Administrator** role
- **Privileged Role Administrator** role (required to grant certain permissions to blueprints)

### Roles blocked from agent identities

For security reasons, the following high-privilege directory roles can't be assigned to agent identities:
- **Global Administrator**
- **Privileged Role Administrator**
- **User Administrator**

Agent identities can only be assigned lower-privileged roles. Additionally, custom roles can't be assigned to agent identities, and agent identities can't be members of role-assignable groups.

## Permission inheritance model

Agent identities inherit permissions from their parent agent identity blueprints. Understanding this inheritance model is crucial for effective permission management.

### How permission inheritance works

1. **Blueprint defines permissions**: The agent identity blueprint declares:
   - Microsoft Graph permissions (delegated and application scopes)
   - App roles that can be assigned
   - Authentication settings and optional claims

2. **Agent identities inherit**: When an agent identity is created from a blueprint, it can inherit:
   - **Delegated permissions** from the blueprint (when impersonation is used)
   - Common characteristics like app roles and authentication settings

3. **Direct assignment also possible**: Agent identities can also receive permissions through direct assignment, independent of blueprint inheritance

### Delegated permissions inheritance

When `InheritDelegatedPermissions` is enabled on the agent identity service principal:
- The agent identity inherits delegated permissions from its parent agent identity blueprint
   - Simplifying permission management in multi-instance scenarios
- The inheritance applies when impersonation is used during authentication

### Application permissions

Application permissions (for app-only operations) can be assigned:
- Directly to the agent identity for instance-specific access requirements
- To the blueprint (though agent identities don't inherit application permissions automatically)

## Permission reassignment when publishing agents

A critical scenario for permission management occurs when publishing agents in platforms like Microsoft Foundry:

### The challenge

- **During development**: Unpublished agents use the shared project identity
- **After publishing**: The agent receives a distinct agent identity with its own agent identity blueprint

### Required action

When you publish an agent:

- **RBAC permissions don't transfer**: Permissions assigned to the shared project identity don't automatically transfer to the new distinct identity
- **You must reassign permissions**: Navigate to each Azure resource the agent accesses and assign the required RBAC role to the new agent identity
- **Verify access**: Test that the published agent can still access all required resources

### Example: Publishing a Microsoft Foundry agent

Before publishing:
- Agent uses shared project identity (AgentIdentity-Project-ABC)
- Shared identity has Storage Blob Data Reader role on Storage Account XYZ

After publishing:
- Agent receives distinct identity (AgentIdentity-Agent-123)
- Distinct identity has no permissions yet
- You must assign Storage Blob Data Reader role to AgentIdentity-Agent-123 on Storage Account XYZ

## Azure RBAC role assignment

Agent identities can be assigned Azure RBAC roles just like service principals:

1. **Navigate to the Azure resource** (Storage Account, Key Vault, etc.)
2. **Select Access control (IAM)**
3. **Add role assignment**
4. **Select the appropriate role** (for example, Storage Blob Data Reader)
5. **Search for the agent identity** by its name or object ID
6. **Assign the role**

> [!Note]
> You need the object ID of the agent identity for role assignments.

## Microsoft Graph permissions

Agent identities can be granted Microsoft Graph permissions to access Microsoft Entra resources:

### Permissions blocked for agents

For security, certain high-risk Microsoft Graph permissions are blocked for agent identities. Examples include:

| Blocked permission | Notes |
|-------------------|-------|
| `Application.ReadWrite.All` | Allows managing all applications |
| `RoleManagement.ReadWrite.All` | Includes full control over users, groups, roles, directory settings, and other critical operations |
| `User.ReadWrite.All` | Grants full control of all user accounts |
| `Directory.AccessAsUser.All` | Grants access to information in the directory as the signed-in user |

Agents can still be granted lower-privilege permissions as appropriate. For example, if an agent needs to read a user's mailbox or OneDrive file on that user's behalf, it can request a delegated permission like `Mail.Read` or `Files.Read`. Any tenant-scoped privileges that go beyond a single user or involve administrative control are *blocked*.

### Requesting Microsoft Graph permissions

To grant Microsoft Graph application permissions to an agent identity:

1. **Create an app role assignment** via Microsoft Graph API:
   ```
   POST https://graph.microsoft.com/v1.0/servicePrincipals/<agent-identity-id>/appRoleAssignments
   ```

2. **Use admin consent URL** to direct an administrator to grant permissions:
   ```
   https://login.microsoftonline.com/contoso.onmicrosoft.com/v2.0/adminconsent
   ?client_id=<agent-identity-client-id>
   &role=User.Read.All
   &redirect_uri=https://entra.microsoft.com/TokenAuthorize
   ```

## Owners and sponsors

The agent identity platform introduces an administrative model that separates technical administration from business accountability:

### Owners

- **Role**: Technical administrators for agents
- **Responsibilities**: Operational and configuration tasks
- **Permissions**: Can manage the agent identity's technical settings

### Sponsors

- **Role**: Business accountability for agents
- **Responsibilities**: Lifecycle decisions and business justification
- **Permissions**: Don't require technical administrative access
- **Purpose**: Provide a human contact for security incidents and compliance

### Managers (for agent users)

- **Role**: Designated hiring manager or operational owner
- **Applies to**: Agent users specifically (not regular agent identities)

## Best practices for permission management

1. **Use blueprint inheritance**: Configure common permissions on the blueprint to simplify management across multiple agent instances

2. **Apply least privilege**: Grant only the minimum permissions required for the agent to perform its function

3. **Document permission requirements**: Maintain documentation of which permissions each agent type requires

4. **Plan for publishing**: Before publishing agents, document which permissions need to be reassigned to the new distinct identity

5. **Regular permission audits**: Periodically review agent identity permissions to ensure they're still appropriate

6. **Use sponsors**: Designate sponsors for agent identities to maintain business accountability

7. **Monitor permission usage**: Review agent activity in audit logs to verify permissions are being used appropriately

## Security restrictions summary

| Security Control | Restriction |
|------------------|-------------|
| **High-privilege roles** | Global Admin, Privileged Role Admin, User Admin blocked |
| **Custom roles** | Can't be assigned to agent identities |
| **Role-assignable groups** | Agent identities can't be members |
| **Microsoft Graph permissions** | Several high-risk permissions blocked |
| **Credential management** | Agent identities can't manage their own credentials |

These restrictions help ensure that AI agents operate with appropriate access controls and can't gain excessive privileges that could compromise tenant security.
