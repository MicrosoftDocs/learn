::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=b65c7fa0-a5db-478d-a393-26bed03d1e6e]

::: zone-end

::: zone pivot="text"

Imagine you work at Lamna Healthcare, a fictitious medical center that manages operations across hospitals, departments, and rooms.

Your data lives in multiple places—hospital, department, room, and patient records exist as lakehouse tables, while continuous vital signs monitoring from intensive care unit (ICU) equipment streams into an eventhouse. To enable natural language queries and exploration across all of it, you need to create an ontology that unifies these data sources with consistent business vocabulary.

You face a key decision: how to start building your ontology. You can automatically generate structure from an existing Power BI semantic model, or build from scratch using OneLake data. Both paths lead to the same destination—a complete ontology bound to your lakehouse tables and eventhouse streams.

Creating an ontology means defining business entity types like Hospital, Department, Room, and Patient with their properties. You establish relationship types between entities, such as "Department located in Hospital" or "Patient assigned to Room." Then you bind these definitions to actual data sources, mapping your conceptual model to physical tables and streams. This binding makes your business vocabulary queryable across multiple data sources.

The ontology becomes your semantic layer—a unified graph model that AI agents and Graph in Microsoft Fabric use to answer questions. Instead of writing SQL joins between lakehouse and eventhouse, users explore connected business concepts through natural language or visual graph navigation.

In this module, you build the complete Lamna Healthcare ontology by choosing your creation approach, modeling entity types and relationships, and binding them to OneLake data sources. By the end, you have a working ontology that connects Lamna Healthcare's patient records in the lakehouse to live vital signs monitoring in the eventhouse—ready for natural language queries and graph exploration.

> [!IMPORTANT]
> Fabric IQ is currently in [preview](/fabric/fundamentals/preview).

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
