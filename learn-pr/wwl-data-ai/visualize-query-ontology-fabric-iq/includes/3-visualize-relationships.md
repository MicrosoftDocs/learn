Seeing entity instances in a table confirms your bindings are working. Seeing how those instances connect across your business domain is where the ontology becomes genuinely useful—it replaces multi-table queries with visual traversal through named relationships.

## Expand the relationship graph

From any entity type overview page, select **Expand** on the relationship graph tile. The full graph view opens in Graph in Microsoft Fabric.

:::image type="content" source="../media/relationship-graph-expand.png" alt-text="Screenshot of the relationship graph tile with the Expand button highlighted on the Department entity type overview page.":::

The graph view initially shows entity type nodes—representations of your entity types and the relationship types connecting them. No instance data has loaded yet.

## Run the default query

To see actual entity instances in the graph, select **Run query** from the Query builder ribbon. The default query retrieves the current entity type and all entities one relationship hop away.

:::image type="content" source="../media/relationship-graph-instances.png" alt-text="Screenshot of the relationship graph after running the default query, showing department instances including Cardiology and ICU connected to room instances by labeled relationship edges.":::

After the query runs, type nodes become clusters of real instances. Starting from the Department entity type, each department appears as a labeled node: Cardiology, ICU, Surgical, and Emergency. Connected Room instances appear as separate nodes, with edges showing which rooms belong to each department—Room 201, Room 202, and Room 203 connecting to the Cardiology node; Room 301 and Room 302 connecting to ICU.

These are the relationships you configured—Department has Room—now displaying actual connections between real data records. The edges aren't constructed at query time with JOINs; they're the relationship bindings you defined, materialized as first-class graph connections.

## Select nodes to view details

The graph is interactive. Select any node to view its property values in a side panel. Selecting the Cardiology department node shows DepartmentId: 3, DepartmentName: Cardiology, Floor: 2, and HospitalId: 1. Selecting a Room node shows its RoomNumber, RoomType, and Capacity values.

This node-level inspection helps you verify both data quality and relationship configuration. If a department node shows no connected rooms when you expect some, check the relationship binding—the source column for the Department key in the relationship's source table may not be matching correctly.

## Navigate connected business concepts

The graph view that opens from the Department entity type shows one hop: departments connected to rooms. The full Lamna Healthcare ontology spans more hops. Rooms connect to Patients (via the Room has Patient relationship). Patients connect to VitalSignEquipment (via the VitalSignEquipment monitors Patient relationship).

Following the path Department → Room → Patient answers "Which patients are currently in Cardiology?" without writing a single JOIN. Following the extension to VitalSignEquipment answers "Which monitors are active for Cardiology patients?" The graph traverses the named relationships you built—doing the relational work implicitly.

In the next unit, you use the Query builder to add filters and select specific components so you can ask those targeted questions directly, rather than visually exploring every connected node in the graph.
