Restoration creates a candidate recovered workload. Validation establishes whether that candidate is suitable for service. Isolation prevents the candidate from affecting production before that decision.

Confirm the incident type and restore scope before selecting a point. Use item-level or application-native recovery when that supported scope meets the requirement. If compromise is suspected, apply the cyber recovery gates as well as the application validation gates.

## Choose a clean recovery point

Consider this supplied scenario for a standard, non-Trusted-Launch VM. Application evidence establishes that corruption began at 10:04. The 09:52 recovery point is known to predate that corruption, while 10:08 contains the affected state.

The following evidence determines the initial restore choice.

| Event or recovery point | Time | Recovery decision |
| --- | --- | --- |
| Known clean recovery point | 09:52 | Select as the initial restore candidate |
| Corruption begins | 10:04 | Establish the boundary that recovery mustn't cross without validation |
| Later recovery point | 10:08 | Don't select merely because it's newer |

The diagram illustrates why freshness and trustworthiness aren't the same.

:::image type="content" source="../media/clean-recovery-point.svg" alt-text="Diagram that shows selecting the clean 09:52 recovery point instead of the corrupted 10:08 point." border="false":::

Restoring 09:52 doesn't always mean abandoning every later transaction. If the application supports point-in-time recovery and you have a complete, validated log chain, you might be able to advance to a clean boundary before the corrupting operation. Log replay must follow application-specific rules. Blindly replaying all available logs can reproduce the original fault.

## Prepare an alternate target

Before opening a recovery wizard, confirm the restore destination, supported product versions, available space, keys, and application owner. Use a distinct approved host and storage path for this exercise.

Establish network isolation before the restored VM starts. Isolation must prevent production routing, duplicate IP address advertisement, unintended authentication changes, and outbound application side effects. An application can cause damage even without serving users if it starts scheduled jobs, sends messages, or submits transactions to an external system.

Provide isolated or otherwise approved dependencies for testing. If a test requires an identity service, don't clone a production domain controller casually. Follow the identity platform's supported recovery and testing procedure. Where a real downstream integration can't be safely used, agree on a test endpoint or controlled substitute.

## Walk through a bounded MABS recovery

This walkthrough uses the MABS Recovery wizard to review and perform an approved alternate-host restore. It isn't a production failover exercise. The operator needs backup access, an isolated supported host, sufficient storage, required keys, and an application owner to validate the result.

> [!WARNING]
> Original-instance recovery deletes the original virtual hard disks and associated checkpoints. Selecting the original host in the alternate-location workflow can have the same destructive behavior. Neither choice is a nondisruptive restore test.

1. In **Recovery**, locate the exact protected VM and select the 09:52 recovery point. Match its identity and location to the approved inventory. Record the point's consistency and required recovery material.
1. Select **Recover** and review the selection. Choose **Recover as virtual machine to any host** only when the alternate destination is supported. Confirm that the host and storage path are distinct from the original instance.
1. Confirm isolation and startup behavior before authorizing recovery. Ensure that the recovered workload can't connect to production or start live outbound jobs when it boots.
1. Review the recovery options and final summary with the responsible operator. Authorize the disk writes only after the destination, capacity, recovery point, and required access have been confirmed.
1. Monitor the recovery job to a terminal result. A failed or partially completed job isn't a successful restore. Preserve the job details and investigate before continuing.
1. Pass the identity and storage gates. Confirm approved authentication, reliable time, name resolution, keys, required disks, and application recovery logs.
1. Pass the application gate. Run the application's integrity checks and representative read/write transactions in the isolated environment. Reconcile results with the application owner and retain evidence.
1. End the exercise by removing only the approved test artifacts and closing any temporary access. Retain the protected backup and the evidence required by policy. A production release requires the separate authorization described in the next section.

MABS alternate-location recovery can produce an unmanaged VM. A VM recovered to a cluster node isn't automatically highly available. The MABS-specific documentation doesn't support converting that alternate-location recovered VM into an Azure Local-managed VM. Don't silently promise that selecting a cluster destination restores the original Azure resource.

Original-instance and alternate-instance recovery also have different support implications. Resolve any ambiguity in the product's documentation for the exact build and recovery path before using it as a production procedure.

## Define what passes each gate

Validation should produce specific evidence rather than a general statement that the workload looks healthy. The following gate criteria provide a starting point for the order-processing application.

| Gate | Example evidence | Stop condition |
| --- | --- | --- |
| Identity and keys | Approved operator can authenticate, certificates are usable, required keys are available, and time is correct | Missing trust, missing key, expired certificate, or unsafe identity dependency |
| Storage and data | Required disks are attached, expected volumes mount, and logs or backup chains are complete | Missing disk, damaged chain, or unexpected data source |
| Application integrity | Database checks and application consistency checks pass | Corruption, invalid relationships, or failed log replay |
| Business behavior | Representative order is created, retrieved, and reconciled through approved test integrations | Failed transaction, incorrect result, or unapproved production side effect |

If a gate fails, retain isolation and stop release. Preserve the original backup and failed-test evidence. Choose a different recovery point, repair a dependency through a supported method, or escalate to the application owner.

Removing an isolated test copy reverses that exercise's artifacts. It doesn't undo an overwrite of the original production VM. Reversal of an overwritten workload requires another supported recovery operation.
