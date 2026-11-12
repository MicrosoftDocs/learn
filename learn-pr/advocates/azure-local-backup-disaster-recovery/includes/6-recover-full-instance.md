An Azure Local *instance* includes the physical membership, storage, platform configuration, and management components that support its workloads. Recovering it is a different task from restoring one VM to an already healthy destination.

For the connected, hyperconverged deployments covered here, don't treat a VM backup as an instance snapshot or assume that a single restore command reconstructs the physical cluster, lifecycle state, management services, and workload data. Choose a recovery path according to what survives. This can mean repairing an existing instance, using a specifically supported preserved-data redeployment, or building a replacement platform and restoring workloads afterward.

## Classify management loss, operating-system loss, and data loss

An unavailable Azure resource isn't evidence that local data has been destroyed. Conversely, surviving disk devices don't prove that the complete platform can be reconstructed by importing VM files.

The following decision table distinguishes the main recovery cases.

| Failure condition | Recovery direction | What not to assume |
| --- | --- | --- |
| Azure connectivity or portal management is unavailable, but hosts and workloads still operate | Diagnose connectivity, registration, and the affected management service | Don't redeploy the instance solely because Azure information is stale |
| The Arc resource bridge's Azure representation or appliance is lost | Use the recovery path for that specific management component, with support assistance for appliance redeployment where required | A missing bridge doesn't necessarily mean that the workload VMs or storage are lost |
| A single-machine instance loses its operating system while its data pool survives | Use the supported single-machine redeployment option that retains existing data drives | The system volume is reprovisioned, and encryption access and storage mappings still need recovery |
| All operating-system disks in a multi-node instance are lost, but data disks survive | Preserve disks, metadata, keys, and deployment evidence, then obtain a product-specific recovery plan before provisioning writes | The ordinary node-repair workflow assumes a surviving member, and the single-machine preserve-data option isn't a general multi-node restore recipe |
| The storage pool or entire site is destroyed | Deploy a supported replacement instance and restore workloads from independent backups or replicas | Azure registration and secret backup don't recreate lost workload disks |

For a single-machine redeployment, **Use existing data drives** applies to an existing Storage Spaces pool and preserves its data drives and volumes. It isn't a recovery option for data that's been destroyed. Validate the encryption material, retained volumes, and any required infrastructure or workload storage paths after deployment.

For multi-node all-operating-system loss, a general end-to-end retained-pool reconstruction procedure isn't established by the ordinary repair workflow. Escalate that preservation case before resetting storage or deploying over it. This is a support boundary, not a conclusion that support-assisted recovery is impossible.

## Preserve an infrastructure recovery inventory

Prepare recovery artifacts while the instance is healthy. Store configuration separately from secrets and keep both accessible independently of the protected instance.

The following inventory supports reconstruction, but isn't itself a complete platform backup.

| Artifact category | Information to preserve | Why it matters |
| --- | --- | --- |
| Deployment configuration | Approved template and parameter versions, instance and node names, deployment and identity model, storage layout, witness, and security settings | Establishes the intended platform rather than relying on memory during an incident |
| Hardware and software | Machine and disk identifiers, retained-disk locations, solution build, compatible image, OEM drivers, firmware, and solution extensions | Prevents use of incompatible replacement media or accidental reuse of the wrong disks |
| Network configuration | Management and infrastructure addressing, DNS, gateways, VLANs, adapter names, network intents, switch settings, and cabling | Recreates the paths needed for deployment, storage, management, and workloads |
| Identity and access | Domain and organizational unit where applicable, deployment identity and rights, emergency access, and Azure permissions | Allows reconstruction without circular dependencies on the failed instance |
| Azure management mapping | Tenant, subscription, region, resource group, instance and node resource IDs, bridge, custom location, logical networks, and storage paths | Distinguishes recovered platform configuration from stale or replacement resource identities |
| Keys and protected secrets | BitLocker recovery material, Trusted Launch guest state protection keys, required certificates, and backup-service encryption material | Allows retained volumes and protected guests to be used after recovery |
| Workload recovery map | Backup locations, included VM disks, application versions, dependencies, target networks, recovery order, and supported management outcomes | Connects the rebuilt platform to the actual business-service recovery plan |

Don't place passwords or private keys in plaintext deployment templates or incident notes. The inventory should identify the approved retrieval location and access process.

Automatic system-secret backup to Azure Key Vault can preserve items such as BitLocker recovery keys and Trusted Launch guest state protection keys. At this baseline, that functionality is preview. It doesn't contain a backup of all VM disks, storage-pool data, or the complete platform state. Prove access to the required secrets as well as to the workload recovery points.

> [!NOTE]
> Azure Local disconnected operations has a separate backup and restore capability for its local control plane. That backup excludes the configured physical clusters and associated workloads. Restoration requires a compatible control-plane environment and retained decryption material, followed by reconnection or rehydration of resources. It isn't a full-instance workload backup or a recovery mechanism automatically available to a connected deployment.

## Reconstruct the platform before restoring workloads

Use the following staged process when the approved recovery path requires a replacement deployment. For surviving multi-node storage, resolve the preservation plan first rather than applying a new-deployment workflow over retained data.

1. Declare the failure scope and recovery authority. Record which hosts, disks, backups, identities, and management components remain usable. Fence any original systems that could return and create a competing workload writer.
1. Retrieve and validate the infrastructure inventory, required keys, and workload recovery points. Preserve potentially recoverable disks and incident evidence. Decide whether this is supported same-instance repair, single-machine preserved-data redeployment, or a replacement-instance deployment.
1. Reestablish prerequisites independently: supported hardware and media, power, switching, DNS, time, identity, Azure connectivity, deployment permissions, and vault access. Confirm that target capacity includes platform services, recovery processing, and the required application workload.
1. Prepare deployment inputs from the approved configuration, adjusting addresses and identities deliberately for the recovery location. Use the supported Azure Local deployment process and resolve validation failures before provisioning the instance. Reusing the old display name doesn't establish continuity with the old Azure resources.
1. Verify the resulting physical nodes, cluster membership, storage pools and volumes, network intents, security configuration, and lifecycle health. Confirm the intended Azure Local and node resource projections, including automatically managed resources, rather than deleting unexpected objects to make the inventory appear tidy.
1. Establish the VM-management dependencies: Arc resource bridge, its infrastructure network, custom location, and the workload logical networks and storage paths. Verify that each mapping points to the intended destination before restoring applications.
1. Recover required identities and application dependencies through their own supported processes, then restore workload data and protected guest-state keys. Keep candidate workloads isolated until their integrity, connectivity, and representative transactions pass.
1. Apply the production-release gates: one authorized writer, approved traffic changes, business acceptance, and renewed protection. Reconcile each workload's supported local and Azure management state, then plan any return to the original location as a separate handover.

The following workflow emphasizes that deploying the platform is an intermediate milestone, not completion of business recovery.

:::image type="content" source="../media/instance-recovery.svg" alt-text="Diagram that shows preservation, platform reconstruction, management mapping, workload recovery, and service acceptance." border="false":::

## Reconcile storage and management identities

The Arc resource bridge connects Azure resource operations to local infrastructure. A *custom location* identifies the deployment destination for Azure-managed resources. A *logical network* describes the workload network, and a *storage path* maps an Azure resource to a location on the instance's storage. Recreating these resource definitions doesn't restore their missing data.

Restore workload files only to appropriate supported workload storage paths. Don't use the infrastructure volume named `Infrastructure_1` as a workload storage path. Preserve the separation between the platform's own components and application storage.

Track four outcomes separately: data has been restored, the VM can operate locally, its guest Azure Arc connection works, and Azure Local lifecycle management is supported for that restored VM. One doesn't automatically prove the next.

The product-specific restrictions still apply on a replacement instance. MABS alternate-location recovery can leave a VM unmanaged and doesn't automatically make it highly available. A Trusted Launch VM recovered to a different instance needs its guest state protection key and remains subject to the documented local-management restriction. Don't promise universal Azure onboarding simply because the new instance uses familiar resource names.

Retire obsolete Azure and directory objects only through an approved cleanup plan after recovery dependencies are understood. Retain vaults, organizational units, keys, and backups that still support restoration or investigation. The narrowly scoped faulty-node Arc-resource step in node repair isn't authorization for deleting an entire resource group during instance recovery.

## Accept the platform and the business service separately

*Platform acceptance* is the recovery team's confirmation, based on validation results, that the repaired or rebuilt Azure Local infrastructure is ready to host restored workloads. To accept the platform, confirm that the approved deployment or repair has completed, the expected nodes belong to both the cluster and VM infrastructure, storage has regained the required resilience, and current health results meet the agreed criteria. Validate network connectivity, identity, encryption, key retrieval, Azure registration, and management mappings. A completed deployment wizard isn't a substitute for these checks.

Business acceptance additionally requires the restored application's integrity, authentication, representative transactions, release approval, and protection at the active location. Record any agreed degraded service or unsupported management expectation as a residual issue, not as an invisible assumption.

Include platform reconstruction in the RTO when no prepared destination exists. Hardware procurement, identity recovery, deployment validation, storage preparation, workload transfer, and application validation can dominate recovery time. Don't apply a measured VM restore duration to complete instance loss without accounting for those dependencies.
