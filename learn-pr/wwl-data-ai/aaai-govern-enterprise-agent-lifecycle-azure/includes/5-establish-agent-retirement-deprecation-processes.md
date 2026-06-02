The Microsoft Foundry Control Plane gives you visibility into every deployed agent—its version, operational status, error rate, and monthly cost—making it the central tool for identifying and decommissioning agents that are no longer needed. In this unit, you use the Foundry portal alongside retirement checklists, graceful deprecation patterns, and governance processes to manage the full agent lifecycle through to safe decommissioning.

## Recognize hidden costs of zombie agents

| Retirement Challenge | Uncontrolled Deprecation | Governed Retirement Process |
|---------------------|--------------------------|----------------------------|
| Zombie agents | Accumulate indefinitely | Systematic decommissioning |
| Dependency tracking | Unknown (breaks on deletion) | Documented and verified |
| Security patches | Can't force upgrades | Controlled migration windows |

Zombie agents are deprecated versions still running in production because no one verified dependencies or executed retirement. These agents create several classes of problems that compound over time.

**Resource consumption** continues even after agents are functionally replaced. A deprecated security analyzer version 1.8 that's been replaced by version 2.3 still consumes: compute resources (container instances running continuously in Azure Container Apps), storage resources (vector indexes and embeddings that are no longer queried), model quota allocation (if the agent was deployed on a dedicated model instance), and monitoring costs (Application Insights logging and dashboard queries tracking the deprecated agent).

If three deprecated agent versions accumulate over a year, they might consume 15-20% of total infrastructure costs despite providing zero business value. These costs are invisible until someone audits deployed resources and discovers containers running outdated versions.

**Technical debt** accumulates in zombie agents that never receive updates. The deprecated security analyzer is running on an older Azure OpenAI model version that reached end-of-life, uses system prompts with known bias issues that were fixed in later versions, and depends on Python libraries with published CVEs that haven't been patched. The agent continues functioning but represents a security and compliance liability.

**Output inconsistency** emerges when zombie agents remain in the multi-agent orchestration pipeline alongside updated agents. If the preprocessing agent has been upgraded to version 3.1 but the security analyzer is still running version 1.8, the orchestrator coordinates mismatched versions. The preprocessing agent outputs new fields that the security analyzer doesn't understand, or uses updated terminology that the security analyzer misinterprets, creating degraded review quality despite most agents being current.

Preventing zombie agents requires proactive retirement processes that identify deprecation triggers, track dependencies, execute migration plans, and verify decommissioning completeness.

## Plan model deprecation and agent migration

Model deprecation drives many agent retirements. Microsoft Foundry announces model retirement dates months in advance—for example, "gpt-4o version 2024-08-06 will retire no earlier than October 15, 2025. Migrate to gpt-4.1 (2025-04-14) by that date." When a model your agents depend on reaches retirement, you must migrate affected agents to supported models.

You implement a deprecation calendar tracking process that monitors Azure OpenAI product announcements and maps model versions to agent dependencies. When a deprecation announcement occurs, the process:

1. **Identifies affected agents** by querying agent version manifests for dependencies on the deprecating model—"Which agents use GPT-4-0613?"
2. **Assesses migration complexity** by determining whether agents can migrate to the replacement model (gpt-4.1) with minimal changes, or whether the model's different characteristics (longer context window, different token limits, updated training data) require prompt rewrites and reevaluation
3. **Sets migration deadlines** at 90, 60, and 30 days before deprecation, creating time-bound milestones for testing, approval, and deployment
4. **Creates migration tickets** in the development backlog for each affected agent, prioritized by criticality (customer-facing agents migrate before internal tooling)

The migration work for each agent follows the versioning and approval workflow: create a new agent version using the replacement model, run evaluation benchmarks comparing old and new model outputs to verify equivalent or better performance, submit for approval through automated and manual gates, and deploy to production following the standard rollout tier schedule (aggressive adopters first, conservative adopters after validation).

For agents that can't easily migrate—perhaps the replacement model has different characteristics that would require extensive prompt reengineering—you assess whether to invest in migration or retire the agent entirely. If an agent's functionality has been superseded by newer agents or is rarely used, deprecation becomes an opportunity to simplify the system by retiring rather than migrating.

## Create agent retirement checklists

Before retiring an agent, you verify that removing it won't break production systems or violate customer commitments. The retirement checklist ensures comprehensive dependency verification:

**Check tenant version pins**. Query the tenant configuration database for any tenants that have pinned to a version of the agent being retired. If tenant "enterprise-fabrikam-eu" has pinned security-analyzer to version 1.8 with a pin expiring in 45 days, you can't retire version 1.8 until that pin expires or the tenant agrees to early migration. Contact affected tenants to discuss migration timing or wait for pins to expire naturally.

**Verify orchestrator dependencies**. Review the orchestrator code to confirm all references to the retiring agent have been updated to call newer versions. If the orchestrator has hardcoded conditional logic like "if security-analyzer version < 2.0, use legacy output format", that code must be removed or updated before retirement. Automated tests should verify the orchestrator functions correctly without the deprecated agent.

**Archive agent data**. The retiring agent might have created data that needs preservation for audit or compliance purposes. Security analysis results, reasoning traces logged to Application Insights, and agent-specific configuration files should be archived according to data retention policies before the agent is deleted. For enterprise customers with seven-year retention requirements, export relevant agent logs to long-term archive storage.

**Disable agent managed identity**. The retiring agent authenticates to Azure resources using a managed identity with specific role assignments. Don't delete the identity immediately—audit logs reference it, and deleting the identity would make historical logs harder to interpret. Instead, disable the identity (preventing new authentications) but preserve the identity resource so audit queries can resolve the identity name. Schedule identity deletion for 90 days post-retirement after audit retention requirements are satisfied.

**Update documentation and runbooks**. Operational documentation, troubleshooting runbooks, and architecture diagrams that reference the retiring agent need updates. If a runbook says "restart security-analyzer-1.8 if latency exceeds 5 seconds", update it to reference the current version. Outdated documentation creates operational confusion when teams troubleshoot issues referencing agents that no longer exist.

## Implement graceful deprecation with migration guidance

Immediately deleting a deprecated agent creates abrupt failures for any remaining users. Graceful deprecation means the agent continues serving existing users during a migration window while rejecting new requests and guiding users to the replacement.

You implement graceful deprecation by modifying the deprecated agent's API endpoint to return a structured deprecation response for new invocations:

```python
from flask import Flask, request, jsonify
from datetime import datetime, timezone

app = Flask(__name__)

# Configuration for deprecated agent
DEPRECATION_DATE = datetime(2026, 5, 1, tzinfo=timezone.utc)
MIGRATION_ENDPOINT = "https://api.fabrikam.com/agents/security-analyzer/v2"
DELETION_DATE = datetime(2026, 6, 1, tzinfo=timezone.utc)

@app.route('/analyze', methods=['POST'])
def analyze_code_deprecated():
    """
    Deprecated agent endpoint returns 410 Gone with migration instructions.
    
    Serves pinned tenants during migration window, rejects new users.
    """
    tenant_id = request.headers.get('X-Tenant-ID')
    
    # Check if tenant has an active pin allowing continued use
    tenant_has_pin = check_tenant_version_pin(tenant_id, agent_version='1.8')
    
    if tenant_has_pin:
        # Serve pinned tenants but include deprecation warning in response
        result = perform_legacy_security_analysis(request.json)
        
        result['deprecation_warning'] = {
            'message': 'This agent version is deprecated and will be deleted on '
                      f'{DELETION_DATE.strftime("%Y-%m-%d")}. Migrate to v2 API.',
            'migration_endpoint': MIGRATION_ENDPOINT,
            'days_until_deletion': (DELETION_DATE - datetime.now(timezone.utc)).days
        }
        
        # Log continued usage for migration tracking
        log_deprecated_usage(tenant_id, agent_version='1.8')
        
        return jsonify(result), 200
    
    else:
        # Reject new requests with 410 Gone and migration instructions
        return jsonify({
            'error': 'agent_deprecated',
            'error_code': 'AGENT_RETIRED',
            'message': f'Security Analyzer v1.8 was deprecated on {DEPRECATION_DATE.strftime("%Y-%m-%d")} '
                      f'and will be deleted on {DELETION_DATE.strftime("%Y-%m-%d")}.',
            'migration': {
                'replacement_endpoint': MIGRATION_ENDPOINT,
                'migration_guide': 'https://docs.fabrikam.com/agents/security-analyzer-migration-v2',
                'breaking_changes': [
                    'Output schema includes new `threat_severity` field',
                    'Input requires `language` parameter for improved analysis'
                ],
                'support_contact': 'agent-support@fabrikam.com'
            },
            'deprecation_timeline': {
                'deprecated_date': DEPRECATION_DATE.isoformat(),
                'deletion_date': DELETION_DATE.isoformat(),
                'days_remaining': (DELETION_DATE - datetime.now(timezone.utc)).days
            }
        }), 410  # 410 Gone: resource no longer available, permanently removed

def check_tenant_version_pin(tenant_id: str, agent_version: str) -> bool:
    """Check if tenant has active version pin allowing deprecated version usage."""
    # Query tenant configuration database
    # Return True if tenant has unexpired pin to agent_version
    # Implementation depends on your configuration storage
    return False  # Placeholder

def perform_legacy_security_analysis(code_data: dict) -> dict:
    """Execute the deprecated security analysis for pinned tenants."""
    # Original agent logic
    return {'findings': [], 'confidence': 0.0}

def log_deprecated_usage(tenant_id: str, agent_version: str):
    """Log continued usage of deprecated agent for migration progress tracking.
    
    Requires configure_azure_monitor() called at application startup.
    Install: pip install azure-monitor-opentelemetry
    """
    from opentelemetry import trace
    
    tracer = trace.get_tracer(__name__)
    
    with tracer.start_as_current_span("deprecated_agent_usage") as span:
        span.set_attribute("tenant_id", tenant_id)
        span.set_attribute("agent_version", agent_version)
```

This graceful deprecation approach serves dual purposes. Existing users with version pins continue working during their migration window, avoiding abrupt service disruption. New users attempting to integrate with the deprecated agent receive immediate, actionable guidance on migrating to the replacement, including the new endpoint, documentation links, and a timeline for forced migration.

The deprecation logging tracks migration progress. You monitor how many tenants are still invoking the deprecated endpoint and can proactively reach out to assist with migration as the deletion date approaches.

## Govern retirement decision-making

Before executing retirement, use the Microsoft Foundry Control Plane to identify aging agents and take initial action. The agent inventory view in the Foundry portal shows all running agents with their version, operational status, error rate, and estimated monthly cost—making zombie agents directly visible when you filter for low-run, high-cost deployments. For hosted agents, the Foundry portal and REST API support stop and start operations that deallocate compute while preserving the deployment record; for custom agents, block and unblock operations prevent new requests without deleting the agent. Use these platform controls to stop or block the retiring agent as soon as the retirement decision is made, preventing new workloads from reaching it while you work through the checklist below.

Who decides when an agent is retired? Individual developers shouldn't unilaterally delete agents without verifying impacts. You establish a governance process with clear roles:

**Product team** proposes retirement when an agent is functionally replaced by a newer version, a model dependency is deprecated forcing migration, or usage metrics show the agent is rarely invoked (fewer than 10 requests per month across all tenants). The proposal includes: the agent to retire, the replacement agent or alternative approach for users, the proposed retirement timeline (deprecation date, deletion date), and justification (cost savings, security improvements, functionality replacement).

**Customer success team** validates tenant impacts by checking tenant configurations for version pins and usage patterns, contacting enterprise customers using the retiring agent to discuss migration, and confirming no contractual commitments require continued support of the retiring version. If an enterprise customer's contract specifies support for specific agent versions, retirement requires contract renegotiation or waiting for contract renewal.

**Security team** confirms no active vulnerabilities require extended support. If the retiring agent is the only component that can detect a specific actively-exploited vulnerability, retirement is deferred until the replacement agent implements equivalent detection. Security patches might extend an agent's lifespan beyond its planned retirement if replacement capabilities aren't ready.

**Governance committee** (Responsible AI Officer, engineering leadership, product management) reviews the retirement proposal and makes the final decision. They assess: whether the migration timeline provides reasonable time for tenant migration (minimum 90 days from deprecation announcement to deletion), whether retirement risks are acceptable (known dependencies resolved, tenant impact minimal), and whether costs justify earlier or later retirement (high-cost zombie agents retire faster, low-cost agents might get longer migration windows).

Only after governance committee approval does retirement proceed. The decision is documented in the agent's version manifest with retirement metadata:

```yaml
retirement:
  status: deprecated
  deprecated_date: 2026-05-01
  deletion_date: 2026-06-01
  replacement_agent: security-analyzer-v2
  justification: "Model dependency (gpt-4o 2024-08-06) retired. Migrated to gpt-4.1 (2025-04-14) in v2."
  approval:
    approver: governance-committee@fabrikam.com
    approval_date: 2026-04-15
```

A retirement decision is only as good as its execution. The governance framework you've built here—Foundry Control Plane visibility to surface aging agents, checklists that verify every dependency, graceful deprecation that protects pinned tenants during migration windows, and committee approval that weighs efficiency against customer commitments—ensures agents reach end of life deliberately rather than accidentally. A platform that decommissions agents cleanly stays lean and secure as it evolves, without the zombie deployments that quietly consume budget and accumulate vulnerabilities.

## Key takeaways

- **Zombie agents** are deprecated versions that continue consuming compute, storage, and quota resources while creating security liabilities and output inconsistencies.
- **Model deprecation planning** maps Azure OpenAI deprecation announcements to affected agents and sets 90/60/30-day migration milestones.
- **Retirement checklists** verify tenant version pins, orchestrator dependencies, data archival, managed identity status, and documentation updates before decommissioning.
- **Graceful deprecation** returns HTTP 410 with migration instructions for new users while continuing to serve pinned tenants during their migration window.
- **Governance committees** make retirement decisions balancing operational efficiency against customer commitments, with minimum 90-day migration windows.
