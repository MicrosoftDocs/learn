Your ontology's graph model is built from a snapshot of your bound data. It reflects the lakehouse tables and eventhouse streams as they existed at the last ingest. When upstream sources change—new patients are admitted, room assignments update, vital sign equipment is added—that snapshot can become stale. Understanding how the graph model stays current is essential once your ontology moves from design into operational use.

## How the graph model handles change

The graph model distinguishes between two kinds of changes: changes to the ontology's structure, and changes to the underlying data.

**Structural changes propagate automatically.** When you add a new entity type, update property definitions, or introduce a relationship type, the system re-ingests all currently bound data to reflect the new structure. You don't need to take any action—the graph stays synchronized with your ontology design as you work.

**Data changes don't.** When new rows land in your patients table, room assignments are updated in the lakehouse, or equipment records are added to the eventhouse, the graph model doesn't detect those changes automatically. The entity instances and relationship edges in the graph reflect the data as it existed at the last ingest. To surface new data, you trigger a refresh—either on demand or on a schedule.

A full refresh re-reads every bound source and rebuilds all nodes and edges. It catches new records, modified values, and deletions, but it's also a resource-intensive operation with cost implications. The practical guidance: batch upstream changes and refresh once rather than after each individual update.

## Refresh cadence

The right refresh schedule depends on how your data changes and how current your queries need to be.

For Lamna Healthcare, patient records and room assignments that update overnight through an ETL process suit a daily refresh—rebuilding the graph before clinical staff begin their shifts. Vital sign equipment assignments that change throughout the day may warrant a more frequent schedule so the graph reflects current monitoring configurations.

Three factors shape the decision:

- **Frequency of upstream changes** — How often does source data change, and does every change matter for the queries the ontology supports?
- **Cost per refresh** — Full refreshes on large datasets accumulate cost. Infrequent, well-timed refreshes are more efficient than continuous ones.
- **Tolerance for stale data** — Operational questions about current patient occupancy require near-current data. Historical trend analysis can tolerate an older snapshot.

For most scenarios, a scheduled refresh aligned with your upstream ETL cadence—supplemented by manual refreshes after significant data loads—provides the right balance. Communicating the refresh schedule to users sets expectations and prevents confusion when recent changes don't appear immediately in query results.
