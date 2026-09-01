Deploying the no-show model safely gets it into production, but production is where a model's real behavior, and the data it sees, can start to drift from what the data science team designed for. Monitoring is how you catch that.

## Watch the endpoint's operational health

Azure Machine Learning online endpoints emit metrics to **Azure Monitor**, including request latency, request count, error rate, and the CPU and memory utilization of the deployment's compute. You view these in Azure Machine Learning studio, or build alerts and dashboards on them directly in Azure Monitor. If the endpoint's error rate spikes or latency climbs, that pattern points to an infrastructure or scoring issue to investigate, separate from whether the model's predictions are still accurate.

> [!TIP]
> Learn more about [monitoring online endpoints](/azure/machine-learning/how-to-monitor-online-endpoints).

If a deployment fails to provision or score requests, first separate configuration problems from runtime problems. Test the model locally when possible, review the deployment state and error details, and inspect its container logs. The logs can reveal missing dependencies, invalid scoring behavior, image failures, or resource and quota constraints.

> [!TIP]
> Learn more about [troubleshooting online endpoint deployment and scoring](/azure/machine-learning/how-to-troubleshoot-online-endpoints).

## Set up monitoring for the model's predictions

Metrics tell you the endpoint is responding; they don't tell you whether its predictions still hold up as real-world data changes. Azure Machine Learning provides **model monitoring** for that, but it's a capability you configure. A deployment isn't monitored for prediction quality by default. To use it, you first enable data collection on the online deployment so incoming requests and responses are logged, then create a monitor that compares that production data against a reference dataset, typically the data the model was trained or validated on.

A model monitor computes signals like these on a schedule you define:

| Signal | What it detects |
|---|---|
| Data drift | The distribution of incoming features shifts from the reference data. |
| Prediction drift | The distribution of the model's outputs shifts over time. |
| Data quality | Missing values, new categories, or out-of-range values appear in production data. |
| Feature attribution drift | The relative importance of features shifts compared to training. |

> [!TIP]
> Learn more about [monitoring the performance of models deployed to production](/azure/machine-learning/how-to-monitor-model-performance).

## Decide when to investigate or retrain

A monitoring signal that crosses its configured threshold is a prompt to investigate, not an automatic fix. For Proseware's no-show model, a data drift alert on appointment lead time might mean the clinic changed its scheduling policy, which is worth a closer look before you decide whether retraining is needed. A sustained prediction drift signal, paired with feedback from clinic staff that flagged appointments aren't actually higher risk, is a stronger case for retraining the model on more recent data and redeploying it through the same pipeline you automated earlier in this module.

## Choose between rollback and retraining

Rollback is appropriate when a problem starts with a new deployment and the previous model remains healthy. Shift traffic to the retained deployment first, then investigate the new version. Retraining is more appropriate when production data or real-world behavior has changed enough that the previous model would have the same limitation. Monitoring provides evidence for the decision; it shouldn't trigger either response without evaluation.
