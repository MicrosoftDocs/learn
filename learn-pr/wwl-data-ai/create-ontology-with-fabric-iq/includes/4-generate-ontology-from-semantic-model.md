::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=fe3678b7-3d0a-4e2b-9c6a-2c4e6d4ed9c9]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Imagine you're working at Lamna Healthcare and you already have a Power BI semantic model representing hospitals, departments, rooms, and patients—complete with relationships showing how they connect. Building an ontology manually would mean recreating all that structure from scratch. Instead, you can generate an ontology directly from the existing semantic model, getting entity types, properties, and relationship structure in minutes.

Fabric reads your semantic model and translates it into ontology components. Tables become entity types, columns become properties with their data types preserved, and semantic-model relationships define how entity types connect. Existing DAX measures also appear as metrics, with calculations owned by the source semantic model.

## Generate ontology structure

You need a Fabric-enabled capacity, permission to create items in the destination workspace, and Read and Build permissions on the source semantic model. The required ontology and Fabric item tenant settings must also be enabled.

To generate an ontology, select **Generate Ontology** from the semantic model ribbon or its **...** action menu. Choose the destination workspace and ontology name, then select **Create**.

:::image type="content" source="../media/generate-ontology-button.png" alt-text="Screenshot of the Generate Ontology button in the Power BI semantic model ribbon in Fabric." lightbox="../media/generate-ontology-button.png":::

The generation process creates entity types from the tables in your semantic model. In Lamna Healthcare's scenario, tables like hospitals, departments, rooms, patients, and vitalsignequipment become entity types with those same names.

## Review what was generated

After generation completes, the ontology editor opens displaying your new ontology. The Entity Types pane on the left shows the business vocabulary generated from your semantic model tables.

:::image type="content" source="../media/ontology-editor.png" alt-text="Screenshot of the ontology editor showing the Entity Types pane on the left listing hospitals, departments, rooms, patients, and vitalsignequipment." lightbox="../media/ontology-editor.png":::

Generation handles several tasks automatically, saving significant manual effort:

**Entity types and properties** — Each table becomes an entity type, and each column becomes a property with its data type preserved. An integer column like HospitalId becomes an integer property, while a string column like HospitalName becomes a string property.

**Entity data bindings** — Generation creates property bindings to source data. These aren't necessarily direct bindings to lakehouse tables. An entity bound to a semantic model isn't currently eligible for optional graph projection.

**Entity type keys** — Generation doesn't guarantee that every required key is complete. For example, HospitalId identifies hospitals and DepartmentId identifies departments; these keys might need configuration after generation.

**Relationship type definitions** — Based on relationships in your semantic model, the system creates relationship types. If hospitals relate to departments in the model, a corresponding relationship type appears in your ontology.

**Metrics** — DAX measures from the semantic model appear as metrics associated with entities. The source semantic model still owns the calculation.

## Complete remaining configuration

After generation, the remaining configuration includes:

- **Names and identifiers** — Technical names can be renamed to business vocabulary. Entity type keys need review, including any missing keys and composite identifiers.

- **Relationship bindings** — Generated relationship type definitions still need bindings to the appropriate source properties or mapping tables.

- **Time-series data** — Generation doesn't automatically create time-series properties and bindings. The eventhouse readings require an additional source linked to the equipment entity through EquipmentId.

::: zone-end
