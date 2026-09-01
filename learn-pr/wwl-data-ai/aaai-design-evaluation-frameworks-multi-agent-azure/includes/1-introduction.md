::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=4b015e3e-cc60-4224-8891-5c8dfa7d8626]

::: zone-end

::: zone pivot="text"

You run comprehensive tests on each of the 14 specialized agents before deployment. The product search agent scores 92% accuracy on its benchmark dataset. The order management agent processes 97% of test transactions correctly. The returns agent validates 94% of refund requests without error. Each agent passes its quality gates individually. Yet production telemetry reveals that 18% of complex multi-step customer interactions produce confusing or incorrect results.

A customer wants to return one item from a three-item order while upgrading another item to expedited shipping. This workflow requires coordination between the order lookup agent, the returns agent, the inventory agent, and the shipping agent. Each agent executes its isolated task: the returns agent validates the return policy, the inventory agent confirms stock availability, and the shipping agent quotes the expedited cost. But the final customer response contradicts itself—quoting a refund amount that doesn't account for the shipping upgrade cost. Individual agent evaluation metrics showed success, but the end-to-end customer journey failed.

Component-level evaluation measures whether individual agents perform their isolated tasks. System-level evaluation measures whether the multi-agent orchestration accomplishes the customer's actual goal. In this module, you learn how to design evaluation frameworks for multi-agent systems:

- Define system-level success metrics that capture end-to-end task completion
- Implement large language model (LLM)-as-judge evaluation (using an LLM to score output quality) for holistic quality assessment
- Design synthetic test datasets that cover multi-agent interaction scenarios
- Build regression testing pipelines that detect quality drift before it reaches production

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
