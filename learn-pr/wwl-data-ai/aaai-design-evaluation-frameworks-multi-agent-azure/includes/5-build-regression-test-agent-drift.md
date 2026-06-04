The Microsoft Foundry Evaluation SDK integrates directly into continuous integration/continuous deployment (CI/CD) pipelines, letting you enforce automated quality gates that compare each new agent version against a gold baseline before deployment. Unlike traditional software where quality only changes with code modifications, AI agents drift without any code changes.

## Design regression test suite composition

A new model deployment, a context window adjustment, or gradual training data drift silently degrades quality. Regression testing catches these drifts before they reach production—but only if you run evaluations systematically and compare new agent versions against established baselines.

| Change type | Code modified? | Quality impact | Detection method |
|-------------|----------------|----------------|------------------|
| Code deployment | Yes | Potentially high | CI/CD tests + evaluation |
| Model update | No | Medium to high | Regression evaluation |
| Prompt modification | Yes (prompt text) | Medium | Regression evaluation |
| Gradual drift | No | Low per day, cumulative | Production sampling |

A complete regression suite combines three test categories, each serving a distinct purpose. The **full synthetic dataset** provides comprehensive coverage—all 400 test cases spanning scenario types, complexity variants, customer personas, and adversarial conditions. This coverage ensures no capability gaps emerge in rarely-exercised code paths.

**Canary cases** are a subset of 20-30 high-confidence test cases that should always pass: baseline product search, simple order placement, straightforward returns processing. These cases test fundamental capabilities. If canaries start failing, something seriously broke. Canary failures trigger immediate investigation before checking detailed metrics.

**Historical failure probes** are test cases that previously caused failures and were fixed. These cases verify that fixes remain effective—regressions don't reintroduce old bugs. For Adventure Works, historical probes include: a multi-item modification edge case that caused refund miscalculation, an international shipping query that produced contradictory currency conversions, and a gift message handling bug that exposed PII in logs.

The combined suite runs on every candidate deployment: canaries run first (5 minutes), full dataset runs if canaries pass (45 minutes), and historical probes run in parallel with full dataset. This sequencing provides fast feedback on critical failures while ensuring comprehensive validation.

## Establish baseline and comparison runs

Define a **gold baseline**—evaluation results from a known-good agent configuration. This baseline typically comes from the current production version that meets quality targets. For Adventure Works, the gold baseline comes from version 2.3.1 deployed in production: task completion rate 82%, average goal achievement 7.8/10, journey coherence 8.2/10, customer resolution rate 76%.

For each new agent version, run the full evaluation suite and compare scores against the gold baseline. Configure comparison thresholds that define acceptable degradation: task completion rate must not drop more than 2 percentage points, goal achievement must not drop more than 0.3 points, journey coherence must not drop more than 0.5 points, and no single interaction type can drop more than 5 percentage points in task completion.

These thresholds balance two risks: blocking legitimate deployments due to random variation (false positive), and allowing quality regressions to reach production (false negative). Set thresholds using historical variation data: if evaluation scores naturally fluctuate ±1% between identical runs, set the blocking threshold at 2% to avoid false positives while catching real regressions.

```python
from typing import Dict, List
import json

class RegressionTestRunner:
    """Run regression evaluation and compare against baseline."""
    
    def __init__(self, baseline_results: Dict, thresholds: Dict):
        self.baseline = baseline_results
        self.thresholds = thresholds
    
    def run_evaluation(self, agent_version: str, test_suite: List[Dict]) -> Dict:
        """Run evaluation on new agent version."""
        # This would integrate with Microsoft Foundry Evaluation SDK
        # For demonstration, simulating results
        
        results = {
            "agent_version": agent_version,
            "task_completion_rate": 0.80,  # 82% baseline
            "avg_goal_achievement": 7.6,   # 7.8 baseline
            "journey_coherence": 8.0,      # 8.2 baseline
            "customer_resolution_rate": 0.74,  # 76% baseline
            "by_interaction_type": {
                "product_search": 0.92,     # 94% baseline
                "order_placement": 0.87,    # 89% baseline
                "returns": 0.75,            # 78% baseline
                "multi_item_mods": 0.65     # 67% baseline
            }
        }
        
        return results
```

The `run_evaluation` method executes the full evaluation suite against a new agent version, capturing metrics like task completion rate, goal achievement, and per-interaction-type scores. These results are then compared against the established baseline to detect regressions before deployment:

```python
    def compare_to_baseline(self, current_results: Dict) -> Dict:
        """Compare results to baseline and determine pass/fail."""
        
        comparisons = {}
        
        # Task completion rate comparison
        baseline_tcr = self.baseline["task_completion_rate"]
        current_tcr = current_results["task_completion_rate"]
        tcr_delta = current_tcr - baseline_tcr
        tcr_pass = tcr_delta >= -self.thresholds["task_completion_drop"]
        
        comparisons["task_completion"] = {
            "baseline": baseline_tcr,
            "current": current_tcr,
            "delta": tcr_delta,
            "threshold": -self.thresholds["task_completion_drop"],
            "pass": tcr_pass
        }
        
        # Goal achievement comparison
        baseline_ga = self.baseline["avg_goal_achievement"]
        current_ga = current_results["avg_goal_achievement"]
        ga_delta = current_ga - baseline_ga
        ga_pass = ga_delta >= -self.thresholds["goal_achievement_drop"]
        
        comparisons["goal_achievement"] = {
            "baseline": baseline_ga,
            "current": current_ga,
            "delta": ga_delta,
            "threshold": -self.thresholds["goal_achievement_drop"],
            "pass": ga_pass
        }
        
        # Per-type comparison
        type_pass = True
        type_details = {}
        
        for interaction_type, current_score in current_results["by_interaction_type"].items():
            baseline_score = self.baseline["by_interaction_type"][interaction_type]
            delta = current_score - baseline_score
            type_delta_pass = delta >= -self.thresholds["per_type_drop"]
            
            type_details[interaction_type] = {
                "baseline": baseline_score,
                "current": current_score,
                "delta": delta,
                "pass": type_delta_pass
            }
            
            if not type_delta_pass:
                type_pass = False
        
        comparisons["by_type"] = {
            "details": type_details,
            "pass": type_pass
        }
        
        # Overall pass/fail
        overall_pass = (
            comparisons["task_completion"]["pass"] and
            comparisons["goal_achievement"]["pass"] and
            comparisons["by_type"]["pass"]
        )
        
        return {
            "overall_pass": overall_pass,
            "comparisons": comparisons,
            "recommendation": "APPROVE DEPLOYMENT" if overall_pass else "BLOCK - Quality regression detected"
        }
```

The comparison method checks each metric against its configured threshold and flags any regressions. Per-interaction-type analysis is critical—an overall passing score can mask a severe regression in a specific category like returns or order modifications. The report generator produces a human-readable summary for the deployment gate:

```python
    def generate_report(self, comparison: Dict) -> str:
        """Generate human-readable regression test report."""
        
        report = f"""
REGRESSION TEST RESULTS
{'=' * 60}

Overall Result: {comparison['recommendation']}

Task Completion Rate:
  Baseline: {comparison['comparisons']['task_completion']['baseline']:.1%}
  Current:  {comparison['comparisons']['task_completion']['current']:.1%}
  Delta:    {comparison['comparisons']['task_completion']['delta']:+.1%}
  Status:   {'✓ PASS' if comparison['comparisons']['task_completion']['pass'] else '✗ FAIL'}

Goal Achievement Index:
  Baseline: {comparison['comparisons']['goal_achievement']['baseline']:.2f}/10
  Current:  {comparison['comparisons']['goal_achievement']['current']:.2f}/10
  Delta:    {comparison['comparisons']['goal_achievement']['delta']:+.2f}
  Status:   {'✓ PASS' if comparison['comparisons']['goal_achievement']['pass'] else '✗ FAIL'}

Per-Interaction Type:
"""
        
        for itype, details in comparison['comparisons']['by_type']['details'].items():
            status = '✓' if details['pass'] else '✗ FAIL'
            report += f"  {itype:20s}: {details['current']:.1%} (baseline: {details['baseline']:.1%}, delta: {details['delta']:+.1%}) {status}\n"
        
        return report

# Usage example
baseline = {
    "task_completion_rate": 0.82,
    "avg_goal_achievement": 7.8,
    "journey_coherence": 8.2,
    "customer_resolution_rate": 0.76,
    "by_interaction_type": {
        "product_search": 0.94,
        "order_placement": 0.89,
        "returns": 0.78,
        "multi_item_mods": 0.67
    }
}

thresholds = {
    "task_completion_drop": 0.02,   # Max 2% drop
    "goal_achievement_drop": 0.3,   # Max 0.3 point drop
    "per_type_drop": 0.05           # Max 5% drop per type
}

runner = RegressionTestRunner(baseline, thresholds)

# Run evaluation on new version
new_results = runner.run_evaluation("2.4.0", test_suite=[])

# Compare to baseline
comparison = runner.compare_to_baseline(new_results)

# Generate report
print(runner.generate_report(comparison))

if not comparison["overall_pass"]:
    print("\n⚠️  DEPLOYMENT BLOCKED - Quality regression detected")
    exit(1)
```

## Monitor drift in production with sampling

Pre-deployment regression tests catch problems before release, but gradual drift occurs in production between deployments. Model endpoints degrade, external APIs change behavior, or user behavior patterns shift. Production evaluation sampling detects these drifts.

Periodically sample a small percentage of production interactions and run automated evaluation: 1% random sampling captures approximately 10,000 interactions daily for Adventure Works' traffic volume, enough for statistically significant trend analysis. Run the same LLM-as-judge evaluators used in regression testing on these samples, storing scores in a time-series database.

Track evaluation scores over time using 7-day rolling averages to smooth daily noise. Alert when the rolling average drops below the regression test baseline minus a tolerance band. For example, if production task completion averaged 82% for the last two weeks and suddenly drops to 78% over three days, trigger an investigation even though no new deployment occurred.

This production monitoring caught a gradual drift issue for Adventure Works in March 2026: task completion rates slowly declined from 82% to 77% over 10 days with no code changes. Investigation revealed the product catalog API introduced a new rate limit that caused occasional timeout errors. The agent code hadn't changed, but the external dependency degraded, causing quality drift.

## Integrate with CI/CD deployment gates

Connect regression evaluation directly to your GitHub Actions deployment pipeline as a required quality gate: deployments don't proceed unless evaluation scores meet thresholds.

Add an evaluation job to the GitHub Actions workflow that runs after building the agent container but before deploying to production. This job runs the Microsoft Foundry Evaluation SDK against the synthetic test suite, compares results to the baseline, and sets the workflow exit code based on pass/fail status.

```yaml
# .github/workflows/deploy-agents.yml

name: Deploy Multi-Agent System

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build agent container
        run: docker build -t agents:${{ github.sha }} .
  
  evaluate:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: |
          pip install azure-ai-evaluation azure-ai-agents azure-identity
      
      - name: Run regression evaluation
        env:
          PROJECT_ENDPOINT: ${{ secrets.PROJECT_ENDPOINT }}
        run: |
          python evaluation/run_regression_tests.py \
            --agent-version ${{ github.sha }} \
            --baseline-file evaluation/baselines/v2.3.1.json \
            --test-suite evaluation/synthetic_test_suite.json \
            --thresholds evaluation/regression_thresholds.json \
            --output-report evaluation/results/regression_report_${{ github.sha }}.json
      
      - name: Check evaluation results
        run: |
          python evaluation/check_regression_pass.py \
            --results evaluation/results/regression_report_${{ github.sha }}.json
      
      - name: Upload evaluation report
        uses: actions/upload-artifact@v3
        with:
          name: regression-report
          path: evaluation/results/regression_report_${{ github.sha }}.json
  
  deploy:
    needs: evaluate
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to production
        run: |
          # Deployment only happens if evaluation passed
          echo "Deploying agents:${{ github.sha }} to production"
```

The `check_regression_pass.py` script exits with code 0 if evaluation passed and code 1 if it failed—halting the GitHub Actions workflow and preventing deployment of regressed agent versions. This automated gate ensures quality standards apply consistently without manual review bottlenecks.

## Key takeaways

- **Regression test suites** combine full synthetic datasets, canary cases for fundamental capabilities, and historical failure probes that verify past fixes remain effective.
- **Gold baselines** establish reference evaluation scores from known-good agent configurations, enabling objective comparison for each new version.
- **Comparison thresholds** define acceptable degradation limits (for example, 2% task completion drop) calibrated from historical variation to balance false positive and false negative risks.
- **Production drift monitoring** samples 1% of live interactions for continuous evaluation, detecting gradual quality degradation between deployments using 7-day rolling averages.
- **CI/CD deployment gates** integrate regression evaluation directly into GitHub Actions workflows, automatically blocking deployments that fail quality thresholds.
