Ontology modeling in Fabric IQ defines business concepts independent of specific analytical use cases. This unit explains how the ontology approach differs from traditional analytical data modeling.

## Shift from report schemas to business concepts

Traditional analytical data modeling designs tables optimized for specific reporting and analytics needs. You start with questions like "What reports do we need to support? Which dimensions and facts are required?" and design star schemas or dimensional models accordingly.

Ontology modeling inverts this. You start by asking: "What are the core concepts in our business? How do they relate? What facts matter about each concept?" Analytical considerations come after you've captured business meaning.

At Contoso Offshore, a traditional approach might create ProjectDim, VesselDim, and EquipmentDim tables for separate reports, with abbreviated column names like `proj_id`, `vsl_id`, and `eq_id`. If project planning, fleet management, and maintenance teams build their own data marts, they might define "required equipment" differently.

With ontology modeling, you start with shared business concepts: projects, vessels, equipment, foundations, installation tasks, and maintenance orders. You define properties such as `ProjectName`, `VesselName`, and `PlannedStart`, and named relationships such as `Project hasTask InstallationTask`.

:::image type="content" source="../media/offshore-ontology-relationship-graph.png" alt-text="Diagram comparing a Contoso Offshore semantic model with an ontology of connected business concepts." lightbox="../media/offshore-ontology-relationship-graph.png":::

You could answer a project-impact question with SQL joins. The ontology's value is that the definitions and relationships become reusable business context, rather than logic each report or agent interprets independently.

## Model entity types as reusable concepts

**Entity types** are conceptual definitions that you create before binding them to data, unlike database tables that combine schema definition with data storage.

An entity type standardizes the name, description, identifiers, and properties for a business concept. By defining what "equipment" means, including its properties and identifier, you create a definition that you then bind to prepared data. This separates the conceptual model from the underlying table structure.

For Contoso Offshore's fictional foundation-installation scenario, you define six entity types:

| Entity type | Business meaning | Example properties |
|---|---|---|
| Project | A contracted delivery project | `ProjectId`, `ProjectName`, `ProjectDeadline` |
| Vessel | A vessel used to execute work | `VesselId`, `VesselName`, `VesselType` |
| Equipment | An individually managed piece of equipment | `EquipmentId`, `EquipmentName`, `RatedCapacityTonnes` |
| Foundation | A physical foundation to install | `FoundationId`, `FoundationDesign`, `FoundationStatus` |
| InstallationTask | A scheduled operation to install a foundation | `TaskId`, `PlannedStart`, `PlannedEnd`, `TaskStatus` |
| MaintenanceOrder | A maintenance job affecting equipment | `OrderId`, `OrderStatus`, `BlocksOperation`, `BlockedFrom`, `BlockedUntil` |

## Understand entity instances

Once an entity type is defined and data binding is applied, your ontology produces **entity instances**—concrete occurrences of each entity type populated from your bound data.

**Vessel** is an entity type. **Vessel V001** is one entity instance populated from a bound vessel record. `VesselType = "Heavy-lift installation vessel"` is a property value on that instance.

This distinction matters because tools query instances, not types. When a data agent answers "Which installation tasks are assigned to vessel V001?", it uses specific vessel and task instances and their relationship instances. Graph in Microsoft Fabric shows those entity instances as nodes and relationship instances as edges.

Each entity instance tracks the data source that created it, ensuring that when you query across lakehouses, eventhouses, and semantic models, each result carries context about where it came from.

## Define properties with semantic meaning

**Properties** provide a way to standardize names and data types at the conceptual level, which you then map to actual columns during data binding.

Source systems might use `rated_tonnes`, `capacity_t`, or `max_lift` for an equipment capacity field. Before you map these fields, confirm that they represent the same quantity and use consistent units. A rated capacity isn't the same as a current load measurement.

In your ontology, you define standard property names on Equipment and bind them to columns in prepared data. For example:

| Property | Meaning | Binding |
|---|---|---|
| `EquipmentId` | The identifier for an equipment instance | Static equipment register |
| `EquipmentName` | A descriptive equipment name | Static equipment register |
| `RatedCapacityTonnes` | Rated lifting capacity in metric tonnes | Static equipment register |
| `HydraulicTemperatureC` | A timestamped hydraulic temperature in degrees Celsius | Optional time-series equipment measurements |

Marking `EquipmentId` as the entity type key identifies each equipment instance. Source identifiers must already agree: if one system uses `E001` and another uses a different code for the same crane, reconcile those codes during data preparation. Defining a key doesn't resolve inconsistent identifiers automatically.

## Establish relationships between concepts

**Relationships** in ontology modeling are named, directional connections between entity types. Unlike foreign keys that are implicit until you write JOIN statements, these relationships are explicit concepts that tools can query and visualize.

For the offshore scenario, you define these directional relationships:

:::image type="content" source="../media/offshore-semantic-model-ontology.png" alt-text="Diagram showing a conceptual graph with six nodes: Project, InstallationTask, Vessel, Foundation, Equipment, and MaintenanceOrder." lightbox="../media/offshore-semantic-model-ontology.png":::

| Source entity type | Relationship | Target entity type |
|---|---|---|
| Project | `hasTask` | InstallationTask |
| InstallationTask | `assignedTo` | Vessel |
| InstallationTask | `installs` | Foundation |
| InstallationTask | `requiresEquipment` | Equipment |
| Vessel | `carries` | Equipment |
| MaintenanceOrder | `affects` | Equipment |

**A vessel carrying equipment is different from a task requiring it.** A fault in unrelated onboard equipment shouldn't automatically flag every task assigned to that vessel.

To investigate a dependency, follow maintenance order M001 through `affects` to crane E001. Traverse `requiresEquipment` in reverse to find task T001, then `hasTask` in reverse to find project P001. The relationship directions remain as defined even when you explore them in reverse.

## Define explicit business rules

Relationships describe how concepts connect. **Business rules** specify how you interpret those connections and property values. An ontology alone doesn't calculate schedule risk or authorize an operational decision.

Suppose task T001 installs foundation F001 tomorrow from 08:00 to 14:00, using crane E001 on vessel V001. Maintenance order M001 is open and blocks the crane from 06:00 to 18:00 on the same day. Both intervals use the same time zone.

Your query or consuming application must explicitly implement this rule:

> Flag a planned task when it requires equipment affected by an unresolved, operation-blocking maintenance order whose blocking interval overlaps the task's planned interval.

The checks include `OrderStatus`, `BlocksOperation`, and the two time intervals. For intervals that exclude their end time, overlap means `BlockedFrom < PlannedEnd` and `BlockedUntil > PlannedStart`.

The result is explainable: **Task T001 is at risk because maintenance order M001 blocks its required crane E001 throughout the planned installation window. The affected project is P001.** This finding identifies a dependency conflict, not a calculated project delay.

## Bind concepts to data without duplication

Data binding connects your entity types to actual data sources without copying or moving data. The data stays in place—in lakehouse tables or eventhouse streams in OneLake. The ontology creates a semantic layer that references this data.

You populate Contoso Offshore's ontology from prepared sources:

| Prepared source | Ontology binding |
|---|---|
| Fleet master table | Vessel instances |
| Equipment register | Equipment instances |
| Project, planning, and foundation tables | Project, InstallationTask, and Foundation instances, respectively |
| Maintenance orders table | MaintenanceOrder instances |
| Task-equipment mapping table | `requiresEquipment` relationships using `TaskId` and `EquipmentId` |
| Optional eventhouse equipment measurements | Time-series properties on Equipment, matched by `EquipmentId` |

For example, a task record containing `TaskId = T001` and `VesselId = V001` supplies the keys for an `assignedTo` relationship binding. A mapping record containing `TaskId = T001` and `EquipmentId = E001` supplies the keys for `requiresEquipment`.

Each entity type supports **one static binding** and multiple time-series bindings. If equipment master data comes from several systems, consolidate it into one prepared table first. Bind the static equipment records before you add timestamped measurements, using matching equipment identifiers. For details, see [Data binding in ontology](/fabric/iq/ontology/how-to-bind-data).

Data binding creates a semantic reference layer, not a live streaming connection. When new rows arrive in a source, a manual graph refresh is needed before they appear as entity instances in the ontology.

Check data freshness before you use an answer to assess installation readiness. The ontology gives maintenance and project planning shared business meaning, but it doesn't replace data preparation, refresh management, or operational judgment.
