Use this timestamped fixture to practice calculations. Every timestamp is on the same synthetic day and in UTC. For this analysis fixture, assume the supported same-region restoration used P1's available snapshot. The table's later **snapshot and vault** label doesn't mean that the restore read the vault copy. This assumption describes the synthetic exercise, not observed Azure job telemetry.

| Event | Time | Interpretation |
|---|---|---|
| P1 content boundary | 09:10 | `A101` through `A103` present |
| Last acknowledged legitimate pre-incident write | 09:20 | `A104` commit completed and the application acknowledged the write |
| Failure detected | 09:21 | `A102` deletion discovered |
| Recovery authorized and requested | 09:22 | RTO clock starts |
| Restore job starts | 09:24 | Two minutes of queue and request overhead |
| Infrastructure restore completes | 09:39 | Not yet usable application evidence |
| Application first passes functional check | 09:47 | Data report and transaction work |
| Independent validation completes | 09:50 | Acceptance clock stops |
| Owner accepts result | 09:53 | Decision recorded separately |

Validated recovery duration is `09:50 - 09:22 = 28 minutes`. The infrastructure job took 15 minutes, but reporting only that value would omit access and validation. Detection-to-validation is 29 minutes. Application checks first passed 25 minutes after authorization. Independent validation finished after 28 minutes, which is the duration used to assess the RTO.

The 28-minute result applies to this snapshot-based rehearsal and its defined acceptance boundary. It doesn't measure a vault-only restore after the snapshot is unavailable. A live result must retain its actual or explicitly inferred restore-source provenance before it's used for recovery planning.

The last acknowledged legitimate pre-incident write was 10 minutes after the point boundary. The recovered copy lacks one acknowledged order worth 600 cents. It restores the previously deleted `A102`, but it doesn't restore `A104`. In this example, recovery takes 28 minutes, meeting the 60-minute RTO. The 10-minute acknowledged-write gap meets the laboratory's 15-minute RPO criterion, and the single missing order meets the record-loss limit. Acceptance still requires the application owner's approval.

Also report point age at authorization: 12 minutes. Point age measures the time from the recovery point to recovery authorization. The acknowledged-write gap measures the time from the recovery point to the last acknowledged legitimate pre-incident write. If acknowledgement output is missing, a row or later manifest doesn't reconstruct that exact event. Record available timing bounds and uncertainty rather than inventing a precise acknowledgement timestamp. Don't accept the recovery if the maximum possible data-loss interval could exceed the RPO.

This selected rehearsal meets its observed 15-minute data-loss criterion. It doesn't prove that a four-hour schedule can continuously meet a 15-minute RPO. For example, with the most recent usable point at 10:02 and a legitimate write acknowledged at 13:58 before the next capture, the gap is 236 minutes. Even a healthy four-hour schedule can therefore be unsuitable for the stated target.

Four hours is the most frequent supported scheduled interval for Enhanced Azure VM backup. Tightening that policy alone can't provide a 15-minute scheduled interval. On-demand backups are bounded operations, not a substitute for a designed 15-minute protection service. If 15 minutes is a workload requirement, the owner must select and validate an appropriate complementary mechanism, such as application-native log backup and point-in-time recovery where supported. This SQLite fixture doesn't supply such a mechanism. VM backup can still protect the machine and other required data.

Record both conclusions: the selected point passed this rehearsal, but this VM-backup schedule alone doesn't establish the required continuous protection capability. Assign the design gap, its owner, and repeat-drill criteria. Don't silently change the target or describe the workload as production-ready on the basis of one favorable point.

During a live drill, waiting for backup operations to finish can also cause the selected point to fall outside the agreed RPO. Record a failure to meet the recovery objective rather than changing timestamps. Review supported protection mechanisms against the target. A different approved VM-backup schedule can improve recovery within its supported limits, but a target shorter than the minimum scheduled interval needs a different or complementary mechanism. Preserve the failed result and obtain the owner's decision before repeating the drill.

Use this evidence template for either track, replacing every placeholder and clearly retaining the track label.

```text
Run and track: <identifier>; Live Azure / Analysis only
Source authority and write freeze: <resource ID, approver, time>
Failure and acceptance criteria: <RTO, RPO, record-loss allowance>
Support review: <date, OS, generation, security type, backup method, disks, backed-up size, region, Create-new eligibility, exceptions>
Policy and scope: <vault, policy, schedule and timezone, selected disks, tier-specific retention>
Backup service evidence: <job ID, snapshot result, transfer result, Validate backup result where applicable, observation UTC>
Point and method: <identifier, scheduled/on-demand trigger, available tiers, capture and transfer times, consistency, rationale>
Restore source: <snapshot/vault/undetermined, job evidence or labeled inference, observation UTC>
Isolation: <subnet, routes, NSG evidence, management path, identity>
Staging readiness: <account ID, kind, region, network and service authorization, Shared Key policy, approved fallback>
Request / start / infrastructure / app-ready / validated UTC: <values>
Data: <expected IDs, actual IDs, totals, external manifest, hashes>
Acknowledgement evidence: <WRITE_ACK operation, order ID, acknowledged UTC, command exit code, independent capture location>
Application: <integrity result, rollback result, exit code>
Observed duration and loss: <calculations, uncertainty, pass or fail>
Protection-design suitability: <required incident window and tier, supported interval, gap, owner, repeat-drill criteria>
Remediation: <issue, owner, due date, repeat-drill trigger>
Final authority and protection: <item, policy, next and subsequent backup>
Cleanup: <removed resources, retained points, remaining costs, owner>
Reviewer and closure decision: <name, time, exceptions>
```
