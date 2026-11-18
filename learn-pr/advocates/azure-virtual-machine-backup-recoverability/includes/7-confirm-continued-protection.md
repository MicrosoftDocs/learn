## Restore the intended operating state

The recovered VM remains a nonauthoritative test destination. After evidence approval, repair only the missing synthetic order on the original disposable source. Read its amount from the validated recovered ledger and have the reviewer confirm `A102 = 1800` before running these commands on the source. This is a controlled record repair, not a source disk replacement.

```powershell
Set-Location C:\RecoveryLab -ErrorAction Stop
python .\ledger.py add F:\RecoveryLab\orders.db --id A102 --cents 1800
if ($LASTEXITCODE -ne 0) { throw "STOP: source repair failed" }
python .\ledger.py verify F:\RecoveryLab\orders.db --manifest .\expected-before-failure.json
if ($LASTEXITCODE -ne 0) { throw "STOP: repaired source verification failed" }
```

The source's logical contents must again match `expected-before-failure.json`, with all four orders totaling 6,000 cents. The new row-write sample and separate post-commit acknowledgement for repaired `A102` are expected. Preserve that event and an audit note explaining the repair, without substituting them for the pre-incident evidence. Resume only the approved synthetic workload.

Open the source backup item again. Verify protection remains enabled, the correct data disk is selected, the intended policy is assigned, and the next scheduled backup is visible. Obtain a subsequent successful backup after the repair, either at the scheduled time or through an approved on-demand run within service limits. Record its point, available tiers, and applicable expiration. A valid snapshot-only point isn't a failed backup solely because it isn't the scheduled daily vaulted point. A repaired but unprotected authoritative source doesn't satisfy this module.

If the subsequent point is being recorded as vaulted, retain its successful transfer and **Validate backup** evidence. A successful snapshot-only point can satisfy the chosen snapshot path, but it doesn't establish a completed vault transfer or vault validation.

For the analysis track, use the following complete synthetic post-repair protection record, not an invented successful job. All times shown without a date in the earlier synthetic records refer to 14 November 2026. P3 is a subsequent scheduled backup, distinct from the unsuitable P2 point.

The fixture's four-hour policy uses a fixed UTC+10 policy timezone and a 24-hour schedule starting at 00:00 local policy time. Its scheduled runs are at 00:00, 04:00, 08:00, 12:00, 16:00, and 20:00 in that timezone. P3's 10:00 UTC request is the 20:00 run and the last scheduled backup of that policy day. The next 14:00 UTC run is 00:00 on the next policy day. This fixed policy timezone isn't the learner's daylight-saving timezone.

The following record includes the daily vault transfer and reported expiration values for that synthetic policy.

| Evidence field | Supplied synthetic value |
|---|---|
| Authoritative workload | `m09-source` in `rg-m09-source`. The application owner confirms authority at 09:53 UTC. `m09-restored-01` remains nonauthoritative |
| Repair and source validation | `A102 = 1800` repaired at 09:55 UTC, independent full-source manifest's business records and hash match at 09:57, `A101`, `A102`, `A103`, `A104`, total 6,000 cents, integrity and rollback checks pass |
| Protected item and vault | `m09-source` in `rsv-m09-lab`, with protection enabled |
| Policy | `M09-Approved-Enhanced-4h-30d`, approved four-hour schedule over a 24-hour window from 00:00 in fixed UTC+10, 30-day daily vault retention and two-day snapshot retention, unchanged |
| Selected disks | `m09-source-os` and `m09-source-data01`, data disk logical unit number 0 containing `F:\RecoveryLab`. Neither disk is excluded |
| Subsequent job | `M09-BACKUP-03`, scheduled request and start `2026-11-14T10:00:00Z`, snapshot complete 10:02, transfer to vault complete 10:24, job completed successfully 10:25 |
| Backup service validation | **Validate backup** succeeded after the 10:24 vault transfer and before the 10:25 successful job completion. This is supplied synthetic evidence, not a live observation |
| New recovery point | P3, `2026-11-14T10:02:00Z`, application-consistent, both disks, snapshot and vault tiers available |
| Reported expiration | Snapshot `2026-11-16T10:02:00Z`, vault `2026-12-14T10:02:00Z` |
| Final protection review | Backup operator verifies item, policy, disk scope, job, and point at 10:26 UTC. Next scheduled backup is `2026-11-14T14:00:00Z` |
| Evidence and retention owner | Laboratory backup operator retains manifests, job details, P1/P2/P3 records, and closure approval. No point deletion or retention change is authorized |

For an analysis-only submission, this synthetic record supplies the evidence needed to assess continued protection. It doesn't demonstrate that a live backup ran. This record doesn't show that P3 was restored and tested. The earlier recovery validation still ends at 09:50. Live learners must replace it with their own observed evidence. If evidence of the post-repair backup job or recovery point is missing, record **Closure blocked: continued protection unverified**. Assign the backup owner to obtain the missing evidence. A working repaired application doesn't prove that its backup succeeded.

The reported expiration values aren't promises of physical deletion at those exact instants. Snapshot cleanup is asynchronous and can depend on a subsequent successful backup. Retain the approved policy and record actual remaining resources rather than deleting protected snapshots to force the fixture's dates.

Creating a restored VM doesn't automatically make it the protected authoritative workload. If a separate operational recovery promotes a new VM, explicitly configure and verify that VM's protection and retain the original protection history. Don't infer coverage from a similar name.

## Troubleshoot without weakening controls

Use the following actions when a required recovery check fails.

| Symptom | Safe investigation and next action |
|---|---|
| Required point absent | Check retention, region view, item identity, tier, and job progress. Escalate unavailable historical content |
| Transfer progress is complete but service validation is pending or failed | Keep vault readiness unverified until **Validate backup** succeeds and the vault point is available. Assess any supported snapshot path separately |
| Authorization failure | Save denied action and scope. Request the specific role correction rather than subscription Owner |
| Restore option unavailable | Compare encryption, disk type, operating system, and destination with the support matrix |
| Deploy Template blocked by storage policy | Preserve the denied operation and account settings, then use an approved deployment from restored disks or stop. Don't enable Shared Key to bypass policy |
| Restore delayed | Inspect subtasks and service health. Preserve elapsed time and contact the owner when the RTO is at risk |
| VM starts but application fails | Check disk mapping, manifest provenance, runtime, permissions, schema, and integrity. Don't accept infrastructure success |
| Protection fails afterward | Inspect extension, disk inclusion, policy, and job errors. Keep the run open with an assigned backup owner |

Don't delete recovery points, disable backup safeguards, or reduce retention to work around an error. Locked immutability can't be reversed. Preserve error identifiers without exporting credentials.

## Cleanup and independent assessment

Save evidence before removing the approved restored VM and its test-only network interface, disks, and staging artifacts. Inspect the resource group afterward: deleting a VM doesn't necessarily remove disks or virtual hard disk staging files. Delete only resources identified in the restore job and approved inventory. Preserve the authoritative source and its protection for the final check.

Retained backup points, vault storage, source disks, management services, and any remaining machine continue to cost money. Deallocation stops VM compute usage charges, not all resource charges. List deliberately retained resources separately from resources that should have been deleted. Assign an owner and review date to each remaining resource.

Answer the following questions before reading the explanations.

1. A successful 10:00 point contains the operating system disk only. The ledger moved to a new data disk at 09:30. Can a successful new-VM restore meet the objective?
1. A point at 11:58 is application-consistent, but deletion occurred at 11:55. An older complete point is 11:45. Which point is defensible?
1. The recovered hash matches, but the transaction probe fails with a permission error. Has recovery succeeded?
1. Validation took 47 minutes against a 45-minute RTO. The subsequent source backup also failed. Can the operator close the drill as passed?
1. A separate evidence pack contains only P0, P1, and P2 plus a successful source repair. Its post-repair job and recovery point are absent. May the reviewer assume that protection resumed?
1. A selected point has a ten-minute acknowledged-write gap. Does that prove that a four-hour Enhanced schedule continuously meets a 15-minute RPO?
1. Transfer progress is 100%, but **Validate backup** is still in progress. Can you record the vault point as ready?
1. A successful same-region restore used a point labeled **snapshot and vault**. Does its measured duration prove vault-only recovery performance?

The answer explanations identify the evidence that changes each decision.

1. No. The required data is outside the point's scope. Find a point or another protection mechanism containing the new disk. Otherwise, report unrecoverable scope.
1. Investigate the 11:45 point because it predates the deletion. Measure its actual content gap and obtain approval if it breaches the RPO. Newer and application-consistent doesn't mean suitable.
1. No. Data equality passes, but the application can't perform required behavior. Correct the isolated guest permissions through the approved path and rerun validation.
1. No. Report the two-minute RTO breach and failed continued protection, assign owners, and repeat the failed gates before closure.
1. No. Block closure, request the actual subsequent job and point from the backup owner, and preserve the uncertainty. Correctly identifying this gap passes the scenario question, but doesn't establish completed protection or authorize inventing a passing job.
1. No. That point passes the observed laboratory criterion, but writes can be almost four hours newer than the latest scheduled point. Four hours is the minimum scheduled interval. Record the protection-design gap and have the owner select and validate a suitable complementary mechanism rather than claiming that a tighter VM-backup schedule can provide 15-minute protection.
1. No. Capture the successful service-validation result and confirm vault-point availability before recording vault readiness. A separately available, supported snapshot can still be used for an approved Instant Restore path. Neither result replaces the application checks.
1. No. The ordinary same-region workflow automatically uses the available local snapshot for a dual-tier point. Record the actual restore source or a labeled inference. A successful snapshot rehearsal doesn't establish vault-only performance when the snapshot is unavailable.

To pass the practical assessment, explain why you selected the recovery point and restore method. Submit isolation evidence, applicable backup-service phase results, the negative-control result, exact data and application results, and evidence of continued backup protection. Keep service-side backup validation distinct from application validation. Report the restore source separately from the point's available tiers, marking any inference explicitly. Include UTC timestamps for the recovery request, restore-job start, infrastructure completion, application readiness, and independent validation. State whether the observed RTO and RPO were met, separately assess the ongoing protection design, and assign an owner and repeat-drill criteria to any design gap. Identifying that gap can satisfy the learning assessment without proving production readiness. An analysis submission uses the supplied snapshot-source assumption and P3 record with fixture provenance and mustn't claim live execution. Any unsafe overwrite, ambiguous authority, missing data validation, or claim of successful closure with unverified final protection is a critical failure.
