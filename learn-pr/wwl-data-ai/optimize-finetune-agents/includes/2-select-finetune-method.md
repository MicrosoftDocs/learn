Selecting the right optimization approach requires understanding what problem you're solving. Before choosing a fine-tuning method, determine whether fine-tuning addresses your quality gaps or whether prompt engineering, and retrieval improvements solve the problem more efficiently. Different fine-tuning methods—supervised fine-tuning, reinforcement fine-tuning, and direct preference optimization—solve distinct problems with varying data requirements and cost implications.

## Evaluate when fine-tuning is needed

Before selecting a fine-tuning method, evaluate whether fine-tuning actually addresses your quality problems. Monitor key metrics at scale to identify patterns that indicate optimization needs:

- **Format consistency**: When responses frequently omit required sections or structure varies unpredictably despite prompt examples
- **Response quality**: When accuracy, relevance, or completeness decline across sufficient sample volumes
- **User satisfaction**: When approval ratings drop, follow-up questions increase, or human escalation rates rise
- **Operational efficiency**: When system prompts or agent instructions require 8+ examples driving high token costs, or maintenance burden grows across multiple prompt templates

> [!TIP]
> Consider prompt engineering and RAG improvements first. Fine-tuning teaches the model *how* to respond, while prompt engineering and RAG provide *what* information to include. Fine-tuning becomes valuable when prompt engineering reaches diminishing returns, format consistency remains unpredictable despite clear instructions, or reasoning quality plateaus.

## Compare fine-tuning methods

The following table provides a side-by-side comparison of the three primary fine-tuning methods available for optimizing agent responses. Use this overview to understand how each method differs in what data you need, what you pay, and what problems each method solves best.

| Dimension | Supervised Fine-Tuning (SFT) | Reinforcement Fine-Tuning (RFT) | Direct Preference Optimization (DPO) |
|-----------|------------------------------|----------------------------------|--------------------------------------|
| **Data requirements** | 50-100+ labeled examples (prompt + desired response) | 30-50+ prompts with grader function to score outputs | 50-100+ preference pairs (prompt + preferred/non-preferred responses) |
| **Cost structure** | Token-based training (per million tokens × epochs) + hourly hosting | Time-based training (hourly rate) + grading tokens + hourly hosting | Token-based training (per million tokens × epochs) + hourly hosting |
| **Primary purpose** | Format consistency, style adherence, domain terminology | Complex reasoning, problem-solving, multi-step analysis | Subjective preferences, tone alignment, content choices |

> [!TIP]
> For detailed information about managing and optimizing fine-tuning costs, learn more at [cost management for fine-tuning](/azure/ai-foundry/openai/how-to/fine-tuning-cost-management?view=foundry).

## Understand decision dimensions for method selection

Three key dimensions determine which fine-tuning method fits your project: the data you can create, the costs you can bear, and the purpose you're optimizing for. These dimensions matter because they represent both your constraints and your goals—data availability defines what's technically feasible, cost structure determines what's economically sustainable, and purpose alignment ensures the optimization actually solves your quality problem.

> [!TIP]
> Select each tab to explore how data requirements, cost structure, and primary purpose differ across fine-tuning methods. Examples are provided in the context of the Adventure Works scenario. Understanding these dimensions helps you match the right optimization approach to your specific agent quality challenge.

# [Supervised Fine-Tuning (SFT)](#tab/method-sft)

**Data requirements**: You need 50-100+ labeled examples showing exact desired outputs. Each example pairs a prompt with the complete response you want the model to produce. At Adventure Works, this means gathering gear recommendation responses with specifications, pricing, and availability in their standard structure. With 300 historical gear interactions already documented, they have sufficient volume to train format consistency across product queries.

**Cost structure**: Token-based pricing charges per million tokens multiplied by training epochs, making costs predictable from your dataset size. Deployed models incur hourly hosting fees on Standard tier (Developer tier avoids hosting fees but autodeletes after 24 hours). This predictability helps Adventure Works budget for optimizing their high-volume gear specification use case.

**Primary purpose**: SFT excels at format consistency, style adherence, and domain terminology. It teaches models to follow templates and maintain standardized structures across responses—exactly what Adventure Works needs when customers expect product comparisons with technical specifications in consistent formats.

# [Reinforcement Fine-Tuning (RFT)](#tab/method-rft)

**Data requirements**: You need 30-50+ prompts representing reasoning challenges plus a grader function that scores solution quality. The grader can be code-based (checking specific criteria) or model-based (using another AI to evaluate). Adventure Works might use prompts describing complex trip planning scenarios with a grader checking whether recommendations consider fitness, weather, experience, and safety constraints simultaneously.

**Cost structure**: Time-based hourly rates vary by model and region, plus grading token costs if your evaluation function calls another model rather than using code-based scoring. Beyond training, deployed models incur Standard tier hosting fees. RFT's higher training costs make sense when optimization delivers significant business value—like Adventure Works reducing expensive human escalations for complex multi-day trip planning.

**Primary purpose**: RFT excels at complex reasoning, problem-solving, and multi-step analysis. It develops logic to handle interacting constraints and trade-offs—valuable when trip planning requires reasoning about how weather, fitness levels, experience, trail difficulty, and seasonal factors interact rather than treating each factor independently.

# [Direct Preference Optimization (DPO)](#tab/method-dpo)

**Data requirements**: You need 50-100+ preference pairs where each pair shows a prompt with two responses—one clearly better capturing your values than the other. Adventure Works creates pairs from safety recommendations. The preferred version balances honesty about risks with encouragement, while the rejected version either sounds alarmist or dismisses genuine hazards. Both format availability and volume feasibility shape your options.

**Cost structure**: Token-based pricing charges per million tokens multiplied by training epochs (similar to SFT), making costs predictable from your dataset size. Deployed models incur Standard tier hourly hosting fees. Adventure Works justifies this investment for safety recommendations where tone calibration directly impacts customer trust and appropriate risk-taking behavior.

**Primary purpose**: DPO excels at subjective preferences, tone alignment, and content choices. It calibrates outputs to match human values around communication style—critical when Adventure Works wants safety recommendations to balance product suggestions with precautions in a way that feels helpful rather than pushy or dismissive.

---

Each method's distinct requirements create natural constraints for your selection. Matching your available data, budget, and quality goals to the right method determines whether fine-tuning succeeds or fails. A method that requires preference pairs doesn't work if you only have labeled examples. A high-cost approach doesn't scale if you need to optimize multiple agents. And teaching format consistency doesn't help if your real problem is reasoning quality.

> [!NOTE]
> Two other fine-tuning methods address specialized scenarios: [**vision fine-tuning**](/azure/ai-foundry/openai/how-to/fine-tuning-vision?view=foundry) optimizes models for image understanding tasks (like product catalog recognition or visual quality inspection), while [**tool use fine-tuning**](/azure/ai-foundry/openai/how-to/fine-tuning-functions?view=foundry) teaches models when to make function calls and what to do with the results. Unlike the methods covered here (which optimize text generation quality) these specialized methods focus on multimodal processing and function-calling behavior respectively.

Understanding the characteristics of each method provides the foundation—but recognizing when to apply each approach requires practice. Next, you explore realistic agent quality problems and determine which fine-tuning method best addresses each scenario.
