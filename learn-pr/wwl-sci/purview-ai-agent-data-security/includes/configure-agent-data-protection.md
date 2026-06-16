Data loss prevention (DLP) policies and sensitivity labels prevent sensitive data from leaving through agent interactions. They only work when you explicitly include agent instances in policy scope and account for Agent 365 behavioral differences.

## Specify agent instances in DLP policies

DLP policies that only scope to users and groups silently exclude agent instances, even when agents share the same sensitive content those policies were designed to catch.

To include agent instances in a DLP policy, you add them the same way you would add a user. You have two approaches:

- **Specify agent instances directly** in the DLP policy's user scope.
- **Specify a security group** that includes the agent instances you want to cover.

The security group approach is more manageable when you have multiple agent instances to cover with the same policy. You can add or remove agents from the group without editing the policy itself.

### Supported DLP interactions for agents

DLP policies applied to agent instances support:

- **Actions**: Block or audit
- **Direction**: Agent-to-human and human-to-agent interactions
- **Locations**: Microsoft Teams, OneDrive or SharePoint, and emails

These interaction types and locations are the same ones that DLP supports for human users. The configuration surface is familiar. The difference is that you must explicitly include agent instances in the policy scope.

### Configure for Agent 365 DLP limitations

Because Agent 365 instances are unaware of DLP block actions, the agent owner needs a way to detect when interactions are blocked:

1. In the Microsoft Purview portal, configure DLP policy alerts for the policies that include Agent 365 instances.
1. Assign the agent owner as a notification recipient for policy alerts that involve their agent instances.
1. Establish an alert review workflow where agent owners review DLP alerts for their agent instances and understand the effect on subsequent agent workflows.

> [!NOTE]
> If an agent instance isn't in policy scope, its interactions won't appear in DLP activity reports at all. When reviewing Activity Explorer, filter by the **AI activities** tab and confirm your agent instances generate events. If no events appear for a known active agent, the agent isn't covered by any DLP policy, even if the capability is available for that agent type.

## Address sensitivity label encryption requirements

When Agent 365 instances can't open encrypted files, they fail without notifying the user or owner. To prevent silent failures, the label's encryption settings must grant the agent instance VIEW and EXTRACT usage rights.

To verify and address this requirement:

1. In the Microsoft Purview portal, review your sensitivity labels that apply encryption.
1. For each label, check the encryption permissions configuration. Verify whether the agent instances that need access are explicitly listed with VIEW and EXTRACT rights.
1. If the label uses "Add all users and groups in your organization" or "Add any authenticated users," these settings aren't sufficient for Agent 365 instances. Add the specific agent instances or a security group containing them to the label's permissions.
1. Confirm that the updated permissions grant VIEW and EXTRACT to the intended agent instances.

Updating encryption permissions on existing labels keeps your label taxonomy clean. Creating separate labels just to add agent access leads to parallel labels that fragment your classification scheme.

## Address the file sharing requirement

Encryption rights only matter if the agent can reach the file. Agent 365 instances don't automatically have access to files that users can reach, so files must be explicitly shared with them. Both the share and the encryption rights must be in place.

When your protection plan identifies content that Agent 365 instances need to access:

1. Confirm that the files or libraries are explicitly shared with the relevant agent instances.
1. Verify that sharing combined with encryption permissions allows the intended access.
