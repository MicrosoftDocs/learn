Imagine you're working at Lamna Healthcare and you already have a Power BI semantic model representing hospitals, departments, rooms, and patients—complete with relationships showing how they connect. Building an ontology manually would mean recreating all that structure from scratch. Instead, you can generate an ontology directly from the existing semantic model, getting entity types, properties, and relationship structure in minutes.

Fabric reads your semantic model and translates it into ontology components. Tables become entity types, columns become properties with their data types preserved, and model relationships define how entity types connect. This automation doesn't just save time—it ensures your ontology mirrors the analytical model your teams already trust for reporting.

## Generate ontology structure

To generate an ontology from your Power BI semantic model, navigate to your semantic model in Fabric and select **Generate ontology**. The system prompts you to choose a workspace and name for your new ontology, then creates the foundational components automatically.

:::image type="content" source="../media/generate-ontology-button.png" alt-text="Screenshot of the Generate Ontology button in the Power BI semantic model ribbon in Fabric." lightbox="../media/generate-ontology-button.png":::

The generation process creates entity types from all visible tables in your semantic model. In Lamna Healthcare's scenario, tables like hospitals, departments, rooms, patients, and vitalsignequipment become entity types with those same names.

## Review what was generated

After generation completes, the ontology editor opens displaying your new ontology. The Entity Types pane on the left shows the business vocabulary generated from your semantic model tables.

:::image type="content" source="../media/ontology-editor.png" alt-text="Screenshot of the ontology editor showing the Entity Types pane on the left listing hospitals, departments, rooms, patients, and vitalsignequipment." lightbox="../media/ontology-editor.png":::

Generation handles several tasks automatically, saving significant manual effort:

**Entity types and properties** — Each table becomes an entity type, and each column becomes a property with its data type preserved. An integer column like HospitalId becomes an integer property, while a string column like HospitalName becomes a string property.

**Entity data bindings** — The system configures bindings automatically because the semantic model already connects to your lakehouse tables through Direct Lake mode. These bindings map properties to source columns, making entity data queryable immediately.

**Entity type keys** — Where the system can determine unique identifiers from your data, it configures keys automatically. For example, HospitalId becomes the key for hospitals, DepartmentId for departments.

**Relationship type definitions** — Based on relationships in your semantic model, the system creates relationship types. If hospitals relate to departments in the model, a corresponding relationship type appears in your ontology.

## Complete remaining configuration

After generation, complete these tasks to finalize your ontology:

- **Review entity type keys** — Verify each entity type has a key defined. Keys are inferred from the semantic model's relationship structure, and most are configured automatically, but you should verify they're all present.

- **Verify and configure relationship types** — Relationship bindings are created based on the semantic model structure. Depending on how the model defines relationships, some bindings are configured automatically while others require manual configuration to make them queryable.

- **Add time series bindings for streaming data** — Static entity bindings from the lakehouse are configured automatically. For entity types that need real-time streaming data, add time series bindings to connect eventhouse data sources.
