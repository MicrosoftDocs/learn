Authentication proves identity. Authorization determines what that identity can do.

In Azure environments, authorization is enforced through role-based access control. Role assignments define which actions an identity can perform and where those permissions apply.

When securing AI workloads in Microsoft Foundry, role design directly affects risk exposure and blast radius.

## Role-based access control in Azure

Azure uses RBAC (role-based access control) to grant permissions to identities. Roles contain a defined set of allowed actions. When you assign a role to an identity, you grant that identity the ability to perform those actions within a specific scope.

RBAC applies to both management plane and data plane operations, though the permission models differ.

Management plane permissions are defined through Azure RBAC roles that govern resource configuration and administrative control. Data plane permissions may rely on resource-specific roles and access models tied directly to the AI endpoint and its associated data.

Management plane permissions control administrative operations such as deploying models, modifying configuration, or assigning additional roles.

Data plane permissions control runtime access to AI endpoints and associated data.

Understanding which permissions apply to which plane is critical when designing access boundaries.

## Scope hierarchy

Every role assignment includes a scope. Scope defines where the role applies.

Azure uses a hierarchical model:

- Subscription
- Resource group
- Individual resource, such as an AI endpoint

Permissions assigned at a higher scope apply to all child resources beneath that scope.

For example, assigning a contributor role at the subscription level grants broad control across all resource groups and resources within that subscription. Assigning a role at the resource level limits that access to a specific AI resource.

Scope selection directly affects blast radius. In the management plane, broader scope spreads configuration authority. In the data plane, broader scope expands model usage and data access.

Designing for least privilege requires aligning role permissions to the narrowest practical scope. Subscription-level assignments should be rare and justified, not default.

## Built-in and custom roles

Azure provides built-in roles that cover common administrative and operational scenarios. These roles simplify configuration but might grant more permissions than necessary in tightly controlled environments.

Custom roles allow you to define a specific set of permitted actions. They're useful when built-in roles exceed the level of access required.

Choosing between built-in and custom roles depends on the balance between operational simplicity and precision. In AI environments where data sensitivity is high, defaulting to built-in roles without reviewing their permissions can introduce unnecessary exposure.

Regardless of role type, permissions should align to defined responsibilities and avoid unnecessary privilege. Convenience should not determine authorization boundaries.

## Designing role assignments intentionally

Role assignments should never be an afterthought.

When evaluating access to AI workloads, consider:

- Which identity is performing the action
- Which plane the action affects
- Which scope is appropriate
- Whether separation between development and production is preserved
- Whether the role grants more access than required

Poorly designed role assignments can undermine even strong authentication controls. A correctly issued token still enables misuse if the associated permissions are too broad.

Effective AI security depends on aligning identity, role, and scope in a deliberate way. Misalignment expands privilege boundaries and increases the likelihood of lateral movement. When that alignment breaks down, identity becomes the source of security failure rather than its control layer.
