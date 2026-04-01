The ontology you built in the previous module now contains populated data. Each entity type definition has become a collection of entity instances—real records from your lakehouse tables and eventhouse streams. Exploring how those instances appear is the first step in getting value from your ontology.

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
