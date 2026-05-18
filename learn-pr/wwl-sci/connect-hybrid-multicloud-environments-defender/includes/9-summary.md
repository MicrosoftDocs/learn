Contoso's security team now has what the Security Officer (CISO) asked for: a single Defender for Cloud view covering Azure, on-premises, AWS, and GCP environments. Arc-enabled on-premises servers appear beside Azure VMs in the Inventory. AWS EC2 instances and GCP Compute Engine VMs contribute to the secure score. The AWS Foundational Security Best Practices and GCP Default compliance standards run automatically. Defender for Servers plans protect cloud VMs through Arc autoprovisioning, and Defender CSPM identifies misconfigurations across all three clouds continuously—without agents.

## Key technical decisions in this module

The connections you built in this module involved several architectural choices that affect security posture, operational overhead, and compliance audit readiness.

**Federated authentication eliminates stored credential risk.** Both the AWS CloudFormation template and GCP GCloud script establish federated trust relationships—OIDC federation for AWS and workload identity federation for GCP. Defender for Cloud never stores long-lived credentials in Azure. Even if a connector resource were compromised, there are no access keys or private keys to exfiltrate.

**CSPM activates immediately; CWPP requires Arc.** The Security Posture Management plan is always active on every connector and runs agentlessly through cloud provider APIs. Asset inventory, recommendations, compliance standards, and Defender CSPM capabilities are available within hours of connector creation—before any agent deployment. CWPP plans (Defender for Servers threat detection, JIT VM access, file integrity monitoring) require Azure Arc on each VM. For AWS and GCP, Arc autoprovisioning handles scale; for on-premises servers, deliberate deployment planning is required.

**Connector scope defines coverage boundaries.** Organization-level connectors (AWS management account, GCP organization) provide enterprise-wide coverage with automated child account or project discovery. Account-level and project-level connectors provide granular control. Unselected AWS regions and unconnected GCP projects remain unguarded sides—coverage is exactly as wide as your connectors define.

**Least privilege access reduces blast radius.** Selecting least privilege access during connector creation ensures Defender for Cloud has only the permissions required for the plans active today. If you add plans later, you must regenerate and redeploy the onboarding script with updated plan selections to add the new permissions.

**The MMA path is retired.** On-premises servers must use Azure Arc for full Defender for Servers Plan 2 coverage. The Microsoft Monitoring Agent retired in August 2024.

## Learn more

To continue building your knowledge on multicloud security in Defender for Cloud, review these resources:

- [Connect your AWS account to Microsoft Defender for Cloud](/azure/defender-for-cloud/quickstart-onboard-aws)
- [Connect your GCP project to Microsoft Defender for Cloud](/azure/defender-for-cloud/quickstart-onboard-gcp)
- [Connect non-Azure machines to Microsoft Defender for Cloud](/azure/defender-for-cloud/quickstart-onboard-machines)
- [Authentication architecture for AWS connectors](/azure/defender-for-cloud/concept-authentication-architecture-aws)
- [Authentication architecture for GCP connectors](/azure/defender-for-cloud/authentication-architecture-google-cloud)
- [Plan multicloud security in Defender for Cloud](/azure/defender-for-cloud/plan-multicloud-security-get-started)
- [Azure Arc-enabled servers overview](/azure/azure-arc/servers/overview)
