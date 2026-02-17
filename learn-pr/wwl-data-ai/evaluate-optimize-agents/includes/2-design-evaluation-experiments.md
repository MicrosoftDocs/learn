# Design evaluation experiments for AI agents

Optimizing AI agents requires more than making changes and hoping they work better. Effective optimization depends on structured experiments that compare agent variants objectively, measuring quality improvements, cost impacts, and performance characteristics. Consider Adventure Works, an outdoor adventure company managing a Trail Guide Agent that helps customers plan hiking trips with trail recommendations, accommodation bookings, and gear suggestions. The team wants to reduce operational costs by switching from GPT-4 to GPT-4 mini, but they need to verify that quality doesn't degrade below their 4.2/5.0 customer satisfaction target and response times remain under 30 seconds. Here, you learn how to design evaluation experiments by defining metrics, selecting variants to test, and creating systematic testing approaches.

| Design component | What to include | Why it matters |
|------------------|-----------------|----------------|
| **Evaluation Metrics** | **Quality**: Intent Resolution, Relevance, Groundedness<br>**Cost**: Token usage, model pricing<br>**Performance**: Response time, time-to-first-token | Objective measurement of quality, operational costs, and user experience |
| **Variants to Test** | Baseline version<br>Prompt variations<br>Model alternatives (GPT-4, GPT-4 mini)<br>Agent configuration changes (max_tokens, streaming) | Controlled comparison reveals which changes improve performance across all three dimensions |
| **Testing Approach** | Test prompts covering diverse use cases<br>Success criteria and thresholds<br>Comparison methodology<br>Documentation for reproducibility | Systematic testing ensures reliable results and enables team collaboration |

## Define evaluation metrics

Every experiment needs objective measures that reveal whether changes improve or degrade agent performance. Without clear metrics, you can't distinguish between actual improvements and subjective preferences.

**Quality** metrics measure how well the agent serves user needs. Microsoft Foundry provides built-in evaluators organized into categories designed for different evaluation scenarios:

- **General purpose evaluators** (Coherence, Fluency): Use to assess logical flow, consistency, and natural language quality across all applications.

- **Textual similarity evaluators** (Similarity, F1 Score, BLEU, GLEU, ROUGE, METEOR): Use when comparing generated responses against expected or ground truth answers, particularly for translation or benchmarking tasks.

- **Agent evaluators** (Task Adherence, Task Completion, Intent Resolution, Tool Call Accuracy, Tool Selection, Tool Input Accuracy): Use for agent applications that perform multi-step workflows, make tool calls, or need to validate correct task execution.

- **RAG evaluators** (Retrieval, Document Retrieval, Groundedness, Groundedness Pro): Use when your agent retrieves information from knowledge bases or documents and you need to verify responses are grounded in authoritative sources.

- **Risk and safety evaluators** (Hate and Unfairness, Sexual, Violence, Self-Harm, Protected Materials, Content Safety): Use for all customer-facing applications to ensure responsible AI practices and maintain user trust.

- **Azure OpenAI graders** (Model Labeler, String Checker, Text Similarity, Model Scorer): Use for custom scoring logic and flexible validation patterns when built-in evaluators don't match your specific criteria.

- **Custom evaluators**: Create your own evaluation logic for business-specific requirements like brand voice compliance, regulatory adherence, or domain-specific accuracy measures.


> [!TIP]
> For detailed specification of each evaluator including required inputs, scoring ranges, and implementation guidance, learn more through the [evaluators reference](https://learn.microsoft.com/azure/ai-foundry/concepts/built-in-evaluators?view=foundry).

**Cost** metrics quantify the operational expense of running your agent. Token usage measures the number of input and output tokens the model processes for each request. Model pricing converts token counts into actual costs based on the model's rate structure. For GPT-4, you might pay $30 per million tokens, while GPT-4 mini costs $7.50 per million tokens. With these metrics, you can calculate that processing 800 tokens with GPT-4 costs approximately $0.024 per request, while the same request with GPT-4 mini costs $0.006—a 75% reduction. At Adventure Works' scale of handling thousands of customer inquiries daily, this difference impacts their operational efficiency goals significantly. Current pricing details for all models are available at [Microsoft Foundry pricing](https://azure.microsoft.com/pricing/details/microsoft-foundry/).

**Performance** metrics measure response speed and user experience. End-to-end response time captures how long customers wait for complete answers—critical for real-time interactions where Adventure Works targets 30-second average responses. For applications using streaming, time-to-first-token measures perceived responsiveness: how quickly users see the agent start generating a response. A shorter time-to-first-token creates better user experience even when total response time remains the same. Model selection significantly affects these metrics—GPT-4 mini typically responds faster than GPT-4, while prompt length and generation size (controlled by `max_tokens`) directly influence response time.

> [!TIP]
> Learn more about optimization techniques for [performance and latency](https://learn.microsoft.com/azure/ai-foundry/openai/how-to/latency?view=foundry).

## Select variants to test

Optimization experiments compare a baseline version against one or more variants to identify which configuration performs best. The baseline represents your current production agent or your starting point, while variants introduce specific changes you want to evaluate.

**Prompt variations** modify the system instructions that guide agent behavior. You might test a concise prompt against a detailed prompt, or compare different approaches to handling edge cases. With the Adventure Works Trail Guide Agent, one variant might emphasize gear sales recommendations while another balances gear suggestions with safety considerations. Prompt length also affects performance: shorter prompts reduce latency, while more detailed prompts might improve response quality. Testing both extremes reveals the optimal balance for your use case.

**Model alternatives** compare different model tiers to balance capability, cost, and performance. GPT-4 offers sophisticated reasoning that excels at complex trip planning scenarios but costs more and responds slower. GPT-4 mini provides strong performance at lower expense with faster response times, making it ideal for high-volume, latency-sensitive applications. Testing both reveals whether the simpler model maintains acceptable quality for Adventure Works' target of 85% inquiry resolution without human escalation while meeting their 30-second average response time requirement.

**Agent configuration changes** adjust technical parameters that affect quality, cost, and user experience:

- **`max_tokens` parameter**: Limits generation length—lower values reduce both cost and latency but might truncate helpful information.
- **Streaming (`stream: true`)**: Doesn't change total response time but improves perceived responsiveness by showing tokens as they generate, creating better user experience for conversational interfaces.
- **Temperature settings**: Lower temperatures produce more predictable and consistent responses, while higher temperatures allow more creative variation.
- **Retrieval strategies**: Adjusted retrieval configurations might surface more relevant information based on context, proximity, or other criteria.

Agent optimization involves balancing three competing priorities: **quality** (how well responses serve user needs), **cost** (operational expenses at scale), and **performance** (response speed and user experience). A variant that reduces costs by 75% doesn't help if it degrades quality below acceptable thresholds or introduces unacceptable latency for real-time customer interactions. Your experiments must measure all three dimensions to make informed trade-off decisions.

The key principle is controlled comparison. When you test multiple changes simultaneously, you can't determine which change caused observed differences. Testing a new prompt with a new model creates ambiguity: did customer satisfaction improve because of the prompt, the model, or their interaction? Change one variable at a time to isolate the impact of each modification. After validating individual changes, you can test combinations of successful variants.

## Design the testing approach

A systematic testing approach transforms vague improvement goals into reliable experimental results through careful test prompt design, clear success criteria, and documented methodology.

Representative test prompts cover the spectrum of real-world usage. For the Adventure Works Trail Guide Agent, test prompts include queries from different customer segments seeking gear recommendations:

- **Digital nomads planning weekend hikes**: "I'm hiking in the Scottish Highlands in March, what waterproof gear do I need from Adventure Works?"
- **Families preparing for their first outdoor adventure**: "We're taking our teenagers on easy trails near London next month, what basic equipment should we buy or rent?"
- **Experienced hikers planning extended trips**: "I need a complete gear list for five-day backpacking trip in moderate terrain with variable weather"

Edge cases test how the agent handles challenging situations:

- **Ambiguous requests**: "What should I pack for hiking?"
- **Incomplete trip details**: "I need gear for Scotland"
- **Last-minute gear changes**: "Can I swap my camping equipment rental for different sizes?"

Including five to 10 diverse test prompts provides sufficient coverage for manual testing and smoke tests while remaining practical for human evaluation. Each test prompt captures the user query, expected information needs, and ideal response characteristics.

Success criteria establish what constitutes acceptable performance before you run experiments. Setting thresholds in advance prevents rationalizing disappointing results. Adventure Works defines success thresholds across all three optimization dimensions:

| Dimension | Success threshold | Business rationale |
|-----------|------------------|-------------------|
| **Quality** | Average 4.2+ (five-point scale)<br>Minimum 3.5 per response | Aligns with customer satisfaction targets; prevents trust erosion |
| **Cost** | 60% expense reduction | Achieves operational efficiency goals while maintaining 85% resolution rate |
| **Performance** | Average response time <30 seconds<br>Time-to-first-token <2 seconds (streaming) | Ensures acceptable user experience for real-time interactions |

Business requirements influence these thresholds: customer-facing agents handling trip planning need higher quality standards and faster response times than internal tools.

Your comparison methodology structures how you execute experiments and analyze results. You run each variant against the same test prompts, recording quality scores, token usage, and response times for every request. Organizing results in a comparison table reveals patterns across variants—perhaps GPT-4 mini performs well on straightforward gear queries but struggles with complex multi-day trip planning requiring detailed equipment recommendations, or streaming significantly improves perceived responsiveness without increasing costs. Documenting your experiment design ensures reproducibility: another team member can repeat your experiment and verify your findings. This documentation captures test prompts, scoring criteria, variant configurations, and the rationale behind each design decision.

With comprehensive experiment design complete, you're ready to implement these experiments using version control workflows that enable safe testing and team collaboration.
