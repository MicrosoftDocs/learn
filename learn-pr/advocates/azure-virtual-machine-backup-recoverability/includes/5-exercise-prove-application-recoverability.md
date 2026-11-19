## Create the synthetic application

Save the following complete program as `C:\RecoveryLab\ledger.py`. It uses only Python's standard library. The hash is calculated from order identifiers and integer amounts in a fixed order, rather than from the database file. This prevents differences in the database's internal page layout from changing the hash.

Use a fresh disposable database and fresh manifests for this program. If you've run an earlier revision, don't reuse its database schema. `CREATE TABLE IF NOT EXISTS` creates a missing table but doesn't migrate an existing one. Preserve any earlier evidence rather than overwriting it.

```python
import argparse
import hashlib
import json
import sqlite3
from datetime import datetime, timezone
from pathlib import Path

p = argparse.ArgumentParser()
p.add_argument("action", choices=["seed", "add", "remove", "manifest", "verify"])
p.add_argument("database")
p.add_argument("--manifest")
p.add_argument("--id")
p.add_argument("--cents", type=int)
a = p.parse_args()
if a.action in {"manifest", "verify"} and not a.manifest:
    p.error("--manifest is required for manifest and verify")
path = Path(a.database)
if a.action != "seed" and not path.is_file():
    raise SystemExit("STOP: database does not exist")
path.parent.mkdir(parents=True, exist_ok=True)
db = sqlite3.connect(path)
db.execute("PRAGMA journal_mode=DELETE")
db.execute("CREATE TABLE IF NOT EXISTS orders "
           "(id TEXT PRIMARY KEY, cents INTEGER NOT NULL, written_utc TEXT NOT NULL)")

def now():
    return datetime.now(timezone.utc).isoformat()

def acknowledge(operation, identifiers):
    event = {
        "operation": operation,
        "ids": identifiers,
        "acknowledged_utc": now(),
    }
    print("WRITE_ACK=" + json.dumps(event, separators=(",", ":")), flush=True)

def contents():
    return [list(r) for r in db.execute(
        "SELECT id, cents FROM orders ORDER BY id")]

def digest(rows):
    raw = json.dumps(rows, separators=(",", ":")).encode("utf-8")
    return hashlib.sha256(raw).hexdigest()

def require(condition, message):
    if not condition:
        raise SystemExit("VALIDATION=FAIL: " + message)

if a.action == "seed":
    if db.execute("SELECT COUNT(*) FROM orders").fetchone()[0]:
        raise SystemExit("STOP: seed requires an empty laboratory database")
    for key, amount in [("A101", 1200), ("A102", 1800), ("A103", 2400)]:
        db.execute("INSERT INTO orders VALUES (?, ?, ?)", (key, amount, now()))
    db.commit()
    acknowledge("seed", ["A101", "A102", "A103"])
elif a.action == "add":
    if not a.id or a.cents is None or a.cents <= 0:
        raise SystemExit("STOP: supply an identifier and positive integer cents")
    db.execute("INSERT INTO orders VALUES (?, ?, ?)", (a.id, a.cents, now()))
    db.commit()
    acknowledge("add", [a.id])
elif a.action == "remove":
    if a.id != "A102":
        raise SystemExit("STOP: this drill removes only synthetic A102")
    cur = db.execute("DELETE FROM orders WHERE id=?", (a.id,))
    if cur.rowcount != 1:
        raise SystemExit("STOP: expected exactly one synthetic row")
    db.commit()
    acknowledge("remove", [a.id])

rows = contents()
if a.action == "manifest":
    document = {
        "rows": rows,
        "sha256": digest(rows),
        "captured": now(),
        "row_write_times": list(
            db.execute("SELECT id, written_utc FROM orders ORDER BY id")
        ),
    }
    with open(a.manifest, "x", encoding="utf-8") as handle:
        json.dump(document, handle, indent=2)
elif a.action == "verify":
    expected = json.loads(Path(a.manifest).read_text(encoding="utf-8"))
    require(rows == expected["rows"], "Record identifiers or amounts differ")
    require(digest(rows) == expected["sha256"], "Logical hash mismatch")
    integrity = db.execute("PRAGMA integrity_check").fetchall()
    require(integrity == [("ok",)], "SQLite integrity check failed")
    total = sum(r[1] for r in rows)
    db.execute("BEGIN")
    try:
        db.execute("INSERT INTO orders VALUES (?, ?, ?)", ("PROBE", 1, now()))
        require(
            db.execute("SELECT SUM(cents) FROM orders").fetchone()[0] == total + 1,
            "Transaction read-back failed",
        )
    finally:
        db.rollback()
    require(contents() == rows, "Transaction rollback changed ledger contents")
    print("INTEGRITY=ok TRANSACTION=rollback_ok VALIDATION=PASS")
print("ROWS=" + json.dumps(rows, separators=(",", ":")))
print("COUNT=" + str(len(rows)) + " TOTAL_CENTS=" + str(sum(r[1] for r in rows)))
print("SHA256=" + digest(rows))
db.close()
```

The manifest's `row_write_times` contains timestamps sampled while constructing rows before commit. These aren't commit-completion evidence and remain excluded from the logical-content hash. `WRITE_ACK` is emitted only after commit returns successfully. Its timestamp is the application's post-commit acknowledgement event, not an exact measurement of the database engine's internal durable-commit instant.

Run these commands in the source guest, using a fresh laboratory database and manifest filename. Preserve successful mutation acknowledgements and command results on the independent evidence workstation.

```powershell
Set-Location C:\RecoveryLab -ErrorAction Stop
python .\ledger.py seed F:\RecoveryLab\orders.db
if ($LASTEXITCODE -ne 0) { throw "STOP: ledger seed failed" }
python .\ledger.py manifest F:\RecoveryLab\orders.db --manifest .\expected-p1.json
if ($LASTEXITCODE -ne 0) { throw "STOP: point manifest creation failed" }
python .\ledger.py verify F:\RecoveryLab\orders.db --manifest .\expected-p1.json
$verificationExit = $LASTEXITCODE
if ($verificationExit -ne 0) {
    throw "STOP: ledger verification failed with exit code $verificationExit"
}
```

The expected report is three orders totaling 5,400 cents. Save the emitted 64-character Secure Hash Algorithm 256-bit (SHA-256) digest and the manifest outside the protected VM, on the approved evidence workstation. Don't rely solely on a manifest restored alongside the data.

## Capture a point and introduce the failure

Perform the following sequence only on the disposable source.

1. Stop all application invocations and verify that the Python process has exited. Record the three-order manifest and actual UTC time.
1. Confirm the administrator's enrollment result and both-disk scope, then open the protected backup item and select **Backup now**, using the policy-approved retention date. Record the job identifier. Don't proceed if the item is absent or protection is disabled.
1. Establish point readiness for the supported restore path before introducing the failure. A snapshot path needs a successfully created, available snapshot. A vault path needs successful transfer, successful **Validate backup**, and an available vault point. Inspect included disks and consistency, and save the point identifier and applicable job-subtask evidence. Don't choose a point merely because its display time looks close, and don't assume that a dual-tier label selects the vault copy for restoration.

After confirming point readiness, add a legitimate later record and create the pre-failure manifest. Check each invocation immediately.

```powershell
python .\ledger.py add F:\RecoveryLab\orders.db --id A104 --cents 600
if ($LASTEXITCODE -ne 0) { throw "STOP: later order wasn't added successfully" }
python .\ledger.py manifest F:\RecoveryLab\orders.db --manifest .\expected-before-failure.json
if ($LASTEXITCODE -ne 0) { throw "STOP: pre-failure manifest creation failed" }
```

Preserve `expected-before-failure.json`, the successful `WRITE_ACK` event for the `add` of `A104`, and its command result on the independent evidence workstation before proceeding. Only then delete the designated synthetic row. The deletion and later repair have different purposes and aren't the last legitimate pre-incident write used in the loss calculation.

```powershell
python .\ledger.py remove F:\RecoveryLab\orders.db --id A102
if ($LASTEXITCODE -ne 0) { throw "STOP: synthetic deletion failed" }
```

Freeze further writes and record authorization to recover. Run the following negative control. It must report the expected record mismatch, not just any nonzero exit. A missing manifest or an interpreter error doesn't prove that the checker detected the deletion.

```powershell
$negativeOutput = & python .\ledger.py verify F:\RecoveryLab\orders.db `
    --manifest .\expected-before-failure.json 2>&1
$negativeExit = $LASTEXITCODE
$negativeOutput
if ($negativeExit -eq 0 -or
    ($negativeOutput -join [Environment]::NewLine) -notmatch
        'VALIDATION=FAIL: Record identifiers or amounts differ') {
    throw "STOP: negative control didn't produce the expected record mismatch"
}
```

Before deletion, the four-order total is 6,000 cents. After deletion, the source contains `A101`, `A103`, and `A104`, totaling 4,200 cents. The selected pre-deletion recovery point should contain the original three records, not `A104`.

## Restore without overwriting the source

Follow this portal procedure after the recovery operator confirms isolation and permission evidence.

1. Open the protected item and select **Restore VM**. Alternatively, open **Resiliency**, **Recover**, and choose **Azure Virtual machines** and the protected item.
1. Select the recorded pre-deletion recovery point. Capture its timestamp, consistency, disks, available tiers, and backed-up VM size. Confirm that the source configuration passed the Create-new eligibility review before continuing.
1. Select **Create new**, then **Create new virtual machine**. Enter a unique name such as `m09-restored-01`.
1. Select `rg-m09-restore`, the same subscription and region, `vnet-m09-restore`, and its isolated subnet. Confirm the subnet rather than accepting the first displayed choice.
1. Select the administrator-prevalidated dedicated staging account when requested. Confirm its resource ID and approved access path rather than accepting an arbitrary account. Preserve approved disk access controls and confirm capacity and quota for the backed-up VM size.
1. Select **Restore** and record request and job-start times. Monitor **Backup Jobs** and save subtask output and any errors.
1. After completion, inspect the restored VM, disks, network interface, and effective security configuration. Record two separate times: when the infrastructure restore finishes and when you can sign in to the restored guest. Record whether the operation used the snapshot or vault path, together with the evidence or explicitly labeled inference supporting that conclusion.

If direct Create-new recovery isn't supported for the source, use only the Restore-disks branch approved during readiness review. Otherwise, pause and obtain approval. Select **Restore disks**, wait for completion, and review the job results, resource names, disk identities, security type, network settings, and permissions before creating a VM.

The documented **Deploy Template** experience uses a storage SAS and fails when the staging account's **Allow storage account key access** setting is disabled. If policy blocks that experience, use an administrator-reviewed deployment from the restored managed disks that doesn't rely on that blocked template path, or stop and escalate. Don't enable Shared Key, open public network access, remove disk controls, or deploy into the source network merely to proceed.

## Prove recovered usability

Connect through the isolated management route. Verify that `F:` maps to the restored data disk and that the expected application code is present. Copy the independently preserved `expected-p1.json` from the evidence workstation to `C:\RecoveryLab\expected-p1-independent.json` in the recovery guest.

Run the following check against the restored database and copied manifest.

```powershell
Set-Location C:\RecoveryLab -ErrorAction Stop
python .\ledger.py verify F:\RecoveryLab\orders.db --manifest .\expected-p1-independent.json
$verificationExit = $LASTEXITCODE
if ($verificationExit -ne 0) {
    throw "STOP: restored ledger verification failed with exit code $verificationExit"
}
```

Require exit code zero, `INTEGRITY=ok`, `TRANSACTION=rollback_ok`, and `VALIDATION=PASS`. Require the exact three identifiers, total 5,400, and the original logical hash. Save the output and UTC completion time with the restore-source evidence or labeled inference.

The rollback probe proves the application can begin, write, read, and roll back a transaction. It intentionally leaves no persistent test order and doesn't establish crash durability of committed writes. Separately copy the independently preserved `expected-before-failure.json` to the recovery guest and reuse the negative-control pattern. That comparison must report a record mismatch because `A104` is newer than the point. Explain this expected difference instead of concealing it or accepting a missing-file error.

For local analysis, seed a separate database, preserve its manifest, and use another copy to introduce the later write and deletion. Label any copy operation **Local simulation, not cloud recovery**. Analyze the fixture timeline in [Measure recovery outcomes](xref:learn.devrel.azure-virtual-machine-backup-recoverability.measure-recovery-outcomes) for service timing. Don't substitute local copy speed for an Azure restore measurement.

If a separately approved exercise must demonstrate recovery when no snapshot is available, choose an appropriate existing vault-only point or another explicitly supported vault-based workflow and measure that path separately. Reassess the point's content and RPO. Don't delete protected snapshots, reduce retention, change regional scope, or weaken access controls to force a different source. This module doesn't require a second live restore.
