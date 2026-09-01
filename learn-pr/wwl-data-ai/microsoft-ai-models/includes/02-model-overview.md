::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=a04b6ecc-ed1b-4416-859a-4b257707e9ef]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Microsoft AI builds models around the idea of **humanist superintelligence**: AI that is capable and safe, addresses the demands of real work, and amplifies human potential. The MAI portfolio includes both broad foundational models and models optimized for a particular task or modality.

## Understand the portfolio

Microsoft AI models span several types of workload:

- **Reasoning and chat** - Models such as **MAI-Thinking-1** reason through complex mathematics, business scenarios, and other problem spaces to arrive at a logical, explainable conclusion.
- **Code generation** - **MAI-Code-1.1-Flash** is a lightweight, agentic coding model that can generate and explain code across a wide range of programming languages and frameworks.
- **Speech synthesis** - The **MAI-Voice-2** family turns text or a short reference recording into natural, expressive speech.
- **Speech recognition** - **MAI-Transcribe-1.5** converts audio into domain-aware text across many languages and difficult recording conditions.
- **Image generation** - The **MAI-Image-2.5** family generates and edits photorealistic and design-ready images.
- **Security** - The **MAI-Cyber-1-Flash** model analyzes and mitigates cybersecurity threats.
- **Custom** - **Microsoft Frontier Tuning** provides a way to adapt a foundation model to private business data and requirements.

This module focuses on models for chat and thinking, code generation, speech and transcription, and image generation.

## Choose by workload

Start with the input and output your application needs:

| Requirement | Model family to evaluate |
| --- | --- |
| Reason over text or a complex problem | MAI-Thinking-1 |
| Generate, explain, or modify code across a development workflow | MAI-Code-1.1-Flash |
| Produce spoken audio from text | MAI-Voice-2 |
| Convert spoken audio to text | MAI-Transcribe-1.5 |
| Generate or edit an image | MAI-Image-2.5 |

Next, evaluate the qualities that matter to your scenario. These qualities might include accuracy, latency, cost, language support, output consistency, and safety. When a family offers multiple variants, use representative examples from your application to compare them. A smaller or faster variant can be a better production choice when it meets the required quality.

> [!IMPORTANT]
> Model availability, pricing, and benchmark results can change. Review the current model card and service documentation before choosing a model for production.

You can experiment with MAI models in the [MAI Playground](https://playground.microsoft.ai?azure-portal=true) and review supported deployment options in Microsoft Foundry.

::: zone-end
