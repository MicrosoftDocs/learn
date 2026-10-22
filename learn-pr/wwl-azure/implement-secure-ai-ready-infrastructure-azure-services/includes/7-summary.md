
This module examines security controls for AI infrastructure, including Microsoft Foundry hub-based projects, Azure OpenAI Service, and container image protection. You distinguish supported hub settings from the controls that require configuration on connected resources and calling applications.

Hub-based projects share infrastructure and supported security settings rather than receiving a dedicated copy of every Azure resource. Validate project permissions, shared connections, and access to dependent services. For Azure OpenAI, configure the calling identity, required service roles, private connectivity, public access restrictions, and diagnostic settings explicitly.

Data residency requires a separate deployment decision. Resource location, inference-processing location, stored-data location, and logging destinations aren't interchangeable. Review Global, Data Zone, and geography-based deployment commitments against the workload's approved boundary. A private endpoint or same-region log destination doesn't change the model deployment's processing boundary.

The exercises distinguish a Foundry account and project from a hub-based managed-network setup. Apply each architecture's own security guidance instead of treating all Foundry projects as hub-based.

## Key security decisions

- **Choose managed identities over API keys** for Azure OpenAI Service authentication where supported, avoiding application-managed API keys
- **Configure private connectivity and public access restrictions** on the services that require private-only access, with routing and DNS validated for permitted callers
- **Enable Microsoft Defender scanning** on Azure Container Registry, gaining automated vulnerability detection across all base images and dependencies
- **Use supported hub settings** as a shared baseline for hub-based projects, while configuring connected-resource controls separately
- **Select a model deployment type** that matches the approved processing boundary and review storage and logging locations independently

## Next steps

Expand your secure AI infrastructure by implementing these advanced capabilities:

- Configure Azure Monitor workspaces to track AI service usage patterns, set alerts for anomalous activity, and create dashboards for capacity planning
- Document your compliance controls in a security runbook for audit reviews, including network architecture diagrams, identity flows, and policy enforcement points
- Explore multi-region deployments using Azure Container Registry geo-replication to support disaster recovery and reduce latency for global AI workloads
- Implement Azure Key Vault integration for managing model encryption keys and securing sensitive configuration values

## More resources

- [Monitor Azure AI workloads](/azure/ai-services/openai/how-to/monitoring) - Implementation guide for Azure Monitor integration with AI services
- [Responsible AI practices](/azure/ai-services/responsible-use-of-ai-overview) - Framework for implementing ethical and compliant AI systems