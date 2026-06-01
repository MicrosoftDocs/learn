At Fabrikam, 20 development teams use the multi-agent code review system, consuming Azure OpenAI tokens, agent compute resources, and vector storage across hundreds of code submissions daily. Finance asks: "What does the code review system cost per team so we can allocate expenses to departmental budgets?" Without granular cost attribution, AI spending appears as a single line item on the Azure bill, making it impossible to identify which teams drive costs or to create incentives for optimization. Implementing cost allocation and chargeback requires architecting cost attribution across model usage, compute consumption, and storage expenses, metering usage with custom dimensions, calculating monthly chargeback reports, and creating cost dashboards that drive optimization behaviors.

| Cost Attribution | Shared Cost Model | Granular Chargeback Model |
|------------------|-------------------|--------------------------|
| Visibility | Total monthly cost only | Per-team, per-agent breakdown |
| Accountability | No owner for optimization | Teams manage their budgets |
| Optimization incentive | None (invisible costs) | Strong (teams see their costs) |

## Understand multi-dimensional cost attribution

AI system costs span multiple Azure services, each requiring different attribution approaches. Model costs come from Azure OpenAI API usage measured in tokens—every agent invocation consumes input tokens (the prompt and code submitted) and output tokens (the agent's response). Azure bills per 1,000 tokens with different rates for different models: GPT-4 Turbo costs more per token than GPT-3.5 Turbo, and input tokens cost less than output tokens.

Compute costs come from agent container runtime in Azure Container Apps. Each agent runs in dedicated container instances that consume CPU and memory. When an agent scales to handle increased load, additional container instances deploy, increasing compute costs. Azure bills for container vCPU-seconds and GB-seconds. Unlike model costs, which correlate directly with workload (more code reviews = more tokens), compute costs include baseline "always-on" expenses even when no code reviews are processing.

Storage costs come from multiple sources: blob storage for uploaded code files, vector databases storing code embeddings for semantic search, search indexes enabling agents to query security guidelines, and Application Insights logs capturing telemetry and audit trails. Storage costs are relatively small compared to model and compute but accumulate over time and should be attributed to understand complete cost of ownership.

For accurate cost attribution, you need to track which tenant triggered which resource consumption. When tenant "enterprise-fabrikam-eu" submits code for review, you need to attribute the resulting model token usage, compute seconds, and storage operations to that tenant. This requires instrumenting every resource interaction with tenant context.

## Instrument cost tracking at interaction points

Cost attribution begins with comprehensive metering. You instrument three primary interaction points where costs accrue: model API calls, agent container execution, and storage operations.

**Model API call metering** captures token consumption per request. Azure OpenAI API responses include `usage` fields showing input tokens, output tokens, and total tokens consumed. You extract these values and log them along with tenant context:

Every model API response includes usage data that you must log immediately:

```json
{
  "choices": [...],
  "usage": {
    "prompt_tokens": 1247,
    "completion_tokens": 312,
    "total_tokens": 1559
  }
}
```

Your agent code extracts this usage information and emits a custom metric to Application Insights with dimensions enabling cost queries by tenant, agent, and model.

**Compute metering** attributes container runtime to tenants. Azure Container Apps doesn't natively track which tenant drove which scaling events, so you implement custom metering. Each agent invocation logs start and end timestamps, enabling duration calculation. You emit metrics showing: tenant ID that triggered the invocation, agent ID consuming compute resources, container instance ID that processed the request, duration in seconds, and estimated vCPU and memory consumption based on container instance size.

**Storage metering** tags operations with tenant context. When agents write files to blob storage (uploaded code, intermediate processing results), you include tenant ID in blob metadata. When vector embeddings are stored, you partition by tenant and track storage consumption per partition. These tags enable Azure Cost Management to attribute storage costs to tenant-level cost centers.

```python
from applicationinsights import TelemetryClient
from datetime import datetime, timezone

class CostAttributionTracker:
    """Track resource consumption for cost allocation and chargeback."""
    
    def __init__(self, instrumentation_key: str):
        self.telemetry = TelemetryClient(instrumentation_key)
    
    def track_model_usage(self, tenant_id: str, agent_id: str, model_name: str, 
                         usage: dict, operation_type: str):
        """
        Emit cost attribution metric for model API consumption.
        
        Dimensions enable querying by tenant, agent, model for chargeback calculation.
        """
        self.telemetry.track_event(
            'ModelTokenUsage',
            properties={
                'tenant_id': tenant_id,
                'agent_id': agent_id,
                'model_name': model_name,
                'operation_type': operation_type,  # e.g., 'security_analysis', 'quality_review'
                'timestamp': datetime.now(timezone.utc).isoformat()
            },
            measurements={
                'input_tokens': usage.get('prompt_tokens', 0),
                'output_tokens': usage.get('completion_tokens', 0),
                'total_tokens': usage.get('total_tokens', 0)
            }
        )
    
    def track_compute_usage(self, tenant_id: str, agent_id: str, 
                          duration_seconds: float, container_spec: dict):
        """
        Emit cost attribution metric for agent compute consumption.
        
        Tracks vCPU and memory consumption for container instance runtime.
        """
        # Container specs define vCPU and memory allocation
        vcpu_allocation = container_spec.get('vcpu', 0.5)  # e.g., 0.5 vCPU
        memory_gb = container_spec.get('memory_gb', 1.0)   # e.g., 1 GB
        
        # Calculate vCPU-seconds and GB-seconds for cost attribution
        vcpu_seconds = vcpu_allocation * duration_seconds
        gb_seconds = memory_gb * duration_seconds
        
        self.telemetry.track_event(
            'AgentComputeUsage',
            properties={
                'tenant_id': tenant_id,
                'agent_id': agent_id,
                'container_instance': container_spec.get('instance_id'),
                'timestamp': datetime.now(timezone.utc).isoformat()
            },
            measurements={
                'duration_seconds': duration_seconds,
                'vcpu_seconds': vcpu_seconds,
                'memory_gb_seconds': gb_seconds
            }
        )
    
    def track_storage_usage(self, tenant_id: str, operation_type: str, 
                          bytes_written: int, storage_service: str):
        """
        Emit cost attribution metric for storage operations.
        
        Tracks blob writes, vector index updates, search operations.
        """
        self.telemetry.track_event(
            'StorageUsage',
            properties={
                'tenant_id': tenant_id,
                'operation_type': operation_type,  # e.g., 'blob_write', 'vector_index'
                'storage_service': storage_service,  # e.g., 'blob', 'search', 'cosmos'
                'timestamp': datetime.now(timezone.utc).isoformat()
            },
            measurements={
                'bytes': bytes_written,
                'operations': 1  # Count operations for transaction-based costs
            }
        )
    
    def flush(self):
        """Ensure all telemetry is sent before agent terminates."""
        self.telemetry.flush()
```

## Calculate monthly chargeback from metered usage

Metered usage data enables monthly chargeback calculation combining Azure Cost Management data with custom metrics. Azure Cost Management provides actual costs for model API usage (Azure OpenAI charges), compute resources (Container Apps charges), and storage services (blob, search, database charges). These costs are tagged with resource groups and subscriptions but don't include tenant-level granularity.

You combine Azure costs with custom metric aggregations to calculate per-tenant chargeback. The monthly chargeback process runs automatically on the first day of each month:

1. **Query Azure Cost Management API** for total costs across all code review system resources during the previous month—model deployments, container apps, storage accounts, and supporting services
2. **Query Application Insights** for custom metrics aggregated by tenant—total tokens consumed per tenant, total compute seconds per tenant, and total storage operations per tenant
3. **Calculate cost allocation ratios**—if tenant A consumed 40% of total tokens, they're allocated 40% of Azure OpenAI model costs; if tenant B consumed 25% of compute seconds, they're allocated 25% of Container Apps costs
4. **Generate chargeback reports** showing per-tenant costs broken down by service category: model usage, compute usage, storage usage, and total monthly cost

The calculation handles shared baseline costs appropriately. Some compute costs aren't tenant-driven—the orchestrator runs continuously even with no active requests, consuming baseline compute. You allocate these shared costs proportionally across all active tenants rather than to any specific tenant. The shared cost percentage (typically 10-15% of total compute costs) is distributed evenly.

```python
def generate_monthly_chargeback_report(month: str, year: int):
    """
    Calculate per-tenant chargeback by combining Azure costs with usage metrics.
    
    Returns chargeback report with cost breakdown by service category.
    """
    from azure.mgmt.costmanagement import CostManagementClient
    from azure.identity import DefaultAzureCredential
    from applicationinsights.query import QueryClient
    
    # Query actual Azure costs for the month
    cost_client = CostManagementClient(DefaultAzureCredential())
    
    # Get total model costs (Azure OpenAI)
    total_model_cost = query_azure_openai_costs(cost_client, month, year)
    
    # Get total compute costs (Container Apps)
    total_compute_cost = query_container_apps_costs(cost_client, month, year)
    
    # Get total storage costs (Blob, Search, Cosmos)
    total_storage_cost = query_storage_costs(cost_client, month, year)
    
    # Query Application Insights for tenant usage breakdowns
    insights_client = QueryClient(app_id='<app-insights-id>', credential=DefaultAzureCredential())
    
    # Aggregate token usage by tenant
    token_usage_query = f"""
    customEvents
    | where timestamp >= datetime({year}-{month:02}-01) and timestamp < datetime({year}-{month+1:02}-01)
    | where name == 'ModelTokenUsage'
    | summarize TotalTokens = sum(todouble(customMeasurements.total_tokens)) by TenantID = tostring(customDimensions.tenant_id)
    """
    token_usage_by_tenant = insights_client.query(token_usage_query)
    
    # Aggregate compute usage by tenant
    compute_usage_query = f"""
    customEvents
    | where timestamp >= datetime({year}-{month:02}-01) and timestamp < datetime({year}-{month+1:02}-01)
    | where name == 'AgentComputeUsage'
    | summarize TotalVCPUSeconds = sum(todouble(customMeasurements.vcpu_seconds)) by TenantID = tostring(customDimensions.tenant_id)
    """
    compute_usage_by_tenant = insights_client.query(compute_usage_query)
    
    # Calculate allocation ratios and per-tenant costs
    chargeback_report = []
    
    total_tokens = sum([row['TotalTokens'] for row in token_usage_by_tenant.tables[0].rows])
    
    for tenant_row in token_usage_by_tenant.tables[0].rows:
        tenant_id = tenant_row['TenantID']
        tenant_tokens = tenant_row['TotalTokens']
        
        # Allocate model costs proportionally to token usage
        tenant_model_cost = (tenant_tokens / total_tokens) * total_model_cost
        
        # Allocate compute costs (simplified - should match compute query)
        tenant_compute_cost = calculate_tenant_compute_cost(tenant_id, compute_usage_by_tenant, total_compute_cost)
        
        # Storage typically small, allocate evenly or by operations
        tenant_storage_cost = total_storage_cost / len(token_usage_by_tenant.tables[0].rows)
        
        chargeback_report.append({
            'tenant_id': tenant_id,
            'month': month,
            'year': year,
            'model_cost_usd': round(tenant_model_cost, 2),
            'compute_cost_usd': round(tenant_compute_cost, 2),
            'storage_cost_usd': round(tenant_storage_cost, 2),
            'total_cost_usd': round(tenant_model_cost + tenant_compute_cost + tenant_storage_cost, 2)
        })
    
    return chargeback_report
```

## Create cost dashboards that drive optimization

Chargeback reports make costs visible, but cost dashboards drive action. You design a Cost Dashboard accessible to development team leads showing their team's monthly AI costs with breakdowns by cost driver, comparison to previous months, and optimization recommendations.

The dashboard displays: **Total monthly cost** (current month and trend over previous 3 months), **Cost per code review** (total cost divided by number of submissions, showing unit economics), **Top 5 cost drivers** (which agents or operations consumed the most resources), **Token efficiency** (average tokens per code review, with outliers highlighted), and **Optimization opportunities** (specific actions that would reduce costs with estimated savings).

The optimization recommendations are generated automatically by analyzing usage patterns. Common recommendations include:

**Use smaller models for simple tasks**: "Your security analyzer consumed 1.2M tokens on syntax checks that could run on GPT-3.5-Turbo instead of GPT-4 Turbo, saving ~$45/month."

**Batch processing during off-peak hours**: "Your team submitted 87% of code reviews between 2-4 PM UTC, competing for quota with other teams. Shift batch reviews to off-peak hours (8-10 PM UTC) to reduce retry overhead and improve latency."

**Cache repeated analysis patterns**: "23% of your code reviews analyzed similar authentication patterns. Enable semantic caching to reduce redundant model calls, estimated savings: $30/month."

**Right-size agent deployments**: "Your quality analyzer averaged 12% CPU utilization. Reduce container allocation from 1.0 vCPU to 0.5 vCPU, saving $18/month in compute costs."

When teams see their costs broken down with actionable optimization guidance, they make informed decisions. A team spending $800/month on code reviews might decide that's reasonable for their 50-developer organization, or they might implement caching and model optimization to reduce costs by 30% while maintaining review quality. The visibility creates accountability and optimization incentives that don't exist when AI costs are invisible shared overhead.

With comprehensive cost allocation in place—instrumented metering at all consumption points, monthly chargeback calculation combining Azure costs with usage metrics, and cost dashboards driving optimization behaviors—you make AI spending transparent and manageable across Fabrikam's development organization. The final governance challenge is managing the agent lifecycle from deployment through retirement, ensuring outdated agents don't accumulate costs and technical debt.

## Unit summary

- **Multi-dimensional attribution** tracks model token costs, compute container runtime, and storage operations separately, each requiring different metering approaches.
- **Instrumented metering** emits custom Application Insights metrics at every cost-accruing interaction—model API calls, agent compute duration, and storage writes—tagged with tenant context.
- **Monthly chargeback calculation** combines Azure Cost Management totals with per-tenant usage ratios from custom metrics to generate proportional cost reports.
- **Cost dashboards** display per-team breakdowns with optimization recommendations—like model downgrades, off-peak scheduling, and semantic caching—that drive actionable spending reductions.
