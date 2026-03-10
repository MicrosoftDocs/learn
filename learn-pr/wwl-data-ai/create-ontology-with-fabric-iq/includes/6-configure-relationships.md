Entity types bound to data give you facts about individual business concepts—a hospital, a department, a patient. Relationship types define the connections between them: a department *belongs to* a hospital. A patient *is admitted to* a room, equipment *monitors* a patient.

Like entity types, relationship types need two things: a definition (which entity types can connect) and a binding (which table and columns contain the actual connection data). Without the binding, the relationship exists as a definition but can't be queried.

This unit covers both: how to create relationship types that model your business connections, and how to configure them with the source data that makes those connections queryable.

## Understand relationship types and configuration

A relationship type establishes the possibility of a connection between entity types. For example, a *monitors* relationship type says vital sign equipment can monitor patients. But the type doesn't specify which equipment monitors which patients—that requires binding to source data.

When you generate your ontology from a semantic model, the system creates relationship type definitions automatically based on the model's relationships. However, these are just the definitions—they're not yet bound to source data. When you build your ontology manually, you create both the relationship type definitions and their bindings yourself.

Regardless of how you created your ontology, every relationship type requires configuration. Configuration binds each relationship type to a source table that contains the keys identifying which specific entities connect to each other.

## Create relationship types

Creating a relationship type starts by defining the connection you want to model. You give the relationship a name that describes the connection—like *monitoredBy* or *contains* or *admittedTo*—and specify which two entity types it connects, as shown below.

:::image type="content" source="../media/add-relationship-type.png" alt-text="Screenshot showing the Add relationship type dialog showing the name field and source and target entity type dropdowns." lightbox="../media/add-relationship-type.png":::

The source and target entity types must be different. For a relationship showing which vital sign equipment monitors which patients, VitalSignEquipment is the source entity type and Patient is the target entity type. The relationship name you choose becomes part of how users query and understand the ontology.

After you create the relationship type, the next step is configuration—specifying the source table and mapping its columns to the entity type keys that identify each end of the relationship.

## Configure relationship source data

Configuration connects the relationship type definition to actual data. Under **Source data**, select the workspace, lakehouse, and table that contains identifying information for both entity types—each row references both a source entity and a target entity by ID.

For a *contains* relationship between Hospital and Department, the source table is departments. This table contains HospitalId (identifying which hospital each department belongs to) and DepartmentId (identifying each department), so each row can link a specific hospital to a specific department.

After selecting the table, select a **Source column** for each entity type—the column whose values match that entity type's key. For Hospital, select HospitalId. For Department, select DepartmentId, as shown below.

:::image type="content" source="../media/relationship-configuration.png" alt-text="Screenshot of Relationship configuration with departments table and HospitalId and DepartmentId mapped to entity keys." lightbox="../media/relationship-configuration.png":::

Every row with values in both columns creates one relationship instance connecting those specific entities.

Each relationship type needs its own configuration. A Patient-Room relationship uses the patients table, mapping PatientId, and CurrentRoomId. A VitalSignEquipment-Patient relationship uses the vitalsignequipment table, mapping EquipmentId, and PatientId. The same table can serve as source for multiple relationships if it contains the necessary keys. The hospitals table couldn't serve as source for the Hospital-Department relationship—it contains only HospitalId, with no column identifying which department is connected.

With entity types bound to data and relationship types configured, your ontology is complete—definitions backed by source data, connections established between entities, ready to explore.
