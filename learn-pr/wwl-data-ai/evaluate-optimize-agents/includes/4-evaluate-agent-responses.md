
Manual evaluation provides essential quality insights that automated metrics can't capture, but multiple human evaluators often score the same response differently without clear guidance. When three Adventure Works team members evaluate the same Trail Guide Agent response, one rates it 5 for Intent Resolution while another rates it 3—not because the response quality changed, but because they interpret the scoring criteria differently. Inconsistent evaluation undermines optimization decisions, making it impossible to determine whether quality improved or human evaluators judged responses more leniently. Here, you learn how to create evaluation consistency through rubrics, rater training with calibration examples, and inter-rater reliability testing.

Consistent manual evaluation requires:

- **Detailed rubrics** that define each score level with concrete examples
- **Calibration exercises** where human evaluators practice scoring and align on interpretation
- **Inter-rater reliability testing** to measure and maintain agreement over time
- **Evaluation criteria alignment** with built-in or custom automated evaluators for eventual human-in-the-loop workflows

Choosing quality metrics that Microsoft Foundry supports as built-in or custom automated evaluators enables a progressive evaluation strategy: start with manual human evaluation during initial optimization to understand quality deeply, then transition to automated evaluations with human spot-checks as your understanding matures. This human-in-the-loop approach scales evaluation while maintaining quality oversight.

## Create evaluation rubrics with specific examples

Evaluation rubrics define exactly what each score means with concrete examples that remove ambiguity. Without rubrics, "Intent Resolution score of 4" means different things to different human evaluators—some consider it "good" while others consider it "acceptable with minor issues." Clear rubrics establish shared understanding.

For the Adventure Works Trail Guide Agent, create a rubric for each evaluation criterion you chose. A rubric includes the metric definition, scoring levels with descriptions, and example responses at each level:

**Intent Resolution Rubric (1-5 scale):**

| Score | Definition | Example response |
| ------- | ------------ | -------------------- |
| 5 | Fully addresses user's need with complete information | User asks about March Scotland hiking gear; agent recommends waterproof layers, specifies materials, suggests Adventure Works products |
| 4 | Addresses core need with minor gaps | User asks about Scotland gear; agent recommends waterproof items but doesn't specify materials or products |
| 3 | Partially addresses need, missing key information | User asks about Scotland gear; agent mentions waterproofing generically without specific recommendations |
| 2 | Tangentially related but doesn't address core need | User asks about Scotland gear; agent discusses Scotland trails without addressing gear |
| 1 | Misses user's intent entirely | User asks about Scotland gear; agent discusses different area |

Create similar rubrics for Relevance, Groundedness, and any other criteria you evaluate. Include real example responses from your test prompts that demonstrate each score level. These examples become your calibration set for training human evaluators.

## Train human evaluators with calibration exercises

Human evaluator training ensures all team members interpret rubrics consistently before they evaluate experiment results. Training uses calibration exercises where human evaluators score preselected responses, discuss their scores, and align on interpretation.

Select five to eight agent responses that span your score range—include clear examples of scores 5, 3, and 1, plus ambiguous responses that fall between levels. For Adventure Works, you might include responses to the "Scottish Highlands March gear" test prompt that demonstrate different quality levels. Present each response to your evaluation team without revealing the intended score. Format the calibration set as simple text blocks:

**Low-performing response**

```text
Test Prompt: What gear do I need for hiking in the Scottish Highlands in March?

Agent Response: The Scottish Highlands feature beautiful terrain with mountains, lochs, and glens. Popular trails include the West Highland Way and routes around Ben Nevis. March is considered shoulder season with fewer tourists than summer months. The landscape offers stunning views and diverse wildlife including red deer and golden eagles.
```

**High-performing response**

```text
Test Prompt: What gear do I need for hiking in the Scottish Highlands in March?

Agent Response: For March hiking in the Scottish Highlands, you need waterproof and windproof outer layers since conditions are wet and windy. Look for jackets with Gore-Tex or similar waterproof-breathable materials. Adventure Works offers the StormShield jacket (rated to 20,000mm waterproof) and TrailGuard pants perfect for these conditions. Also bring insulating mid-layers like fleece, moisture-wicking base layers, waterproof hiking boots, gloves, and a warm hat. March temperatures range 2-8°C with frequent rain and possible snow at higher elevations.
```

Have each human evaluator score the calibration responses independently using your rubrics. Then gather the team to compare scores. For responses where scores differ by more than one point, discuss what led to the different interpretations. One human evaluator might focus on completeness while another prioritizes accuracy. Clarify the rubric to address these interpretation differences. Update rubric descriptions based on what causes confusion.

Repeat calibration exercises until the team achieves inter-rater agreement on how to interpret and apply the rubrics. This shared understanding of quality standards becomes the foundation for consistent evaluation. Document the calibrated examples in your repository alongside rubrics—they become reference material when new team members join or when human evaluators need refreshers.

## Test and maintain inter-rater reliability

Inter-rater reliability measures how consistently human evaluators score the same content. High reliability means optimization decisions rest on stable quality assessments rather than individual evaluator preferences. Test reliability periodically to catch score drift over time.

To test inter-rater reliability, have multiple human evaluators independently score the same set of agent responses—perhaps 10-15 responses from a recent experiment. Calculate agreement: count how often human evaluators assign the same score or scores within one point. For Adventure Works with three human evaluators scoring 10 responses across three metrics (30 total scoring opportunities), agreement might look like:

| Agreement Level | Count | Percentage |
| ------------------ | ------- | ------------ |
| Exact agreement (all human evaluators assign same score) | 18 | 60% |
| Within 1 point (all scores within 1-point range) | 10 | 33% |
| Divergent (scores differ by 2+ points) | 2 | 7% |

Aim for at least 80% agreement within one point. When divergent scores occur, review those specific responses with human evaluators to understand what caused disagreement. Update rubrics to clarify those situations. If agreement falls below 80%, conduct additional calibration training.

> [!NOTE]
> Percent agreement (counting scores within one point) provides a simple, interpretable measure of inter-rater reliability suitable for small evaluation teams. Research literature describes additional statistical measures like Cohen's Kappa (for two raters), Fleiss' Kappa (for multiple raters), Krippendorff's Alpha, and Intraclass Correlation Coefficient (ICC). These measures account for chance agreement and provide more rigorous reliability estimates, but require statistical knowledge to interpret. For manual evaluation in optimization experiments, percent agreement offers practical simplicity while maintaining quality oversight.

Test inter-rater reliability at the start of each major optimization initiative and when adding new human evaluators to your team. As evaluation work continues over weeks or months, individual evaluators can drift from calibrated standards—periodic reliability checks catch this drift before it compromises evaluation quality.

With consistent evaluation practices established, you're ready to analyze evaluation data systematically to make evidence-based optimization recommendations.
