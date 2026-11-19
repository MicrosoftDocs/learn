The incident is an accidental deletion of order `A102` from the disposable source. Other legitimate writes occurred after the selected backup. Recover the deleted order in an isolated copy without overwriting newer source data or allowing the restored machine to accept normal workload updates.

> [!NOTE]
> **Workload authority and promotion**: The authoritative workload is the designated source of accepted records and ongoing writes. A restored test copy isn't automatically authoritative. A write freeze temporarily stops updates while records are compared. Promotion deliberately transfers service responsibility to a recovered workload, including which copy clients can update. If both copies accept independent writes, their records can diverge. Reconciliation resolves those differences deliberately, such as repairing only the missing order while preserving newer source records. This exercise doesn't promote the restored machine.

The following diagram connects the decisions that make recovery evidence meaningful.

:::image type="content" source="../media/module-overview.svg" alt-text="Diagram that shows recovery criteria, point selection, isolation, data and application checks, timing, and continued protection.":::

## Define what recovery means

The recovery time objective (RTO) is the maximum acceptable time to restore the agreed service state. The recovery point objective (RPO) describes acceptable data loss expressed as time. Neither is the duration of a portal job. A service can answer requests with incorrect data, and a correct database can remain inaccessible to its application.

Use this acceptance worksheet before starting the timer.

| Field | Laboratory acceptance criterion |
|---|---|
| Failure | `A102` deleted from the source ledger, with no regional outage |
| Required recovered state | Isolated copy contains `A101`, `A102`, and `A103`, with exact amounts and successful report and transaction checks |
| RTO | Validated recovered application within 60 minutes of recovery authorization |
| RPO | Recovery content no more than 15 minutes behind the last acknowledged legitimate pre-incident write |
| Observed rehearsal RPO result | Record whether the selected point's demonstrated content gap meets the 15-minute laboratory criterion |
| Protection-design suitability | Assess whether the configured mechanism can support that target across the required incident window and recovery tier, including failures and delay |
| Record-loss limit | At most one acknowledged post-point order absent from the isolated recovered copy |
| Authority | Original source remains the designated authority, with writes frozen during comparison |
| Promotion | No promotion of the restored machine in this exercise |
| Approval | Application owner accepts missing newer data explicitly. The operator can't approve their own exception |
| Escalation | Missing required disk, unknown authority, unexpected external reachability, or failed correctness check stops recovery acceptance |

Record failure detection separately from authorization. The laboratory RTO starts at authorization, but an operational incident also needs a detection-to-restoration measure. Delaying authorization mustn't make a slow incident appear fast.

Use Coordinated Universal Time (UTC) for evidence. Record clock synchronization and the precision of timestamps. Portal timestamps, guest timestamps, and a human stopwatch can differ. Keep original values and explain discrepancies rather than silently adjusting them.

> [!NOTE]
> **Timekeeping and timestamp notation**: Clock synchronization keeps machines aligned to a common time reference. Precision describes the smallest recorded interval, such as a second, while accuracy describes how close the clock is to the correct time. ISO 8601 is an international standard for date and time notation. In `2026-11-14T10:02:00Z`, `T` separates the date and time, and `Z` means UTC. An offset of `+00:00` also means UTC. Compare timestamps using the same time basis, but retain their original values and stated precision.

When orders are written infrequently, the last recovered order's timestamp alone doesn't establish which transactions the recovery point contains. Record the recovery point's timestamp and independent post-commit acknowledgement evidence for the most recent legitimate pre-incident write missing from that point. Don't substitute a row's pre-commit timestamp or the deliberate deletion's acknowledgement. A database's logical content is the stronger evidence of which business records survived.

## Decide how much proof is sufficient

Matching hashes provide strong evidence that the compared content is identical, provided both hashes were generated from the same fields using the same method. They don't prove that the application can open the database, interpret its schema, or write a transaction. A correct total alone doesn't prove that the records are correct: a duplicate order could offset the value of a missing order.

> [!NOTE]
> **Hashing and data representation**: A cryptographic hash produces a fixed-length digest from input bytes. Secure Hash Algorithm 256-bit (SHA-256) produces the 64-character hexadecimal digest used here. Serialization converts structured records into a reproducible representation. The script orders records, serializes identifiers and amounts as JavaScript Object Notation (JSON), and encodes that text using the 8-bit Unicode Transformation Format (UTF-8). Hashing the same selected fields in the same order avoids differences caused by database-file layout. This logical hash excludes row-write and acknowledgement timestamps and doesn't establish that the reference data is trustworthy or the application works.

This drill therefore requires exact identifiers, amounts, a logical-content hash, SQLite integrity verification, an application report, and a write-and-rollback probe. The evidence reviewer rejects any submission that substitutes a successful restore banner for these checks.
