Selecting automated evaluators that measure the same quality dimensions as human evaluators enables effective cross-validation and builds confidence in automation.

In the Adventure Works scenario, trail guides evaluate trail recommendations on accuracy, safety information completeness, and response helpfulness. To validate automated evaluators, the team needs to select evaluators that measure similar dimensions, allowing comparison between human judgment and automated scores.

Here, you learn how to map human evaluation criteria to available automated evaluators, measure alignment between human and automated scores, and iteratively refine evaluator selection for effective cross-validation.

| Human Evaluation Criterion | Corresponding Automated Evaluator | Validation Approach |
|----------------------------|----------------------------------|---------------------|
| Trail accuracy | Groundedness + Relevance | Compare scores on fact-checkable trail details |
| Response completeness | Relevance + Coherence | Measure correlation on comprehensive recommendations |
| Appropriate tone | Fluency + Custom evaluator | Create custom scorer for tone assessment |
| Safety information | Custom evaluator | Requires domain-specific evaluation logic |

## Map human criteria to automated evaluators

Human evaluators assess AI responses using domain-specific criteria that reflect business requirements and user expectations. To automate these assessments, you identify which automated evaluators measure similar quality dimensions.

The mapping process follows these steps:

**1. Identify human evaluation criteria**: Document what human evaluators actually assess when reviewing responses. In the Adventure Works example, trail guides evaluate:
   - **Trail information accuracy**: Are trail details, distances, and difficulty ratings correct?
   - **Safety information**: Does the response appropriately communicate trail hazards and weather considerations?
   - **Booking completeness**: Does the response include relevant accommodation and gear recommendations?
   - **Clarity**: Can customers understand the recommendations?

**2. Match criteria to available evaluators**: For each human criterion, identify automated evaluators that measure similar aspects:
   - Trail information accuracy → Groundedness (checks factual basis) + Relevance (ensures on-topic responses)
   - Safety information → Custom evaluator (domain-specific requirement)
   - Booking completeness → Relevance + Coherence (comprehensive coverage)
   - Clarity → Coherence (logical flow) + Fluency (language quality)

**3. Accept partial coverage**: Not every human criterion maps perfectly to automated evaluators. Custom evaluators address domain-specific needs, while some nuanced judgments remain human-only.

> [!TIP]
> Start by automating objective, well-defined criteria (factual accuracy, response length) before tackling subjective dimensions (tone appropriateness, contextual suitability).

## Measure alignment between human and automated scores

After mapping criteria to evaluators, you validate that automated scores correlate with human judgment by comparing their assessments on the same examples.

**Calculate correlation coefficients**: Use statistical correlation (Pearson or Spearman) to measure how consistently human and automated scores move together:
- **0.7+ correlation**: Strong alignment—automation captures human patterns well
- **0.5-0.7 correlation**: Moderate alignment—useful but needs improvement
- **< 0.5 correlation**: Weak alignment—investigate systematic differences

**Analyze score distributions**: Compare how humans and automation distribute scores:

```python
import pandas as pd
import matplotlib.pyplot as plt

# Example score comparison
df = pd.DataFrame({
    'response_id': range(1, 101),
    'human_score': human_scores,
    'automated_score': automated_scores
})

# Calculate correlation
correlation = df['human_score'].corr(df['automated_score'])
print(f"Correlation: {correlation:.2f}")

# Visualize alignment
plt.scatter(df['human_score'], df['automated_score'])
plt.xlabel('Human Score')
plt.ylabel('Automated Score')
plt.title(f'Human vs Automated Scores (r={correlation:.2f})')
plt.show()
```

Strong alignment means automated scores reliably predict human judgments, enabling confident automation adoption.

## Investigate disagreement patterns

When human and automated scores diverge significantly, examining these disagreements reveals systematic differences and improvement opportunities.

**Identify high-disagreement examples**: Find responses where human and automated scores differ by more than one point on a five-point scale:

```python
# Find disagreements
df['score_diff'] = abs(df['human_score'] - df['automated_score'])
disagreements = df[df['score_diff'] >= 1.5].sort_values('score_diff', ascending=False)

# Examine top disagreements
for idx, row in disagreements.head(10).iterrows():
    print(f"Response {row['response_id']}")
    print(f"Human: {row['human_score']}, Automated: {row['automated_score']}")
    print(f"Text: {row['response_text'][:200]}...")
    print("---")
```

**Categorize disagreement types**:
- **Automation too strict**: Automated evaluators penalize acceptable variations that humans approve
- **Automation too lenient**: Automated evaluators miss quality issues humans identify
- **Context differences**: Humans apply context that automated evaluators don't access
- **Scoring scale interpretation**: Humans and automation use the same scale differently

In the Adventure Works scenario, the team discovered automation scored long, detailed trail descriptions lower than humans did because the coherence evaluator penalized length. Humans valued comprehensive safety information over brevity, revealing a misalignment in scoring priorities.

## Refine evaluator selection and configuration

Based on alignment analysis and disagreement investigation, you iteratively improve automated evaluator selection and configuration.

**Adjust evaluator weights**: When using composite scores, weight individual evaluators to match human priorities:

```python
# Initial equal weighting
composite_score_v1 = (
    0.25 * relevance_score +
    0.25 * groundedness_score +
    0.25 * coherence_score +
    0.25 * fluency_score
)

# Adjusted based on alignment analysis
composite_score_v2 = (
    0.35 * relevance_score +      # Increased—humans prioritize relevance
    0.35 * groundedness_score +   # Increased—accuracy is critical
    0.15 * coherence_score +      # Decreased—less concern about structure
    0.15 * fluency_score          # Decreased—acceptable language variations
)
```

**Customize evaluator prompts**: For evaluators accepting custom instructions, tailor prompts to reflect human evaluation nuances:

```python
custom_relevance_prompt = """
Evaluate response relevance to the user's question about trail recommendations.
Consider:
- Does the response address the specific hiking needs?
- Does it provide actionable trail suggestions?
- Longer, detailed responses are acceptable if comprehensive.

Rate 1-5 where 5 is highly relevant.
"""
```

**Add domain-specific evaluators**: Create custom evaluators for criteria without standard equivalents:

```python
def evaluate_safety_information(response: str, query: str) -> dict:
    """
    Custom evaluator for trail safety information.
    Returns score 1-5 and reasoning.
    """
    # Check for required safety elements
    required_elements = [
        "weather",
        "difficulty",
        "prepare"
    ]
    
    elements_found = sum(1 for element in required_elements if element in response.lower())
    score = min(5, elements_found + 2)  # Base score of 2, +1 per element
    
    return {
        "score": score,
        "reasoning": f"Found {elements_found} of {len(required_elements)} required safety elements"
    }
```

> [!IMPORTANT]
> Each refinement iteration requires re-running shadow ratings to validate improvements. Track correlation improvements over iterations to ensure changes enhance alignment.

## Establish acceptance criteria for automation adoption

Before fully trusting automated evaluators, define clear acceptance criteria based on your risk tolerance and quality requirements:

| Criterion | Target | Validation Method |
|-----------|--------|------------------|
| Score correlation | ≥ 0.7 | Pearson correlation on 100+ examples |
| High-score agreement | ≥ 85% | Both rate as "good" (4-5) on same examples |
| Low-score agreement | ≥ 80% | Both rate as "poor" (1-2) on same examples |
| Systematic bias | None detected | No consistent over/under-scoring patterns |

The Adventure Works team required 0.75 correlation and 85% agreement on safety information issues before fully trusting automation for the model comparison. These thresholds reflect the importance of maintaining customer safety standards.

## Monitor alignment over time

After adopting automated evaluations, ongoing monitoring detects drift between human and automated assessments:

- **Periodic shadow ratings**: Continue shadow rating on 10-20% of examples to track correlation
- **Drift alerts**: Flag when correlation drops below acceptance thresholds
- **Model changes**: Re-validate alignment when underlying language models update
- **Criteria evolution**: As human evaluation standards change, recalibrate automated evaluators

Now that you understand how to align automated evaluators with human criteria, you're ready to learn how to create synthetic test datasets that enable comprehensive automated evaluation.
