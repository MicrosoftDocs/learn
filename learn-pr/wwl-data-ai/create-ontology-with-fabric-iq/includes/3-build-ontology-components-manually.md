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

:::image type="content" source="../media/create-entity.png" alt-text="Screenshot of the ontology editor with the Add entity type button and Entity Types pane." lightbox="../media/create-entity.png":::

The ribbon at the top contains all ontology actions. The Entity Types pane on the left lists each entity type as you create them, and the canvas in the center is where you see entity types and relationships laid out visually.

Enter "Hospital" as the entity type name and select **Add Entity Type**. The system creates the entity type definition and displays it in the Entity Types pane.

### Add properties to the entity type

After creating the entity type, define its properties. Properties describe the entity's characteristics. A Hospital entity might have HospitalName (string), City (string), and State (string). A Department entity might have DepartmentName (string), Floor (integer), and DepartmentId (integer).

To add properties, select the entity type name in the **Explorer**, then select **View entity type details** from the top ribbon. The **Configure** page opens. Expand **Manage property bindings** and select **Add properties**. The dialog asks you to specify each property's name and property type, as shown below.

:::image type="content" source="../media/entity-properties-unfilled.png" alt-text="Screenshot of the entity type configuration showing where to add properties." lightbox="../media/entity-properties-unfilled.png":::

## Define property characteristics

For each property, you make two decisions:

- **Property name** — Describes what the property represents. Use specific terms like `HospitalName` rather than generic terms like `Name`, so queries are unambiguous when the same concept appears across multiple entity types—`HospitalName`, `DepartmentName`, `PatientName` are each clearly distinct. Property names often match the column names in your source data. Property names must be 1–26 characters, contain only alphanumeric characters, hyphens, and underscores, and start and end with an alphanumeric character.

- **Property type** — Defines whether the property represents static or time series data. Static properties describe attributes that change infrequently—a hospital's name, a department's floor number, a patient's date of birth. Time series properties represent continuously arriving observations, like vital signs readings that arrive every few seconds from monitoring equipment. All of Lamna Healthcare's entity types in this unit use static properties. You encounter time series properties in a later unit when you add the VitalSignsReadings entity type and connect it to eventhouse streaming data.

  If you prefer to define your business concepts before deciding on data types, you can choose **Define at binding** as the property type to create an untyped property. The data type is assigned automatically when you bind a source column to that property later.

## Add properties to entity type

You add properties for the Hospital entity type—HospitalName (string, static), City (string, static), State (string, static), and HospitalId (integer, static)—as shown in the image below. You select **Save** to create the properties.

:::image type="content" source="../media/hospital-properties.png" alt-text="Screenshot of Add properties dialog with Hospital properties: HospitalName, City, State, and HospitalId." lightbox="../media/hospital-properties.png":::

Each row in the dialog becomes a property on the Hospital entity type. Once saved, the properties appear in the Entity type configuration pane on the right.

### Configure entity type metadata

While you configure an entity type, add metadata that gives people and AI agents more context about the business concept. A clear description explains what the entity type represents and how it's used. You can also add synonyms for alternate terms that people might use and additional metadata as key-value pairs. For example, a Hospital entity type might use "Medical facility" as a synonym and `BusinessDomain: Healthcare` as additional metadata.

### Configure the entity type key

Every entity type needs a key identifying each unique instance of that entity. An instance represents one real-world occurrence of the entity type. The Hospital entity type represents the concept of hospitals, while individual instances represent specific hospitals—the hospital with HospitalId 1, the hospital with HospitalId 2, the hospital with HospitalId 1001. Similarly, the Patient entity type represents the concept of patients, while instances represent specific patients—PatientId 101, PatientId 102, PatientId 103.

The key tells the system how to identify and distinguish these instances. Without a key, the system can't tell whether incoming data describes a new hospital or updates for an existing one. The key property must contain unique values—no two hospitals share the same HospitalId, no two patients share the same PatientId.

To configure the entity type key, select **Define entity type key** in the Entity type configuration pane. Choose one or more properties that uniquely identify instances. For Hospital, HospitalId uniquely identifies each hospital instance. For Department, DepartmentId uniquely identifies each department instance. For Patient, PatientId serves this purpose.

Keys can only use string or integer properties—other data types don't work as identifiers. Keys are required before you can bind the entity type to data sources. Without a key, the system can't create instances from your source data.

:::image type="content" source="../media/configured-properties.png" alt-text="Screenshot of Hospital entity type configuration showing properties list and HospitalId configured as the key." lightbox="../media/configured-properties.png":::

You repeat this pattern for each business concept in your domain—Department, Room, Patient. Each entity type gets business-friendly properties, a property type, and a key that uniquely identifies each instance.

## Create relationship types

The second step in creating an ontology manually is defining relationship types—connections between entity types.

Entity types alone don't capture how your business operates. In a hospital setting, for example, hospitals contain departments, departments contain rooms, patients occupy rooms. Relationship types describe these connections, turning isolated entity definitions into a connected business model.

### Define the relationship structure

To create a relationship type, select **Add relationship** from the top ribbon, or select **... > Add relationship** next to an entity type name in the **Explorer**. The **Add new relationship** window appears. Enter the relationship type name and specify which two entity types connect.

For a relationship from Hospital to Department, choose Hospital as the **Origin entity type** and Department as the **Target entity type**. The direction matters—"Hospital contains Department" describes how hospitals organize, while "Department belongs to Hospital" describes the reverse perspective. Choose the direction that matches how people ask questions about your business.

:::image type="content" source="../media/relationship-structure.png" alt-text="Screenshot of Add new relationship dialog with Hospital as origin entity type and Department as target entity type." lightbox="../media/relationship-structure.png":::

Name the relationship type with business vocabulary that reads naturally: "Hospital contains Department" makes sense when you read origin entity, relationship name, target entity together. Other examples: "Department has rooms" for Department to Room, or "Room has Patient" for Room to Patient. The name should describe what the relationship means, not just that a relationship exists.

Enter "contains" as the relationship name (because Hospital contains Department). Select **Create** to create the relationship type.

### Review the relationship configuration

After creating the relationship type, the relationship configuration pane opens. You see the origin entity type (Hospital), target entity type (Department), and the relationship name (contains).

In this pane, provide a description that explains how the relationship type is used. A clear description gives AI agents more context for interpreting and navigating the relationship. You can also add additional metadata as key-value pairs. For example, the contains relationship might use `BusinessRule: A hospital contains one or more departments` as additional metadata.

The pane doesn't show a data binding yet—that configuration comes later when you connect the ontology to data sources. For now, you define the conceptual structure: which entities connect and what those connections mean.

Relationship direction matters for how people navigate and query the ontology. When someone asks "which departments does this hospital have," they're following the relationship from Hospital to Department. When someone asks "which hospital does this department belong to," they're following the reverse direction. Define relationship types based on the questions your users ask.

You repeat this process for each relationship in your business domain. For a hospital scenario, you'd define Department "has rooms" Room to show how departments organize their spaces, and Room "has Patient" Patient to show patient assignments. Each relationship captures one aspect of how your organization operates.

At this stage, relationship types are defined as conceptual connections—which entities relate and what those connections mean using business vocabulary. Later, when you configure data bindings, the system populates these relationships with actual data showing specific connections between entity instances. Next, you learn how to generate an ontology from an existing semantic model, automating this entire process. The system creates entity types, properties, keys, and relationship types from an existing semantic model.
