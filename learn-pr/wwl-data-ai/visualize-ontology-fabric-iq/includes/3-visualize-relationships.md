You can inspect individual records, but the hospital question requires the connections between them. An optional materialized graph makes eligible instances and their relationships available for visual traversal.

## Read nodes and edges

In a materialized graph, each entity instance becomes a **node** and each relationship becomes an **edge**. Room ICU-301 is a node. A patient admitted to that room is another node. The `admittedTo` edge connects those specific instances.

Nodes have a type label, properties, and an identity based on the entity type key. Edges have a relationship type, a direction, and source and target nodes. For example, Patient → Room through `admittedTo` differs from Room → Department through `inDepartment`.

The Lamna Healthcare ontology connects departments to rooms, rooms to patients, and patients to equipment through named relationships. Following these connections answers which equipment is assigned to patients in the Intensive Care Unit. These assignments don't establish whether equipment is actively taking measurements.

## Select eligible data for the graph

Graph materialization loads a selected projection of bound data into Graph in Microsoft Fabric. It isn't automatic or required for an ontology to work. It supports questions that depend on the relationship path rather than individual property values.

For the hospital question, the projection needs the department, room, patient, and equipment definitions and their connecting relationships.

Before you materialize the selection, check these conditions:

- Each selected entity type has an entity type key.
- Entity types and relationships have data bindings and don't use multiple backing tables.
- Sources are supported Delta tables from lakehouses or mirrored databases. Semantic-model-backed and eventhouse-backed entities aren't supported for graph projection.

An equipment entity with a single eligible lakehouse binding can participate in the assignment path. An ontology binding can be valid even when it isn't supported by graph; eventhouse-backed readings don't become graph data.

## Materialize and open the graph

On the ontology home ribbon, **Manage graph** opens **Configure Graph**, where you can select entities and relationships for the projection. The **Status** column indicates eligibility, and an **Ineligible** status explains why an item can't be selected.

The **Projection Summary** shows the selection before **Materialize** loads its data. Loading can take several minutes to several hours, depending on volume. A schema preview before materialization shows definitions, not loaded instance results.

Once materialization completes, **Explore graph** opens the graph queryset view within ontology. You can also open the graph model from the workspace. Manage the entities and relationships included in the projection through the ontology's **Manage graph** action.

## Check freshness before drawing conclusions

A materialized graph isn't a guarantee of live source values. Source records can change after graph ingestion. If a patient moves to another room, rerunning a query against an unrefreshed graph can still show the previous assignment.

The graph model's **Schedule** panel in the workspace provides **Refresh now** and recurring refresh options. Refreshing the graph loads updated source data for subsequent queries.

For the supported sources, eligibility rules, and materialization workflow, see [Materialize an ontology graph](/fabric/iq/ontology/how-to-use-ontology-graph).
