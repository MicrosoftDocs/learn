You selected your fine-tuning method and prepared quality training data. Before submitting your first training job, invest time in two critical decisions: establishing a clear optimization strategy and understanding how hyperparameters control the training process. These decisions determine whether your fine-tuning job produces a genuinely better model or wastes compute resources on a poorly configured run.

## Design your optimization strategy

A clear optimization strategy prevents the most common fine-tuning failure: training a model without knowing whether it improved. Three steps define the strategy: benchmark the base model, set measurable targets, and split the dataset before training begins.

**Evaluate your base model**

Run your evaluation dataset through the unmodified base model and record scores for the Microsoft Foundry metrics relevant to your quality problem—coherence, relevance, fluency, groundedness, or a custom evaluator. This baseline becomes your reference point. Without it, you can't determine whether fine-tuning improved, degraded, or had no effect.

> [!NOTE]
> For RFT, run the grader function against the base model's outputs on your validation set and record the reward scores. The grader is the same instrument you'll use to measure improvement after training, so using it for the baseline gives you a direct before-and-after comparison.

**Define target performance**

Set specific, measurable thresholds before training. A goal like "improve response quality" has no finish line. Quantified targets let you determine when the model is production-ready and prevent unnecessary extra training rounds.

After training, compare your fine-tuned model's scores against these thresholds using the same evaluation dataset you used for the baseline.

**Split your dataset**

Divide your prepared data into training and validation sets before training begins. The training set teaches the model; the validation set measures how well it generalizes to unseen examples. Keep the two sets strictly separate—overlap makes evaluation metrics look better than they are.

| Adventure Works dataset split | |
|---|---|
| **Total examples** | 300 gear interactions |
| **Training set (80%)** | 240 examples |
| **Validation set (20%)** | 60 examples |

> [!TIP]
> If your dataset has fewer than 100 examples, consider a 90/10 split to maximize training data while preserving enough validation examples for meaningful evaluation.

> [!NOTE]
> RFT can work effectively with far fewer examples than SFT because the model doesn't learn from ground-truth outputs—it learns from reward scores. A split like 100 training examples and 50 validation examples is often sufficient to get meaningful results.

## Configure training hyperparameters

Hyperparameters control how the training algorithm learns from your data. Three hyperparameters appear across all fine-tuning methods—supervised fine-tuning (SFT), direct preference optimization (DPO), and reinforcement fine-tuning (RFT). Start with the defaults and adjust one at a time based on evaluation results.

| Hyperparameter | Default | Typical range | How to adjust |
|---|---|---|---|
| `n_epochs` | 3 | 1–10 | Increase if evaluation scores remain low after training (underfitting). Decrease if scores are high but the model behaves unexpectedly on new inputs (overfitting). |
| `batch_size` | 1 | 1–8 | Increase to 2–4 for larger datasets to speed up training. Keep at 1–2 when training stability matters, such as with DPO. |
| `learning_rate_multiplier` | 1.0 | 0.1–2.0 | Reduce below 1.0 for more conservative updates if training is unstable. Increase above 1.0 to speed up learning, but watch for erratic results. |

Select the tab for your method to see how to pass these hyperparameters when creating a job.

# [Supervised Fine-Tuning (SFT)](#tab/sft)

Pass hyperparameters inside the `supervised` method block:

```python
fine_tuning_job = openai_client.fine_tuning.jobs.create(
    training_file=train_file_id,
    validation_file=val_file_id,
    model=model_name,
    method={
        "type": "supervised",
        "supervised": {
            "hyperparameters": {
                "n_epochs": 3,
                "batch_size": 1,
                "learning_rate_multiplier": 1.0
            }
        }
    }
)
```

# [Direct Preference Optimization (DPO)](#tab/dpo)

Pass hyperparameters inside the `dpo` method block. DPO is more sensitive to training instability than SFT—keep `batch_size` at one or two, and reduce `learning_rate_multiplier` first if results are erratic:

```python
fine_tuning_job = openai_client.fine_tuning.jobs.create(
    training_file=train_file_id,
    validation_file=val_file_id,
    model=model_name,
    method={
        "type": "dpo",
        "dpo": {
            "hyperparameters": {
                "n_epochs": 3,
                "batch_size": 1,
                "learning_rate_multiplier": 1.0
            }
        }
    }
)
```

# [Reinforcement Fine-Tuning (RFT)](#tab/rft)

RFT includes three extra parameters inside the `reinforcement` block. `eval_interval` controls how often (every N steps) the grader scores the model during training. `eval_samples` sets how many examples are scored at each interval. `reasoning_effort` (`low`, `medium`, or `high`) controls how much compute the model uses when generating responses during training. Because the grader provides continuous feedback, RFT typically needs fewer epochs than SFT—default is two instead of three:

```python
fine_tuning_job = openai_client.fine_tuning.jobs.create(
    training_file=train_file_id,
    validation_file=val_file_id,
    model=model_name,
    method={
        "type": "reinforcement",
        "reinforcement": {
            "grader": grader,
            "hyperparameters": {
                "n_epochs": 2,
                "batch_size": 1,
                "learning_rate_multiplier": 1.0,
                "eval_interval": 5,
                "eval_samples": 2,
                "reasoning_effort": "medium"
            }
        }
    }
)
```

---

## Iterate on your results

Start with the default hyperparameters for your first training run. After evaluating results against your baseline, adjust one hyperparameter at a time. When you change multiple values simultaneously, it can be impossible to determine which change drove any improvement or regression.

Fine-tuning rarely produces a perfect model on the first attempt. If your fine-tuned model doesn't meet your target thresholds, you don't have to start over. You can use the fine-tuned model itself as the base for another training round, adjusting hyperparameters, incorporating more data, or targeting a more specific task without discarding the progress already made.

The most effective fine-tuning process is a loop: evaluate, adjust, retrain, and repeat until the model consistently meets your quality targets.
