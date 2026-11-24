When a course ends, Contoso no longer needs to create classroom VMs, but it might still need to rebuild one. Start by stopping new deployments. Then trace which systems still depend on the image and decide what can be removed without losing evidence or a tested recovery option.

**Withdrawal** stops the approved workflow from using a version for new VMs. **Retirement** is the later decision about when support ends and whether the image can be deleted. If support for `1.0.1` ends today, the owner can withdraw it immediately while retaining it for recovery. That decision doesn't stop, patch, or delete a running VM.

:::image type="content" source="../media/6-image-withdrawal-effects.svg" alt-text="Diagram that shows what withdrawal means for new deployments, existing VM disks, and the retained recovery image.":::

Record who withdrew the version, when, why, and which consumers already use it. Change the trusted manifest to `Withdrawn`. Record the withdrawal through the same authoritative release-control update, advancing its revision even if the active image ID doesn't change. The admission check in [Deploy an approved version and verify the guest](xref:learn.devrel.azure-virtual-machine-image-lifecycle.image-deployment-verification) should refuse a new request before any VM creation call. A refusal such as `RELEASE_REFUSED status=Withdrawn` records why the request stopped.

Neither `excludeFromLatest` nor a gallery **end-of-life date** enforces withdrawal. The date tells operators when support ends; it doesn't prevent explicit deployment or shut down existing VMs.

## Decide whether the image can be deleted

Start with references, not just running VMs. A scale-set model, deployment template, downstream image build, or disaster-recovery script can name the version without a VM using it today. Ask the workload owner what would happen if a region had to be rebuilt tomorrow. Confirm replacement compatibility, regional availability, and owner approval before removing that recovery option.

Retain a known-good image, or prove that the team can rebuild one. A rebuild needs the exact base image, template, successful parameters, application files, definition, identity and role requirements, and validator. Build under a new template name and version, rerun validation and regional checks, and verify a consumer. A saved recipe alone isn't tested recovery: the publisher could remove the base or a package repository could change. If a replacement or rebuild hasn't been validated, retain the version and record its cost, owner, and review date.

## Separate deployment recovery from publishing continuity

Define what recovery must accomplish. A completed image replica can still serve deployments in a healthy target region when another region is unavailable. That doesn't make the image-building pipeline multi-region. An Image Builder template belongs to one region, and Image Builder doesn't automatically move its builds elsewhere. If the region hosting the gallery resource is unavailable, creating or updating gallery resources is also unavailable.

Image availability is only one part of recovery. The admission workflow also needs the current protected release decision and the fresh replication evidence required by its policy. If it can't read either, hold the deployment request even if Azure might still serve the retained replica. A saved `Approved` record isn't a substitute for the current decision: the owner might have withdrawn the version or paused deployments since that record was saved.

Before promising recovery during a regional outage, test the deployment path and its dependencies from the intended recovery region, including release-store access, identity, network connectivity, required Azure status queries, and VM creation. If that path can't meet the recovery objective, prepare a separately approved and tested recovery path in advance. Record its exact image version ID, permitted region, and authoritative release decision; an independent gallery is one option where needed, not a requirement merely to consume a healthy replica. Don't silently shorten the approved regional scope, bypass a failed status query, or remove the normal all-target release gate during an incident.

If recovery means deploying a retained known-good image, keep tested replicas and the deployment workflow ready in the promised regions. If the team must also build and publish a corrected image during an outage, prepare an independent build environment and gallery in another supported region. Include the source image, artifacts, networking, identities, permissions, quota, and a release store reachable during the incident. Regularly prove that the alternate environment can build and publish. A second gallery isn't required merely to consume a ready replica in another region or subscription.

An image version in an independent gallery has a different full resource ID. Record and approve that recovery ID explicitly rather than substituting it behind an approval for another version. Don't delete the retained recovery image until the replacement recovery path is proven.

## Diagnose failures and clean up in dependency order

If a classroom VM won't deploy, the image itself may be fine: the build might have stopped early, or the regional copy might not be ready. Before deleting anything, trace the failure and save the records that explain it. Then remove temporary resources only after confirming that no build, classroom, or recovery process still needs them.

Use the first missing piece of evidence to choose the next action:

| Observation | Next action |
|---|---|
| Azure denies an action, or a private artifact can't be read. | Identify the caller, action, and scope. Check name resolution and routing separately, then verify the artifact hash. Don't widen access to diagnose a network problem. |
| A build fails before the validator runs. | Read the customizer and startup logs. Correct the failing input or prerequisite; don't report a workload-contract failure without a validator result. |
| A validator fails, or a VM uses the wrong version. | Preserve expected and actual values and check the exact gallery ID. Reject the candidate or stop new deployments, as appropriate. |
| An image exists but a required region isn't ready. | Keep the release on hold. Wait for fresh per-region evidence or seek approval for a narrower release. |
| Source, definition, and consumer settings disagree. | Select a compatible approved version or build under a matching definition. Don't relax the security type to make the request succeed. |

Cleanup should remove resources that are no longer needed without removing the ability to investigate or recover:

1. Archive the manifest, reviewed inputs and hashes, failed and successful run records, logs, regional status, consumer results, and withdrawal decision. Record unresolved errors explicitly. Redact access tokens, signed storage URLs, private keys, and other credentials before exporting evidence.
1. Remove temporary verification VMs and only the disks and interfaces owned by that deployment. Preserve shared networking and shared access services such as Azure Bastion.
1. Confirm no build is running before removing its template. Image Builder normally removes temporary compute, but staging storage or a preexisting staging group can remain. Inventory each group before removing leftover resources or accounting for ongoing charges.
1. Keep gallery versions and replicas needed for recovery. Remove role assignments and managed identities only after checking retained workflows; preserve their definitions for an authorized rebuild. Track the cost of retained storage, networking, and replicas until the next review.
1. Once deletion is approved, delete unneeded versions before deleting an empty definition or gallery. Record which recovery option replaces them. Use new names and unused version numbers for future builds rather than overwriting the evidence.
