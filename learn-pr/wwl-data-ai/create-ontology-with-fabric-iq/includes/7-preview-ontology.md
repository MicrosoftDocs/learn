::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=47d6fd32-7831-451f-9350-069cc9de2966]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

With entity types bound to data and relationships configured, the ontology is ready to explore. Entity type details show how source records populate your business concepts.

## Explore entity instances

The **View Entity Type details** command opens an entity's details. Its **Instances** page displays populated instances and their static property values. For Room, these include RoomId, RoomNumber, DepartmentId, and RoomType.

The ontology canvas shows definitions and modeled connections; **Instances** shows the associated records.

The **Configure** page shows property bindings and their source mappings. Together, these views help you distinguish an ontology definition from the data it represents.

## Understand relationship exploration

A relationship definition on the canvas describes which entity types can connect. Exploring those connections as a graph of actual records requires a separate, optional materialized graph.

**Manage graph** identifies eligible entities and relationships for materialization. Eligibility depends on keys, bindings, and supported sources, so a valid ontology isn't necessarily eligible in its entirety. **Explore graph** opens the materialized data for visual queries. Graph data requires refresh after source changes.

Your ontology now connects business definitions to source records. The next module covers [graph materialization](/fabric/iq/ontology/how-to-use-ontology-graph), visualization, and visual queries in more detail.

::: zone-end
