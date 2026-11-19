---
no_index_ks: true
---

The agent needs both available services and access to the data required for its task. Check service availability and resource access separately.

## Confirm that the required services are available

Use the approved requirements to identify the sources and services the agent needs. For Threat Intelligence Agent extraction, these include the selected source, Defender XDR access, and MDTI availability. Keep the same source for validation so the test addresses those requirements.

Ask the person responsible for the service to confirm availability. Under Service and scoped-resource checks, record:

- Who confirmed the service or data is available.
- When they confirmed it.
- Which service or data the confirmation covers.

If the approved task requires MDTI enrichment, confirm service availability and test whether the agent can use it. An individual indicator might have no MDTI context even when access works. Use service checks and session errors to distinguish unavailable context from an access failure.

## Check the agent's access to the required data

Identify the agent account whose access you're checking. In Perception > Agents, open the agent and inspect Identity if you need to confirm it. API grants determine what the agent is permitted to read. Resource restrictions can further limit which data that identity can access.

If the organization restricts the required Defender data to particular resources:

- Confirm which scopes the agent needs with the person responsible for those resources.
- Confirm that the recorded agent identity has the required assignments. Make missing approved assignments within your authority, or request them through your organization's resource-access process.
- Record the identity, permitted scope, and confirmed assignment with the service checks.

Follow the [scoped-resource guidance](/security/agentic-security/agentic-security-get-started?azure-portal=true). Base resource assignments on the approved task and the data the agent needs. Selecting an article doesn't restrict the agent's underlying data access.

## Confirm data access during a test

Keep unresolved service or access requirements visible. Resolve them before you test the task with a security practitioner.

Availability and assignment confirmations establish that the required services and access are in place. Session task results supply evidence that the agent processed the source and retrieved the data. During the test, inspect those results for successful retrieval, missing data, and access errors.
