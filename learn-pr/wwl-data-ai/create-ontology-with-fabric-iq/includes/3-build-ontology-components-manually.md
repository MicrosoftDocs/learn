Building an ontology starts with defining its fundamental building blocks. This unit focuses on ontology structure. You learn to create entity types representing business concepts and relationship types showing how they connect. Creating an ontology manually involves three steps:

1. Define entity types—name each business concept, add properties, and set a key
2. Define relationship types—connect entity types with named, directional relationships
3. Bind to data—connect entity types and relationships to OneLake sources

This unit covers steps 1 and 2. Later units show how to bind these definitions to data sources in OneLake.

Creating ontology components manually gives you complete control over business vocabulary from the start. You build intentionally, thinking through each entity type's meaning, which properties matter, and how entities relate. This approach reveals how your business domain maps to ontology structure. The next unit shows how to generate an ontology from an existing semantic model, automating much of this process. Understanding manual creation first reveals how ontology structure works.

## Create entity types

The first step in creating an ontology manually is defining entity types—the business concepts in your domain.

Entity types represent business concepts—the things your organization works with. In a healthcare scenario, this might include Hospital, Department, Room, and Patient. Each entity type needs properties describing its characteristics and a key uniquely identifying each instance.

### Define the entity type

To create an entity type, select **Add entity type** from the ontology ribbon. You enter a business-friendly name that matches how people in your organization talk about the concept.

A hospital administrator thinks "Hospital"—not a technical table name. A care coordinator thinks "Patient"—not a database record. Choose names that make sense when spoken aloud: "Hospital contains Department" or "Patient assigned to Room."

:::image type="content" source="../media/create-entity.png" alt-text="Screenshot of ontology editor with Add entity type button in ribbon and Entity Types pane on left." lightbox="../media/create-entity.png":::

The ribbon at the top contains all ontology actions. The Entity Types pane on the left lists each entity type as you create them, and the canvas in the center is where you see entity types and relationships laid out visually.

Enter "Hospital" as the entity type name and select Add Entity Type. The system creates the entity type definition and displays it in the Entity Types pane.

### Add properties to the entity type

After creating the entity type, define its properties. Properties describe the entity's characteristics. A Hospital entity might have HospitalName (string), City (string), and State (string). A Department entity might have DepartmentName (string), Floor (integer), and DepartmentId (integer).

To add properties to the entity, select **Add properties** to open the properties configuration dialog. The dialog displays a table where you specify each property's name, data type, and property type, as shown below.

:::image type="content" source="../media/entity-properties-unfilled.png" alt-text="Screenshot of the Add properties dialog showing empty table with columns for Property name, Data type, and Property type, with Save button at bottom." lightbox="../media/entity-properties-unfilled.png":::

## Define property characteristics

For each property, you make three critical decisions:

- **Property name** — Describes what the property represents. Use specific terms like `HospitalName` rather than generic terms like `Name`, so queries are unambiguous when the same concept appears across multiple entity types such as `HospitalName`, `DepartmentName`, `PatientName` are each clearly distinct. Property names often match the column names in your source data—when your source tables already use business-friendly names, you can use the same name for both the property and the source column. Property names must be 1–26 characters, contain only alphanumeric characters, hyphens, and underscores, and start and end with an alphanumeric character.

- **Data type** — Defines what kind of values the property holds. String properties store text like names and addresses. Integer properties store whole numbers like floor numbers or patient counts. The data type must match the source data type when you bind the ontology to data sources later. Binding connects your ontology definitions to actual data in lakehouse tables or eventhouse streams, populating entity instances with real values.

- **Property type** — Defines whether the property represents static or time series data. Static properties describe attributes that change infrequently—a hospital's name, a department's floor number, a patient's date of birth. Time series properties represent continuously arriving observations, like vital signs readings that arrive every few seconds from monitoring equipment. All of Lamna Healthcare's entity types in this unit use static properties. You'll encounter time series properties in a later unit when you add the VitalSignsReadings entity type and connect it to eventhouse streaming data.

## Add properties to entity type

You add properties for the Hospital entity type—HospitalName (string, static), City (string, static), State (string, static), and HospitalId (integer, static)—as shown in the image below. You select **Save** to create the properties.

:::image type="content" source="../media/hospital-properties.png" alt-text="Screenshot of Add properties dialog with Hospital properties: HospitalName, City, State, and HospitalId." lightbox="../media/hospital-properties.png":::

Each row in the dialog becomes a property on the Hospital entity type. Once saved, the properties appear in the Entity type configuration pane on the right.

### Configure the entity type key

Every entity type needs a key identifying each unique instance of that entity. An instance represents one real-world occurrence of the entity type. The Hospital entity type represents the concept of hospitals, while individual instances represent specific hospitals—the hospital with HospitalId 1, the hospital with HospitalId 2, the hospital with HospitalId 1001. Similarly, the Patient entity type represents the concept of patients, while instances represent specific patients—PatientId 101, PatientId 102, PatientId 103.

The key tells the system how to identify and distinguish these instances. Without a key, the system can't tell whether incoming data describes a new hospital or updates for an existing one. The key property must contain unique values—no two hospitals share the same HospitalId, no two patients share the same PatientId.

To configure the entity type key, select **Add entity type key** in the Entity type configuration pane. Choose one or more properties that uniquely identify instances. For Hospital, HospitalId uniquely identifies each hospital instance. For Department, DepartmentId uniquely identifies each department instance. For Patient, PatientId serves this purpose.

Keys can only use string or integer properties—other data types don't work as identifiers. Keys are required before you can bind the entity type to data sources. Without a key, the system can't create instances from your source data.

:::image type="content" source="../media/configured-properties.png" alt-text="Screenshot of Hospital entity type configuration showing properties list and HospitalId configured as the key." lightbox="../media/configured-properties.png":::

You repeat this pattern for each business concept in your domain, for example, Department, Room, Patient. Each entity type gets business-friendly properties, appropriate data types, and a key, for instance,  identification.

## Create relationship types

The second step in creating an ontology manually is defining relationship types—connections between entity types.

Entity types alone don't capture how your business operates. In a hospital setting, for example, hospitals contain departments, departments contain rooms, patients occupy rooms. Relationship types describe these connections, turning isolated entity definitions into a connected business model.

### Define the relationship structure

To create a relationship type, select an entity type on the canvas (the visual workspace showing your entity types), then select **Add relationship type** from the ribbon. The dialog asks you to identify which two entity types connect and what the relationship means.

For a relationship from Hospital to Department, choose Hospital as the source entity and Department as the target entity. The direction matters—"Hospital contains Department" describes how hospitals organize, while "Department belongs to Hospital" describes the reverse perspective. Choose the direction that matches how people ask questions about your business.

:::image type="content" source="../media/relationship-structure.png" alt-text="Screenshot of Add relationship dialog with Hospital as source and Department as target." lightbox="../media/relationship-structure.png":::

Name the relationship type with business vocabulary that reads naturally: "Hospital contains Department" makes sense when you read source, relationship name, target together. Other examples: "Department has rooms" for Department to Room, or "Room has Patient" for Room to Patient. The name should describe what the relationship means, not just that a relationship exists.

Enter "contains" as the relationship name (because Hospital contains Department). Select Add to create the relationship type.

### Review the relationship configuration

After creating the relationship type, the Relationship configuration pane appears to show the relationship's structure. You see the source entity (Hospital), target entity (Department), and the relationship name (contains).

The pane doesn't show a data binding yet—that configuration comes later when you connect the ontology to data sources. For now, you define the conceptual structure: which entities connect and what those connections mean.

Relationship direction matters for how people navigate and query the ontology. When someone asks "which departments does this hospital have," they're following the relationship from Hospital to Department. When someone asks "which hospital does this department belong to," they're following the reverse direction. Define relationship types based on the questions your users ask.

You repeat this process for each relationship in your business domain. For a hospital scenario, you'd define Department "has rooms" Room to show how departments organize their spaces, and Room "has Patient" Patient to show patient assignments. Each relationship captures one aspect of how your organization operates.

At this stage, relationship types are defined as conceptual connections—which entities relate and what those connections mean using business vocabulary. Later, when you configure data bindings, the system populates these relationships with actual data showing specific connections between entity instances. Next, you learn how to generate an ontology from an existing semantic model, automating this entire process. The system creates entity types, properties, keys, and relationship types from an existing semantic model.
