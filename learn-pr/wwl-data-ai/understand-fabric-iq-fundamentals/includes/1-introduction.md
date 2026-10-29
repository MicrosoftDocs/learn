::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=65398f14-d772-42ce-9408-62f906a6da09]

::: zone-end

::: zone pivot="text"

Imagine you're a data analyst at Contoso Offshore, a fictional company that specializes in offshore construction, wind-farm installation, and marine engineering. You help project planning, fleet management, and maintenance teams understand whether vessels and equipment are ready for scheduled foundation installations.

## Connect maintenance data to project readiness

Project schedules, vessel records, equipment registers, and maintenance orders sit in separate lakehouse tables. Equipment measurements arrive in an eventhouse. When a project manager asks, "Which planned foundation installations are at risk tomorrow because required equipment is unavailable?", you need to connect records across systems and translate business terms into technical column names.

:::image type="content" source="../media/offshore-maintenance-example.png" alt-text="Diagram showing an offshore maintenance example linking projects, tasks, vessels, equipment, and maintenance orders." lightbox="../media/offshore-maintenance-example.png":::

For example, task T001 in project P001 installs foundation F001 using crane E001 on vessel V001. An open maintenance order blocks the crane during the planned installation window. You need shared definitions of which equipment a task requires and which maintenance orders block operation to explain why the task is at risk.

Fabric IQ helps you define that business vocabulary in an ontology and bind its concepts to prepared data. You define Project, Vessel, Equipment, Foundation, InstallationTask, and MaintenanceOrder with their properties and relationships. Business users then explore those connections through Graph in Microsoft Fabric or ask natural-language questions through data agents. Identifying task risk still requires an explicit rule that checks whether operation-blocking maintenance overlaps the planned use of required equipment.

## Explore the module

In this module, you discover what Fabric IQ is and how it works. You explore the components that work together, including ontology items, data agents, Graph in Microsoft Fabric, and Power BI semantic models. You also learn how ontology modeling shifts your approach from use-case-driven thinking to concept-driven thinking, so teams share business definitions across reports and agents.

> [!IMPORTANT]
> Fabric IQ is currently in [preview](/fabric/fundamentals/preview).

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
