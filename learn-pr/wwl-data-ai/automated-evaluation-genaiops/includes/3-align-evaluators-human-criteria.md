Aligning automated evaluators with human judgment isn't a one-time setup—it's an ongoing workflow that ensures automation measures what you actually care about.

Adventure Works needs to validate that automated evaluators capture the same quality patterns their human evaluators identify. This lets them trust automated scores when deciding whether to deploy prompt updates. The alignment workflow ensures automation remains meaningful as evaluation criteria evolve.

Follow these steps to align automated evaluators with human evaluation:

1. **Select built-in evaluators** that match your quality dimensions
2. **Run shadow rating** to measure initial alignment with human scores
3. **Monitor alignment over time** to detect drift as your system evolves
4. **Investigate misalignment** when correlations drop below thresholds
5. **Refine with custom evaluators** when built-in options don't capture domain-specific needs

## Select built-in evaluators

Start by choosing Microsoft Foundry evaluators that align with your human evaluation criteria.

**Available built-in evaluators:**

| Evaluator | Measures | Best for |
|-----------|----------|----------|
| Intent Resolution | How fully the response addresses user's need | Ensuring the agent completes the user's task |
| Relevance | How well response addresses the question | Ensuring answers are on-topic |
| Groundedness | Factual accuracy based on sources | Checking if responses stick to provided information |

> [!TIP]
> This table shows a subset of commonly used evaluators. For detailed specification of all available evaluators including required inputs, scoring ranges, and implementation guidance, learn more through the [evaluators reference](/azure/ai-foundry/concepts/built-in-evaluators).

**Map your criteria to evaluators:**

For Adventure Works, human evaluators assess:

- Intent Resolution → **Intent Resolution**
- Relevance → **Relevance**
- Groundedness → **Groundedness**

**Add essential evaluators beyond human criteria:**

You can include evaluators that humans don't shadow-rate but are critical for safety or compliance:

```python
evaluators = {
    # Shadow-rated against human judgment
    'intent_resolution': IntentResolutionEvaluator(),
    'relevance': RelevanceEvaluator(),
    'groundedness': GroundednessEvaluator(),
    
    # Essential safety checks (not shadow-rated)
    'content_safety': ContentSafetyEvaluator(),
    'pii_detection': PIIDetectionEvaluator()
}
```

> [!NOTE]
> Safety and compliance evaluators can serve as gates regardless of human evaluation. A response can score well on human-validated dimensions but still fail on content safety, blocking deployment.

## Run shadow rating

Shadow rating measures how well automated evaluators align with human judgment by having both evaluate the same examples independently.

**The shadow rating process:**

1. **Select evaluation examples** - Choose 100-200 responses representing your use cases
2. **Human evaluation** - Human evaluators score examples on your criteria (1-5 scale)
3. **Automated evaluation** - Run selected evaluators on same examples
4. **Calculate correlation** - Measure alignment using Pearson correlation coefficient

```python
import pandas as pd
from scipy.stats import pearsonr

# Compare scores
df = pd.DataFrame({
    'response_id': response_ids,
    'human_intent_resolution_score': human_scores,
    'automated_intent_resolution': intent_resolution_scores
})

# Calculate correlation
correlation, p_value = pearsonr(
    df['human_intent_resolution_score'], 
    df['automated_intent_resolution']
)

print(f"Correlation: {correlation:.2f}")
```

**Interpreting correlation:**

| Correlation | Meaning | Action |
|-------------|---------|--------|
| ≥ 0.7 | Strong alignment | Proceed with automation |
| 0.5-0.7 | Moderate alignment | Investigate and refine |
| < 0.5 | Weak alignment | Major adjustments needed |

Adventure Works targets 0.75 correlation between their human evaluation scores and automated evaluator scores before trusting automation for deployment decisions.

## Monitor alignment over time

Alignment isn't static—it drifts as your system evolves, underlying models change, or evaluation criteria shift.

**What causes alignment drift:**

- **Model updates** - Underlying language models change response patterns
- **New scenarios** - System encounters cases outside training distribution
- **Criteria evolution** - Human evaluators adjust quality standards
- **Evaluator changes** - Microsoft updates evaluator models

**Establish monitoring cadence:**

```python
# Monthly alignment check
monthly_sample = select_random_sample(production_responses, n=50)

human_review = get_human_scores(monthly_sample)
automated_review = run_evaluators(monthly_sample)

current_correlation = calculate_correlation(human_review, automated_review)

if current_correlation < CORRELATION_THRESHOLD:
    trigger_alignment_investigation()
```

**Set alert thresholds:**

- **Warning threshold (0.65)** - Schedule review, increase human sampling
- **Critical threshold (0.55)** - Pause automated gates until alignment restored
- **Severe threshold (0.45)** - Revert to full human evaluation

> [!TIP]
> Track correlation trends over time, not just point-in-time values. A gradual decline from 0.75 to 0.68 signals systematic drift requiring investigation.

## Investigate misalignment

When correlation drops, determine whether the issue stems from human inconsistency or automation miscalibration.

**Check human evaluator consistency first:**

Before adjusting automated evaluators, verify humans are applying criteria consistently.

**Calculate inter-rater reliability:**

```python
from sklearn.metrics import cohen_kappa_score

# Have two evaluators score same examples
evaluator_1_scores = [4, 5, 3, 4, 2, 5, 3]
evaluator_2_scores = [4, 4, 3, 5, 2, 5, 4]

kappa = cohen_kappa_score(evaluator_1_scores, evaluator_2_scores)
print(f"Inter-rater reliability (Cohen's Kappa): {kappa:.2f}")
```

**Interpreting kappa scores:**

| Kappa | Agreement | Action |
|-------|-----------|--------|
| > 0.8 | Excellent | Humans consistent, investigate automation |
| 0.6-0.8 | Substantial | Generally reliable, minor calibration needed |
| 0.4-0.6 | Moderate | Clarify evaluation criteria with humans |
| < 0.4 | Poor | Resolve human inconsistency before automation |

> [!TIP]
> If human inter-rater reliability is low, invest in evaluator training and clearer rubrics before spending time on automation adjustments. Automating inconsistent criteria just scales the inconsistency.

**Analyze disagreement patterns:**

Once human consistency is confirmed, examine where automation diverges:

```python
# Find high-disagreement examples
df['score_diff'] = abs(df['human_score'] - df['automated_score'])
disagreements = df[df['score_diff'] >= 1.5]

# Categorize patterns
for _, row in disagreements.iterrows():
    print(f"Response: {row['response_text'][:100]}")
    print(f"Human: {row['human_score']}, Auto: {row['automated_score']}")
    print(f"Likely issue: {categorize_disagreement(row)}")
```

**Common disagreement patterns:**

- Automation penalizes length when humans value comprehensiveness
- Automation misses domain-specific terminology
- Automation applies generic quality standards to specialized contexts

## Refine with custom evaluators

When built-in evaluators consistently miss domain-specific quality dimensions, create custom evaluators that capture your unique requirements.

**When to create custom evaluators:**

- Built-in evaluators lack domain context (safety terminology, industry standards)
- Correlation remains below threshold despite configuration adjustments
- Specific quality dimensions have no built-in equivalent (regulatory compliance, brand voice)

**Create a custom evaluator:**

```python
from azure.ai.evaluation import EvaluatorBase

class TrailSafetyEvaluator(EvaluatorBase):
    """Custom evaluator for trail safety information completeness"""
    
    def __init__(self):
        self.required_elements = [
            'weather considerations',
            'difficulty rating',
            'preparation requirements',
            'emergency contact info'
        ]
    
    def evaluate(self, response: str, query: str = None) -> dict:
        response_lower = response.lower()
        
        elements_found = sum(
            1 for element in self.required_elements 
            if any(keyword in response_lower for keyword in element.split())
        )
        
        score = 1 + (elements_found * 1.0)  # 1-5 scale
        
        return {
            'safety_score': min(5, score),
            'elements_present': elements_found,
            'reasoning': f"Found {elements_found}/{len(self.required_elements)} required safety elements"
        }
```

**Test custom evaluator alignment:**

```python
# Run custom evaluator on shadow rating examples
custom_scores = [
    TrailSafetyEvaluator().evaluate(response)['safety_score'] 
    for response in test_responses
]

# Check correlation with human safety ratings
custom_correlation = pearsonr(human_safety_scores, custom_scores)
print(f"Custom evaluator correlation: {custom_correlation[0]:.2f}")
```

**Iterate until alignment achieved:**

- Adjust scoring logic based on disagreement analysis
- Add or remove required elements based on human priorities  
- Refine keyword matching to capture domain terminology
- Rerun shadow rating after each adjustment

> [!IMPORTANT]
> Custom evaluators require ongoing maintenance. As your domain evolves or language models change, revalidate that custom logic still aligns with human judgment.

Now that you understand how to align automated evaluators with human criteria, you're ready to learn how to create synthetic test datasets.
