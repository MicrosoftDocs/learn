Contoso Retail's Cloud Security Engineering team began this module with two unaddressed detection gaps: no vulnerability scanning for Azure Container Registry (ACR) images and no runtime visibility into Azure Kubernetes Service (AKS) clusters. A suspicious external base image went undetected for weeks, and the team had no way to know what was actually running in production.

You explored the architecture of Microsoft Defender for Containers and its four protection pillars: vulnerability assessment, runtime threat protection, security posture management, and gated deployment. Each pillar covers a distinct phase of the container lifecycle, and together they create a layered defense model.

You enabled the Defender for Containers plan in Microsoft Defender for Cloud and configured its components—the Defender sensor, Azure Policy add-on, Kubernetes API access, and registry access—to protect AKS clusters and ACR registries across a subscription. You verified deployment coverage using the Recommendations screen.

You assessed container image vulnerability findings from ACR scanning, working through the recommendation views that surface CVSS scores, affected packages, exploitability data, and remediation guidance. You learned how push-triggered and continuous rescanning work together, and how runtime vulnerability findings trace vulnerable images back to live workloads in AKS clusters.

You detected container runtime threats and misconfigurations using Kubernetes audit log analysis, Defender sensor runtime alerts, and binary drift detection. You configured drift policies to both alert on and block unauthorized processes in running containers. You reviewed security posture recommendations aligned to the CIS Kubernetes Benchmark, and explored how gated deployment through Azure Policy admission control stops noncompliant workloads from reaching the cluster. You configured alert forwarding to Microsoft Sentinel and Microsoft Defender XDR so your SOC team can investigate container alerts alongside identity and network signals in their investigation tools.

The layered model these capabilities form is: **prevent** misconfigurations through posture recommendations and gated deployment, **detect** vulnerabilities, and threats through image scanning and runtime alerts, and **block** unauthorized behavior with binary drift blocking.

## In this module, you learned to:

- Describe the architecture and protection pillars of Microsoft Defender for Containers
- Enable and configure the Defender for Containers plan in Microsoft Defender for Cloud
- Evaluate container image vulnerability findings from ACR scanning
- Interpret runtime threat alerts and security posture recommendations for AKS clusters

## Learn more

- [Microsoft Defender for Containers overview](/azure/defender-for-cloud/defender-for-containers-introduction)
- [Defender for Containers architecture for AKS](/azure/defender-for-cloud/defender-for-containers-architecture)
- [Binary drift detection and blocking](/azure/defender-for-cloud/binary-drift-detection)
- [Connect Microsoft Defender for Cloud to Microsoft Sentinel](/azure/sentinel/connect-defender-for-cloud)
