Contoso is a technical training company that teaches IT teams to manage Linux servers in Azure. Its Ubuntu course gives learners dedicated VMs where they can change file permissions, restart services, and recover from mistakes without disrupting a production server. 

Each week Contoso will deploy 48 classroom VMs from one Ubuntu image: 24 in East US and 24 in West US 2. Each learner gets a VM, and both classes need the same version of `vmops-release` for the first lesson. Contoso updates its images to ensure that they incorporate the security fixes. In one particular week the updated build fails its application check. Contoso publishes the corrected build as gallery image version `1.0.1`. Its East US copy is ready first, so the release owner waits for West US 2 before approving it. The team confirms each classroom VM was created from that image version. When the course ends, it blocks new deployments but keeps the image for recovery.

Contoso packages application version `4.7.2` of `vmops-release` in gallery image version `1.0.1`. When a learner runs the command with `mode=training`, it returns `VmOpsRelease:4.7.2`. That output identifies the application, not the image used to create the VM. By installing the tool and its configuration in the image, Contoso gives all 48 VMs the same tested starting point. Learners don't have to wait for a post-deployment script to install the tool on each VM, and a failed download can't leave a classroom VM without it. A file with the right name isn't enough: the command must run with learner permissions and report the expected version.

:::image type="content" source="../media/1-classroom-image-rollout.svg" alt-text="Diagram that shows Contoso's weekly rollout from a failed build to 48 VMs in two regions, then withdrawal of the image and retention for recovery.":::

## Build an image with Azure VM Image Builder

**Azure VM Image Builder** builds and tests an image from a recipe called an *image template*. **Azure Compute Gallery** stores numbered versions of the resulting image and can copy them to other Azure regions. Publishing puts a version in the gallery. Approval is a separate decision by a person authorized to release it. A **consumer** is a VM or deployment process that uses that version.

Contoso builds one image for all 48 classroom VMs. An image template tells Azure VM Image Builder what to start from, what to change, how to test the result, and where to publish it. Here's how the team builds the corrected image:

1. **Choose the source and destination**: Select an exact version of Canonical's Ubuntu Server 22.04 image available in East US. For this example, create or select an Azure Compute Gallery and compatible image definition in East US. Confirm the image definition's actual location and that version `1.0.1` doesn't already exist. Attach a user-assigned managed identity to the template. Grant it permission to read the gallery and definition and to read and write image versions under that definition. Grant it Contributor only on an empty staging resource group dedicated to this template, in the same subscription and East US location as the template, so Image Builder can create and remove temporary build resources there.
1. **Describe the changes**: In the template's `source` section, enter the Marketplace publisher, offer, SKU, and pinned version. In `customize`, add a Linux shell **customizer**: a script that installs `vmops-release` in `/usr/local/bin`, writes `mode=training` to `/opt/vmops-release/config`, and writes the application version `4.7.2` to `/opt/vmops-release/version`. Use `root:root` ownership, mode `755` for the executable and application directory, and mode `644` for the configuration and version files. Keep parent directories traversable but not writable by the learner. Provision the classroom account when creating a VM; don't bake its credentials into the image.
1. **Define what can be published**: In `validate.inVMValidations`, add a shell **validator** that runs on the customized image. Check for Ubuntu 22.04 on x64, an active Azure guest agent, and the expected file ownership and permissions. Confirm the application version file contains `4.7.2` and the configuration is `mode=training`, then run `vmops-release` and require the exact output `VmOpsRelease:4.7.2`. Have the script exit with a nonzero status if any check fails. Set `continueDistributeOnFailure` to `false` so a failure blocks publication. In `distribute`, choose `SharedImage`, set `galleryImageId` to the full gallery version ID ending in `/versions/1.0.1`, and set `excludeFromLatest` to `true`. Set `targetRegions` to East US and West US 2, with two replicas in each for this example's simultaneous classroom rollout.
1. **Register the recipe, then run it**: Keep the template and its parameters together. This example uses Image Builder API version `2024-02-01`, sets `properties.autoRun.state` to `Disabled`, and has no automatic build trigger. If using Bicep, Azure's language for declaring resources, compile the template locally and preview its resource changes with `az deployment group what-if`. After review, `az deployment group create` registers the image template in the build resource group. With this configuration, it doesn't start the image build. Start a separate Image Builder run.

Merge the following JSON into the image template's `properties` object; it isn't a complete template. A recipe with `autoRun.state: Enabled` can start its build on creation, so inspect its settings before invoking another run.

```json
{
  "autoRun": {
    "state": "Disabled"
  }
}
```

For example, these Azure CLI commands in PowerShell use `$templateId`, the full resource ID of the **registered image template**, not the gallery version ID:

```powershell
az image builder run --ids $templateId --no-wait
if ($LASTEXITCODE -ne 0) { throw 'Azure did not accept the build request.' }
az image builder show --ids $templateId --query lastRunStatus --output json
```

Image Builder creates a temporary VM from the pinned source, runs the customizer, and prepares the OS so each classroom VM can receive its own identity. It captures the customized image and tests it before publishing. With `--no-wait`, the first command returns before that work finishes. Repeat the `show` query, not the `run` command, until the run reaches a final state. On success, confirm that the requested gallery version exists. The result is one **candidate image**, not 48 deployed VMs or an approved two-region release.

:::image type="content" source="../media/1-image-build-process.svg" alt-text="Diagram that shows how Azure VM Image Builder customizes a temporary VM, tests the captured image, and publishes a passing version to the gallery.":::

## Azure Compute Gallery

Azure Compute Gallery is where Contoso publishes and shares numbered versions of its classroom image. The gallery belongs to a resource group in one subscription. Publishing version `1.0.1` doesn't make it public or approve it for deployment. Where Contoso can use it depends on three things:

- **Region**: The version needs a ready copy in the region where Azure will create the VM. A copy in East US can serve that classroom, but it can't serve the West US 2 classroom while replication there's incomplete.
- **Resource group and subscription**: The VM can be in a different resource group or subscription from the gallery. The deployment identity needs permission to read the image version in the source subscription and to create the VM and its supporting resources in the destination resource group. It can use the shared version directly; it doesn't need a separate gallery in each subscription.
- **Management group**: A management group organizes subscriptions; it isn't a VM deployment location. Subscriptions can inherit role assignments and policies from their management group, but putting two subscriptions in the same group doesn't by itself share an image or replicate it to another region.

:::image type="content" source="../media/1-gallery-deployment-scopes.svg" alt-text="Diagram that shows regional image readiness, permissions across two subscriptions, and the policies and roles a management group can pass down.":::

### Manually publish an existing VM or managed image

If Contoso already has a configured Ubuntu VM or a standalone Azure managed image, it can publish that source as a new gallery version without running Image Builder. This is an alternative to the automated build, not an extra step after it.

1. **Prepare the source**: For a VM, use a dedicated reference VM or a copy, not a running classroom VM. Remove credentials, private keys, and learner data. Contoso needs each new VM to get its own identity, so deprovision the reference VM's Linux OS, deallocate the VM, and mark it generalized in Azure. Once marked generalized, that VM can't restart. If you're publishing an existing generalized managed image, skip VM preparation.
1. **Choose the portal path for your source**: For a VM, open **Virtual machines**, select the reference VM, then select **Capture** and **Yes, share it to a gallery as an image version**. Select or create the destination gallery and image definition. Leave automatic deletion of the source VM off. For a managed image, open **Azure Compute Gallery**, select the gallery and its image definition, then select **Create a version**. Choose **Managed image** as the source and select the image in its region. If the definition doesn't exist, create it first under **Add > VM image definition**. In either path, the definition's OS, OS state, architecture, generation, and security settings must match the source.
1. **Publish the candidate**: Enter an unused `major.minor.patch` gallery version number; don't reuse Image Builder's `1.0.1`. Select **Exclude from latest** so an unapproved candidate isn't selected automatically. Under **Replication**, include the source region (East US in this example) and West US 2. Set two replicas in each region for the example's rollout of 24 concurrent VM creations per region. Select **Review + create**, then **Create**.

The Azure CLI can perform the same publication. In this PowerShell example, `$managedImageId` is the full ID of an existing managed image in East US. Set `$subscriptionId`, `$galleryResourceGroup`, `$gallery`, and `$definition` to the destination, and `$newVersion` to the unused version number. For a prepared reference VM instead, replace `--managed-image $managedImageId` with `--virtual-machine $sourceVmId`, using the VM's full resource ID.

```powershell
$versionId = az sig image-version create --subscription $subscriptionId `
    --resource-group $galleryResourceGroup --gallery-name $gallery `
    --gallery-image-definition $definition --gallery-image-version $newVersion `
    --managed-image $managedImageId --location eastus --target-regions eastus=2 westus2=2 `
    --exclude-from-latest true --query id --output tsv
if ($LASTEXITCODE -ne 0 -or !$versionId) { throw 'Gallery version creation failed.' }
az sig image-version show --ids $versionId --expand ReplicationStatus --output json
```

Manual publication doesn't run the Image Builder validator. Record the new version's full resource ID in the release manifest. Before approving it, confirm replication is `Completed` in both regions and boot a test VM in each region from that exact ID. Apply the image-baseline checks below and the [independent learner-access check](xref:learn.devrel.azure-virtual-machine-image-lifecycle.image-deployment-verification#verify-the-vm-from-outside-and-inside), including the expected `VmOpsRelease:4.7.2` response.

## Run an Azure VM Image Builder validator before publishing the image

The validator tests the result against the training team's requirement, independently of the customizer. If it read the expected version from the file it was testing, a wrong marker would pass. The Linux shell validator below instead compares the file with the required application version, `4.7.2`. `set -e` stops the script at the first failed check, so it prints `CONTRACT_PASS` only if all checks succeed. Its root-owned, mode-`755` directories are this example's declared baseline, not universal requirements for every Linux image. A Windows image would use checks appropriate to Windows, typically a PowerShell validator.

```sh
set -eu
. /etc/os-release
test "$ID" = "ubuntu"
test "$VERSION_ID" = "22.04"
test "$(uname -m)" = "x86_64"

app=/opt/vmops-release
expected=4.7.2
actual=$(cat "$app/version")
printf 'ReleaseContract: marker actual=%s expected=%s\n' "$actual" "$expected"
test "$actual" = "$expected"
test "$(cat "$app/config")" = "mode=training"

for directory in / /opt "$app" /usr /usr/local /usr/local/bin; do
    test -d "$directory"
    test "$(stat -c '%u:%g:%a' "$directory")" = "0:0:755"
done
for file in "$app/version" "$app/config"; do
    test -f "$file"
    test "$(stat -c '%u:%g:%a' "$file")" = "0:0:644"
done
test -f /usr/local/bin/vmops-release
test "$(stat -c '%u:%g:%a' /usr/local/bin/vmops-release)" = "0:0:755"

systemctl is-active --quiet walinuxagent
test "$(/usr/local/bin/vmops-release)" = "VmOpsRelease:$expected"
echo CONTRACT_PASS
```

File mode `644` lets the owner write the file and others read it; `755` also lets others run the application. Ownership matters: a learner-owned file with mode `644` would still be writable by that learner. Directory write access can allow replacing a file even if the file itself isn't writable. The script checks numeric user ID, group ID, and mode with `stat`; `0:0` identifies `root:root`.

The validator checks the image's declared OS, ownership, permissions, agent, configuration, and application response. It runs in its validation context, not necessarily as the future learner. `CONTRACT_PASS` is image-baseline evidence, not proof of the learner's effective access. `walinuxagent` is the Azure Linux guest agent, which handles communication between Azure and the guest; a healthy agent alone doesn't prove the application works.

Configure the template to test the customized image (`validate.sourceValidationOnly: false`). Set `validate.continueDistributeOnFailure` to `false` so a failed validator prevents publication. If it's `true`, Image Builder can publish the output **and still report the run as failed**.

:::image type="content" source="../media/1-validation-failure-outcomes.svg" alt-text="Diagram that shows how the same failed validator can block or allow gallery publication without changing the failed run status.":::

Decide separately what to keep for diagnosis. Set `errorHandling.onValidationError` to `cleanup` to remove temporary build resources after a validation failure. Set it to `abort` to keep them for investigation, with charges continuing until cleanup. `onCustomizerError` makes the same choice for customization failures. Neither setting turns a failed check into a pass.

Here's how an operator would interpret two build records. The values illustrate the decisions; they aren't logs from an Azure run.

| Gallery version requested | What the evidence says | Decision |
|---|---|---|
| `1.0.0` | The customizer finished. The `ReleaseContract` validator logged `actual=0.0.0 expected=4.7.2` and exited nonzero. The run ended `Failed`, and the requested version was absent from the gallery. | Reject. The evidence identifies a content defect, not a permissions or boot failure. |
| `1.0.1` | A new template with corrected parameters produced application marker `4.7.2`. The validator passed, the run ended `Succeeded`, and the gallery version exists. | Keep as a candidate until regional readiness and release approval are established. |

For a real decision, inspect the template's `lastRunStatus.runState` and wait for a final state. Save the timestamped run details and the named validator's log from the staging storage account before deleting the template; don't assume the log has a fixed blob name. After a rejection, list versions under the intended definition and confirm the requested ID is absent. A failed query isn't proof of absence.

If the build stopped at authorization, boot, or customization, record that cause instead of claiming the validator caught a defect. Correct the cause under a new template name and unused gallery version; keep the rejected candidate's history.

## Gallery image definition

A gallery **image definition** describes a family of compatible images. It records:

- Operating system (OS), such as Linux or Windows
- Processor architecture, such as x64
- Boot generation, such as Hyper-V Generation 1
- Supported security features, such as Trusted Launch
- OS state: generalized if the OS is prepared for a new machine identity, or specialized if it retains the original machine's settings

The definition describes the family; it isn't a disk. Azure creates VM disks from a numbered **image version** within that family.

:::image type="content" source="../media/1-gallery-image-model.svg" alt-text="Diagram that shows the gallery, definition, and numbered image version, followed by the VM that gets its own disk.":::

Three version numbers can appear in one release record. They answer different questions:

| Version | What it identifies | Example |
|---|---|---|
| Marketplace base version | The publisher's OS image used as the starting point | An exact Canonical image version available in the build region, not `latest` |
| Gallery image version | The team's packaged OS, application, and configuration | `1.0.1`, under the team's Ubuntu image definition |
| Application version | The software expected to run inside the VM, also called the *guest* | `vmops-release` returns `VmOpsRelease:4.7.2` |

The base image's Marketplace name has four parts: `publisher:offer:sku:version`. The publisher supplies the image, the offer identifies the product, and the stock-keeping unit (SKU) identifies a variant. For example, Canonical's `0001-com-ubuntu-server-jammy` offer includes the `22_04-lts` SKU. Resolve an available version in the intended region and record it; `latest` can refer to a different version tomorrow.
