At 11:40:18 UTC, Azure reported that the `m02-command` extension update had failed on Contoso's Ubuntu VM. Two seconds later, a teammate ran the installed `vmops-report` script over SSH. It printed `report-ready os=ubuntu` and exited with code `0`. That shows the report worked when called directly. Rather than submitting the update again, the operator reads the command output and exit code the handler recorded for the failed run.

## Identify the operation in Azure

Start with the subscription, resource group, VM, extension instance name, and UTC time from the ticket. A resource group is a container for related Azure resources. In the portal, **Activity log** shows who requested the extension update and its management result, not what the command printed inside Ubuntu. **Properties** and **Extensions + applications** show the reported agent and extension details. Record the guest image and architecture, CLI version, agent version, extension publisher and type, and installed handler version. A requested Custom Script version such as 2.1 isn't proof of the exact version installed.

Azure role-based access control (RBAC) separates *role* (what you can do) from *scope* (where you can do it). Read access to the VM, relevant Activity Log, and health records may be enough to investigate. A VM change needs separate authorization. Contributor on a resource group doesn't grant permission to create other groups, assign roles, or sign in to the guest. Virtual Machine Contributor can be appropriate for an approved VM change without granting network administration. Guest log access, including `sudo` on Ubuntu, is separate.

The following read-only Azure CLI queries run in PowerShell on the operator's workstation. Use the names from the incident and confirm the active subscription matches the ticket before collecting evidence. Keep any saved JSON in a private incident location. `az vm show` reads the configuration; `az vm get-instance-view` returns the runtime status Azure last received.

```powershell
$rg = 'rg-vmops-m02'
$vm = 'vm-m02-linux'
$extension = 'm02-command'
az version
az account show --query '{subscription:name,id:id,tenant:tenantId}' -o json
az vm show -g $rg -n $vm --query '{id:id,region:location,size:hardwareProfile.vmSize,image:storageProfile.imageReference}' -o json
az vm extension list -g $rg --vm-name $vm -o table
az vm get-instance-view -g $rg -n $vm -o json
az vm extension show -g $rg --vm-name $vm -n $extension --instance-view --query instanceView -o json
```

For an initial extension operation rejected before guest execution, inspect the separate Azure-side control. Run this query on the operator's PowerShell workstation with the incident's existing `$rg` and `$vm` values and confirmed subscription.

```powershell
az vm show -g $rg -n $vm --query '{allowExtensionOperations:osProfile.allowExtensionOperations}' -o json
```

`allowExtensionOperations` specifies whether extension operations are allowed on the VM. Azure permits this value to be set to false only when the VM has no extensions. Use it when investigating a denied initial extension operation, not as an explanation for the failed update of Contoso's already installed handler. If the property isn't returned, record it as unreported and consult the owning deployment; don't interpret null as false.

Confirm the control's intended value with the owning deployment before proposing a change. A rejected Azure operation and a guest-side processing restriction are different failure stages.

The instance name `m02-command` identifies the installation on this VM. Its software is publisher `Microsoft.Azure.Extensions`, type `CustomScript`. Confirm who owns the instance before changing it: another deployment might use the same handler. For delivery failures, check approved outbound access for the agent and extension packages. A command that runs an installed script doesn't need an external script download.

## Compare the SSH run with the extension run

Contoso uses `vmops-report` as a *workload probe*: a small, read-only test with a known result. This excerpt from the installed script shows what it checks. It reads Ubuntu's OS identification file and prints the report only if the OS identifier matches. It doesn't change any files or services.

```sh
set -eu
. /etc/os-release
test "$ID" = ubuntu
printf 'report-ready os=%s\n' "$ID"
```

The expected result is `report-ready os=ubuntu` and exit code zero. Over SSH, the operator captures the exit code immediately after running the report. In Bash, `$?` is the exit code of the preceding command. A later command would replace it.

```bash
date -u +%Y-%m-%dT%H:%M:%SZ
systemctl is-active walinuxagent
/usr/local/bin/vmops-report
printf 'SSH report exit: %s\n' "$?"
sudo tail -n 60 /var/log/waagent.log
sudo tail -n 60 /var/log/azure/custom-script/handler.log
```

The SSH result answers only whether the report worked in that session. In the agent log, match the extension name and time to the failed update. In the handler log, find the corresponding sequence, command start, and exit code. If the incident falls outside the last 60 lines, read the relevant time window, including rotated logs where available. Read `stdout` and `stderr` for that sequence, not simply the newest directory. For example, these paths correspond to sequence 0:

```bash
sudo cat /var/lib/waagent/custom-script/download/0/stdout
sudo cat /var/lib/waagent/custom-script/download/0/stderr
```

These per-sequence files aren't a durable archive. Depending on the installed handler version, a later execution can remove older download directories, including their `stdout` and `stderr` files. Preserve the relevant failed-run output in the approved private evidence location before a retry. If an older file is absent, use the preserved copy and retained logs; record any remaining gap rather than concluding that the command never ran.

These illustrative records put the two runs on one UTC timeline:

```text
11:40:00Z Azure operation: extension update accepted
11:40:11Z waagent: m02-command handler enable requested, sequence 0
11:40:12Z handler: command started, sequence 0
stdout: report-ready os=ubuntu
stderr: report wrapper returned an error
11:40:12Z handler: command exited with code 23
11:40:18Z instance view: extension ProvisioningState/failed
11:40:20Z independent SSH: walinuxagent active; report-ready os=ubuntu; report exit 0
```

The report printed the expected line in both runs. At 11:40:12 UTC the handler recorded exit 23, six seconds before Azure reported failure. The `commandToExecute` field in the approved deployment configuration explains why: it ran the report, wrote a diagnostic message to stderr using `>&2`, then ended with an unconditional `exit 23`. The teammate's SSH session ran the report directly, without those extra instructions. Code 23 is a result from this submitted command, not a general Azure error code. Execution-context differences are a branch for other evidence, not a reason to change this diagnosis.

Don't confuse the guest result with the workstation result. In PowerShell, `$LASTEXITCODE` immediately after `az vm extension set` describes the CLI request. A nonzero CLI result can tell you the update failed, but only the matching handler record tells you how the guest command exited.

:::image type="content" source="../media/extension-failure-evidence-timeline.svg" alt-text="Diagram that shows sequence 0 reaching command exit 23 before Azure reports failure, followed by a successful SSH probe.":::

## Correct the submitted command

The evidence narrows the change to one field. Contoso's corrected settings call the report directly so the handler receives the report's own exit code. This JSON excerpt explains the change; it isn't a replacement for an extension's complete settings.

```json
{ "commandToExecute": "/usr/local/bin/vmops-report" }
```

For an actual incident, use the deployment that owns the extension and follow its change procedure:

1. Preserve the failed sequence, exit code, relevant output, and guest and agent state. In the private change record, identify the previous configuration, who approves the change, and how to reverse it. Don't copy protected settings into the ticket.
1. Confirm the earlier operation has finished. Apply only the approved command change to the existing instance, keeping its publisher, type, version policy, and unrelated settings intact. Neither the agent nor the report needs reinstalling.
1. Capture the new sequence and completion time. Compare the handler exit code and stdout with the updated instance view. Repeat the probe through the independent guest login. If filesystem, network, or permission errors appear instead, stop and investigate the new evidence before changing anything else.

A changed Custom Script configuration triggers execution. If an approved retry must run *unchanged* settings, `az vm extension set --force-update` requests another execution; confirm that the handler records a new sequence. Never force an update while the prior run might still be active. Commands should be *idempotent* (running them twice leaves the same intended state) and must finish without prompting. The Linux Custom Script handler allows 90 minutes, but a normally one-second report that stalls warrants investigation well before that limit.

Don't use Custom Script commands on Windows or Linux to reboot the VM or stop or update its platform agent. This includes actions performed by an installer the command starts. Idempotence doesn't make those actions safe inside an extension. A reboot interrupts execution, and the extension doesn't resume the script after startup. Stopping or updating the platform agent from the command can leave the operation **Transitioning** and lead to a timeout.

If a change requires a reboot or platform-agent maintenance, put that work in a separately approved maintenance step outside the Custom Script command. Preserve the failed run's evidence and assess partial changes before proceeding. After maintenance, establish guest and agent readiness, check for work still running from the interrupted attempt, and prevent overlapping execution before separately approving a new extension run. Don't assume that rebooting automatically reruns or completes the original script.
