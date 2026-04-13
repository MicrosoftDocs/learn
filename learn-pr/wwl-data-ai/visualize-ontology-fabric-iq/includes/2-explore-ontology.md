The ontology preview experience lets you explore your ontology data—the real records from your lakehouse and eventhouse bound to your entity types. In this unit, you'll learn how to navigate that experience: viewing entity instances and drilling into individual records to see how your graph connects.

## Understand the graph structure: nodes and edges

Your ontology is a graph database—a data structure built from two fundamental elements: **nodes** and **edges**. In the graph view below, each colored circle is a node (a real record—a patient, a room, or a department), and each labeled arrow connecting them is an edge (a relationship like `admittedTo` or `inDepartment`).

:::image type="content" source="../media/room-instance-graph.png" alt-text="Screenshot of the Fabric IQ Graph view for Rooms showing a query schema at the top with Patients admittedTo Rooms inDepartment Departments, and below it a live populated graph with colored dots representing individual patient, room, and department nodes connected by admittedTo and inDepartment edges, with Department Node and Edge annotations in red.":::

### Nodes represent entities

A **node** is a single real record represented as a point in the graph. Each entity instance—a room, a department, a patient—is a node. Room ICU-301 is a node. The Intensive Care Unit department is a node. A patient admitted to that room is a node.

Nodes have:
- **Labels** (the entity type, like Patient or Department)
- **Properties** (attributes like fullName, departmentName, or roomNumber)
- **A unique identity** (the key property value that distinguishes this instance from all others)

### Edges represent relationships

An **edge** (also called a relationship) is the connection between two nodes. The `admittedTo` relationship between Patient and Room creates edges. When a patient is admitted to Room SUR-202, that specific connection becomes an edge in the graph.

Edges have:
- **A direction** (Patient → Room, not Room → Patient)
- **A type** (assignedToPatient, admittedTo, inDepartment)
- **Source and target nodes** (the two instances being connected)
- Optionally, **properties** (like admissionDate or transferReason)

Those named connections are what make graph exploration powerful. To answer "Which patients are in the Intensive Care Unit?", the graph starts at the ICU department node, follows `inDepartment` edges to find the rooms in that department, then follows `admittedTo` edges to find the patients in those rooms—no complex queries required.

## Open the entity type overview

The entity type overview is your starting point for exploring any entity type's instances and connections. To open it, select an entity type in the **Entity Types** pane—for example, **Rooms**—and then select **Entity type overview** from the ribbon.

The overview page shows three sections: the relationship graph tile, property charts, and entity instances table for the Rooms entity type. The entity instances table shows 10 room instances from the Lamna Healthcare dataset, spanning three room types: Critical Care, Emergency, and Post-Op.

:::image type="content" source="../media/room-overview.png" alt-text="Screenshot of the Rooms entity type overview showing the relationship graph tile with Patients admittedTo Rooms inDepartment Departments, property charts for RoomNumber, DepartmentId, and RoomType, and an entity instances table listing 10 rooms including ICU-301, SUR-202, and ER-102.":::

The relationship graph tile shows Rooms at the center of two connections: Patients link to Rooms via the `admittedTo` edge, and Rooms link to Departments via the `inDepartment` edge.

The entity instances table reflects the records in the bound data source. Each row is one room from the Rooms table. The columns correspond to the properties defined on the Rooms entity type: RoomId, RoomNumber, DepartmentId, and RoomType.

## Explore an entity instance

The entity instances table is a gateway to individual records. Select any row to open the instance view for that specific instance.

The instance view shows all property values for that record—the actual data from your lakehouse. For room SUR-202, you see RoomId: 8, RoomNumber: SUR-202, DepartmentId: 3, and RoomType: Post-Op.

Below the properties, the relationship graph tile shows how this entity type connects to others in the ontology: Patients link to Rooms via `admittedTo`, and Rooms link to Departments via `inDepartment`. The property charts reflect data across all room instances.

:::image type="content" source="../media/room-instance.png" alt-text="Screenshot of the Rooms instance view for Room 8 (SUR-202) with instance properties RoomId 8, RoomNumber SUR-202, DepartmentId 3, RoomType Post-Op highlighted in a red box at the top, and below it a relationship graph tile showing Patients admittedTo Rooms inDepartment Departments, plus RoomNumber and RoomType property charts.":::

The instance properties panel at the top is the key difference from the entity type overview: it shows the specific values for this one record, not aggregates across all rooms.

With instance-level exploration covered, you're ready to expand the relationship graph to see all entity instances and their connections together.
