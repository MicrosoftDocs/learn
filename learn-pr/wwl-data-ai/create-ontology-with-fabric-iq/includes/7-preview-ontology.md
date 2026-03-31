With entity types bound to data and relationships configured, the ontology is ready to explore. Selecting an entity type and choosing **Entity type overview** from the ribbon opens the preview experience—a dashboard showing how your bound data looks as a populated ontology.

## Explore the entity type overview

The entity type overview shows three sections for the selected entity type.

**Relationship graph**—a visual map showing how this entity type connects to others. For Room, you can see connections to VitalSignEquipment, Department, and Patient—confirmation that your relationship configuration worked.

**Property charts**—bar charts showing the distribution of property values across all instances. For Room, charts show the spread of RoomNumber, DepartmentId, and RoomType values across all 10 room instances.

**Entity instances table**—the list of actual instances populated from your bound data, showing RoomId, RoomNumber, DepartmentId, and RoomType for each room. Selecting any instance opens its detail view, showing that room's property values and its connections to other entities.

:::image type="content" source="../media/preview-experience.png" alt-text="Screenshot of Room entity overview with relationship graph, property charts, and entity instances table." lightbox="../media/preview-experience.png":::

> [!NOTE]
> When you first open the preview experience, you'll see an **"Updating your ontology"** message while the system processes your data in the background. After 1-2 minutes, refresh your browser to display the entity type overview.

The entity type overview confirms your ontology is working—definitions are populated with real data and connected across entity types. The next module covers how to query and visualize this data using the Query builder and relationship graph.
