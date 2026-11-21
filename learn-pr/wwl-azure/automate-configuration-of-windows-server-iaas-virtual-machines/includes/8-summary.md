Contoso needed to automate Windows Server IaaS VM configuration, detect drift, and choose an appropriate way to restore the required state.

Azure Automation runbooks execute administrative procedures in an Azure sandbox or on a supported extension-based Hybrid Runbook Worker. Their execution location, runtime, dependencies, permissions, and connectivity determine which resources they can manage.

Azure Machine Configuration uses compatible packages and guest assignments to assess or apply settings inside a VM. The VM's managed identity authenticates the guest and can read an authorized private package. The policy-assignment identity performs the Azure deployments required to deliver that configuration.

You learned to distinguish audit-only behavior, apply-and-monitor, and automatic correction. Initial remediation of an existing VM is separate from ongoing guest correction. Compliance reporting and direct checks of the declared settings provide better evidence than an Azure deployment status alone.

Custom Script Extension performs one-time configuration, such as installing IIS. Its scripts must be noninteractive, idempotent, and safe to run as LocalSystem. Private-blob identity access and protected settings help avoid exposing credentials. Successful installation doesn't establish continuous enforcement or prove every aspect of website health.

You can now explain the Machine Configuration prerequisites and deployment sequence, interpret configuration compliance, and distinguish monitored drift from automatic correction. The Machine Configuration walkthrough is conceptual, not a completed hands-on exercise. Executing its package-dependent steps requires a separately obtained, maintained package tested on the target VM. The one-time IIS installation script doesn't supply that desired-state package.

## More info

Use these references for the current service models, prerequisites, and operational constraints:

- [Azure Automation Runtime environments](/azure/automation/runtime-environment-overview).
- [Azure Automation runbook execution](/azure/automation/automation-runbook-execution).
- [Machine Configuration prerequisites](/azure/governance/machine-configuration/overview/02-setup-prerequisites).
- [Create custom Machine Configuration policy definitions](/azure/governance/machine-configuration/how-to/create-policy-definition).
- [Machine Configuration remediation options](/azure/governance/machine-configuration/concepts/remediation-options).
- [Windows Custom Script Extension](/azure/virtual-machines/extensions/custom-script-windows).
- [Action Run Command for Windows VMs](/azure/virtual-machines/windows/run-command).
