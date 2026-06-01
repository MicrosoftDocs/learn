Agent behavior changes are invisible to traditional infrastructure monitoring. A new system prompt or model version switch might produce identical latency and error rate metrics while generating fundamentally different outputs. You can't rely on health checks alone to validate an agent deployment—you need quality-gated rollout strategies that monitor behavioral correctness, not just operational health.

| Strategy | Traffic Pattern | Rollback Speed | Best For |
|----------|----------------|----------------|----------|
| Canary | Gradual % increase | Moderate (hours) | Behavioral validation at scale |
| Blue-green | Instant 100% switch | Immediate (seconds) | Configuration changes, urgent fixes |
| Feature flags | Per-tenant activation | Immediate | Gradual feature rollout by customer |

## Route traffic incrementally with canary deployments

Canary deployment routes a small percentage of requests to the new agent version while the majority continues using the stable version. Start with 5% of traffic going to the canary. Monitor quality metrics for 24 hours. If the canary performs within acceptable thresholds, increase to 25%, then 50%, then 100% over several days.

The quality gate determines success: if evaluation scores drop more than a defined threshold compared to the baseline, stop the rollout and roll back automatically. For Fabrikam's code review system, the primary quality metric is the accuracy of security vulnerability detection. A canary that misses 15% more vulnerabilities than the production version fails the quality gate.

Implement canary deployment using traffic splitting in Azure AI Foundry or Azure Container Apps. For agent endpoints deployed as Azure Container Apps, configure traffic splitting at the revision level:

```python
# scripts/configure_canary.py
from azure.mgmt.appcontainers import ContainerAppsAPIClient
from azure.identity import DefaultAzureCredential

def configure_canary_deployment(
    subscription_id: str,
    resource_group: str,
    container_app_name: str,
    stable_revision: str,
    canary_revision: str,
    canary_weight: int
):
    """Configure traffic split between stable and canary agent revisions."""
    
    credential = DefaultAzureCredential()
    client = ContainerAppsAPIClient(credential, subscription_id)
    
    # Get current container app configuration
    container_app = client.container_apps.get(
        resource_group_name=resource_group,
        container_app_name=container_app_name
    )
    
    # Update traffic configuration
    traffic_config = [
        {
            "revisionName": stable_revision,
            "weight": 100 - canary_weight,
            "label": "stable"
        },
        {
            "revisionName": canary_revision,
            "weight": canary_weight,
            "label": "canary"
        }
    ]
    
    container_app.configuration.ingress.traffic = traffic_config
    
    # Apply configuration
    client.container_apps.begin_create_or_update(
        resource_group_name=resource_group,
        container_app_name=container_app_name,
        container_app_envelope=container_app
    ).result()
    
    print(f"Canary configured: {canary_weight}% traffic to {canary_revision}")
```

This script sets the traffic weight for the canary revision. Call it from a GitHub Actions workflow that gradually increases the canary percentage based on quality gate results.

## Monitor quality metrics during progressive rollout

Quality gates assess whether the canary version maintains acceptable behavioral performance. Define baseline metrics from the stable version using evaluation runs over representative test data. During the canary period, evaluate the canary version against the same test data and compare results.

Key quality metrics for agent deployments include:

- **Evaluation score**: Overall quality rating from Azure AI Evaluation SDK benchmarks
- **Error rate**: Percentage of requests that fail or produce invalid output
- **Latency P95**: 95th percentile response time
- **Task success rate**: Percentage of requests that accomplish the intended task

Configure automated quality assessment in a GitHub Actions workflow that queries evaluation results and makes rollout decisions:

```yaml
# .github/workflows/canary-quality-gate.yml
name: Canary Quality Gate Assessment
on:
  schedule:
    - cron: '0 */4 * * *'  # Every 4 hours during canary period

jobs:
  assess-quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Run evaluation against canary revision
        run: |
          python scripts/run_evaluation.py \
            --agent-endpoint ${{ vars.CANARY_ENDPOINT }} \
            --test-dataset data/eval-set.jsonl \
            --output results/canary-eval.json
      
      - name: Compare against baseline metrics
        id: compare
        run: |
          python scripts/compare_metrics.py \
            --baseline results/baseline-eval.json \
            --current results/canary-eval.json \
            --threshold 0.05
      
      - name: Make rollout decision
        run: |
          if [ "${{ steps.compare.outputs.decision }}" == "PASS" ]; then
            echo "Quality gate passed - increasing canary traffic"
            python scripts/increase_canary_weight.py --increment 20
          else
            echo "Quality gate failed - initiating rollback"
            python scripts/rollback_canary.py
            exit 1
          fi
```

This workflow evaluates the canary every four hours. If quality metrics remain within 5% of baseline (the threshold parameter), it increases canary traffic by 20%. If metrics degrade beyond the threshold, it triggers an automated rollback.

## Switch instantly with blue-green deployments

Blue-green deployment maintains two complete environments: blue represents the current production version, green represents the new version. You deploy and validate the green environment fully before switching any traffic to it. Once validation passes, switch 100% of traffic from blue to green instantly. If problems emerge, switch back to blue immediately.

This strategy works well for configuration changes, infrastructure updates, or urgent security fixes where you need immediate full deployment or immediate full rollback. Use Azure Traffic Manager or Azure Front Door to switch traffic between blue and green endpoints at the DNS level.

The traffic switch happens by updating the Traffic Manager profile to route all requests to the green endpoint:

```azurecli
# Switch traffic from blue to green
az network traffic-manager endpoint update \
  --name blue-endpoint \
  --profile-name fabrikam-agents \
  --resource-group fabrikam-production \
  --type azureEndpoints \
  --endpoint-status Disabled

az network traffic-manager endpoint update \
  --name green-endpoint \
  --profile-name fabrikam-agents \
  --resource-group fabrikam-production \
  --type azureEndpoints \
  --endpoint-status Enabled
```

Blue-green deployments require maintaining double the infrastructure during the transition period, but they provide the fastest rollback path—just re-enable the blue endpoint if the green version causes problems.

## Control feature activation with feature flags

Feature flags decouple code deployment from feature activation. Deploy the new agent code everywhere, but activate new behaviors only for specific tenants using runtime configuration. This approach enables gradual feature rollout without redeployment and provides instant feature deactivation if problems occur.

Store feature flags in Azure App Configuration and configure agents to check flag state before using new behaviors:

```python
# agents/orchestrator/feature_flags.py
from azure.appconfiguration import AzureAppConfigurationClient
from azure.identity import DefaultAzureCredential

class FeatureFlagManager:
    def __init__(self, connection_string: str):
        self.client = AzureAppConfigurationClient.from_connection_string(
            connection_string
        )
    
    def is_enabled(self, feature_name: str, tenant_id: str = None) -> bool:
        """Check if a feature is enabled globally or for specific tenant."""
        
        # Check tenant-specific override first
        if tenant_id:
            tenant_key = f"features:{feature_name}:tenants:{tenant_id}"
            try:
                config = self.client.get_configuration_setting(key=tenant_key)
                return config.value.lower() == "true"
            except:
                pass  # No tenant override exists
        
        # Check global feature flag
        global_key = f"features:{feature_name}:enabled"
        config = self.client.get_configuration_setting(key=global_key)
        return config.value.lower() == "true"

# Usage in agent code
feature_flags = FeatureFlagManager(os.environ["APPCONFIG_CONNECTION_STRING"])

if feature_flags.is_enabled("advanced_security_scan", tenant_id=current_tenant):
    # Use new security scanning model
    result = advanced_security_scan(code)
else:
    # Use stable security scanning model
    result = standard_security_scan(code)
```

Feature flags provide the most granular control over rollout. Activate the new security scanning model for Fabrikam's internal testing first, then for select beta customers, then for all customers—without touching deployment pipelines.

## Combine strategies for comprehensive risk management

Use multiple progressive deployment strategies together. Deploy the new agent version to staging with full blue-green infrastructure. After staging validation passes, deploy to production using canary rollout. Control which customers see the new behavior using feature flags. This layered approach provides defense in depth: infrastructure validation, behavioral validation at scale, and per-tenant activation control.

Now that you understand how to roll out agent changes progressively with quality gates, you're ready to configure multi-environment strategies that support enterprise deployment workflows.

## Key takeaways

- **Canary deployment** routes a small percentage of traffic to the new version while monitoring quality gates before increasing exposure.
- **Quality gates** compare behavioral metrics—evaluation scores, error rates, and task success rates—against baseline thresholds to approve or reject rollouts.
- **Blue-green deployment** maintains two complete environments for instant traffic switching and immediate rollback capability.
- **Feature flags** decouple deployment from activation, enabling per-tenant feature rollout without redeployment.
- **Layered strategies** combine canary, blue-green, and feature flags for defense-in-depth risk management.
