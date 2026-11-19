After you assess preview readiness, you match capabilities to operational requirements to decide whether a workspace is necessary. A workspace isn't the default starting point: your target outcomes determine which capabilities you need and whether they require a workspace during the current preview.

## Start with built-in capabilities

Eligible customers can use these ISOC capabilities without an ISOC workspace during the preview:

| Capability | Planning use |
| --- | --- |
| Case management | Standardize ownership, tasks, collaboration, investigation records, and workflow tracking. |
| Workbooks | Visualize and monitor accessible security data by using advanced hunting queries. |
| Natural-language playbook generation | Generate a playbook starting point from a natural-language description, followed by review, testing, and governed activation. |
| Enhanced automation rules | Run supported actions for matching alerts or cases, subject to permissions and rule design. |

Starting with these capabilities can limit initial infrastructure and data changes. It also lets the organization validate operating processes before expanding scope. However, a built-in start still requires planning for RBAC, data scope, workflow ownership, testing, and preview change.

The examples in the [workbooks guidance](/defender-xdr/siem-defender-workbooks) cover device activity, email security, identity and sign-in monitoring, and alerts and incidents. Your plan identifies which views support the team's reporting needs and which underlying data and permissions each view requires.

:::image type="content" source="../media/built-in-example-workbooks.png" lightbox="../media/built-in-example-workbooks.png" alt-text="Screenshot of workbook examples for device activity, email security, identity and sign-in monitoring, and alerts and incidents.":::

For example, users need appropriate Workbooks permissions or a supported security role to view or manage workbooks. Enhanced automation rules also require the applicable Automation Rules permissions and, when a rule runs a playbook, Automation Playbooks permissions.

## Identify workspace-dependent capabilities

Add an ISOC workspace when a defined requirement depends on one or more of these capabilities:

| Capability | Why the workspace matters |
| --- | --- |
| User and Entity Behavior Analytics (UEBA) | The workspace supports the data and Microsoft Sentinel capability used for behavioral analytics. Review the UEBA guidance for setup and cost considerations before you enable it. |
| Content hub | The preview uses a workspace for supported Content hub data connectors. |
| Repositories for continuous integration and continuous delivery (CI/CD) | The workspace supports deploying eligible content as code from a repository. |
| Threat intelligence | The workspace supports the current ISOC threat-intelligence capability. |
| Azure and third-party security data | The workspace supports additional Microsoft and non-Microsoft data ingestion through more than 500 data connectors. |

The current requirement matrix applies to ISOC during this preview. It doesn't describe licensing or workspace requirements for the same capabilities in every other Microsoft security experience.

## Make the decision

Use this sequence:

1. **Name the outcome.** Describe the process or risk the organization needs to improve.
1. **Select the minimum capability set.** Choose capabilities that directly support the outcome.
1. **Classify each capability.** Mark it as built-in or workspace-dependent according to current documentation.
1. **Identify prerequisites and costs.** Include permissions, data dependencies, optional capability charges, and operational ownership.
1. **Choose the starting state.** Start without a workspace, plan a workspace, or defer the capability.

A useful decision statement is specific:

> Start with case management and workbooks to standardize incident coordination and reporting. Defer an ISOC workspace until the approved use case for third-party data establishes data scope, retention, cost, and ownership.

This statement links the workspace decision to outcomes and conditions. It avoids treating the workspace as a general requirement for ISOC.

## Avoid common planning errors

- **Assuming all ISOC capabilities require a workspace:** This adds unnecessary dependencies to the initial phase.
- **Assuming no-workspace means no governance:** Built-in capabilities still expose security data and can trigger actions.
- **Selecting connectors before defining use cases:** More data doesn't automatically improve detection or response.
- **Treating generated automation as production-ready:** Generated playbooks require review, testing, permissions, and monitoring.
- **Ignoring preview-specific distinctions:** Revalidate the capability matrix before implementation.
