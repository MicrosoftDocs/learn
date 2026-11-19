---
no_index_ks: true
---

To set up the Threat Intelligence Agent, configure its identity and check its permissions against the approved requirements.

## Check the required agent permissions

Use Security Admin for Perception setup. The agent runs with its own Microsoft Entra Agent ID and assigned permissions.

Record the identity you configure so access checks and later troubleshooting refer to the correct account.

The [Threat Intelligence Agent documentation](/security/agentic-security/threat-intelligence-agent?azure-portal=true) lists the following permissions:

| API | Required permissions |
| --- | --- |
| Microsoft Defender XDR | ThreatIntelligence.Read.All, ThreatHunting.Read.All, AdvancedHunting.Read.All |
| Microsoft Defender Threat Intelligence | ThreatIntelligence.Read.All |
| Microsoft Graph | SecurityEvents.Read.All |

Check the API as well as the permission name. ThreatIntelligence.Read.All appears under two different APIs.

Check that your organization has authorized the permissions the agent requires. If the required permissions exceed the approved access, stop setup and request authorization before you proceed.

## Set up the Threat Intelligence Agent

For an existing agent, confirm that its use for the task is authorized. Inspect its identity and grants against the permission table above rather than creating another identity. Confirm that required services and resource access are available before you test the task.

For a new agent, confirm the required services are available and identify any resource restrictions before you start. For the Threat Intelligence Agent, this includes Defender XDR and MDTI access for full data and enrichment. Identify how your organization assigns resource access so you can arrange any assignments the new identity needs.

Follow the [documented setup](/security/agentic-security/agentic-security-get-started?azure-portal=true):

1. Sign in to the [Microsoft Defender portal](https://security.microsoft.com?azure-portal=true) with the authorized setup account and open Perception > Agents.
2. Find Threat Intelligence Agent under Ready for setup and select Set up.
3. Use the wizard to create the agent identity. Record the Microsoft Entra Agent ID created for this configuration.
4. Review the required permissions.
5. Complete grants within your authority through the setup wizard, and request any others through your organization's grant process.
6. Confirm that each API grant listed above is present for the recorded agent identity. A submitted grant request isn't confirmation.
7. For a missing or unconfirmed grant, record the API, permission, and displayed issue, then request correction through the grant process.
8. Confirm that the agent identity has access to any scoped resources required for the task. Make missing approved assignments if you have the required authority. Otherwise, request them through your organization's resource-access process and confirm completion. Follow the [scoped-resource guidance](/security/agentic-security/agentic-security-get-started?azure-portal=true) in the documented setup.
9. After you confirm the required grants and resource access, select Finish setup. Confirm that the agent appears as Enabled, then check Identity and Permissions against your record.

Record the confirmed identity, API grants, and unresolved issues under Agent identity and API grants. Complete setup after all required grants and resource assignments are confirmed.

## Resolve setup problems

If Set up is unavailable, check the setup account's Security Admin access. Giving the agent more data permissions doesn't correct the administrator's missing setup authority.

If the permissions shown during setup differ from the table, check the current agent requirements and resolve the difference before completing setup.
