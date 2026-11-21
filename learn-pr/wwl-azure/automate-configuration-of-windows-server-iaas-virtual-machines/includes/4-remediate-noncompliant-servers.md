Azure Machine Configuration reports whether a VM matches its assigned configuration and can correct configuration drift. If you execute the workflow described in the preceding unit, first obtain and prepare a maintained, tested package. A successful Azure deployment alone doesn't prove that the declared settings are compliant inside the VM.

## Choose a guest assignment type

The guest assignment type controls what happens inside the machine:

| Assignment type | Behavior |
| --- | --- |
| `Audit` | Reports configuration state without changing the machine. |
| `ApplyAndMonitor` | Applies the configuration, then reports subsequent drift without automatically correcting it. Trigger remediation when you want to restore the declared state. |
| `ApplyAndAutoCorrect` | Applies the configuration and corrects subsequent drift during guest evaluation. |

These case-sensitive values aren't Windows DSC Local Configuration Manager modes or Azure Policy enforcement modes. A package must support setting configuration, such as an `AuditAndSet` package, to perform remediation. Changing an assignment type doesn't make an audit-only implementation capable of applying settings.

Azure Policy's `deployIfNotExists` effect delivers the guest assignment. An initial policy remediation task can deliver and apply the configuration to an existing noncompliant VM. After that initial deployment, `ApplyAndAutoCorrect` corrects guest drift without a new policy remediation task for each occurrence.

## Remediate and verify a noncompliant VM

Use the following process for the isolated Windows Server lab VM:

1. Inspect the guest assignment and its detailed compliance reasons. Confirm the intended package version and content hash, the effective assignment type, and the settings the package actually manages.
1. Resolve prerequisite failures before retrying remediation. Distinguish service or assignment-retrieval failures from custom-package download failures. Check the Machine Configuration extension, VM identity, and the service endpoints for the VM's cloud and region. Separately check HTTPS access to the package host and the VM identity's blob-read permission. Both paths need working DNS and routing. A successful blob download doesn't prove that the service endpoints are reachable.
1. For an existing VM that needs the configuration applied initially, create a remediation task for the relevant Azure Policy assignment. You can select **Create a remediation task** when assigning the policy, or create one after evaluation. The task only targets noncompliant resources. If an initial audit assignment already reports compliance, follow the walkthrough's conditional baseline procedure and confirm the delivered type instead of assuming the task applied settings. The policy-assignment identity needs the deployment permissions declared by the definition; it isn't the VM identity that reads the package.
1. For subsequent drift under `ApplyAndMonitor`, trigger another remediation for that assignment, for example through an Azure Policy remediation task after noncompliance is reported. Under `ApplyAndAutoCorrect`, allow the next guest evaluation to correct the drift and investigate any reported errors. An `Audit` assignment won't apply settings.
1. Confirm both the actual setting values inside the VM and the guest compliance result. If remediation fails, use the detailed reasons to resolve the failure rather than repeatedly submitting the same deployment.

When changing remediation modes, update the existing lab definition and deliver the corresponding change to its guest assignment. If the existing assignment is compliant, changing the definition might not trigger another deployment. Follow the controlled transition in the walkthrough and confirm the effective guest-assignment type before testing drift. Don't leave conflicting assignments active.

Test only an outcome that the package declares. Stopping W3SVC demonstrates service-state drift only if the package manages that service's running state. It doesn't demonstrate drift in a package that checks only whether the Web-Server role is installed. With automatic correction, the reported result might already be compliant after correction, so don't require a transient noncompliant portal result as proof of the test.

## Optional diagnostics with Action Run Command

Action Run Command uses the Azure VM agent to run PowerShell inside a Windows VM. It's useful for diagnostics or an approved one-time correction, but it isn't the Machine Configuration enforcement mechanism.

The VM must be running with a ready Azure VM agent. Action Run Command can work when inbound Remote Desktop Protocol (RDP) access is blocked, but it can't execute through an agent that isn't ready. Check the agent status in the VM's properties before using it.

Outbound connectivity on port 443 to the documented Azure public endpoints is required to return results. If those endpoints are blocked, a script might run without returning its results. Where appropriate for your network policy, use the `AzureCloud` service tag to allow that traffic.

### Restrictions

The following limits apply to Action Run Command:

- Returned output is limited to the last 4,096 bytes.
- The minimum time to run a script is about 20 seconds.
- Scripts run as LocalSystem on Windows.
- Only one script can run at a time.
- Interactive prompts aren't supported.
- You can't cancel a running script.
- A script times out after 90 minutes.
- Don't stop or update the VM agent from inside the script; doing so can leave the operation in a transitioning state until it times out.

Managed Run Command is a separate resource-based option with capabilities such as configurable timeouts, an execution user, multiple scripts, and external output storage. Don't infer its limits or authorization from this Action Run Command procedure.

### Limit access to Action Run Command

Catalog access and execution use different permissions and scopes:

| Operation | Required permission | Scope |
| --- | --- | --- |
| List available command definitions or display their details | `Microsoft.Compute/locations/runCommands/read` | Subscription scope |
| Execute a command on a VM | `Microsoft.Compute/virtualMachines/runCommand/action` | The VM or an inherited scope |

Reader includes the catalog-read permission. Virtual Machine Contributor includes the execute permission. Effective access depends on role assignments and their scopes, not a hierarchy of higher roles. A VM-scoped role assignment doesn't provide subscription-scoped catalog access. Use an appropriately scoped built-in role or a custom role with the permissions needed for the task.

> [!CAUTION]
> Action Run Command executes as LocalSystem on Windows. Treat execution permission as privileged guest access, even when inbound remote-management ports are closed.

### Inspect the IIS role

For a read-only check, open the VM in the Azure portal, select **Run command**, and choose **RunPowerShellScript**. Review the following script before running it:

```powershell
Import-Module ServerManager -ErrorAction Stop
Get-WindowsFeature -Name 'Web-Server'
Get-Service -Name 'W3SVC' -ErrorAction Stop
```

The role and service results describe current state; they don't establish continuous enforcement or full website health. For network diagnostics, the built-in **IPConfig** command reports the VM's adapter configuration.

## Additional reading

Use these references for remediation behavior and the Run Command variants:

- [Machine Configuration remediation options](/azure/governance/machine-configuration/concepts/remediation-options).
- [Run scripts in a Windows VM with Action Run Command](/azure/virtual-machines/windows/run-command).
- [Compare Run Command options](/azure/virtual-machines/run-command-overview).
