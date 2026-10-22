::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=b2145419-fb44-47d8-ad19-b74005bb4757]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

A Fabric data agent provides a conversational way to ask questions about connected data. For Lamna Healthcare, an ontology adds the business context needed to interpret questions about departments, rooms, patients, and equipment.

## Separate context from query execution

An **ontology** describes business entities, their properties and relationships, and how those concepts map to physical data. Definitions and synonyms help express the vocabulary people use. Bindings connect that vocabulary to the sources that supply data.

A Fabric data agent uses the ontology as a **context source**, not as the endpoint that executes a query. The current integration separates three responsibilities:

1. **The ontology provides meaning.** It describes the entities, relationships, terminology, mappings, and bindings relevant to a question.
1. **The data agent interprets and orchestrates.** It uses the context to identify an underlying source and generate an appropriate query.
1. **The underlying source executes.** It runs the generated query under the requesting user's permissions and returns data for the response.

This distinction matters when you investigate an answer. A correct business definition doesn't prove that the agent selects the right source or generates the right filter. You need to check both the semantic context and the query that retrieves the data.

For details, see [Use ontology as context in Fabric data agent](/fabric/data-science/data-agent-ontology-sources).

## Understand source-native queries

The agent generates a query in the language supported by the selected underlying source. For ontology context, the documented languages are SQL, Kusto Query Language (KQL), and Data Analysis Expressions (DAX).

| Underlying source | Query language | Example question topic |
| --- | --- | --- |
| Lakehouse or warehouse | SQL | Rooms associated with a department |
| Eventhouse KQL database | KQL | Equipment readings during a time interval |
| Power BI semantic model | DAX | A measure defined in the model |

The question topics are illustrative. The actual query depends on the ontology bindings, available source objects, and configured business definitions. Adding an ontology doesn't create missing tables, relationships, or measures in those sources.

Don't confuse ontology context with a direct graph connection. Fabric data agents also support graph models as a separate source category that uses Graph Query Language (GQL). That capability doesn't mean that an ontology-context question executes as GQL. See [supported data sources and query languages](/fabric/data-science/data-agent-add-datasources).

In the Lamna scenario, consider "How many rooms in the Surgical Services department are occupied?" You first need an agreed definition of occupied. For example, the scenario might define an occupied room as a room with a current patient assignment. You then need mappings that identify the room, department, and assignment data.

The agent uses this context to generate a query against the appropriate bound source. When you validate the answer, check that it counts rooms rather than patient assignments. Those counts aren't necessarily equivalent. Don't assume that an occupancy property exists unless the actual ontology and source schema define one.

## Put business meaning in the right place

Most shared semantic configuration belongs in the ontology. This includes entity definitions, synonyms, relationships, mappings, and bindings. If "occupied room" has an organization-wide definition, manage that definition as shared business context rather than inventing a different interpretation for each agent.

Agent-specific configuration supplements that context. Agent instructions guide source choice and response behavior. For eligible underlying sources, source instructions and example queries provide additional guidance for query generation.

These configurations serve different purposes. A source instruction might explain a required filter or join path. An example query might demonstrate how to count distinct rooms. Neither configuration writes changes back to the ontology. Update the ontology itself when a shared relationship or mapping is wrong.

Support depends on the underlying source type. Power BI semantic models don't support supplemental data-agent-specific context in this integration, and query generation might not use some ontology context when a semantic model is selected. Check the [ontology configuration limitations](/fabric/data-science/data-agent-ontology-sources#limitations) before you choose a tuning method.

## Account for permissions and context refresh

The agent executes generated queries using the requesting user's access to the underlying source. Users need access to the relevant ontology objects and the data objects needed to answer their question. Sharing the agent doesn't grant those permissions.

For example, two colleagues can use the same published agent but have different access to the source data. Shared terminology doesn't override that difference. Treat ontology context as a way to promote consistent meaning, not as a guarantee of identical results for every person.

Context changes also take time to reach the agent. The agent retrieves the latest ontology context every 10 minutes. A new entity or changed binding can take up to 10 minutes to appear unless you manually refresh the context.

When a question doesn't reflect a recent change, inspect the context available to the agent before you add more instructions. Refresh that context and retest. This separates stale metadata from a problem with the definition, source data, or generated query.

For the access requirements, see [Fabric data agent sharing and permission management](/fabric/data-science/data-agent-sharing#sharing-permission-models-and-required-source-access).

::: zone-end
