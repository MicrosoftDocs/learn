After preparing quality training data, the next challenge involves configuring fine-tuning parameters and interpreting metrics to optimize model performance. This unit covers [understanding key training configurations](#understand-key-training-configurations), [monitoring and interpreting training metrics](#monitor-and-interpret-training-metrics), and [making optimization decisions based on evidence](#make-optimization-decisions-based-on-evidence).

## Understand key training configurations

Fine-tuning jobs expose several hyperparameters that significantly impact model quality, training time, and cost. Focus on these key configurations:

### Batch size

**What it controls**: Number of training examples processed together in one forward-backward pass during training. The model updates parameters after processing each batch.

**How it affects training**:
- **Larger batches** (8-32): More stable parameter updates with lower variance, faster training on powerful hardware, but requires more memory and may struggle with small datasets
- **Smaller batches** (1-4): Higher variance in updates can help escape local optima, works with limited memory, but training takes longer

**Optimization strategy**: Microsoft Foundry sets model-specific defaults that work for most cases. Start with defaults. If training is unstable (loss fluctuates wildly), increase batch size. If overfitting occurs (training loss decreases but validation loss increases), decrease batch size to add regularization through noise.

Adventure Works kept default batch size for their gear specification SFT (dataset of 300 examples) but reduced it for their safety recommendation DPO (only 80 preference pairs) to prevent overfitting.

### Learning rate multiplier

**What it controls**: Scaling factor applied to the base learning rate. The effective learning rate = base model's pretrained learning rate × multiplier. Controls how aggressively the model adjusts parameters during fine-tuning.

**How it affects training**:
- **Higher multipliers** (0.1-0.2): Faster adaptation to training data, risks overshooting optimal parameters or catastrophic forgetting of pretrained knowledge
- **Lower multipliers** (0.02-0.05): Gentler adaptation preserving more pretrained knowledge, slower convergence, may underfit if too conservative

**Optimization strategy**: Recommended range is 0.02-0.2. Start with 0.05-0.1 as baseline. If training loss remains high after multiple epochs, try 0.15-0.2. If validation loss increases while training loss decreases (overfitting), reduce to 0.02-0.05. Larger batch sizes generally pair well with higher learning rates.

Adventure Works used 0.08 for SFT (standard adaptation), 0.05 for DPO (gentler to preserve nuanced tone preferences), and 0.12 for RFT (needed stronger signal for complex reasoning).

### Number of epochs

**What it controls**: How many times the model sees the entire training dataset. One epoch = one complete pass through all training examples.

**How it affects training**:
- **More epochs** (5-10): Better convergence, higher risk of overfitting, increased cost
- **Fewer epochs** (1-3): Faster and cheaper, may underfit, leaves performance on table

**Optimization strategy**: Start with 3-4 epochs. Monitor validation metrics—if validation loss stops improving or starts increasing while training loss keeps decreasing, you're overfitting and should reduce epochs. If both training and validation loss are still decreasing at your final epoch, add 1-2 more epochs.

Adventure Works trained gear specification SFT for 4 epochs (300 diverse examples), safety DPO for 6 epochs (80 preference pairs needed more exposure), and trip planning RFT for 8 epochs (complex reasoning requires more iterations).

### Seed

**What it controls**: Random seed for reproducibility. Same seed + same data + same parameters should produce nearly identical results (small differences can occur due to hardware variations).

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

Effective optimization requires systematic experimentation informed by metrics rather than random hyperparameter adjustments.

### Establish a baseline

Before optimization, train one model with default parameters to establish baseline performance:

1. Use default batch size, learning rate multiplier (0.05-0.1), 3-4 epochs
1. Reserve 15-20% of data for validation
1. Deploy to Developer tier for 24-hour testing
1. Measure baseline: validation loss, token accuracy, real-world test performance on 20-30 queries

Adventure Works' baseline gear specification SFT achieved: validation loss 1.3, token accuracy 78%, 85% format consistency on manual test set.

### Diagnose performance problems

Based on metrics and real-world testing, identify the root cause:

| Symptom | Likely Cause | Optimization Action |
|---------|--------------|---------------------|
| Both training and validation loss high | Underfitting—insufficient learning | Increase learning rate (try 1.5-2× current), add more epochs, verify data quality |
| Training loss low, validation loss high | Overfitting—memorizing training data | Decrease epochs (remove 1-2), lower learning rate (try 0.5× current), add more diverse data |
| Training unstable (loss fluctuates) | Batch size too small or learning rate too high | Increase batch size if possible, halve learning rate |
| Metrics good but real-world performance poor | Data doesn't represent real usage | Revise training data to match actual query patterns |
| Fast convergence then plateau | Hit local optimum or data limitations | Try different learning rate schedule, add data diversity, or accept current performance |

### Implement iterative refinement

Optimize through controlled experiments:

1. **Change one variable**: Adjust one hyperparameter while keeping others constant to isolate effects
1. **Compare validation metrics**: Train new model, compare validation loss and task accuracy to baseline
1. **Test real-world impact**: Deploy improved model, test on same 20-30 queries as baseline
1. **Measure practical improvement**: Does the metric improvement translate to better user experience?
1. **Iterate or deploy**: If improvement is substantial (>5%), consider one more refinement cycle; otherwise deploy

Adventure Works tried three configurations for their trip planning RFT:
- **Config A** (baseline): learning_rate=0.08, epochs=6 → validation loss 0.9, 72% reasoning quality
- **Config B**: learning_rate=0.12, epochs=6 → validation loss 0.85, 78% reasoning quality (+6%)
- **Config C**: learning_rate=0.12, epochs=8 → validation loss 0.82, 79% reasoning quality (+1% vs B)

They deployed Config B—the improvement from B to C didn't justify additional training cost and the risk of overfitting.

### Balance cost and quality

Fine-tuning optimization involves trade-offs between performance, cost, and time:

- **Developer tier**: Free hosting (auto-deletes after 24 hours)—use for all experimentation and validation
- **Standard tier**: Hourly hosting fees—deploy only validated models for production use
- **Training costs**: Token-based (SFT/DPO) or time-based (RFT)—more epochs and iterations increase costs

The optimal model isn't the one with the lowest validation loss—it's the one delivering acceptable performance at sustainable cost. Adventure Works determined 85% format consistency met their requirements, so they deployed Config B for gear specifications rather than chasing 90%+ through expensive additional iterations.

> [!TIP]
> **Optimization stopping criteria**: Stop optimization when: (1) validation metrics meet your quality threshold, (2) real-world testing shows acceptable performance, (3) marginal improvements are under 3-5%, or (4) additional training cost exceeds value of improvement. Perfect isn't necessary—sufficient is optimal.

By understanding how configurations affect training, monitoring metrics to diagnose problems, and making evidence-based decisions through systematic experimentation, you optimize fine-tuning investments for maximum practical impact while controlling costs.