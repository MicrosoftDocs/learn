An image that works in one classroom might not yet be available in the other. To decide whether both classes can start, check that the image fits the intended VMs, verify that a copy is ready in each promised region, and record the evidence behind the release decision.

## Verify replication in every required region

A **replica** is a copy of a gallery image version in a region. Name the regions the release supports; a promise like "all regions" can't tell an approver which copies to check. Listing East US and West US 2 as targets asks Azure to make those copies. It doesn't say that either copy is ready to create a VM.

In an Image Builder distribution setting, `SharedImage` is the API name for a gallery output. Use the full output version ID and `targetRegions`, rather than the deprecated `replicationRegions`, to say exactly what to publish and where. Each target can specify a replica count and storage type; account for the copies you retain.

Image Builder takes the output image version's location from its parent image definition, not simply from the build VM's region. Include that output source region in `targetRegions`. This example uses an East US definition, so its East US and West US 2 targets include the source region. If an existing definition is elsewhere, either select a compatible East US definition or explicitly revise the replication plan to include the output source region and account for the extra copying, storage, and completion time. An additional replica region doesn't become an approved classroom deployment region without a separate release decision.

Set `excludeFromLatest` to `true` when publishing a candidate, whether Image Builder or an operator creates it. Classroom deployment uses the approved full version ID, so the version can remain excluded after approval. This reduces accidental latest selection; it doesn't block an authorized request for an explicit version.

Decide how many VMs the workflow will create concurrently in each region. Microsoft recommends one image replica for every 20 concurrent VM creations, with additional headroom where needed. These examples assume Contoso starts all 24 classroom VMs together in East US and all 24 together in West US 2. Two replicas per region are a starting configuration, not a guarantee against throttling or a hard 20-VM limit. Staggered deployments can use a different concurrency plan; include any overlapping canaries or other deployments in that plan.

The following JSON is one distributor entry in the template's `properties.distribute` array, not a complete template. Replace the resource-ID placeholders with the actual destination. It explicitly uses locally redundant storage (`Standard_LRS`); choose supported zone-redundant storage (`Standard_ZRS`) if resilience to a zone failure is required.

```json
{
  "type": "SharedImage",
  "runOutputName": "classroom-1-0-1",
  "galleryImageId": "/subscriptions/<subscriptionId>/resourceGroups/<galleryResourceGroup>/providers/Microsoft.Compute/galleries/<gallery>/images/<definition>/versions/1.0.1",
  "excludeFromLatest": true,
  "targetRegions": [
    {
      "name": "eastus",
      "replicaCount": 2,
      "storageAccountType": "Standard_LRS"
    },
    {
      "name": "westus2",
      "replicaCount": 2,
      "storageAccountType": "Standard_LRS"
    }
  ]
}
```

Record replica counts and rollout concurrency in the manifest. Completed replication confirms that the image is available; it doesn't reserve VM capacity or establish that a deployment burst will avoid throttling.

Suppose version `1.0.1` exists and the release promises both regions. East US reports `Completed` at 100%; West US 2 reports `Replicating` at 62%. **Hold the two-region release.** The version's `provisioningState` can already be `Succeeded`: it describes creation of the version resource, not completion of each regional copy.

For an individual region, the response uses `Replicating` in `replicationStatus.summary[].state` while the image is being copied. `InProgress` belongs to the separate `replicationStatus.aggregatedState` field, not to an individual region's state.

:::image type="content" source="../media/2-regional-release-decision.svg" alt-text="Diagram that shows why a completed East US replica and an incomplete West US 2 replica block a two-region release.":::

The following read-only PowerShell example shows the decision. `$versionId` is the candidate's full gallery version resource ID from the manifest. The Azure command-line interface (CLI) returns regional details when you request `--expand ReplicationStatus`. Check those details against the regions in the release contract, **not** just the regions that happen to appear in the response.

```powershell
$requiredRegions = @('eastus', 'westus2')
$raw = az sig image-version show --ids $versionId --expand ReplicationStatus --output json
if ($LASTEXITCODE -ne 0) { throw 'Cannot read the candidate version; hold release.' }
$version = $raw | ConvertFrom-Json -ErrorAction Stop
if ($version.id -ine $versionId -or $version.provisioningState -ne 'Succeeded') {
    throw 'The requested version is missing or not ready.'
}
foreach ($region in $requiredRegions) {
    $rows = @($version.replicationStatus.summary | Where-Object {
        ($_.region -replace ' ', '') -ieq $region
    })
    if ($rows.Count -ne 1 -or $rows[0].state -ne 'Completed' -or $rows[0].progress -ne 100) {
        throw "Hold release: no completed replica for $region."
    }
}
if ($version.replicationStatus.aggregatedState -ne 'Completed') {
    throw 'Hold release: overall replication is not complete.'
}
```

When all promised regions are ready, use a test identity restricted to a test resource group to deploy one **canary**, a disposable test VM, from the candidate's exact ID in each region. Collect the [image-baseline and independent learner-access evidence](xref:learn.devrel.azure-virtual-machine-image-lifecycle.image-deployment-verification#verify-the-vm-from-outside-and-inside) before promotion. This test path can use a candidate; classroom deployment still requires approval.

The **release approver** reviews the build evidence, input hashes, full version ID, regional canary results, compatible consumer settings, and recovery option. Record the approved regions, approver, time, and `Approved` decision together in the manifest. A successful status query isn't itself approval.

An East US-only release would be a different promise. It needs explicit owner approval, fresh evidence for that scope, and a workflow that refuses other regions. The example also requires *overall* replication to finish: shortening `$requiredRegions` doesn't make an incomplete two-region copy job pass.

The diagram follows one release. If a candidate (a version proposed for use) fails validation, the team rejects it. Only a corrected candidate can continue to regional review.

:::image type="content" source="../media/2-image-release-overview.svg" alt-text="Diagram that shows the decisions from defining the image contract to withdrawing the released version.":::

## Match the source, definition, and consumer

The example uses Ubuntu Server 22.04 LTS (long-term support), the x64 processor architecture, Hyper-V Generation 1 (`V1`), and Standard security. Generation describes the VM's boot hardware, not the Ubuntu release. These settings illustrate an existing compatibility requirement; they're not a recommended security baseline for new workloads.

> [!NOTE]
> Azure Compute Gallery calls the boot-generation setting `hyperVGeneration` for both Linux and Windows images. Generation 1 (`V1`) boots with BIOS; Generation 2 (`V2`) boots with UEFI. You don't install Hyper-V in Ubuntu. Match the gallery definition to the source image's generation and choose a VM size that supports it.

A **generalized** image has been prepared so each new VM can receive its own machine identity. A **specialized** image retains machine-specific settings and provisions differently. Image Builder expects a generalized source. Linux deprovisioning and Windows generalization are OS-specific preparation steps; neither guarantees that an image is free of secrets. Remove credentials, tokens, private keys, and customer data before capture.

If policy requires **Trusted Launch**, use a compatible Generation 2 image rather than lowering the VM's security setting. Trusted Launch provides boot protections such as Secure Boot and a virtual trusted platform module. For Image Builder, `TrustedLaunchSupported` describes a supported source capability; a `TrustedLaunch` source isn't interchangeable with it. Match the supported source to the destination definition and check the requested VM security type. A Standard-security VM request doesn't satisfy a definition that **requires** Trusted Launch.

## Record what makes the release reproducible

**Provenance** is the record of where the image came from and which inputs produced it. Pinning an input means selecting an exact version rather than whatever is current at build time. Pin the base, package versions, and repository snapshots; retain the scripts and application artifacts (files used by the build). Otherwise, the same recipe can install different software on different days. The example packages the small command inline, so no package download can change its contents.

A **release manifest** is the team's record for one candidate. It starts in `Candidate` status and distinguishes what was requested from what was observed. A useful manifest answers these questions:

| Question | What to record |
|---|---|
| Could another operator reproduce the intended behavior? | Exact base identifier, template and parameters, artifact locations, and SHA-256 hashes. A hash is a fingerprint of a file's contents; it detects changes but doesn't identify an approver. |
| Which consumers are compatible? | OS state, architecture, generation, security type, expected application response, configuration, file ownership, directory and file permissions, and supported regions. |
| Why is this version eligible for use? | Full gallery version resource ID, build and validator results, dated replication and regional canary evidence, replica counts, rollout concurrency, decision, approver, decision time in UTC, and the release-control record revision reviewed for promotion. This record revision is distinct from the gallery image version and recipe commit. |
| Who is responsible after release? | Image owner, support period, known consumers, withdrawal reason, retained replacement or rebuild inputs, and next review date. |

Protect the manifest and its history in an access-controlled release store. A local JSON file or an image tag can describe a decision; neither authenticates it. Retaining exact inputs makes the intended behavior reproducible, not necessarily every disk byte. Timestamps, generated identifiers, and OS preparation can change the final disk hash.
