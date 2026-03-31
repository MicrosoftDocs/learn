Your company runs machine learning workloads on Azure that analyze customer data around the clock. Last week, a virtual machine crashed during a training job, but your team discovered the failure only after users reported missing results. By then, two hours of compute time were wasted, and the training pipeline needed manual restart. This scenario highlights a critical gap: without proactive monitoring, infrastructure failures disrupt business operations before anyone notices.

Azure Monitor closes this gap by collecting metrics, logs, and alerts from your infrastructure in real time. With Azure Monitor, you detect performance degradation before it causes downtime, receive notifications when resources exceed capacity thresholds, and query log data to diagnose the root cause of failures. For AI workloads that demand high availability, this visibility translates to measurable outcomes: reduced mean time to resolution (MTTR), improved service level agreement (SLA) compliance, and fewer manual interventions during production incidents.

In this module, you configure monitoring for Azure infrastructure supporting AI workloads. You set up metric collection to track CPU, memory, and disk performance. You create alert rules that notify your operations team when thresholds are breached. You implement alert processing rules to suppress notifications during planned maintenance windows. Finally, you query log data in Log Analytics Workspace to investigate infrastructure events and validate your monitoring configuration.

## Learning objectives

By the end of this module, you're able to:

- Explain how Azure Monitor and Log Analytics Workspace support infrastructure management
- Configure metrics collection and visualization for Azure resources
- Implement alert rules and processing rules to respond to infrastructure events
- Query log data to diagnose infrastructure issues

## Prerequisites

- Familiarity with basic Azure concepts and resource types such as virtual machines, storage accounts, and networking components
- Access to an Azure subscription with Contributor permissions to create and configure resources
- Understanding of fundamental networking and compute concepts including IP addressing, load balancing, and CPU utilization

## More resources

- [Azure Monitor overview](/azure/azure-monitor/overview) - Official documentation covering Azure Monitor architecture and capabilities
- [Log Analytics Workspace documentation](/azure/azure-monitor/logs/log-analytics-workspace-overview) - Detailed guide to Log Analytics Workspace setup and query capabilities
