::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=2576d207-8194-43e0-b324-37fcd36fe247]

::: zone-end

::: zone pivot="text"

Your team has deployed an AI agent and validated its performance through structured evaluation. Now you face the next challenge: the agent handles general hiking inquiries well, but customers request specific expertise in niche domains like winter mountaineering safety protocols or ultralight backpacking gear selection. Base model prompting alone doesn't capture the nuanced expertise needed, and you don't have sufficient real-world training data in these specialized areas.

Effective fine-tuning requires making critical design decisions rather than simply following procedural steps. You must evaluate when fine-tuning offers better value than prompt engineering, assess which fine-tuning approach matches your quality and cost constraints, recognize what makes training data effective versus problematic, and determine whether model performance improvements justify the investment.

**Adventure Works**, an outdoor adventure company, operates a Trail Guide Agent that helps customers plan hiking trips with trail recommendations, accommodation bookings, and gear suggestions. The team evaluates its agent's baseline performance and identifies opportunities to specialize the model for advanced technical queries about gear specifications and safety equipment recommendations. They need to design a fine-tuning strategy that improves domain expertise without degrading general performance, prepare training data that meets format and quality requirements for their chosen method, and design an optimization strategy that produces measurable improvements.

Fine-tuning adapts the model used by an agent by updating model weights through additional training. It isn't the same as changing the agent's instructions, tools, or retrieval configuration. Evaluate those alternatives first when the problem is missing context or agent configuration rather than learned model behavior.

## Choose a training approach

Microsoft Foundry provides two [training approaches](/azure/foundry/fine-tuning/overview#choose-your-training-approach). The approach determines how much control you have over training:

| Approach | Your responsibility | Foundry's responsibility |
|---|---|---|
| **Managed Training** | Supply training data, select a supported method, and configure job settings such as supported hyperparameters and RFT graders. | Run the training job using a predefined workflow. |
| **Programmed Training (preview)** | Write a Python training loop that controls operations such as sampling, losses, rewards, updates, and checkpoints. | Execute the requested training and sampling operations. |

Both approaches use Foundry-managed training infrastructure; you don't provision training GPUs. Start with Managed Training when predefined workflows meet your needs. Programmed Training is intended for practitioners who need control over the training loop, not just job settings or an RFT grader.

> [!IMPORTANT]
> [Programmed Training](/azure/foundry/fine-tuning/programmed-training/overview) is in preview, requires explicit access approval, and isn't recommended for production workloads. This module doesn't require preview access or teach a Programmed Training workflow.

The **training approach** is separate from the **fine-tuning method**, which determines how the model learns. Managed Training supports model-specific supervised fine-tuning (SFT), direct preference optimization (DPO), and reinforcement fine-tuning (RFT). Programmed Training exposes lower-level operations for custom training workflows rather than these predefined job methods. Support for one approach or method doesn't imply support for another. Check the current [supported models](/azure/foundry/fine-tuning/overview#supported-models) and [regions](/azure/foundry/fine-tuning/overview#supported-global-training-regions) before planning a job.

This module focuses on **Managed Training** for models used by AI agents. You learn to select an appropriate fine-tuning method, prepare training data, configure hyperparameters, and evaluate results against a baseline. The exercise applies method-selection decisions to Adventure Works scenarios without submitting a training job.

Let's start by exploring how to evaluate and select fine-tuning methods for your use case.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
