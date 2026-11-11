::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=b65c7fa0-a5db-478d-a393-26bed03d1e6e]

::: zone-end

::: zone pivot="text"

Imagine you work at Lamna Healthcare, a fictitious medical center that manages operations across hospitals, departments, and rooms.

Your data lives in multiple places—hospital, department, room, and patient records exist as lakehouse tables, while timestamped vital signs readings from intensive care unit (ICU) equipment are stored in an eventhouse. To support natural language queries and exploration, you need to create an ontology that connects these data sources with consistent business vocabulary.

You face a key decision: how to start building your ontology. You can automatically generate structure from an existing Power BI semantic model, or build from scratch using OneLake data. Both paths require you to review the definitions and complete the source and relationship bindings.

Creating an ontology means defining business entity types like Hospital, Department, Room, and Patient with their properties. You establish relationship types between entities, such as "Department located in Hospital" or "Patient assigned to Room." Then you bind these definitions to actual data sources, mapping your conceptual model to physical tables and streams. This binding makes your business vocabulary queryable across multiple data sources.

The ontology becomes your semantic layer: shared definitions and bindings that consuming experiences use to query the relevant sources.

In this module, you build the Lamna Healthcare ontology by choosing your creation approach, modeling entity types and relationships, and binding them to OneLake data sources. By the end, you have ontology definitions connected to patient records and sample equipment readings, ready for validation through supported consuming experiences. The exercises use historical samples, not a live monitoring system.

> [!IMPORTANT]
> Ontology in Fabric IQ, including the creation and data-binding features covered in this module, is in preview. Check the [ontology documentation](/fabric/iq/ontology/overview) for the latest availability, including updates about general availability (GA). For preview conditions and limitations, see [Microsoft Fabric preview features](/fabric/fundamentals/preview).
>
> The ontology interface has been updated. Some videos and screenshots might show earlier controls.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
