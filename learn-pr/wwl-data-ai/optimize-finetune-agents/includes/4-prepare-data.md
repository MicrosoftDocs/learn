Fine-tuning combines a foundation model with training data that includes example prompts and responses. Quality training data determines whether fine-tuning succeeds or wastes resources. This unit covers [recognizing signs you need better training data](#recognize-signs-you-need-better-training-data), [applying quality principles](#apply-quality-principles-for-training-data), [understanding data requirements by method](#understand-data-requirements-by-method), and [making data-driven preparation decisions](#make-data-driven-preparation-decisions).

![Diagram of a base model plus training data resulting in a fine-tuned model.](../media/fine-tuning.png)

## Recognize signs you need better training data

Before investing time in data preparation, identify whether data quality is actually your bottleneck. Several indicators suggest your training data needs improvement:

**Inconsistent model behavior across similar queries**: When your fine-tuned model handles one product question well but fails on structurally identical queries about different products, your training data likely lacks sufficient diversity or representative examples.

**Overfitting to training examples**: If your model reproduces training examples nearly verbatim but struggles with slight variations, you have insufficient examples or your examples are too similar. Adventure Works noticed their model could quote gear specifications from training data perfectly but failed when customers asked equivalent questions using different phrasing.

**Poor performance on edge cases**: When your model handles common scenarios well but fails on less frequent but important cases (like safety recommendations for extreme weather), your training data distribution doesn't match real-world query patterns.

**High variance in response quality**: If some responses demonstrate exactly the behavior you want while others from the same session completely miss the mark, your training data sends conflicting signals about desired behavior. This often occurs when manually curated datasets include examples with inconsistent quality standards.

**Model drift during fine-tuning**: When validation metrics improve initially then degrade, or when training loss decreases but validation loss increases, you're likely overfitting to low-quality or insufficiently diverse training data.

> [!TIP]
> **Diagnostic approach**: Before adding more data, analyze 20-30 failure cases to identify patterns. Do failures cluster around specific query types, response lengths, or domain topics? This analysis reveals whether you need more data, better data, or different data.

## Apply quality principles for training data

High-quality training data shares predictable characteristics regardless of fine-tuning method. Focus on these principles when preparing or evaluating datasets:

**Consistency**: Every example demonstrates the exact behavior you want to reinforce. Adventure Works reviews each gear specification response to ensure it follows their standard format—technical specs, pricing, availability, and complementary suggestions appear in consistent order. Mixed formats in training data produce mixed formats in outputs.

**Accuracy**: Examples contain factually correct information and appropriate recommendations. One inaccurate training example (like recommending summer gear for winter conditions) can corrupt model behavior across related scenarios. Verify domain correctness before including examples.

**Diversity**: Training data covers the full range of query variations, edge cases, and response scenarios your model will encounter. Adventure Works ensures their safety dataset includes varied experience levels, different seasons, multiple activity types, and diverse geographic contexts—not just summer hiking in one region.

**Clarity**: Each example unambiguously demonstrates one desired behavior. Avoid examples where the "correct" response requires subjective interpretation or where multiple valid approaches exist unless you're using preference pairs (DPO) that explicitly show which approach you prefer.

**Representativeness**: Training data distribution matches real-world usage patterns. If 40% of Adventure Works queries ask about waterproof ratings, but waterproof examples represent only 5% of training data, the model underperforms on a frequent use case.

> [!TIP]
> **Quality over quantity**: 100 high-quality diverse examples outperform 500 mediocre examples. Start with your best 50-100 examples, fine-tune, evaluate, then decide whether to expand volume or improve existing examples based on failure analysis.

## Understand data requirements by method

Different fine-tuning methods require different data structures. Prepare the format that matches your chosen optimization approach:

### Supervised Fine-Tuning (SFT) data format

SFT requires conversations in JSONL (JSON Lines) format with system instructions, user prompts, and ideal assistant responses:

```json
{"messages": [{"role": "system", "content": "You are an Xbox customer support agent whose primary goal is to help users with issues they are experiencing with their Xbox devices. You are friendly and concise. You only provide factual answers to queries."}, {"role": "user", "content": "Is Xbox better than PlayStation?"}, {"role": "assistant", "content": "I apologize, but I cannot provide personal opinions. My primary job is to assist you with any issues related to your Xbox device. Do you have any Xbox-related issues that need addressing?"}]}
```

For multi-turn conversations where you want to optimize only specific responses, use the optional `weight` parameter (0 = ignore, 1 = include for training):

```json
{"messages": [{"role": "system", "content": "Adventure Works Trail Guide provides helpful outdoor gear recommendations."}, {"role": "user", "content": "What's the waterproof rating on the StormShield jacket?"}, {"role": "assistant", "content": "IPX4 rated.", "weight": 0}, {"role": "user", "content": "What does that mean practically?"}, {"role": "assistant", "content": "The StormShield jacket has an IPX4 rating with 3000mm hydrostatic head, which means it handles light to moderate rain well. Perfect for day hikes in variable weather, though you might want additional protection for extended downpours.", "weight": 1}]}
```

### Reinforcement Fine-Tuning (RFT) and Direct Preference Optimization (DPO) data formats

RFT requires prompts plus a grader function (code or model-based) that scores response quality. The grader evaluates outputs during training to reinforce higher-scoring behaviors.

DPO requires preference pairs in JSONL format showing one prompt with two responses—one preferred (`chosen`) and one rejected:

```json
{"prompt": "I'm planning my first winter mountain hike in Scotland. What safety gear should I bring?", "chosen": "Winter mountain hiking in Scotland requires serious preparation, and it's great that you're thinking about safety! Here's what you'll need: navigation tools (map, compass, GPS), insulated and waterproof layers, emergency shelter, headlamp with spare batteries, first aid kit, and extra food and water. Given this is your first winter mountain hike, I'd also strongly recommend: going with an experienced group, checking weather forecasts carefully, and starting with a shorter route to build experience. The Scottish mountains demand respect, but with proper preparation, they offer incredible experiences.", "rejected": "Winter mountaineering is extremely dangerous for beginners. You need avalanche transceivers, ice axes, crampons, emergency shelter, PLB, first aid, backup navigation. Do not attempt this without professional training and experienced guides."}
```

> [!NOTE]
> **Format resources**: For detailed format specifications including multi-turn conversations, tool calls, and vision tasks, see [Microsoft Foundry fine-tuning data format documentation](/azure/ai-foundry/how-to/fine-tune-model-api#data-format).

## Make data-driven preparation decisions

Successful data preparation requires choosing between real data curation, synthetic generation, and hybrid approaches based on measurable criteria rather than intuition.

### Assess your data acquisition options

**Real data curation**: Best when you have existing chat logs, support tickets, or documented interactions showing actual desired behaviors. Adventure Works prioritized real data for gear specifications because they had 300 historical support interactions demonstrating their standard response format. Real data captures authentic query patterns and natural language variations users actually employ.

**When to choose real data**:
- Existing data demonstrates desired behaviors consistently
- Privacy/compliance allows using actual interactions (with PII removal)
- You need authentic query patterns and edge cases
- Budget favors manual curation time over API costs

**Synthetic data generation**: Best when real data is scarce, contains privacy concerns, or doesn't cover needed scenarios. Microsoft Foundry's Simple Q&A Generator can create training examples from product documentation, while the Tool use Generator creates function-calling examples from API specifications.

**When to choose synthetic data**:
- Insufficient real examples exist (fewer than 30-50)
- Privacy regulations prevent using real interactions
- Need to cover scenarios not yet encountered
- Want consistent quality standards across all examples
- Reference documentation exceeds manual conversion feasibility

**Hybrid approaches**: Combine real data's authenticity with synthetic data's coverage. Adventure Works used real data for common gear queries (abundant examples) but generated synthetic data for rare scenarios like equipment failures or extreme weather conditions where real examples were scarce.

### Implement iterative data refinement

Don't aim for perfect data before your first fine-tuning job—refine based on evidence:

1. **Start small**: Begin with your best 50-100 examples that clearly demonstrate desired behavior
1. **Fine-tune and deploy**: Train a model using Developer tier (free hosting for 24 hours) to validate approach
1. **Analyze failures**: Test on 20-30 representative queries, document what succeeds and fails
1. **Diagnose gaps**: Categorize failures—missing query types? Inconsistent quality? Wrong examples?
1. **Targeted expansion**: Add 20-50 examples specifically addressing identified gaps
1. **Retrain and compare**: Fine-tune again, comparing metrics to previous iteration
1. **Repeat until sufficient**: Continue refinement cycles until validation metrics meet requirements

Adventure Works discovered their initial gear specification dataset lacked examples for comparison queries ("Which is better, X or Y?"). Rather than doubling dataset size randomly, they added 30 targeted comparison examples—the next fine-tuning iteration improved comparison query performance by 40% while adding only 10% more data.

> [!TIP]
> **Validation splits**: Always reserve 15-20% of your data for validation (never seen during training). Improving training metrics while validation metrics stagnate or degrade signals overfitting—you need more diverse data, not more of the same data.

### Optimize synthetic data generation

When using Microsoft Foundry's synthetic data generators, apply these strategies for quality:

**Reference file quality**: The generator's output quality directly reflects input document quality. Adventure Works improved synthetic safety recommendation examples 35% by restructuring their safety guide with clearer section headings, removing marketing copy, and adding explicit reasoning for each recommendation.

**Sample size calibration**: Start with 100 samples, evaluate quality on 10-15 examples, then scale to 300-500 if quality is acceptable. Generating 1,000 samples rarely improves outcomes proportionally—diversity matters more than volume.

**Question type alignment**: For Simple Q&A Generator, choose "long answer" when optimizing reasoning and explanation quality, "short answer" when optimizing factual accuracy and brevity. Adventure Works uses long answer for safety recommendations (needs explanation) and short answer for inventory status queries (needs facts).

**Hybrid augmentation**: Generate synthetic data, then manually review and edit 20-30% of examples to inject quality standards the generator might miss. This hybrid creates volume efficiently while maintaining human quality oversight.

By making data-driven decisions about acquisition strategy, implementing iterative refinement, and optimizing synthetic generation when appropriate, you prepare training data that maximizes fine-tuning effectiveness while minimizing wasted effort.
