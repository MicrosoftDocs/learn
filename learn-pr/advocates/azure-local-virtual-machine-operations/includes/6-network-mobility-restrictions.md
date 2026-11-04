An operation can be technically possible in Hyper-V and still be unsupported for an Azure-managed VM hosted on Azure Local. Support depends on maintaining consistent ownership across Azure resources and local infrastructure.

## Plan network changes before deployment

Important logical-network properties can't be changed after creation: the default gateway, IP pools, address space, VLAN ID, and virtual switch name. Treat these values as design decisions rather than routine editable settings.

If a workload needs a different managed NIC address or network segment, follow the documented replacement-interface workflow for the installed release. Account for interruption, guest routes, DNS, firewall rules, application bindings, and any dependency that refers to the old address.

Changing the VLAN locally or typing a different static address into the guest doesn't update the Azure-defined network configuration. It can create a mismatch between what Azure manages and how the VM behaves.

Plan required static NICs at initial provisioning.

> [!NOTE]
> The operation matrix documents a narrow guest-address alignment exception for a static NIC added after provisioning, but the creation guide says that adding static NICs after provisioning isn't supported. This module doesn't demonstrate that conflicting workflow. Obtain support clarification for the installed release before relying on it, and don't use the exception to justify arbitrary guest-side address changes.

## Distinguish migration, failover, and backup

*Live migration* moves a running VM between compatible nodes within the same Azure Local cluster while minimizing interruption. *Quick migration* uses saved state and includes an interruption. *Failover* recovers a workload after a host or other component fails and can involve a restart. None of these is a backup.

Eligible Azure Local managed VMs can use supported local tools for within-cluster live or quick migration. Compatibility includes more than available RAM. Consider processor compatibility, attached devices, storage access, VM security type, and destination resources.

Cross-cluster live migration and storage live migration aren't supported managed-VM operations. A host setting for the number of concurrent storage migrations doesn't change that VM-level restriction.

The following boundaries prevent common shortcuts from becoming operating procedures.

| Proposed shortcut | Why it isn't the supported approach | Better planning direction |
| --- | --- | --- |
| Clone or copy a managed VM to provision another one | Managed-VM cloning and copying are unsupported and can duplicate identities | Create a new VM from an approved image. |
| Move the VM to another cluster by live migration | Cross-cluster live migration isn't supported | Evaluate a supported migration service, application migration, or recovery workflow. |
| Move the VM's files through storage live migration | Storage live migration isn't supported for these managed VMs | Plan storage placement before deployment or use a documented relocation method. |
| Convert the managed disk's type locally | Disk-type conversion isn't a supported managed-VM operation | Use a supported provisioning or data-migration design. |
| Move the VM and related Azure resources to another resource group | Resource-group moves aren't supported for the managed VM and associated resources | Choose scopes deliberately and plan a supported migration or recreation if needed. |

## Use checkpoints within their limits

A *checkpoint* captures VM state for a point-in-time return through the supported Hyper-V mechanism. Depending on checkpoint type, it can also involve saved memory state or guest-aware processing. It remains dependent on the VM's storage and isn't an independent, isolated copy of the workload.

Local checkpoints are supported for eligible managed VMs starting with Azure Local 2504, with Hyper-V administrator access. Don't delegate this capability to non-administrators. Check VM security and device restrictions before creating one.

A checkpoint isn't a substitute for backup. If the underlying storage or protected VM state is lost, the checkpoint might be unusable too. Long-lived checkpoints also complicate storage capacity and later merge operations.

Use a supported backup product or application-native protection method for the exact VM configuration. Confirm that a restore works and that it meets the application's recovery objectives.
