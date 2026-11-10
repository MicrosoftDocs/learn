Contoso Manufacturing closed critical security gaps across its server estate—encrypted disks protect data at rest, just-in-time access guards remote connections, and Defender for Servers detects runtime threats. One gap remains unaddressed: operating system configuration drift. Factory servers and Arc-enabled on-premises machines could have unnecessary services running, weak cryptographic settings, default accounts, or registry misconfigurations that enable lateral movement. Contoso needs to assess these settings and safely correct approved configuration issues.

Azure Machine Configuration provides policy-driven auditing of OS-level security settings and can apply approved changes through custom configurations. In this module, you explore how to prepare Contoso's machines, assess their built-in security baselines, and deploy tested custom configurations.

Here, you learn how to:

- Explore how Azure Machine Configuration audits settings and applies approved configurations using Azure Policy.
- Deploy Azure VM prerequisites and verify Azure Arc-enabled server readiness.
- Assign built-in Windows and Linux security baseline policies to audit operating system settings.
- Author, test, and publish custom configurations to audit or remediate selected organization-specific settings.

## Prerequisites

To get the most from this module, you should have:

- Familiarity with Azure Policy concepts, including initiatives, assignments, and compliance reporting.
- Understanding of Azure virtual machines and Azure Arc-enabled servers.

Before following the deployment procedures, confirm these readiness requirements:

- **Subscription and permissions**: Have access to nonproduction Azure VMs or Arc-enabled servers, permission to create and assign policies, and authority to grant required roles to deployment identities. Register `Microsoft.GuestConfiguration` in the relevant subscriptions. Portal assignment can register it automatically; scripted rollout must account for registration explicitly.
- **Supported machines**: Check the current Azure VM and Arc support matrices for operating systems and architectures. The Azure VM matrix excludes ARM64 and uniform VM scale sets; flexible scale sets are supported. New agents introduce PowerShell compatibility changes for older Linux distributions starting in November 2026, so check compatibility before selecting or upgrading Linux hosts.
- **Current agents**: Applying configurations requires at least Azure VM extension version 1.26.24 or Connected Machine agent version 1.10.0. These are historical feature minimums, not recommendations to install old agents.
- **Connectivity**: Allow documented outbound TCP 443 connections to the service and package storage. Azure NSG-based public connectivity uses the `AzureArcInfrastructure` and `Storage` service tags; Arc servers also require the Connected Machine agent's full endpoint set. Verify custom-package reachability and authorization separately.
- **Entitlement**: Review Machine Configuration pricing for hybrid targets. Defender for Servers Plan 2's OS assessment entitlement doesn't necessarily include every custom-policy or remediation capability.

> [!NOTE]
> Private connectivity differs by platform. The Azure VM `EnablePrivateNetworkGC=TRUE` mechanism isn't an instruction for Arc servers; use supported Azure Arc private-link configuration for Arc. Plan package-storage connectivity, name resolution, and authorization for the actual network path.

For the Windows custom-authoring example, use a disposable supported Windows test VM with a currently supported PowerShell 7 release that meets the authoring requirements. You'll install `GuestConfiguration`, the documented `PSDesiredStateConfiguration` 2.0.7 compiler, and the exercise's project-owned resource module on `PSModulePath`. Local package testing installs a test agent and requires elevation. Don't run remediation tests on production machines or your ordinary workstation. The policy-publication steps also require `Az.Resources` and its `Az.Accounts` dependency, an authenticated Azure PowerShell session, and permission to create definitions at the target management group.

The Contoso application and its service must already be installed, correctly configured, startable, and not disabled. `ContosoScheduler` is an example internal service name, not a Windows component. Substitute the actual service name in your lab; the configuration doesn't install application binaries or change service credentials.
