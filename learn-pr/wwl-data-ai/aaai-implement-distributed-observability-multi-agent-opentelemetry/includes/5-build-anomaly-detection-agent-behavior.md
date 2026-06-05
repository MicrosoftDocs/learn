Azure Monitor dynamic thresholds learn from historical telemetry to detect when an agent's behavior deviates from its established baseline, enabling proactive alerting before customers are affected.

Multi-agent systems exhibit anomalies that don't occur in single-agent scenarios. A routing agent may start sending traffic to different downstream agents than its historical pattern, indicating prompt injection or model drift. A tool-calling agent may suddenly take 10× longer to complete, suggesting a stuck external API call. An agent's token usage may triple overnight without code changes, pointing to a prompt injection attack expanding the context window. Detecting these behavioral anomalies requires establishing baselines for normal behavior and alerting when current behavior deviates significantly.

| Anomaly Type | Normal Behavior | Anomalous Behavior | Likely Cause |
|--------------|-----------------|-------------------|--------------|
| Routing drift | 80% to search agent | 40% to search agent | Prompt injection or model drift |
| Latency spike | P95: 1.2 s | P95: 8.5 s | Stuck tool call or endpoint degradation |
| Token explosion | Avg: 800 tokens | Avg: 2,400 tokens | Prompt injection or context leak |
| Escalation surge | 5% daily rate | 18% daily rate | Model quality regression |

## Establish behavioral baselines

Before detecting anomalies, you establish normal behavior baselines for each metric per agent. Use 14-day rolling averages with standard deviation calculations to define expected ranges. This approach captures weekly patterns (weekday vs. weekend traffic) and filters out predictable variation.

For each agent and metric, calculate the mean and standard deviation over the baseline window. Define alert thresholds at 2σ (warning threshold—unusual but not necessarily actionable) and 3σ (critical threshold—highly unusual, requires investigation). A routing decision distribution showing 75% ± 8% to the product search agent over two weeks establishes the baseline—a sudden shift to 50% triggers the 3σ alert.

Update baselines weekly to adapt to gradual legitimate changes in system behavior. Adventure Works' traffic patterns shift seasonally—gift chocolate purchases spike in December, subscription orders dominate in January. Static baselines would generate false alarms during these transitions. Rolling baselines adapt automatically.

## Apply Azure Monitor dynamic thresholds

Azure Monitor metric alerts support dynamic thresholds that learn from historical data and automatically adjust as traffic patterns evolve. Instead of defining a fixed latency threshold like "alert if P95 > 5 seconds," dynamic thresholds learn that normal P95 latency is 1.2 seconds during business hours and 0.8 seconds overnight, alerting when current values deviate from the learned pattern.

Dynamic thresholds handle predictable variations automatically: weekend traffic drops don't trigger false alarms, planned marketing campaigns that increase load don't create alert noise, and gradual baseline improvements (from optimization work) don't require manual threshold updates.

Configure dynamic threshold sensitivity using the `ThresholdSensitivity` parameter: `Low` requires large deviations (approximately 3σ), `Medium` uses 2σ, and `High` uses approximately 1.5σ. For production multi-agent systems, start with Medium sensitivity and adjust based on observed false positive rates.

```python
# Example: Detect token usage anomalies with rolling baseline
import numpy as np
from datetime import datetime, timedelta
from typing import Dict, List

class TokenUsageAnomalyDetector:
    """Detects token usage anomalies using rolling baseline comparison."""
    
    def __init__(self, baseline_days: int = 14, sigma_threshold: float = 3.0):
        self.baseline_days = baseline_days
        self.sigma_threshold = sigma_threshold
        self.agent_baselines: Dict[str, Dict] = {}
    
    def update_baseline(self, agent_id: str, daily_token_counts: List[int]):
        """Calculate baseline statistics from historical data."""
        if len(daily_token_counts) < self.baseline_days:
            return  # Insufficient data for baseline
        
        recent_data = daily_token_counts[-self.baseline_days:]
        mean_tokens = np.mean(recent_data)
        std_tokens = np.std(recent_data)
        
        self.agent_baselines[agent_id] = {
            "mean": mean_tokens,
            "std": std_tokens,
            "updated_at": datetime.utcnow()
        }
    
    def detect_anomaly(self, agent_id: str, current_token_count: int) -> Dict:
        """Check if current token usage is anomalous."""
        if agent_id not in self.agent_baselines:
            return {"is_anomaly": False, "reason": "No baseline established"}
        
        baseline = self.agent_baselines[agent_id]
        mean = baseline["mean"]
        std = baseline["std"]
        
        # Calculate z-score
        if std == 0:
            z_score = 0
        else:
            z_score = (current_token_count - mean) / std
        
        is_anomaly = abs(z_score) > self.sigma_threshold
        
        return {
            "is_anomaly": is_anomaly,
            "z_score": z_score,
            "current_value": current_token_count,
            "baseline_mean": mean,
            "baseline_std": std,
            "threshold_sigma": self.sigma_threshold,
            "severity": "critical" if abs(z_score) > 3.0 else "warning"
        }

# Usage example
detector = TokenUsageAnomalyDetector(baseline_days=14, sigma_threshold=3.0)

# Update baseline with 14 days of historical data
historical_data = [850, 920, 880, 910, 870, 900, 890, 880, 920, 870, 910, 900, 880, 890]
detector.update_baseline("product-search-agent", historical_data)

# Check current day's token usage
current_usage = 2650  # 3x normal
result = detector.detect_anomaly("product-search-agent", current_usage)

if result["is_anomaly"]:
    print(f"ALERT: Token usage anomaly detected!")
    print(f"Agent: product-search-agent")
    print(f"Current: {result['current_value']} tokens")
    print(f"Expected: {result['baseline_mean']:.0f} ± {result['baseline_std']:.0f}")
    print(f"Z-score: {result['z_score']:.2f} (threshold: {result['threshold_sigma']})")
    print(f"Severity: {result['severity']}")
```

This detector tracks per-agent token usage, establishes rolling baselines, and triggers alerts when current usage exceeds the 3σ threshold. Integrating this with the structured logging system enables automatic anomaly detection on every log aggregation cycle.

## Detect LLM output behavioral anomalies

Beyond metric anomalies, you detect output content anomalies—shifts in what the agent outputs rather than how much or how fast. Use Azure AI Content Safety to scan all agent outputs for policy violations: hate speech, violence, sexual content, and self-harm. These violations may indicate successful prompt injection attacks.

Build a custom classifier that analyzes output style and content distribution. Track the distribution of response types (product information, order confirmation, apology for error, escalation notice). A sudden shift from 70% product information responses to 40% suggests the agent's behavior changed—potentially due to model drift or prompt injection.

For Adventure Works, the behavioral monitor tracks each agent's output distribution daily. The product search agent normally produces 85% product information responses, 10% "not found" responses, and 5% escalation notices. If the distribution shifts to 60% product information, 30% "not found" in a single day, the system triggers an investigation—the agent may have developed a failure mode that incorrectly classifies available products as unavailable.

## Correlate multiple anomalies into incidents

Multiple simultaneous anomalies often share a single root cause. If the payment processor agent shows latency spike + error rate increase + token usage anomaly all within the same 5-minute window, these likely stem from one problem (a failing payment gateway API) rather than three independent issues.

Design an alert correlation engine that groups related anomalies into incidents. Anomalies occurring within the same time window (5 minutes) on the same agent or on agents in a known dependency chain (orchestrator and its downstream agents) get grouped into a single incident. This reduces alert fatigue—the on-call engineer receives one incident notification instead of three separate alerts.

Azure Monitor alert suppression rules implement this pattern. Define alert processing rules that suppress downstream alerts when an upstream dependency shows anomalies. If the orchestrator agent shows high error rates because the product search agent is failing, suppress the orchestrator's error alert—the product search failure is the root cause requiring attention.

For complex incident correlation, implement custom logic using Azure Monitor action groups and Azure Functions. The Azure Function receives all alert notifications, applies correlation rules, groups related alerts, and sends a single enriched notification to the on-call engineer with context linking all related anomalies.

## Key takeaways

- **Behavioral baselines** use 14-day rolling averages with standard deviation to define expected ranges, with alerts at 2σ (warning) and 3σ (critical) thresholds.
- **Dynamic thresholds** in Azure Monitor learn from historical patterns and adapt automatically to seasonal traffic changes, reducing false alarms.
- **Token usage anomaly detection** calculates z-scores against rolling baselines to identify potential prompt injection or context window issues.
- **Output behavioral analysis** tracks response type distributions per agent to detect content-level shifts that metric anomalies miss.
- **Incident correlation** groups simultaneous anomalies on related agents into single incidents, reducing alert fatigue for on-call engineers.
