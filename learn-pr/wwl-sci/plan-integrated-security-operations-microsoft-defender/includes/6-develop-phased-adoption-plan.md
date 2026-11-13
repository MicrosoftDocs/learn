You now bring the capability, data, access, retention, and cost decisions together in a phased adoption plan with outcomes, owners, prerequisites, measures, and exit decisions. The plan describes what the organization adopts and why, while separate implementation plans contain portal procedures and configuration details.

## Define the target operating state

Describe the target state in operational terms. Include:

- Security operations outcomes and affected workflows.
- Roles responsible for platform administration, triage, investigation, response, and governance.
- Selected built-in and workspace-dependent capabilities.
- Data sources and access scopes.
- Retention and audit requirements.
- Automation approval and testing controls.
- Cost ownership and consumption monitoring.
- Preview risks and fallback processes.

Keep the target state proportional to the job. If the immediate need is consistent case ownership, don't make third-party data ingestion or UEBA a dependency without another approved outcome.

## Organize adoption into phases

The following model provides a starting point. Adapt it to the organization's requirements.

### Phase 0: Confirm readiness

Validate preview eligibility, licenses, tenant state, and organizational readiness. Inventory current workflows, data, permissions, and retention requirements. Record the decision to proceed, limit scope, or defer.

**Exit evidence:** Approved eligibility and readiness record, named owners, accepted preview risk, and documented target outcomes.

### Phase 1: Establish built-in workflows

Use selected capabilities that don't require an ISOC workspace. A team might introduce case conventions, tenant-level workbooks, or a controlled automation proof of concept. Define RBAC, workflow ownership, testing, and audit expectations before use.

**Exit evidence:** Users can complete the target workflow with approved access, ownership, and measurements. Exceptions and support responsibilities are documented.

### Phase 2: Add a workspace when justified

Create a workspace only when an approved outcome requires UEBA, Content hub connectors, repositories for CI/CD, threat intelligence, or additional Microsoft or non-Microsoft data. Confirm the Azure subscription, provisioning permissions, data design, retention, and cost estimate.

**Exit evidence:** The workspace-dependent use case has approved architecture, access, data ownership, budget, validation criteria, and implementation responsibility.

### Phase 3: Expand and optimize

Add data sources and automation individually based on measured outcomes. Review query performance, data quality, analyst workload, automated actions, consumption, and false-positive effects. Retire capabilities or data that don't support an approved use case.

**Exit evidence:** Operational measures support expansion, controls continue to work, and costs remain within approved thresholds.

## Create capability decision records

For each capability, use a compact record:

| Field | Example planning content |
| --- | --- |
| Outcome | Reduce unassigned security operations work. |
| Capability | Case management. |
| Workspace required | No, according to the current ISOC preview matrix. |
| Data and scope | Supported incident context within approved Defender scopes. |
| Roles | Case managers have manage access; reviewers have read access. |
| Controls | Assignment standard, service-level policy, escalation path, and audit review. |
| Measure | Percentage of cases assigned within the target time. |
| Decision gate | Expand after access and workflow validation. |

The record provides traceability without becoming a configuration guide.

## Define measures and decision gates

Choose measures that reflect operational outcomes:

- Time to assign and acknowledge work.
- Percentage of cases with an owner and required tasks.
- Time analysts spend transferring context between tools.
- Coverage gained from an additional data source.
- Automation success, exception, and rollback rates.
- Data ingestion volume and cost against the approved range.
- Access review findings and audit completeness.

At each phase boundary, decide to **proceed**, **adjust**, **pause**, or **stop**. Revalidate official documentation because the preview can change. Record changes to eligibility, workspace requirements, included retention, pricing, and capability availability.

## Complete the planning checklist

Before handing work to an implementation team, confirm that the plan:

- States the operational outcomes and scope.
- Records eligibility and license evidence.
- Distinguishes built-in from workspace-dependent capabilities.
- Identifies native Defender and additional connector-based data.
- Defines access, ownership, retention, and audit requirements.
- Estimates ingestion, optional capability, retention, and operating costs.
- Establishes phases, measures, decision gates, and fallback criteria.
- Assigns implementation owners without embedding step-by-step deployment instructions.
- Requires product details to be revalidated before each phase.

The completed plan gives decision-makers enough information to authorize a controlled evaluation or to defer it with clear reasons.
