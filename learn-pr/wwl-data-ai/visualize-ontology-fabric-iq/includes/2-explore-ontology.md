The entity type details view lets you explore your ontology data: the records from your sources bound to your entity types. In this unit, you learn how to view entity instances and inspect their property values.

## Distinguish definitions from data

An **entity type** defines a business concept, such as Room, with properties such as `RoomId`, `RoomNumber`, and `RoomType`. An **entity instance** is a particular occurrence, such as room ICU-301. The binding connects the definition to the source fields that supply those values.

Ontology stores business definitions and bindings. It isn't itself a graph database or a general-purpose query engine. Consuming experiences use its context and execute against the appropriate data source. An optional materialized graph provides another way to explore connected instances.

The home configuration canvas shows entity definitions and their relationships, not individual patient or room records. Entity type details provides access to the instances supplied by a binding.

## Open entity type details

You can open entity type details from **Explorer** by selecting an entity type, such as **Rooms**, and choosing **View Entity Type details** from the ribbon. The details view opens on **Configure**. This tab shows the definition, including properties, bindings, and relationship types.

The **Instances** tab shows the instances associated with that entity type and their static property values. You can inspect and configure definitions without binding data, but populated instances require a completed data binding.

For a lakehouse-backed Rooms entity type, an instance can show `RoomId: 8`, `RoomNumber: SUR-202`, `DepartmentId: 3`, and `RoomType: Post-Op`. Those values describe one room. They don't establish the department's name or identify its patients until you follow the relevant relationships.

With instance-level properties covered, you can explore how eligible instances connect through an optional materialized graph.
