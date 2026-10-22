::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=93178df1-1c70-4d05-9e2f-b7a8997e167e]

::: zone-end

::: zone pivot="text"

Imagine you work for Lamna Healthcare, a fictitious organization that uses Microsoft Fabric to analyze hospital operations. You need to help colleagues ask questions using business terms without requiring them to understand the underlying tables.

## Use ontology as business context

A Fabric data agent answers natural-language questions about connected data. An ontology supplies context: business entities, properties, relationships, definitions, synonyms, and mappings to underlying sources. The agent uses that context to select a source and generate a SQL, KQL, or DAX query. The underlying source executes the query under the requesting user's permissions.

For example, a question about occupied rooms needs a definition of occupancy, a way to associate rooms with departments, and access to the relevant source data. Connecting an ontology supplies shared meaning, but you still need to validate the generated query and its answer.

> [!IMPORTANT]
> This module describes the current [ontology-as-context integration](/fabric/data-science/data-agent-ontology-sources), which is in preview. Microsoft Fabric [preview features](/fabric/fundamentals/preview) aren't intended for production use and aren't subject to service-level agreements. Use sample data for the learning scenario.

## Learning objectives

In this module, you learn how to:

- Explain how an ontology provides context for source-native queries.
- Create a Fabric data agent and add ontology context.
- Configure instructions and eligible underlying sources.
- Validate answers by inspecting queries and ontology context.
- Publish and share an agent with the required data access.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
