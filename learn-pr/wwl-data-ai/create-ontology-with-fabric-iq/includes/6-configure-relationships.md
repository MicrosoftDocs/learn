::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=dc5289da-4f94-4a17-9b3e-81ed8a4ec910]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Entity types bound to data give you facts about individual business concepts—a hospital, a department, a patient. Relationship types define the connections between them: a department *belongs to* a hospital. A patient *is admitted to* a room, equipment *monitors* a patient.

Like entity types, relationship types need two things: a definition (which entity types can connect) and a binding (which table and columns contain the actual connection data). Without the binding, the relationship exists as a definition but can't be queried.

This unit covers both: how to create relationship types that model your business connections, and how to configure them with the source data that makes those connections queryable.

## Understand relationship types and configuration

A relationship type establishes the possibility of a connection between entity types. For example, a *monitors* relationship type says vital sign equipment can monitor patients. But the type doesn't specify which equipment monitors which patients—that requires binding to source data.

When you generate an ontology from a semantic model, Fabric creates relationship type definitions from the semantic-model relationships. These definitions still need data configuration to connect specific records. When you build manually, you define both the relationship types and their bindings.

Configuration can match a property in the origin source directly to a property in the target source, or use a mapping table that records pairs of connected entities.

## Create relationship types

Creating a relationship type starts by defining the connection you want to model. You give the relationship a name that describes the connection—like *monitoredBy* or *contains* or *admittedTo*—and specify which two entity types it connects.

For a relationship showing which vital sign equipment monitors which patients, VitalSignEquipment is the **Origin entity type** and Patient is the **Target entity type**. A unique name such as *monitors* expresses the connection in that direction and becomes part of the business vocabulary.

After you create the relationship type, you need to decide which source properties establish the connection. The choice depends on where the relationship information lives, not on whether the ontology was created manually or generated.

## Choose direct matching or a mapping table

For Hospital *contains* Department, the hospitals source has HospitalId and the departments source has the HospitalId of each department's parent hospital. Direct matching connects HospitalId in the origin source to HospitalId in the target source, with **Use mapping table?** off.

This direct path is appropriate because the department records already carry the parent hospital identifier. You don't need a new table just to repeat that connection. A foreign-key column in the source can supply the matching values even when it isn't the target entity's own key.

With **Use mapping table?** on, a table selected from the OneLake catalog supplies the connections. Its origin and target columns map to properties of the two entity types.

For example, the departments table can serve as a mapping table using HospitalId for Hospital and DepartmentId for Department. Each row then identifies the two records that connect. A hospitals table containing only HospitalId can't supply both endpoints.

Direct matching suits connections already encoded in entity source columns. A mapping table suits connections stored as explicit pairs, such as a separate equipment-assignment table.

For Patient and Room, CurrentRoomId in the patient source matches RoomId in the room source, not PatientId. The columns need compatible data types and values that identify the same business concept; matching names alone don't establish a valid connection.

With entity properties bound and relationships configured, the ontology represents both business facts and their connections. The next unit explains how those bindings appear as populated instances.

::: zone-end
