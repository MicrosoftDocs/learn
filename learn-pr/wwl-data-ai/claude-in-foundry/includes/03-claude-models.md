::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=e019306b-6380-4412-b371-6fc89fce4a20]

> [!NOTE]
> See the **Text and images** tab for more details

::: zone-end

::: zone pivot="text"

Before deploying AI in Microsoft Foundry, you need to choose your model. This decision is worth considering thoughtfully because more intelligent models typically cost more to run. The key is finding the right balance between capability and cost for your specific use case.

The following Claude models are available Microsoft Foundry:

### Claude Opus - Maximum capability

**Opus** is Claude's most capable model, designed for the hardest problems. Use Opus when you need:

- **Multi-step reasoning** - Complex logical chains and sophisticated analysis
- **Advanced agents** - Autonomous systems that need to plan and execute complex workflows
- **Complex code work** - Large-scale refactoring, architecture design, or intricate debugging
- **Financial analysis** - Detailed modeling, risk assessment, and strategic planning
- **Security analysis** - Threat detection, vulnerability assessment, and security auditing

Opus typically runs slower and costs more than the other tiers, but it's often worth the investment when the task is genuinely difficult and requires the highest level of intelligence.

### Claude Sonnet - The workhorse model

**Sonnet** strikes the ideal balance for most production workloads. It delivers:

- **Frontier-level intelligence** - Near-Opus quality for most tasks
- **Production speed** - Fast enough for real-time applications
- **Production cost** - Economical for high-volume usage

> [!TIP]
> For most teams, Sonnet is an excellent starting point. It provides sophisticated capabilities without the premium cost of Opus, making it suitable for a wide range of enterprise applications.

### Claude Haiku - Speed and scale

**Haiku** is optimized for speed and volume. It excels at:

- **Classification** - Categorizing content, sentiment analysis, tagging
- **Extraction** - Pulling specific information from documents
- **Routing** - Directing requests to appropriate handlers or workflows
- **Sub-agents** - Fast decision-making components within larger systems

When you're making thousands of calls and each individual task is relatively straightforward, Haiku delivers the performance and cost efficiency you need.

## How to choose the right model

Rather than guessing which model to use, follow this systematic approach:

### Start small, scale up as needed

1. **Begin with Haiku** - Start with the fastest, most cost-effective option
2. **Test with real data** - Take 20-30 examples from your actual workload
3. **Evaluate the results** - Assess whether the quality meets your requirements
4. **Iterate if needed** - If you hit a quality ceiling, step up to Sonnet, then to Opus if necessary

> [!IMPORTANT]
> Starting with Haiku helps you avoid overpaying for capability you don't need. Many tasks that seem complex can actually be handled by smaller models with proper prompt engineering.

## Claude in Foundry Models

In Microsoft Foundry, all three Claude model tiers are available in the model catalog. The catalog provides:

- **Complete model listings** - Browse all available Claude models
- **Model comparison tools** - Compare models across multiple attributes:
  - Performance characteristics
  - Cost per token (input and output)
  - Context window size
  - Latency expectations
  - Capability benchmarks
- **Deployment options** - Deploy models directly from the catalog to your project

::: zone-end
