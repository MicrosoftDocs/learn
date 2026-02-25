Not all fine-tuning methods solve the same problems. Adventure Works needs to improve their Trail Guide Agent's responses across gear specifications, safety recommendations, and trip planning—but each challenge requires a different optimization approach. Here, you learn to:

- Recognize which problems each fine-tuning method solves
- Compare methods across data requirements, cost structure, and purpose
- Select approaches based on your quality needs and constraints
- Apply the decision framework to production scenarios

| Dimension | Supervised Fine-Tuning (SFT) | Reinforcement Fine-Tuning (RFT) | Direct Preference Optimization (DPO) |
|-----------|------------------------------|----------------------------------|--------------------------------------|
| **Data requirements** | 50-100+ labeled examples (prompt + desired response) | 30-50+ prompts with grader function to score outputs | 50-100+ preference pairs (prompt + preferred/non-preferred responses) |
| **Cost structure** | Token-based training (per million tokens × epochs) + hourly hosting | Time-based training (hourly rate) + grading tokens + hourly hosting | Token-based training (per million tokens × epochs) + hourly hosting |
| **Primary purpose** | Format consistency, style adherence, domain terminology | Complex reasoning, problem-solving, multi-step analysis | Subjective preferences, tone alignment, content choices |

## Understand decision dimensions for method selection

Three key dimensions determine which fine-tuning method fits your project: the data you can create, the costs you can bear, and the purpose you're optimizing for. Select a method below to explore how each dimension shapes your decision.

::: zone pivot="method-sft"

### Supervised Fine-Tuning (SFT)

**Data requirements**: You need 50-100+ labeled examples showing exact desired outputs. Each example pairs a prompt with the complete response you want the model to produce. At Adventure Works, this means gathering gear recommendation responses with specifications, pricing, and availability in their standard structure. With 300 historical gear interactions already documented, they have sufficient volume to train format consistency across product queries.

**Cost structure**: Token-based pricing charges per million tokens multiplied by training epochs, making costs predictable from your dataset size. Deployed models incur hourly hosting fees on Standard tier (Developer tier avoids hosting fees but auto-deletes after 24 hours). This predictability helps Adventure Works budget for optimizing their high-volume gear specification use case.

**Primary purpose**: SFT excels at format consistency, style adherence, and domain terminology. It teaches models to follow templates and maintain standardized structures across responses—exactly what Adventure Works needs when customers expect product comparisons with technical specifications in consistent formats.

:::

::: zone pivot="method-rft"

### Reinforcement Fine-Tuning (RFT)

**Data requirements**: You need 30-50+ prompts representing reasoning challenges plus a grader function that scores solution quality. The grader can be code-based (checking specific criteria) or model-based (using another AI to evaluate). Adventure Works might use prompts describing complex trip planning scenarios with a grader checking whether recommendations consider fitness, weather, experience, and safety constraints simultaneously.

**Cost structure**: Time-based hourly rates vary by model and region, plus grading token costs if your evaluation function calls another model rather than using code-based scoring. Beyond training, deployed models incur Standard tier hosting fees. RFT's higher training costs make sense when optimization delivers significant business value—like Adventure Works reducing expensive human escalations for complex multi-day trip planning.

**Primary purpose**: RFT excels at complex reasoning, problem-solving, and multi-step analysis. It develops logic to handle interacting constraints and trade-offs—valuable when trip planning requires reasoning about how weather, fitness levels, experience, trail difficulty, and seasonal factors interact rather than treating each factor independently.

:::

::: zone pivot="method-dpo"

### Direct Preference Optimization (DPO)

**Data requirements**: You need 50-100+ preference pairs where each pair shows a prompt with two responses—one clearly better capturing your values than the other. Adventure Works creates pairs from safety recommendations where the preferred version balances honesty about risks with encouragement, while the rejected version either sounds alarmist or dismisses genuine hazards. Both format availability and volume feasibility shape your options.

**Cost structure**: Token-based pricing charges per million tokens multiplied by training epochs (similar to SFT), making costs predictable from your dataset size. Deployed models incur Standard tier hourly hosting fees. Adventure Works justifies this investment for safety recommendations where tone calibration directly impacts customer trust and appropriate risk-taking behavior.

**Primary purpose**: DPO excels at subjective preferences, tone alignment, and content choices. It calibrates outputs to match human values around communication style—critical when Adventure Works wants safety recommendations to balance product suggestions with precautions in a way that feels helpful rather than pushy or dismissive.

:::

::: zone-end

## Recognize problems fine-tuning solves

Before comparing methods, you need to identify whether fine-tuning addresses your specific quality challenges. Not every agent performance issue benefits from fine-tuning—some problems stem from inadequate prompt engineering, missing knowledge sources, or architectural limitations. Adventure Works discovered three distinct problem patterns where fine-tuning provides the most effective solution path.

### Problem: Inconsistent response format

> [!NOTE]
> **Screenshot placeholder**: Conversation showing inconsistent gear specification responses.
>
> **User**: "What's the waterproof rating on the StormShield jacket?"
>
> **Agent (Response 1)**: "The StormShield jacket has good waterproofing."
>
> **User**: "What about the Alpine Pro tent?"
>
> **Agent (Response 2)**: "IPX4 rated, 3000mm hydrostatic head, sealed seams, durable water repellent coating. Weighs 2.1kg. Current stock: 12 units at Vancouver location, 8 at Toronto."

**Challenge**: The agent provides varying levels of detail and structure when answering gear specification questions. Sometimes responses offer vague qualitative descriptions, other times they include precise technical specifications with availability data. Customers asking similar product questions receive inconsistent information quality, creating frustration and requiring follow-up interactions.

**Desired state**: Every gear specification query receives a structured response following Adventure Works' standard format: include technical specifications using industry terminology, list current pricing and availability across locations, and suggest complementary items when relevant. Consistency builds customer trust and reduces back-and-forth clarification requests.

**Best method**: Supervised Fine-Tuning (SFT) excels at teaching format consistency and terminology standardization. With 300 historical interactions demonstrating the desired response structure, Adventure Works has sufficient labeled examples to train the model to follow the pattern reliably across all gear queries.

> [!TIP]
> **Data constraint**: Need 50-100+ examples minimum. With fewer than 30? Consider synthetic data generation, broader dataset inclusion, or prompt engineering instead.

### Problem: Inappropriate tone for sensitive topics

> [!NOTE]
> **Screenshot placeholder**: Conversation showing tone mismatches in safety recommendations.
>
> **User**: "I'm planning my first winter mountain hike in Scotland. What safety gear should I bring?"
>
> **Agent (Response 1)**: "Winter mountaineering is extremely dangerous for beginners. You need avalanche transceivers, ice axes, crampons, emergency shelter, PLB, first aid, backup navigation. Do not attempt this without professional training and experienced guides."
>
> (Later interaction with different user)
>
> **User**: "Same question - first winter mountain hike, what gear?"
>
> **Agent (Response 2)**: "Bring warm clothes and good boots. Have fun out there!"

**Challenge**: The agent inconsistently balances safety guidance with encouragement. Some responses sound overly alarmist and discouraging, potentially deterring customers from appropriate outdoor activities. Other responses minimize genuine risks, failing to communicate necessary precautions for challenging conditions. Neither extreme serves Adventure Works' goal of supporting safe outdoor experiences.

**Desired state**: Safety recommendations acknowledge real risks honestly while maintaining an encouraging, supportive tone. Responses provide comprehensive equipment lists with rationale, clearly explain skill requirements, and suggest appropriate progression paths—all while conveying that Adventure Works wants customers to succeed in their outdoor goals when properly prepared.

**Best method**: Direct Preference Optimization (DPO) specializes in subjective alignment challenges. By creating preference pairs from historical interactions—labeling which responses better balanced safety with encouragement—Adventure Works teaches the model to align with their values around risk communication. DPO directly addresses tone calibration that SFT alone cannot effectively teach.

> [!TIP]
> **Sequential approach**: Need format consistency AND tone alignment? Train with SFT first, verify improvements, then apply DPO starting from that improved model. Use Developer tier (free hosting, 24-hour limit) for initial validation.

### Problem: Illogical reasoning in complex planning

> [!NOTE]
> **Screenshot placeholder**: Conversation showing flawed trip planning logic.
>
> **User**: "Plan a five-day coastal hiking trip in Wales for April. Two adults, we're moderate fitness level, one person has limited camping experience, budget-conscious."
>
> **Agent**: "Day 1: Pembrokeshire Coast Path, Angle to Freshwater West (18km, challenging terrain). Recommend wild camping at clifftop sites.
>
> Day 2: Freshwater West to Stackpole (22km, some scrambling sections).
>
> Day 3: Stackpole to Manorbier (20km).
>
> Day 4: Manorbier to Saundersfoot (19km, exposed clifftop sections).
>
> Day 5: Saundersfoot to Amroth (15km).
>
> For camping equipment, I recommend:
> - Lightweight 2-person tent (£450)
> - Down sleeping bags rated to -10°C (£280 each)
> - Carbon fiber trekking poles (£180 pair)"

**Challenge**: The agent ignores critical constraint interactions when developing trip plans. This itinerary recommends wild camping despite the user's limited camping experience, suggests exposed clifftop terrain for moderate fitness level without considering April's unpredictable coastal weather, proposes high-end equipment despite budget consciousness, and ignores that -10°C sleeping bags vastly exceed April Welsh coast requirements. The agent lists trip elements but doesn't reason about how constraints interrelate.

**Desired state**: Trip planning recommendations demonstrate multi-step reasoning that considers how different factors interact. The agent should recognize that limited camping experience suggests established campsites over wild camping, moderate fitness in April weather favors conservative daily distances with bailout options, budget constraints require value-oriented equipment suggestions, and equipment specifications should match actual seasonal conditions. Plans show the agent reasoned through trade-offs rather than listing disconnected recommendations.

**Best method**: Reinforcement Fine-Tuning (RFT) develops sophisticated reasoning capabilities through iterative optimization. By defining graders that evaluate whether trip plans appropriately balance customer constraints—fitness level, experience, budget, weather, and safety factors—Adventure Works trains the model to develop better planning logic. While RFT costs more than SFT or DPO, reducing human escalations for complex travel planning justifies the investment for this high-value, complex-reasoning use case.

> [!TIP]
> **Budget constraint**: RFT's time-based training plus grading tokens plus hosting fees can consume 80% of your budget for one use case. Justify with ROI: does this use case drive enough revenue to warrant concentrated investment over spreading budget across multiple use cases?

Now that you understand how to compare fine-tuning methods and select approaches based on project requirements, you're ready to develop strategies for creating and managing the training data each method requires.
