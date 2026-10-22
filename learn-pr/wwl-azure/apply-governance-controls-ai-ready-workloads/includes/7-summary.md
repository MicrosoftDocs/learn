This module examines governance controls for Contoso Financial Services' AI deployment. You distinguish infrastructure inventory from data cataloging, classification, and lineage, and identify the controls and evidence needed to govern each part of the workload.

Microsoft Purview scans supported storage sources to identify sensitive training data. The Azure Machine Learning preview integration catalogs registered workspaces, datasets, jobs, and models through a daily metadata push. Classification and sensitivity labeling depend on source capabilities. Labels don't automatically propagate from training data to models and inference endpoints through this integration.

Building on asset discovery, you implemented Azure Policy guardrails that enforce governance requirements proactively. Your policy definitions prevent AI resource deployments outside approved regions, require customer-managed encryption for sensitive datasets, and automatically configure network isolation for production endpoints. The staged rollout approach—using Audit effect during testing then switching to Deny for production—balanced security requirements with developer productivity. These automated controls eliminated manual approval bottlenecks that previously delayed deployments by days while introducing human error.

Purview lineage helps you identify known relationships between data sources, training datasets, jobs, and models. You validate connector coverage and combine this metadata with ML records, deployment history, and application logs for an audit. Endpoint dependencies and record-level prediction evidence require additional tracking. You also explore enabling threat protection for AI services in the exercise.

## Key takeaways

- Infrastructure inventory, supported data-source scans, and ML metadata registration provide different parts of AI workload visibility
- Azure Policy enforces governance guardrails at deployment time with configurable effects (Audit, Deny, DeployIfNotExists) that balance compliance requirements with developer productivity
- Supported lineage integrations help identify training dependencies, but require coverage checks and additional deployment and application evidence
- Classification findings inform security reviews; access permissions, network controls, and approval workflows require explicit configuration

