::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=65398f14-d772-42ce-9408-62f906a6da09]

::: zone-end

::: zone pivot="text"

Imagine checking whether equipment is ready for tomorrow's work. For an offshore construction team, a crane under maintenance can put a scheduled foundation installation at risk, even when the vessel is available.

Project schedules, vessel records, equipment registers, and maintenance orders sit in separate lakehouse tables. Equipment measurements arrive in an eventhouse. When a project manager asks, "Which planned foundation installations are at risk tomorrow because required equipment is unavailable?", you need to connect records across systems. The problem is that separate records don't provide shared definitions of required equipment and blocking maintenance, so teams can reach different conclusions about the same task.

:::image type="content" source="../media/offshore-maintenance-example.png" alt-text="Diagram showing an offshore maintenance example linking projects, tasks, vessels, equipment, and maintenance orders." lightbox="../media/offshore-maintenance-example.png":::

For example, task T001 in project P001 installs foundation F001 using crane E001 on vessel V001. An open maintenance order blocks the crane during the planned installation window. You need shared definitions of which equipment a task requires and which maintenance orders block operation to explain why the task is at risk.

Fabric IQ uses an ontology to connect shared business meaning to prepared data, helping teams trace which tasks depend on unavailable equipment. This shared context supports a consistent readiness decision, but identifying task risk still requires explicit logic that checks whether operation-blocking maintenance overlaps the planned use of required equipment.

The goal of this module is to explain how Fabric IQ connects shared business meaning to data so teams can investigate readiness consistently. After completing the module, you can distinguish the roles of its workload items and recognize when an ontology adds reusable business context beyond a reporting schema. This helps you choose how to investigate a dependency without mistaking a shared definition for an automatically calculated risk or action.

> [!IMPORTANT]
> The Fabric IQ workload and ontology items covered in this module are in preview. Other workload items can have different release statuses. Check the [Fabric IQ overview](/fabric/iq/overview) for the latest availability, including updates about general availability (GA). For preview conditions and limitations, see [Microsoft Fabric preview features](/fabric/fundamentals/preview).

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
