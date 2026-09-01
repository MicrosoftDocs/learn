Hyperparameter tuning helps you select hyperparameter values that improve model performance.

Each additional trial consumes time and compute. You need to decide whether continuing a poorly performing trial is likely to produce useful results.

Each trial in a sweep job trains a model with a different combination of hyperparameter values. An early termination policy stops individual trials that underperform while the remaining trials continue.

You can also limit the complete sweep by setting a maximum number of trials or a timeout. Use an **early termination policy** when you want Azure Machine Learning to stop poorly performing trials based on their reported primary metric.

## When to use an early termination policy

Whether you want to use an early termination policy may depend on the search space and sampling method you're working with. 

For example, you may choose *grid sampling* over a *discrete* search space that results in six trials. Because the sweep trains only six models, an early termination policy may be unnecessary.

An early termination policy can be especially beneficial when working with continuous hyperparameters. Continuous search spaces contain many possible values, so random or Bayesian sampling can start trials that aren't promising.

## Configure an early termination policy

There are two main parameters when you choose to use an early termination policy:

- `evaluation_interval`: Specifies at which interval you want the policy to be evaluated. Every time the primary metric is logged for a trial counts as an interval. 
- `delay_evaluation`: Specifies how many metric-reporting intervals occur before the policy first evaluates each trial. This delay gives every trial time to make initial progress.

Azure Machine Learning supports three policies for comparing active trials:

- **Bandit policy**: Uses a `slack_factor` (relative) or `slack_amount` (absolute). A trial must remain within the allowed slack of the best-performing trial.
- **Median stopping policy**: Compares a trial's running average with the median of the running averages for all trials.
- **Truncation selection policy**: Cancels a percentage of the lowest-performing trials at each evaluation interval.

## Bandit policy

You can use a bandit policy to stop a trial if the target performance metric underperforms the best trial so far by a specified margin.

For example, the following code delays evaluation for five metric-reporting intervals, evaluates the policy at every interval after the delay, and allows an absolute slack amount of 0.2.

```python
from azure.ai.ml.sweep import BanditPolicy

sweep_job.early_termination = BanditPolicy(
    slack_amount = 0.2, 
    delay_evaluation = 5, 
    evaluation_interval = 1
)
```

Imagine the primary metric is model accuracy. At an evaluation interval, the best-performing trial has an accuracy of 0.9. With a slack amount of 0.2, another active trial must report at least 0.7 to continue. The policy terminates that trial when its best reported accuracy falls below the threshold; it doesn't stop the sweep.

:::image type="content" source="../media/bandit-policy.png" alt-text="Diagram of two examples when using a bandit policy: one model performs sufficiently good, the other underperforms.":::

You can also apply a bandit policy using a slack *factor*, which compares the performance metric as a ratio rather than an absolute value.

## Median stopping policy

A median stopping policy abandons trials where the target performance metric is worse than the median of the running averages for all trials.

For example, the following code applies a median stopping policy after a delay of five metric-reporting intervals and then evaluates the policy at every interval.

```python
from azure.ai.ml.sweep import MedianStoppingPolicy

sweep_job.early_termination = MedianStoppingPolicy(
    delay_evaluation = 5, 
    evaluation_interval = 1
)
```

Imagine the primary metric is model accuracy. At the sixth reporting interval, the policy compares each trial's running average with the median running average across the trials. If that median is 0.82, the policy stops a trial whose running average is below 0.82. Other trials and the overall sweep continue.

:::image type="content" source="../media/median-stopping.png" alt-text="Diagram of two examples when using a median stopping policy: one model performs sufficiently good, the other underperforms.":::

## Truncation selection policy

A truncation selection policy cancels the lowest performing *X*% of trials at each evaluation interval based on the *truncation_percentage* value you specify for *X*.

For example, the following code applies a truncation selection policy with a delay of four trials, evaluates the policy at every interval, and uses a truncation percentage of 20%.

```python
from azure.ai.ml.sweep import TruncationSelectionPolicy

sweep_job.early_termination = TruncationSelectionPolicy(
    evaluation_interval=1, 
    truncation_percentage=20, 
    delay_evaluation=4 
)
```

Imagine the primary metric is model accuracy. At the fifth reporting interval, the policy ranks the active trials and cancels the lowest-performing 20%. The remaining trials and the overall sweep continue.

:::image type="content" source="../media/truncation-selection.png" alt-text="Diagram of two examples when using a truncation selection policy: one model performs sufficiently good, the other underperforms.":::