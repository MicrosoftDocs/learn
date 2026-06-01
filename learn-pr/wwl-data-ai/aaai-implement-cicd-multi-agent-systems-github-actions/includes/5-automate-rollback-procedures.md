Even with progressive deployment and quality gates, some issues only manifest at production scale or with specific customer data patterns. When monitoring detects a quality regression, the system must roll back automatically to the last stable version without waiting for manual intervention. Automated rollback reduces the mean time to recovery (MTTR) from hours to minutes.

| Rollback Trigger | Detection Method | Typical Threshold | Response Time |
|------------------|------------------|-------------------|---------------|
| Evaluation score drop | Automated quality assessment | >5% degradation | 4-6 hours |
| Error rate spike | Application Insights alert | >2× baseline | 5 minutes |
| Latency degradation | Azure Monitor metric | P95 >150% of SLO | 10 minutes |
| Schema violation rate | Structured output validation | >1% of responses | 15 minutes |

## Design rollback triggers based on observable signals

Rollback triggers monitor signals that indicate agent behavioral failure. Design triggers based on metrics that reflect actual quality degradation, not just infrastructure health. An agent can have perfect uptime and normal latency while producing fundamentally incorrect outputs.

**Evaluation score drop** measures overall quality using the Azure AI Evaluation SDK. Establish a baseline by running evaluation sets against the stable production version. During and after deployment, continuously evaluate the new version. If the score drops more than the threshold percentage (typically 5%), trigger rollback. This signal captures behavioral regressions that might not appear in error logs.

**Error rate spike** detects immediate failures. Agent errors include exceptions during tool execution, timeouts waiting for model responses, and invalid JSON outputs. A sudden increase in error rate—more than double the baseline—indicates a deployment problem. This trigger responds fastest because errors appear immediately.

**Latency degradation** identifies performance regressions. If the new version takes 50% longer to respond than the SLO target, user experience suffers even if outputs are correct. Set alerts on P95 latency (the 95th percentile response time) rather than average latency to catch tail-latency problems.

**Schema violation rate** detects agents producing outputs that don't match expected structures. If the orchestrator expects JSON with specific fields and the new agent version returns different schemas, downstream components break. Track the percentage of responses that fail schema validation and roll back if violations exceed 1%.

## Implement automated rollback workflows

When a trigger activates, the rollback workflow re-deploys the previous stable version tag without manual approval. Speed is critical—the longer a degraded version serves traffic, the more customer impact.

Implement rollback as a GitHub Actions workflow that responds to webhook alerts from Azure Monitor:

```yaml
# .github/workflows/automated-rollback.yml
name: Automated Agent Rollback
on:
  repository_dispatch:
    types: [quality-regression-detected]

jobs:
  rollback-agent:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Identify current and previous versions
        id: versions
        run: |
          # Get failing agent and environment from webhook payload
          AGENT_NAME="${{ github.event.client_payload.agent_name }}"
          ENVIRONMENT="${{ github.event.client_payload.environment }}"
          
          # Query deployment history for stable rollback target
          CURRENT_VERSION=$(az containerapp revision list \
            --name fabrikam-${AGENT_NAME}-${ENVIRONMENT} \
            --resource-group fabrikam-agents-${ENVIRONMENT} \
            --query "[?properties.active].name" -o tsv)
          
          STABLE_VERSION=$(az containerapp revision list \
            --name fabrikam-${AGENT_NAME}-${ENVIRONMENT} \
            --resource-group fabrikam-agents-${ENVIRONMENT} \
            --query "[?properties.active==\`false\`]|[0].name" -o tsv)
          
          echo "current=${CURRENT_VERSION}" >> $GITHUB_OUTPUT
          echo "stable=${STABLE_VERSION}" >> $GITHUB_OUTPUT
          echo "agent=${AGENT_NAME}" >> $GITHUB_OUTPUT
          echo "environment=${ENVIRONMENT}" >> $GITHUB_OUTPUT
      
      - name: Execute rollback
        run: |
          az containerapp revision activate \
            --name fabrikam-${{ steps.versions.outputs.agent }}-${{ steps.versions.outputs.environment }} \
            --resource-group fabrikam-agents-${{ steps.versions.outputs.environment }} \
            --revision ${{ steps.versions.outputs.stable }}
          
          echo "Rolled back ${{ steps.versions.outputs.agent }} from ${{ steps.versions.outputs.current }} to ${{ steps.versions.outputs.stable }}"
      
      - name: Notify on-call team
        run: |
          curl -X POST ${{ secrets.TEAMS_WEBHOOK_URL }} \
            -H 'Content-Type: application/json' \
            -d '{
              "title": "Automated Rollback Executed",
              "text": "Agent ${{ steps.versions.outputs.agent }} rolled back in ${{ steps.versions.outputs.environment }} due to quality regression.",
              "themeColor": "FF0000"
            }'
      
      - name: Create incident issue
        uses: actions/github-script@v7
        with:
          script: |
            await github.rest.issues.create({
              owner: context.repo.owner,
              repo: context.repo.repo,
              title: `Rollback: ${process.env.AGENT} in ${process.env.ENV}`,
              body: `Automated rollback executed.\n\nAgent: ${process.env.AGENT}\nEnvironment: ${process.env.ENV}\nTrigger: ${process.env.TRIGGER}\nRolled back to: ${process.env.STABLE}`,
              labels: ['incident', 'automated-rollback']
            })
        env:
          AGENT: ${{ steps.versions.outputs.agent }}
          ENV: ${{ steps.versions.outputs.environment }}
          TRIGGER: ${{ github.event.client_payload.trigger_type }}
          STABLE: ${{ steps.versions.outputs.stable }}
```

Configure Azure Monitor to send webhook alerts to GitHub's repository dispatch endpoint when quality thresholds breach. The workflow identifies the stable rollback target (the previous active revision), activates it, notifies the on-call team, and creates a GitHub issue for post-incident analysis.

## Coordinate partial rollbacks in multi-agent systems

In a multi-agent system, only one agent may need to roll back. If the security scanner version 2.3 causes quality degradation, roll back only the security scanner—not the orchestrator, ingestion agent, or other components. Partial rollback maintains forward progress for agents that deployed successfully.

The rollback workflow must respect the dependency graph in reverse. If Agent A depends on Agent B, and both were updated together, rolling back Agent B might break Agent A unless A's version is compatible with the old B version. The safest approach: when rolling back Agent B, also roll back all agents that depend on B and were updated in the same deployment batch.

Track deployment batches using GitHub release tags:

```yaml
# Tag all agents deployed together
git tag -a release-2024-04-07 -m "Orchestrator v2.3, Security Scanner v2.1, Style Checker v1.8"
git push origin release-2024-04-07
```

During rollback, identify all agents in the failing release tag and roll back the entire set:

```bash
# Extract agents from release tag
AGENTS=$(git tag -l -n1 release-2024-04-07 | grep -oP '\w+-agent')

# Roll back each agent individually
for agent in $AGENTS; do
  az containerapp revision activate \
    --name fabrikam-${agent}-production \
    --resource-group fabrikam-agents-production \
    --revision ${agent}-stable
done
```

This coordinated rollback ensures the agent network remains in a consistent, validated state.

## Document rollback triggers in blameless post-mortems

After a rollback executes, conduct a blameless post-mortem analysis. The goal isn't to assign blame—it's to understand what failed, why the deployment passed pre-production validation but failed in production, and what additional validation would have caught the issue.

Document in the GitHub issue created by the rollback workflow:

- **What failed**: Specific behavior that degraded (evaluation score dropped from 0.87 to 0.79)
- **Trigger signal**: Which monitoring alert activated the rollback (evaluation score threshold breach)
- **Rolled back version**: The version tag that was rolled back
- **Stable version**: The version restored by rollback
- **Root cause**: Why the new version regressed (new system prompt reduced recall for low-severity vulnerabilities)
- **Prevention**: What validation should be added to catch similar issues before production (expand evaluation set to include more low-severity vulnerability examples)

This documentation becomes organizational learning. Over time, you build a knowledge base of failure modes and prevention strategies that improve the entire CI/CD process. Automated rollback reduces immediate customer impact, but the post-mortem analysis prevents future incidents.

With dependency modeling, progressive deployment, multi-environment strategies, and automated rollback in place, you have a comprehensive CI/CD system for multi-agent deployments. You're ready to implement this system hands-on in the exercise.

## Key takeaways

- **Rollback triggers** monitor evaluation scores, error rates, latency degradation, and schema violations to detect quality regressions automatically.
- **Automated rollback workflows** re-deploy the previous stable version via GitHub Actions without manual approval, reducing mean time to recovery to minutes.
- **Partial rollbacks** roll back only the failing agent—plus its dependents—while preserving forward progress for unaffected agents.
- **Blameless post-mortems** document what failed, which signal triggered rollback, root cause, and prevention measures to build organizational learning.
