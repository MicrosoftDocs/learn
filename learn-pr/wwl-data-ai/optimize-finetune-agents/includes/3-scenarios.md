
You learned the characteristics of each fine-tuning method—now apply that knowledge to real-world agent quality challenges. Not every performance issue requires fine-tuning; some stem from insufficient prompts, missing knowledge sources, or architectural gaps. Your task: analyze each scenario, identify the core problem, and determine which fine-tuning method (if any) provides the most effective solution.

Adventure Works faces three distinct agent quality problems. For each scenario, consider:

- What is actually going wrong
- What data exists or can be created?
- Which method addresses the root cause?

> [!NOTE]
> These scenarios are provided for educational purposes to illustrate fine-tuning method selection. They're presented "as-is" without warranty of any kind. The evaluation metrics shown represent example indicators for each scenario—your production systems should use comprehensive evaluation strategies tailored to your specific use cases and requirements. Different scenarios may require different metrics or combinations of metrics.

### Problem: Inconsistent response format

:::image type="content" source="../media/inconsistent-response.png" alt-text="Screenshot of conversation showing inconsistent gear specification responses where one question receives a vague answer while another gets detailed technical specifications." lightbox="../media/inconsistent-response.png":::

| Microsoft Foundry Evaluation Metrics |
|--------------------------------------|
| **Coherence**: 2.8/5 ⚠️ \| **Fluency**: 3.1/5 ⚠️ \| **Groundedness**: 4.2/5 ✓ \| **Relevance**: 4.1/5 ✓ |

**Challenge**

The agent provides varying levels of detail and structure when answering gear specification questions. Automated evaluations reveal that **Coherence** scores (measuring logical flow and structural consistency) and **Fluency** scores (assessing response quality and terminology professionalism) consistently fall below the 4.0 threshold.

Sometimes responses offer vague qualitative descriptions, other times they include precise technical specifications with availability data. Customers asking similar product questions receive inconsistent information quality, creating frustration and requiring follow-up interactions.

**Desired state**

Every gear specification query receives a structured response following Adventure Works' standard format: include technical specifications using industry terminology, list current pricing and availability across locations, and suggest complementary items when relevant. Consistency builds customer trust and reduces back-and-forth clarification requests.

**Best method**

Supervised Fine-Tuning (SFT) excels at teaching format consistency and terminology standardization. With 300 historical interactions demonstrating the desired response structure, Adventure Works has enough labeled examples to train the model to follow the pattern reliably across all gear queries.

> [!TIP]
> **Data constraint**: Need 50-100+ examples minimum. Do you have fewer than 30? Consider synthetic data generation, broader dataset inclusion, or prompt engineering instead.

### Problem: Inappropriate tone for sensitive topics

:::image type="content" source="../media/inappropriate-tone.png" alt-text="Screenshot of conversation showing tone mismatches in safety recommendations where one response is overly alarmist and another dismisses genuine risks." lightbox="../media/inappropriate-tone.png":::

| Microsoft Foundry Evaluation Metrics |
|--------------------------------------|
| **Coherence**: 3.0/5 ⚠️ \| **Content Safety**: 7% flagged ⚠️ \| **Groundedness**: 4.3/5 ✓ \| **Relevance**: 4.2/5 ✓ |

**Challenge**

The agent inconsistently balances safety guidance with encouragement. Automated evaluations show **Coherence** scores (assessing tone consistency) below the 4.0 threshold, while **content safety evaluators** flag 7% of safety-related responses as either insufficiently cautious or inappropriately discouraging.

Some responses sound overly alarmist and discouraging, potentially deterring customers from appropriate outdoor activities. Other responses minimize genuine risks, failing to communicate necessary precautions for challenging conditions. Neither extreme serves Adventure Works' goal of supporting safe outdoor experiences.

**Desired state**

Safety recommendations acknowledge real risks honestly while maintaining an encouraging, supportive tone. Responses provide comprehensive equipment lists with rationale, clearly explain skill requirements, and suggest appropriate progression paths—all while conveying that Adventure Works wants customers to succeed in their outdoor goals when properly prepared.

**Best method**

Direct Preference Optimization (DPO) specializes in subjective alignment challenges. By creating preference pairs from historical interactions—labeling which responses better balanced safety with encouragement—Adventure Works teaches the model to align with their values around risk communication. DPO directly addresses tone calibration that SFT alone can't effectively teach.

> [!TIP]
> **Stacking techniques**: You can combine methods sequentially. Start with SFT to establish task capabilities and response format, then apply DPO to refine subjective qualities like tone and style.

### Problem: Illogical reasoning in complex planning

:::image type="content" source="../media/illogical-reasoning.png" alt-text="Screenshot of conversation showing flawed trip planning logic where recommendations ignore constraint interactions like fitness level, experience, budget, and weather conditions." lightbox="../media/illogical-reasoning.png":::

| Microsoft Foundry Evaluation Metrics |
|--------------------------------------|
| **Tool Call Accuracy**: 2.7/5 ⚠️ \| **Relevance**: 2.8/5 ⚠️ \| **Groundedness**: 4.1/5 ✓ \| **Fluency**: 4.3/5 ✓ |

**Challenge**

The agent ignores critical constraint interactions when developing trip plans. Automated evaluations reveal that **Tool Call Accuracy** scores (measuring whether the agent makes the right tool calls with correct parameters for multi-step planning) and **Relevance** scores (assessing whether all customer constraints are addressed) both fall significantly below the 4.0 threshold.

This itinerary recommends wild camping despite the user's limited camping experience, suggests exposed cliff top terrain for moderate fitness level without considering April's unpredictable coastal weather, proposes high-end equipment despite budget consciousness, and ignores that -10°C sleeping bags vastly exceed April Welsh coast requirements. The agent lists trip elements but doesn't reason about how constraints interrelate.

**Desired state**

Trip planning recommendations demonstrate multi-step reasoning that considers how different factors interact. The agent should recognize that limited camping experience suggests established campsites over wild camping, moderate fitness in April weather favors conservative daily distances with bailout options, budget constraints require value-oriented equipment suggestions, and equipment specifications should match actual seasonal conditions. Plans show the agent reasoned through trade-offs rather than listing disconnected recommendations.

**Best method**

Reinforcement Fine-Tuning (RFT) develops sophisticated reasoning capabilities through iterative optimization. By defining graders that evaluate whether trip plans appropriately balance customer constraints—fitness level, experience, budget, weather, and safety factors—Adventure Works trains the model to develop better planning logic. While RFT costs more than SFT or DPO, reducing human escalations for complex travel planning justifies the investment for this high-value, complex-reasoning use case.

> [!TIP]
> **Budget constraint**: RFT's time-based training plus grading tokens plus hosting fees can consume 80% of your budget for one use case. Justify with return on investment (ROI): does this use case drive enough revenue to warrant concentrated investment over spreading budget across multiple use cases?

Now that you understand how to compare fine-tuning methods and select approaches based on project requirements, you're ready to develop strategies for creating and managing the training data each method requires.
