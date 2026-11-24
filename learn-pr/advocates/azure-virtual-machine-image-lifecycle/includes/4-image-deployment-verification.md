A classroom VM can run the right application even if it came from the wrong image. Before deployment, match the request to the version and region the owner approved. After deployment, check which image Azure used and whether the lesson command works when a learner runs it.

Use the gallery version's full Azure resource ID, ending in `/galleries/{gallery}/images/{definition}/versions/1.0.1`. A definition-level reference or `latest` lets Azure select a version; it doesn't select the version the owner approved. The gallery setting `excludeFromLatest=true` removes a version from automatic latest selection. Someone with sufficient permissions can still request it by its full ID.

An **admission check** is the decision the deployment workflow makes *before* asking Azure to create a VM. For normal classroom deployments, use the protected release-control record described in [Select a revision and roll back safely](xref:learn.devrel.azure-virtual-machine-image-lifecycle.image-maintenance-rollback#select-a-revision-and-roll-back-safely) together with the requested version's manifest. Approval makes a version eligible; the current `activeVersionId` selects which eligible version this workflow should deploy.

1. Read the current authoritative release-control decision and the requested version's manifest from the protected release store. Refuse a missing or unreadable record, a paused workflow, or a request that the current decision doesn't permit. Also refuse a version whose status isn't `Approved`, or whose approval lacks an authorized approver and timestamp. Don't substitute cached approval evidence for an unavailable current decision.
1. Require the requested full version ID to match the current `activeVersionId` and the version ID in its approval. A retained `previousKnownGoodVersionId` isn't an automatic fallback. Match the requested region to the approval, and check the OS state, architecture, boot generation, and VM security type against the image definition. An incompatible request stops here; it isn't a reason to weaken policy.
1. Read fresh replication status for that exact version and apply the existing readiness gate for the approved release, including its required regions and overall completion. Bind the request to the intended subscription, resource group, and network interface. Only then pass that exact active, approved version ID to the VM creation service.

Candidate canaries use the separately authorized test path and test resource group; they don't have to be the active classroom release. Recovery from a predecessor or an independent gallery requires the owner's current, explicit authorization through the rollback procedure or a separately approved and tested recovery path. Neither case is permission for the normal classroom workflow to ignore a pause, withdrawal, or active-version mismatch.

A local script that performs those checks isn't an Azure-wide control. Restrict direct image-read and VM-create permissions to the deployment identities that need them, protect who can change the workflow and its approval records, and audit requests. Apply organizational policy where appropriate. A withdrawal written only in a spreadsheet doesn't reach a workflow that never reads it.

## Verify the VM from outside and inside

After a VM is created, distinguish the Azure **resource model** (what Azure says it deployed) from **guest behavior** (what actually runs inside the OS). These observations answer different questions:

| Evidence | What to inspect | What it proves |
|---|---|---|
| VM resource model | Read `storageProfile.imageReference.id` on the VM and compare it with the manifest's exact version ID. | Azure created this VM from the approved image version. Two different gallery versions can contain the same application marker. |
| Guest execution | Use managed Run Command, which executes a script through the guest agent. Inspect its **instance view**, the execution result: `executionState` must be `Succeeded`, `exitCode` must be present and zero, and output must include the validator's pass marker. | The script ran and its checks passed. Acceptance of the Run Command resource alone doesn't establish either fact. |
| Independent learner access | Connect through the approved private SSH path as the provisioned learner, without sudo. Verify readable configuration, an executable command, no write access to the protected files or their parent directories, and the expected application response. | The intended account has the required initial access independently of Run Command. |

For example, this read-only PowerShell query isolates the first observation. `$vmId` is the verified full ID of the consumer VM; `$approvedVersionId` comes from its release record.

```powershell
$imageUsed = az vm show --ids $vmId --query 'storageProfile.imageReference.id' --output tsv
if ($LASTEXITCODE -ne 0 -or !$imageUsed -or $imageUsed -ine $approvedVersionId) {
    throw 'Cannot confirm that this VM used the approved gallery version.'
}
```

Suppose the manifest approved gallery version `1.0.1`, but the VM's image ID ends in `/versions/1.0.2`. Even if the guest checks pass and the intended user sees `VmOpsRelease:4.7.2` over SSH, the VM still came from the wrong image. Stop new deployments and investigate how the workflow selected it.

:::image type="content" source="../media/4-consumer-evidence-mismatch.svg" alt-text="Diagram that shows a VM with the wrong gallery version even though its Run Command and private SSH checks both pass.":::

For the guest check, send multiline Linux shell text as a string with `Set-AzVMRunCommand -SourceScript`; avoid passing it through Windows `az.cmd --script`, where quoting can change it. Convert Windows line endings to Linux line feeds without changing the rest of the script. Use `Az.Accounts` and an `Az.Compute` version that supports `-SourceScript`, `-SubscriptionId`, and `-TimeoutInSecond`. Specify the subscription explicitly rather than relying on `-DefaultProfile`. Derive the resource group and VM name from the verified VM ID; retrieve the instance view for that same VM and command run. Record the tool versions, submission errors, guest output, and VM ID with the release.

For the independent check, confirm that the SSH login is the intended classroom account. Run the following in that account's session without sudo, not as root or as the default Run Command user:

```sh
set -eu
test "$(id -u)" -ne 0
for directory in / /opt /opt/vmops-release /usr /usr/local /usr/local/bin; do
    test -x "$directory"
    test ! -w "$directory"
done
for file in /opt/vmops-release/version /opt/vmops-release/config /usr/local/bin/vmops-release; do
    test -r "$file"
    test ! -w "$file"
done
test -x /usr/local/bin/vmops-release
test "$(command -v vmops-release)" = "/usr/local/bin/vmops-release"
test "$(vmops-release)" = "VmOpsRelease:4.7.2"
echo LEARNER_CONTRACT_PASS
```

Keep the evidence separate: managed Run Command must report a successful execution, a present zero exit code, and `CONTRACT_PASS`; the learner session must emit `LEARNER_CONTRACT_PASS`. Effective-user checks account for access that permission bits alone might not describe, such as access control lists (ACLs) or mount settings. They establish the learner's initial unprivileged access, not protection against an authorized administrator deliberately elevating and changing the VM.

The private access check assumes a network interface with no public IP, NSG rules limited to approved administrative paths, and outbound connectivity for the guest agent. Keep the SSH private key outside the image; provision only the public key for the intended account. Publishing gallery version `1.0.2` later won't update this standalone VM: it already has its own disks. Patch or replace it through its normal change process. Updating a Virtual Machine Scale Set, a group of VMs deployed from a common model, also requires a separate rollout decision.
