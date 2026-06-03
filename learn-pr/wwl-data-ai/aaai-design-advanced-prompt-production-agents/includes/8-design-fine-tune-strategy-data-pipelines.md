Microsoft Foundry supports supervised fine-tuning, Direct Preference Optimization, and Reinforcement Fine-Tuning so you can specialize models for domain-specific tasks when prompt engineering alone is insufficient. In this unit, you design a fine-tuning strategy and build the data preparation pipeline that supports it.

Northwind Health's clinical reasoning agent handles 200 different chronic disease management scenarios. Prompt engineering has covered 80% of scenarios well—clear chain-of-thought architecture, structural delimiters, system-prompt constraints, and guardrails. But 20% of scenarios involve highly specialized clinical terminology and reasoning patterns that general-purpose models handle inconsistently. The prompt has become a 4,000-token instruction set trying to teach the model clinical reasoning conventions that a fine-tuned model would internalize. Prompt length is increasing latency and cost for every request, including the 80% that didn't need the extra instructions.

Fine-tuning offers a different answer: instead of teaching the model at inference time (via increasingly complex prompts), teach it during training (via fine-tuning data). But fine-tuning has real costs—data preparation, training runs, evaluation, deployment, and retraining cadence—that must be weighed against prompt engineering alternatives.

## Fine-tune versus prompt-optimize decision framework

Fine-tuning is appropriate when several conditions combine. Use the decision matrix to make an evidence-based choice rather than defaulting to fine-tuning because it seems more "sophisticated":

| Criterion | Fine-tune | Prompt-optimize |
|---|---|---|
| **Task consistency** | Highly consistent task with well-defined correct outputs | Task varies significantly across inputs |
| **Prompt length pressure** | System prompt exceeds 2,000 tokens and keeps growing | Prompt is stable and fits within budget |
| **Latency requirements** | Strict P95 latency SLA that long prompts violate | Latency budget is flexible |
| **Data availability** | 500+ high-quality labeled examples available | Insufficient labeled data (< 100 examples) |
| **Inference cost** | Volume is high enough that training cost is amortized | Low request volume; training cost exceeds inference savings |
| **Domain vocabulary** | Highly specialized vocabulary the base model doesn't know well | General-purpose vocabulary covered by base model |

Northwind Health's scenario hits four criteria: highly consistent clinical reasoning structure, prompt length pressure, strict latency requirements, and a corpus of 8,000 labeled clinical reasoning examples from previous agent outputs that clinicians have reviewed and corrected. Fine-tuning is justified.

**When to stay with prompt engineering:** If you have fewer than 500 high-quality examples, the fine-tuning data cost exceeds the benefit. If your task changes frequently (regulatory updates, new product lines), retraining cadence makes prompt updates more cost-effective. If the failure mode is about reasoning depth rather than domain vocabulary, chain-of-thought prompting (Unit 2) addresses reasoning failures more directly than fine-tuning.

**Choosing a fine-tuning method:** Microsoft Foundry supports three fine-tuning approaches. Select based on your objective and available data:

- **Supervised fine-tuning (SFT)**—train on labeled input/output pairs to internalize format, vocabulary, and reasoning patterns. Best for task specialization with consistent input/output structure, such as Northwind Health's clinical reasoning scenario.
- **Direct Preference Optimization (DPO)** (preview)—align the model with human-preferred responses using preference pairs (preferred versus rejected outputs), without requiring a separate reward model. Best for improving response quality, tone, and alignment when you have human reviewer feedback ranking outputs.
- **Reinforcement Fine-Tuning (RFT)** (preview)—use reward signals from model graders to optimize complex reasoning behaviors across dynamic tasks where the solution space is large. Best for o-series models where the goal is iterative reasoning improvement, such as multistep clinical decision workflows with verifiable correctness.

The data pipeline described in the following sections applies to SFT. DPO requires preference-pair format (two competing responses per input with a preference label), and RFT requires grader configuration rather than statically labeled examples.

## Fine-tuning strategy design

Once you've decided to fine-tune, design the strategy before preparing data:

**Base model selection:** Start from the smallest model that meets quality requirements after fine-tuning. Smaller fine-tuned models (Phi-4-mini fine-tuned) frequently outperform larger base models (GPT-4o without fine-tuning) on narrow, consistent tasks and at significantly lower inference cost. Benchmark candidate base models on your domain task before committing to fine-tuning infrastructure.

**Fine-tuning objectives:** Define what the model should learn that it doesn't know from pre-training:
- *Format internalization*—the model consistently produces a specific JSON schema without requiring lengthy output-format instructions in the system prompt.
- *Domain vocabulary*—the model correctly uses clinical terminology, abbreviations, and reasoning conventions specific to your organization.
- *Task-specific reasoning patterns*—the model applies a specific multistep reasoning chain (extract → classify → assess → recommend) consistently without in-context chain-of-thought prompts.

**Data volume thresholds:** Instruction fine-tuning typically requires 500-5,000 high-quality examples for format and style learning; 1,000-10,000+ for domain vocabulary; 5,000+ for reasoning-pattern internalization. Quality matters more than quantity—500 carefully reviewed examples outperform 5,000 noisy examples. Invest in data quality review before training.

**Retraining frequency triggers:** Fine-tuned models degrade when the real-world distribution drifts from training data. Define explicit triggers:
- *Data drift*: input distribution shifts (new clinical scenarios, updated guidelines) beyond a threshold measured by embedding distance.
- *Performance degradation*: evaluation metrics drop below defined baselines on a held-out test set.
- *Domain expansion*: adding a new specialty or disease category that the current training corpus doesn't represent.
- *Schedule*: quarterly retraining as a minimum cadence to capture accumulated labeled data from production corrections.

## Data preparation pipelines

The quality of fine-tuning data determines whether the fine-tuned model improves on the base model. Data preparation isn't a one-time activity—it's a pipeline that runs continuously as you accumulate new training examples.

### Data curation

Curate training data from production sources systematically:
- **Agent output corrections**—when clinicians flag an incorrect or suboptimal agent response, the correction pair (input → corrected output) is a high-value training example. Implement a feedback collection workflow that routes clinician corrections to the curation pipeline.
- **Positive examples**—identify agent outputs that clinicians explicitly approved or that led to successful patient outcomes. These positive examples reinforce desirable reasoning patterns.
- **Synthetic examples**—for coverage areas where production examples are sparse (rare conditions, edge-case medication combinations), generate synthetic examples using a capable teacher model (e.g., GPT-4o generates examples that a smaller model will learn from). Validate synthetic examples against clinical guidelines before including them.

**Curation quality filters:**
- Remove examples where the clinician's correction was ambiguous or conflicting.
- Remove examples involving PHI that wasn't properly de-identified.
- Check for duplicates and near-duplicates (high embedding similarity) that would over-represent specific patterns.
- Verify output-format conformance—training examples where the output doesn't match the target schema teach the wrong format.

### Formatting for instruction fine-tuning

Microsoft Foundry and OpenAI fine-tuning APIs accept data in JSONL format with the OpenAI chat completion message structure:

```json
{"messages": [
  {"role": "system", "content": "<abbreviated system prompt—remove verbose instructions the model should internalize>"},
  {"role": "user", "content": "Patient presents with HbA1c of 9.2% on metformin 1000mg BID. Current weight: 94kg. History of stage 2 CKD."},
  {"role": "assistant", "content": "{\"extracted_facts\": [{\"fact\": \"HbA1c 9.2%\", \"significance\": \"above_target\", \"guideline_ref\": \"ADA-2026-T2DM-glycemic\"}, ...], \"risk_assessment\": {...}, \"recommendation\": {\"action\": \"Consider adding GLP-1 agonist\", \"rationale\": \"...\", \"clinician_review_required\": true}}"}
]}
```

Key formatting decisions:
- **Abbreviate the system prompt** in training examples to the core identity and constraints—the model is learning the reasoning and format, not memorizing a long system prompt. The production system prompt remains in inference deployments.
- **Include clinician review language** in every assistant turn that involves a recommendation—this reinforces the model's understanding that all recommendations require human oversight.
- **Use the exact output schema** that your production guardrails validate—training on malformed schemas teaches the model to produce outputs your validation pipeline rejects.

### Validation and held-out test sets

Before training, allocate your curated dataset:
- **Training set**: 80% of examples, shuffled to prevent ordering artifacts.
- **Validation set**: 10% of examples, used during training to monitor overfitting. Training stops when validation loss plateaus or increases.
- **Test set**: 10% of examples, held out until after training completes. This is your honest estimate of fine-tuned model quality—never use the test set for training decisions.

**Evaluation metrics for clinical fine-tuning:**
- *Format conformance rate*: what percentage of outputs validate against the target JSON schema?
- *Task accuracy*: on the held-out test set, what percentage of recommendations match clinician-reviewed gold-standard responses?
- *Safety guardrail pass rate*: run the fine-tuned model against your guardrail test suite—fine-tuning can inadvertently reduce resistance to injection attacks if safety examples aren't included in training data.

### Data versioning

Fine-tuning datasets must be versioned alongside model versions. When a production incident traces to a training data problem, you need to identify exactly which dataset version trained the affected model. Use the same version-manifest pattern as your agent versioning practice. Store the dataset hash, training example count, source collection date range, curation filter configuration, and evaluator IDs for the clinicians who reviewed corrections.

Azure Machine Learning Data Assets provide versioned dataset storage with lineage tracking—the training run records which dataset version it consumed, creating a traceable chain from production incident → model version → training dataset → specific problematic examples.
