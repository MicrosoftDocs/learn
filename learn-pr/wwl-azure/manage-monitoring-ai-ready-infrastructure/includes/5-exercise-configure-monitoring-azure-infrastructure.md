This unit contains exercises that demonstrate how to configure monitoring for Azure AI Services infrastructure using Microsoft Foundry. The exercises cover the creation of compute instances, enabling diagnostics, and setting up monitoring for AI workloads.

**Exercise 1: Create a compute instance in a Microsoft AI Foundry hub**
This exercise introduces how compute instances provide secure, user‑dedicated environments for interactive development and experimentation in hub‑based Microsoft AI Foundry projects.  
- Compute instances are single‑user virtual machines that support prompt flow, index creation, and Visual Studio Code integration for model development and data preparation.  
- Instances use the latest available VM images at creation time and can be refreshed by recreation to apply updated operating system and dependency versions.  
- Managed identities, idle shutdown schedules, and restricted SSH/root access help balance productivity, cost control, and security.

**Exercise 2: Enable diagnostics for Azure AI Services** 
This exercise focuses on configuring diagnostic settings to collect and route logs and metrics from Foundry resources for centralized monitoring and governance.  
- Diagnostic categories vary by resource type, with AI hubs, hub‑based projects, and Foundry projects exposing progressively richer telemetry such as audit logs, compute events, request/response logs, and metrics.  
- Collected diagnostics can be routed consistently to Log Analytics, Storage accounts, or Event Hubs to enable unified analysis across the Foundry ecosystem.  
- Comprehensive logging supports auditing, troubleshooting, performance optimization, and compliance for complex, multi‑stage AI workflows.

**Exercise 3: Monitor Azure AI Services with Azure Monitor**  
This exercise builds on diagnostics by using Azure Monitor to analyze metrics and establish proactive alerting for AI workloads.  
- Azure Monitor captures platform metrics such as availability, latency, request count, and usage to track performance and reliability of AI services over time.  
- Combining metrics with diagnostic logs enables correlation between infrastructure behavior and AI model execution patterns.  
- Metric‑based alerts and alert processing rules help surface

Learners can find the full list of labs and launch each exercise directly by visiting the [Manage AI-Ready Infrastructure](https://go.microsoft.com/fwlink/?linkid=2345202) GitHub repository, which serves as the single entry point for the course’s hands‑on activities.
## Exercise 1: Create a compute instance in a Microsoft AI Foundry hub


Compute resources in Microsoft AI Foundry provide the processing power required to execute workloads such as model training, data preparation, and experimentation. Within this environment, compute instances serve as dedicated, user-assigned virtual machines designed for interactive development and job execution. Each compute instance is assigned to a single user and can't be shared. It can be reused across multiple workflows within that user's workspace. Compute instances are currently supported only in hub-based projects—standalone Microsoft AI Foundry projects don't include this feature. You need a compute instance to:
- use prompt flow in the Microsoft AI Foundry portal.
- create an index.
- open Visual Studio Code (Web or Desktop) in the Microsoft AI Foundry portal.

SSH access to a compute instance can be optionally enabled, allowing direct sign-in to the virtual machine for advanced tasks such as installing custom dependencies, debugging environment issues, or performing configurations not supported through the Microsoft AI Foundry portal. SSH access can include root-level privileges, enabling full control over the instance when deeper system-level access is required.

When a compute instance is provisioned, it uses the most recent virtual machine image available at that time. Microsoft updates these images monthly to include the latest operating system, Python, and dependency versions. However, deployed compute instances aren't automatically updated. To maintain security and ensure access to the latest patches and software features, administrators can either recreate the instance to refresh its base image (recommended) or manually apply operating system and package updates.

## Scenario
Your company is developing an enterprise AI platform using Microsoft Foundry to support interactive model development, data preparation, and experimentation within hub-based projects. As part of the platform's setup, your company provisions compute instances to provide dedicated, user-assigned environments for interactive development and job execution. These instances are created to enable use of prompt flow, index creation, and integration with Visual Studio Code for coding and experimentation. To optimize resource utilization and reduce costs, the compute instances are configured with scheduled idle shutdown, ensuring that inactive instances don't continue consuming compute resources.

Each compute instance has a system-assigned managed identity enabled, allowing automated workloads such as training jobs, data processing, and artifact storage to securely access Azure resources without relying on user credentials. SSH and root access will be disabled to maintain security and prevent direct system-level modifications, reducing the risk of configuration drift or unintended exposure while still supporting all required development and operational workflows via the portal interface and integrated tools.

:::image type="content" source="../media/system-assigned-managed-identity-enabled.png" alt-text="Diagram shows a company developing an enterprise AI platform using Microsoft Foundry to support interactive model development.":::

## Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription.
- **Familiarity with Microsoft Foundry resource types**: To learn more, refer to [Choose an Azure resource type for AI foundry](https://azure/ai-foundry/concepts/resource-types).

## Estimated time
10 minutes

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2344498)
## Exercise 2: Enable diagnostics for Azure AI Services


Diagnostic settings in Microsoft Foundry enable administrators to collect and route operational data—such as logs and metrics—from Foundry resources to destinations like Log Analytics workspaces, Azure Storage accounts, or Event Hubs. These settings support centralized monitoring, troubleshooting, and auditing across the Foundry environment, allowing consistent data collection and analysis. When configuring diagnostic settings, administrators can select specific log and metric categories or predefined category groups (such as audit and allLogs) that automatically include relevant log types for each resource.

The specific diagnostic categories available differ between AI hubs, hub-based projects, and Microsoft Foundry projects. AI hubs provide options to collect ComputeInstanceEvents and AllMetrics, which capture activity and performance data for compute instances. Hub-based projects include a broader set of categories under audit and allLogs, encompassing operational and security-related events across project components. Microsoft Foundry projects expose the most extensive telemetry options, including Audit Logs, Request and Response Logs, Azure OpenAI Request Usage, Trace Logs, and AllMetrics, reflecting their focus on AI model execution and API interactions.

All three resource types share the same diagnostic destination options, enabling consistent monitoring across the Foundry ecosystem. Administrators can send collected data to a Log Analytics workspace for analysis and querying, archive it to a Storage account for long-term retention, or stream it to an Event Hubs for integration with external monitoring and automation systems. This unified destination model ensures that diagnostics from hubs, projects, and project resources can be correlated and analyzed together to provide a comprehensive view of AI operations and performance.

### Scenario
Your company is planning to establish an enterprise AI platform using Microsoft Foundry to enable consistent monitoring, governance, and diagnostics across a wide range of AI development and operational workloads. These workloads include prompt flow orchestration, large-scale model fine-tuning, vector index creation for retrieval-augmented generation, and data transformation pipelines supporting both experimentation and production scenarios. To ensure full visibility into these activities, diagnostic settings are configured for AI hubs, hub-based projects, and Microsoft Foundry projects. The configuration collects all available log and metric categories (including Audit Logs, ComputeInstanceEvents, Request and Response Logs, Azure OpenAI Request Usage, Trace Logs, and AllMetrics) in order to provide deep insight into user actions, model execution performance, and system health. This comprehensive logging strategy supports auditing, troubleshooting, and optimization of complex, multi-stage AI workflows that span compute, data, and orchestration components.

Collected telemetry is routed to both a Log Analytics workspace and a Storage account. The Log Analytics workspace enables interactive querying, dashboarding, and integration with Microsoft Sentinel for proactive threat detection and correlation across AI resources. The Storage account provides long-term, cost-efficient archival for compliance and forensic analysis, preserving the complete operational history of AI workloads. This approach ensures that diagnostic data from Microsoft Foundry remains comprehensive, actionable, and aligned with the organization’s requirements for reliability, transparency, and security throughout the AI development lifecycle.

:::image type="content" source="../media/collect-telemetry-routed-log-analytics-workspace.png" alt-text="Diagram shows a Log Analytics workspace enabling interactive querying.":::

### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription.
- **Familiarity with Microsoft Foundry resource types**: To learn more, refer to [Choose an Azure resource type for AI foundry](https://azure/ai-foundry/concepts/resource-types?view=foundry-classic).

### Estimated time
25 minutes

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2345106)
## Exercise 3: Monitoring Azure AI Services



Azure Monitor provides a unified framework for collecting, analyzing, and acting on telemetry from Azure resources, including Microsoft Foundry. It captures platform metrics and resource logs to help you understand the performance, availability, and operational behavior of your AI workloads. Platform metrics are automatically collected and stored in the Azure Monitor time-series database. These metrics are lightweight, support near real-time alerting, and are used to track resource performance trends over time.

Azure Monitor also supports alerts, which proactively notify you when specified conditions are met in your monitoring data. Alerts can be used to identify and address issues before they affect end users or dependent services. For AI workloads, monitoring plays a crucial role in maintaining operational reliability, ensuring compliance, and detecting anomalies in model execution or data flow.

As Microsoft Foundry becomes central to developing and deploying generative AI applications, monitoring across its components (including AI hubs, hub-based projects, and Microsoft Foundry projects) provides visibility into both infrastructure-level events and AI-specific telemetry, such as request patterns, latency, usage, and compute instance activity. By combining metrics and diagnostic logs, teams can correlate system performance with AI model behavior and optimize both development and production environments.

### Scenario
Your company is planning to deploy an enterprise AI platform using Microsoft Foundry to monitor and manage the performance, reliability, and security of project-level resources that host key AI workloads. Microsoft Foundry projects support advanced use cases such as large language model fine-tuning, prompt flow orchestration, data preprocessing pipelines, and retrieval-augmented generation (RAG) scenarios. To ensure consistent observability across these workloads, your company focuses on collecting and analyzing project-level metrics that reflect the performance and availability of deployed AI services. These metrics, such as Availability Rate, Request Count, Latency, and Usage statistics across Azure OpenAI and Cognitive Services namespaces, will provide actionable insights into model responsiveness, throughput, and reliability. Monitoring these metrics over time will help identify trends, detect anomalies, and validate the impact of configuration or deployment changes on overall service health.

To track service reliability and increase operational awareness, your company establishes a metric-based alerting framework within Azure Monitor. Alert rules track key availability signals, such as AvailabilityRate, to ensure that any drop below 100% triggers immediate investigation into potential service interruptions, endpoint errors, or infrastructure issues. Complementing this, alert processing rules will automatically suppress notifications outside standard business hours (7:00 PM to 7:00 AM), minimizing alert fatigue while ensuring that critical incidents are promptly surfaced during operational periods.

:::image type="content" source="../media/track-service-reliability-increase-awareness.png" alt-text="Diagram shows how to track service reliability and increase operational awareness.":::

### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription.
- **Familiarity with Microsoft Foundry resource types**: To learn more, refer to [Choose an Azure resource type for AI foundry](https://azure/ai-foundry/concepts/resource-types).

### Estimated time
25 minutes

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2345107)