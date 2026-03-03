After preparing quality training data, the next challenge involves configuring fine-tuning parameters and interpreting metrics to optimize model performance. This unit covers understanding key training configurations, monitoring and interpreting training metrics, and making optimization decisions based on evidence.

## Understand key training configurations

Fine-tuning jobs expose several hyperparameters that significantly impact model quality, training time, and cost. Focus on these key configurations:

### Batch size

**What it controls**: Number of training examples processed together in one forward-backward pass during training. The model updates parameters after processing each batch.

**How it affects training**:

| **Larger batches** (8-32) | **Smaller batches** (1-4) |
| --- | --- |
| More stable parameter updates with lower variance, faster training on powerful hardware, but requires more memory and may struggle with small datasets | Higher variance in updates can help escape local optima, works with limited memory, but training takes longer |

**Optimization strategy**: Microsoft Foundry sets model-specific defaults that work for most cases. Start with defaults. If training is unstable (loss fluctuates wildly), increase batch size. If overfitting occurs (training loss decreases but validation loss increases), decrease batch size to add regularization through noise.

### Learning rate multiplier

**What it controls**: Scaling factor applied to the base learning rate. The effective learning rate = base model's pretrained learning rate × multiplier. Controls how aggressively the model adjusts parameters during fine-tuning.

**How it affects training**:

| **Higher multipliers** (0.1-0.2) | **Lower multipliers** (0.02-0.05) |
| --- | --- |
| Faster adaptation to training data, risks overshooting optimal parameters or catastrophic forgetting of pretrained knowledge | Gentler adaptation preserving more pretrained knowledge, slower convergence, may underfit if too conservative |

**Optimization strategy**: Recommended range is 0.02-0.2. Start with 0.05-0.1 as baseline. If training loss remains high after multiple epochs, try 0.15-0.2. If validation loss increases while training loss decreases (overfitting), reduce to 0.02-0.05. Larger batch sizes generally pair well with higher learning rates.

### Number of epochs

**What it controls**: How many times the model sees the entire training dataset. One epoch = one complete pass through all training examples.

**How it affects training**

|**More epochs** (5-10) | **Fewer epochs** (1-3) |
|---|---|
| Better convergence, higher risk of overfitting, increased cost | Faster and cheaper, may underfit, leaves performance on table |

**Optimization strategy**: Start with 3-4 epochs. Monitor validation metrics—if validation loss stops improving or starts increasing while training loss keeps decreasing, you're overfitting and should reduce epochs. If both training and validation loss are still decreasing at your final epoch, add 1-2 more epochs.

### Seed

**What it controls**: Random seed for reproducibility. The same seed with the same data and the same parameters should produce nearly identical results (small differences can occur due to hardware variations).

**Optimization strategy**: Set a fixed seed when comparing configuration changes—this isolates the effect of your hyperparameter adjustment from random variation. Use different seeds when training production models to avoid inadvertent memorization patterns.

> [!TIP]
> **Configuration interdependencies**: These parameters interact. Larger batch sizes typically benefit from higher learning rates. Smaller datasets need fewer epochs and lower learning rates to avoid overfitting. When changing one parameter, consider adjusting related ones.

## Monitor and interpret training metrics

Microsoft Foundry provides training and validation metrics during and after fine-tuning. Understanding what these metrics reveal guides optimization decisions.

### Training loss

**What it measures**: Average prediction error on training data during each epoch. Lower values indicate the model better predicts training examples.

**What to watch for**:

- **Steadily decreasing**: Normal healthy training progression
- **Plateaus early**: Model may need higher learning rate, more epochs, or better data quality
- **Fluctuates wildly**: Batch size too small or learning rate too high—training is unstable
- **Increases mid-training**: Extremely rare; suggests learning rate far too high causing divergence

Adventure Works saw training loss decrease from 2.1 → 1.8 → 1.5 → 1.3 across 4 epochs for their gear specification SFT—steady convergence indicated good configuration.

### Validation loss

**What it measures**: Average prediction error on held-out validation data (never seen during training). Measures generalization to new examples.

**What to watch for**:

- **Decreases with training loss**: Ideal scenario—model learns genuine patterns that generalize
- **Plateaus while training loss decreases**: Early overfitting signal—model memorizing training data
- **Increases while training loss decreases**: Clear overfitting—stop training or use fewer epochs
- **Much higher than training loss**: Gap indicates overfitting degree; some gap is normal, large gaps are problematic

Adventure Works tracked their safety DPO validation loss carefully. It decreased epochs 1-4 (1.9 → 1.6 → 1.4 → 1.3) then increased epoch 5-6 (1.4 → 1.5). They deployed the epoch 4 checkpoint rather than the final model since validation loss indicated epoch 4 generalized better.

### Token accuracy (when available)

**What it measures**: Percentage of predicted tokens matching expected tokens in validation set. Higher percentages indicate better prediction accuracy.

**What to watch for**:

- **Improving steadily**: Good learning signal
- **Very high (>95%)**: May indicate data leakage, overfitting, or excessively simple task
- **Very low (<40%)**: May indicate task too difficult, data quality issues, or configuration problems

### Full-evaluation metrics

**What it measures**: After training completes, Fine-Tuning API calculates comprehensive metrics on your validation set including perplexity, exact match rates, and task-specific scores.

**What to watch for**: Compare these metrics across different fine-tuning runs when testing hyperparameter changes. A 5% improvement in validation accuracy represents meaningful progress; differences under 2% may be noise.

> [!NOTE]
> **Metrics by method**: SFT, DPO, and RFT report similar loss metrics, but RFT additionally shows reward signals from your grader function. Higher average rewards across epochs indicate the model learns to optimize for your grading criteria.

## Make optimization decisions based on evidence

Effective optimization requires systematic experimentation informed by metrics rather than random hyperparameter adjustments. Follow this workflow to move from baseline to production-ready models while balancing quality and cost:

1. **Establish baseline performance**: Train one model with default parameters (batch size default, learning rate 0.05-0.1, 3-4 epochs). Reserve 15-20% of data for validation. Deploy to Developer tier for 24-hour testing. Measure validation loss, token accuracy, and real-world performance on 20-30 test queries.

1. **Diagnose performance problems**: Use metrics and testing to identify root causes. If both training and validation loss are high (underfitting), increase learning rate or add epochs. If training loss is low but validation loss is high (overfitting), decrease epochs or lower learning rate. If training is unstable (loss fluctuates), increase batch size or halve learning rate. If metrics look good but real-world performance is poor, revise training data to match actual usage patterns.

1. **Run controlled experiments**: Change one hyperparameter at a time while keeping others constant to isolate effects. Train the new model and compare validation metrics to baseline. Deploy the improved model and test on the same queries used for baseline. Measure whether metric improvements translate to better user experience.

1. **Iterate or deploy**: If improvement is substantial (>5%), consider one more refinement cycle. Otherwise, deploy the current model. Remember that the optimal model delivers acceptable performance at sustainable cost—not necessarily the lowest validation loss.

1. **Manage deployment costs**: Use Developer tier (free hosting, auto-deletes after 24 hours) for all experimentation. Deploy validated models to Standard tier for production (incurs hourly hosting fees). Factor in training costs—token-based for SFT/DPO, time-based for RFT—as more epochs and iterations increase expenses.

Adventure Works followed this workflow for their trip planning RFT. Their baseline (Config A: learning_rate=0.08, epochs=6) achieved validation loss 0.9 and 72% reasoning quality. Config B (learning_rate=0.12, epochs=6) improved to validation loss 0.85 and 78% reasoning quality (+6%). Config C (learning_rate=0.12, epochs=8) reached validation loss 0.82 and 79% reasoning quality (+1% vs B). They deployed Config B because the marginal improvement from B to C didn't justify additional training cost and overfitting risk.

Stop optimization when validation metrics meet your quality threshold, real-world testing shows acceptable performance, marginal improvements fall under 3-5%, or additional training cost exceeds the value of improvement. Perfect isn't necessary—sufficient is optimal.

By understanding how configurations affect training, monitoring metrics to diagnose problems, and making evidence-based decisions through systematic experimentation, you optimize fine-tuning investments for maximum practical impact while controlling costs.