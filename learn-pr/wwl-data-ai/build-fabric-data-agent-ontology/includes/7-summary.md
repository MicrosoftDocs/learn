In this module, you learned how ontology context supports a Fabric data agent that answers questions about hospital operations.

## Review the workflow

An ontology provides shared business meaning through entities, properties, relationships, definitions, synonyms, mappings, and bindings. The agent uses that context to select an underlying source and generate a SQL, KQL, or DAX query. The source executes the query under the requesting user's permissions.

You learned how to:

- Add an ontology through the data agent's **Sources** experience.
- Separate shared ontology definitions from agent-specific instructions and eligible source configurations.
- Validate answers against a benchmark by inspecting run steps, generated queries, and source results.
- Inspect downloaded ontology context and refresh it when recent changes are missing.
- Publish an agent while retaining an editable draft, and share it with the required source access.

## Apply the validation approach

When an answer is wrong, identify whether the cause is the ontology context, source selection, generated query, source data, or permissions. Correct that cause and retest rather than assuming that instructions alone fix every issue.

For current capabilities and preview limitations, see [Use ontology as context in Fabric data agent](/fabric/data-science/data-agent-ontology-sources).
