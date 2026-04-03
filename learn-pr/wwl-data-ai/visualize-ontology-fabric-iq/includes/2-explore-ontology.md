The ontology you built in the previous module now contains populated data. Each entity type definition has become a collection of entity instances—real records from your lakehouse tables and eventhouse streams. Exploring how those instances appear is the first step in getting value from your ontology.

## Understand the graph structure: nodes and edges

Your ontology is a graph database—a data structure built from two fundamental elements: **nodes** and **edges**.

### Nodes represent entities

A **node** is an entity instance in your graph. When you defined the Patient entity type and bound it to your lakehouse table, each row in that table became a node in the graph. Patient ID 12345 is a node. The Cardiology department is a node. Room 301 is a node.

Nodes have:
- **Labels** (the entity type, like Patient or Department)
- **Properties** (attributes like fullName, departmentName, or roomNumber)
- **A unique identity** (the key property value that distinguishes this instance from all others)

In graph terminology, your "entity instances table" is showing you a list of nodes of one type.

### Edges represent relationships

An **edge** (also called a relationship) is the connection between two nodes. When you defined the "assigned_to" relationship between Patient and Room, you created the potential for edges. When Patient 12345 checks into Room 301, that specific connection becomes an edge in the graph.

Edges have:
- **A direction** (Patient → Room, not Room → Patient)
- **A type** (assigned_to, located_in, monitors)
- **Source and target nodes** (the two instances being connected)
- Optionally, **properties** (like admissionDate or transferReason)

The "relationship graph" you see in the overview is a visual representation of nodes and edges: entity instances appear as circles (nodes), and the lines connecting them are the relationships (edges).

### Why this matters

Traditional relational databases answer questions by joining tables. Graph databases answer questions by traversing edges between nodes. When you ask "Which patients are in Cardiology?", the graph query starts at the Cardiology node, follows "has" edges to Room nodes, then follows "assigned_to" edges to Patient nodes. No joins. No foreign key lookups. Just following the connections that already exist.

This graph structure is what makes your ontology powerful—and it's what you're about to explore.

## Open the entity type overview

The entity type overview is your starting point for exploring any entity type's instances and connections. To open it, select an entity type in the **Entity Types** pane—for example, **Department**—and then select **Entity type overview** from the ribbon.

The overview page shows three sections: the relationship graph tile, property charts, and entity instances table for the Department entity type. If you previewed the ontology at the end of the previous module, you recognize this experience. With fully bound data, the entity instances table now shows the actual departments from your lakehouse: Cardiology, ICU, Surgical, and Emergency.

:::image type="content" source="../media/department-overview.png" alt-text="Screenshot of the Department entity type overview showing the relationship graph tile, property charts, and entity instances table with Cardiology, ICU, Surgical, and Emergency departments.":::

The entity instances table reflects the records in your bound data source. Each row is one department from the Departments table in your lakehouse. The columns correspond to the properties you defined: DepartmentId, DepartmentName, Floor, and HospitalId.

## Verify data population

The instances table confirms your data binding is working. As you explore, check a few things:

- **Row count matches expectations**: The Lamna Healthcare dataset has five departments. Five rows means the binding is pulling the full table.
- **Property values look correct**: DepartmentName values should be recognizable business terms, not technical column names or raw IDs.
- **Key values are present**: HospitalId links each department to its parent hospital. Missing or inconsistent values here may affect how the Hospital–Department relationship populates.

If the table is empty, the most common cause is a mismatch between the entity type key and the actual values in the source table. Return to the data binding configuration and verify the key property maps to the correct source column.

## Explore an entity instance

The entity instances table is a gateway to individual records. Select any row to open the instance view for that specific instance.

The instance view shows all property values for that record—the actual data from your lakehouse. For the Cardiology department, you see DepartmentId: 3, DepartmentName: Cardiology, Floor: 2, and HospitalId: 1.

Below the properties, the instance view displays a scoped relationship graph: a view of this department's actual connections to other entities in the ontology. You see which hospital it belongs to—the Hospital instance with HospitalId 1—and which rooms are part of this department—the Room instances with DepartmentId 3.

:::image type="content" source="../media/department-instance.png" alt-text="Screenshot of the Cardiology department instance view showing property values and a scoped relationship graph with connections to the parent Hospital instance and three Room instances.":::

This instance graph is the ontology in action. The relationship configuration you defined—Department located in Hospital, Department has Room—now shows actual connections between real records, not just concept definitions. The Cardiology department isn't an abstract definition; it's a connected node in your organization's data graph.

With instance-level exploration covered, you're ready to expand the relationship graph to see all entity instances and their connections together.
