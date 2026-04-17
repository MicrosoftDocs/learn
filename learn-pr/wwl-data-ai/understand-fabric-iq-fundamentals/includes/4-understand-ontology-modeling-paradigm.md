Ontology modeling in Fabric IQ defines business concepts independent of specific analytical use cases. This unit explains how the ontology approach differs from traditional analytical data modeling.

## Recognize business concepts over table schemas

Traditional analytical data modeling designs tables optimized for specific reporting and analytics needs. You start with questions like "What reports do we need to support? Which dimensions and facts are required?" and design star schemas or dimensional models accordingly.

Ontology modeling inverts this. You start by asking: "What are the core concepts in our business? How do they relate? What facts matter about each concept?" Analytical considerations come after you've captured business meaning.

Consider a scenario where you're working with healthcare data. A traditional approach might create PatientDim, RoomDim, and DepartmentDim tables in a star schema with abbreviated column names like "pt_id," "rm_num," and "dept_id." When different teams build separate data marts independently, they may develop overlapping but inconsistent definitions of "patient" or "department."

With ontology modeling, you define Patient, Room, and Department as entity types using business language: PatientName, DateOfBirth, RoomNumber, DepartmentName. You establish named relationships: Department has Room, Room assigned to Patient. These definitions become the foundation for AI agents and graph queries that need consistent business context.

:::image type="content" source="../media/ontology-modeling.png" alt-text="Diagram showing Hospital, Department, Room, and Patient entities connected by labeled relationships in Fabric IQ." border="false":::

This ontology model shows Hospital, Department, Room, and Patient entities connected by named relationships ("contains", "has", "assigned_to") in Fabric IQ's graph interface. Unlike foreign keys that require JOIN statements, these relationships have explicit names and can be queried directly.

## Model entity types as reusable concepts

**Entity types** are conceptual definitions that you create before binding them to data, unlike database tables that combine schema definition with data storage.

An entity type standardizes the name, description, identifiers, and properties for a business concept. By defining what "patient" means at the entity type level—including which properties exist and what the identifier is—you create a definition that can then be bound to a data source. This separates the conceptual model from the underlying table structure.

## Define properties with semantic meaning

**Properties** provide a way to standardize names and data types at the conceptual level, which you then map to actual columns during data binding.

Traditional database columns often vary: "temp," "temperature," "temp_reading," or "body_temp" for the same concept across different tables. Each table defines its own column names independently.

In ontology modeling, you define a standard property name like "Temperature" at the entity type level. When you bind to data, you map this property to whatever column name exists in your table - whether it's "temp," "temperature," or "body_temp." Tools querying the ontology always see the standardized "Temperature" property, regardless of the underlying column name.

:::image type="content" source="../media/vital-sign-properties.png" alt-text="Screenshot of VitalSign entity type showing properties including HeartRate, OxygenSaturation, RespiratoryRate, and Timestamp in Fabric IQ ontology editor." border="false":::

This VitalSign entity type shows standardized property names like HeartRate, OxygenSaturation, and RespiratoryRate. When bound to data, these properties map to the actual column names in the source table.

Properties can be marked as identifiers to signal which values uniquely identify entity instances. Marking PatientID as an identifier establishes that this value uniquely represents each patient, ensuring consistent entity resolution across data sources.

## Establish relationships between concepts

**Relationships** in ontology modeling are named, directional connections between entity types. Unlike foreign keys that are implicit until you write JOIN statements, these relationships are explicit concepts that tools can query and visualize.

Consider a scenario where a "Department has Room" relationship links hospital departments to their physical spaces. A "Room assigned to Patient" relationship tracks current patient assignments. You can traverse these relationships in the graph interface or query them using GQL to perform dependency analysis—when you need to find all patients in a specific department, you can traverse "Department has Room" followed by "Room assigned to Patient."

## Bind concepts to data without duplication

Data binding connects your entity types to actual data sources without copying or moving data. The data stays in place—in lakehouse tables or eventhouse streams in OneLake. The ontology creates a semantic layer that references this data.

Consider a scenario where a Patient entity type binds to a lakehouse table containing demographic information, while the VitalSign entity type binds to an eventhouse stream providing real-time vital signs. Each entity type binds to its appropriate data source using entity-specific keys. When you query across these concepts, the ontology federates queries across the lakehouse and eventhouse, returning integrated results without having moved any data.

:::image type="content" source="../media/data-binding.png" alt-text="Screenshot showing data binding configuration with timeseries properties mapped from eventhouse source columns to entity type properties in Fabric IQ." border="false":::

This data binding configuration shows timeseries properties from an eventhouse mapped to entity type properties. Source columns (HeartRate, OxygenSaturation, RespiratoryRate) bind to standardized property names without copying data—the ontology references the eventhouse data directly.

Data binding creates a semantic layer over your existing data sources without duplication, enabling AI agents to query using business terminology instead of table-specific column names.
