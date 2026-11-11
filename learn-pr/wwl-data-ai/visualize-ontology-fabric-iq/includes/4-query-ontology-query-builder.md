The materialized graph contains the eligible connected records, but a graph of every assignment can hide the answer. Visual query controls let you select the relationship path and filter the records that matter.

## Focus a queryset on the business question

**Explore graph** opens a **queryset**. A queryset can contain multiple named queries and can be saved as one Fabric item. These queries run against the materialized graph, not as arbitrary live joins across every source bound to the ontology.

The **Components** pane, opened with the puzzle-piece icon, lists the nodes and edges available in that graph. You can select the relevant entity and relationship types to bring onto the canvas. **Add a node** provides another way to choose a starting type and expand its connections.

For the ICU equipment question, the relevant types are Departments, Rooms, Patients, and VitalSignEquipment, with `inDepartment`, `admittedTo`, and `assignedToPatient` connecting them.

## Build a constrained path query

The **Path query** pane provides a visual way to choose a start node, direction, and end node, with property filters to narrow the search. Minimum and maximum hop counts control how many relationships a path can traverse.

:::image type="content" source="../media/path-query.png" alt-text="Screenshot from Microsoft documentation showing the Path query pane with start and end node filters, direction, and minimum and maximum hop counts.":::

For example, consider the question "Which patients occupy rooms in the Intensive Care Unit?" In the hospital example, Patient → Room → Department is a two-hop path. A query can start at Patient and end at Department, following the direction of `admittedTo` and `inDepartment`. A filter on the department's `DepartmentName` property selects `Intensive Care Unit`.

This path needs two hops: one from Patient to Room, and one from Room to Department. A one-hop limit can't reach Department. Starting at Department instead requires traversal in the opposite direction.

**Run** renders results in the query result canvas and path results pane. The returned paths show the connections between the matching instances.

Room type and department name aren't interchangeable filters. Critical Care describes a room classification. If the requirement names a department, filter `DepartmentName` and preserve the path to that department rather than assuming every Critical Care room belongs to it.

The **Queries** pane stores named queries. Saving the queryset persists those queries for later use.
