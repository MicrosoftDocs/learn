Multi-agent systems introduce a critical fairness challenge that single-agent systems don't face: bias compounds through agent chains. Each agent in your code review pipeline processes the output of the previous agent, creating opportunities for subtle biases to amplify at each stage. Understanding how bias propagates through multi-agent workflows and designing detection mechanisms to identify it in production forms the foundation of responsible AI governance for collaborative agent systems. The Azure AI Evaluation SDK provides the metrics framework and probe-based testing you use to measure consistency, detect disparity, and trace bias sources across agent chains.

The following table highlights how bias differs between single-agent and multi-agent systems:

| Bias Type | Single Agent | Multi-Agent Chain |
|-----------|--------------|-------------------|
| Input bias | Detected at input | Amplified through chain |
| Framing bias | Isolated to one judgment | Propagates to downstream agents |
| Output disparity | Traceable to one model | Requires multi-stage analysis |

## Why bias compounds in agent chains

The compounding effect occurs because each agent operates on processed representations rather than raw inputs. In Fabrikam's code review system, the preprocessing agent normalizes code submissions by extracting key patterns and summarizing changes. If this agent uses language that subtly differs based on developer context—describing identical code changes as "experimental" from junior developers but "innovative" from senior developers—every downstream agent receives this framing as input.

The quality assessment agent then evaluates "experimental" code with heightened scrutiny for potential issues, while "innovative" code receives benefit-of-doubt interpretations. The security analysis agent follows the same pattern, flagging patterns in "experimental" code more aggressively. By the time the final recommendation reaches the developer, the original framing bias has been amplified through three processing stages, creating systematic disparities that appear to stem from the code itself rather than the biased framing.

Unlike single-agent bias, which you detect by examining input-output relationships for one model, multi-agent bias requires tracing causal relationships across the entire chain. A recommendation that penalizes certain code patterns might not reveal bias when you examine the final recommendation agent's behavior in isolation—the bias was encoded upstream.

## Define fairness metrics for code review agents

Fairness in code review requires concrete, measurable definitions that go beyond general principles. For Fabrikam's multi-agent system, fairness means developers receive consistent, evidence-based feedback regardless of factors unrelated to code quality. You define fairness through three operational metrics:

**Consistency** measures whether identical code receives similar quality ratings regardless of submission context. You maintain a probe set of 50 code samples representing common patterns—authentication logic, data validation, error handling—and submit each sample monthly with different developer metadata. Consistency is the percentage of probe submissions where the quality rating variance stays within 5% across contexts.

**False positive rate parity** tracks whether security and quality alerts trigger at similar rates across different technology stacks and architectural styles. You segment alerts by programming language, framework, and architectural pattern, then compare false positive rates. Parity fails when one segment's false positive rate exceeds another's by more than 10 percentage points, indicating the system may be penalizing certain technologies unfairly.

**Recommendation balance** ensures the system doesn't systematically favor particular architectural approaches. You track the distribution of architectural recommendations—microservices versus monolithic, serverless versus container-based, SQL versus NoSQL—across code submissions. Balance holds when recommendation frequencies align with the actual distribution of architectures in the submitted code, not with a preferred pattern.

These metrics provide quantitative targets for governance. Monthly metric reviews identify when bias enters the system, triggering investigation and remediation.

## Detect bias in production

Automated monitoring transforms fairness metrics from aspirational goals to operational controls. You implement three continuous detection mechanisms:

**Disparity testing** runs automatically each week. The system selects 20 recent code submissions and processes each through the agent pipeline twice: once with original developer metadata and once with all author context stripped. You compare the final recommendations using cosine similarity on the recommendation vectors—identical code should produce recommendations with similarity scores above 0.95. When similarity drops below this threshold, the disparity detector flags the submission pair for manual review.

**Distribution monitoring** tracks the statistical distributions of agent outputs across development teams. Every agent output includes a quality score, security risk rating, and recommendation category. You compute these distributions weekly for each development team and compare them using the Kolmogorov-Smirnov test. When distributions diverge significantly (p < 0.05), it indicates one team receives systematically different treatment. The monitor generates alerts identifying which agent in the pipeline produces the divergent outputs.

**Adversarial probe sets** provide ground truth for bias detection. You maintain 100 carefully curated code sample pairs designed to be functionally equivalent but differing in style, naming conventions, or framework choices. For example, one pair implements the same authentication logic using Python Flask and Node.js Express. You process these probes monthly and expect identical security ratings and similar quality scores. Systematic differences in how the agents evaluate equivalent code reveal architectural biases.

```python
import numpy as np
from scipy.stats import ks_2samp
from sklearn.metrics.pairwise import cosine_similarity

def detect_consistency_bias(original_review, anonymized_review):
    """
    Compare agent outputs for the same code with and without author context.
    
    Returns similarity score and bias flag.
    """
    # Extract recommendation vectors (quality score, security rating, complexity)
    original_vector = np.array([
        original_review['quality_score'],
        original_review['security_rating'],
        original_review['complexity_score']
    ]).reshape(1, -1)
    
    anonymized_vector = np.array([
        anonymized_review['quality_score'],
        anonymized_review['security_rating'],
        anonymized_review['complexity_score']
    ]).reshape(1, -1)
    
    # Calculate cosine similarity
    similarity = cosine_similarity(original_vector, anonymized_vector)[0][0]
    
    # Flag if similarity below threshold
    bias_detected = similarity < 0.95
    
    return {
        'similarity_score': similarity,
        'bias_detected': bias_detected,
        'deviation': {
            'quality': abs(original_review['quality_score'] - anonymized_review['quality_score']),
            'security': abs(original_review['security_rating'] - anonymized_review['security_rating']),
            'complexity': abs(original_review['complexity_score'] - anonymized_review['complexity_score'])
        }
    }

def detect_distribution_bias(team_a_scores, team_b_scores):
    """
    Compare output distributions across development teams.
    
    Returns KS statistic and p-value indicating distribution divergence.
    """
    statistic, p_value = ks_2samp(team_a_scores, team_b_scores)
    
    # Significant divergence indicates potential bias
    bias_detected = p_value < 0.05
    
    return {
        'ks_statistic': statistic,
        'p_value': p_value,
        'bias_detected': bias_detected,
        'interpretation': 'Distributions differ significantly' if bias_detected else 'Distributions similar'
    }
```

## Trace bias sources in multi-agent pipelines

When bias detection alerts fire, you need to identify which agent introduced the bias. Causal tracing in multi-agent systems requires structured provenance and controlled replay.

**Structured provenance** means each agent annotates its output with reasoning context. The preprocessing agent includes: input code hash, normalization decisions made, extracted patterns with confidence scores, and the summarization approach used. Quality assessment agents log: which patterns triggered scrutiny, reference guidelines consulted, and confidence levels for each finding. Security agents record: threat patterns matched, risk calculation inputs, and which code sections influenced the rating.

This provenance enables causality analysis. When the final recommendation shows bias, you examine the decision chain backwards. If the security rating differs between identical code submissions, you compare the security agent's provenance logs. If the agent references the same threat patterns but applies different risk weightings, the bias likely originates in the security agent's logic. If the agent references different patterns altogether, the bias originated upstream—the preprocessing agent extracted different patterns from identical code.

**Replay analysis** confirms the source. You create a controlled test environment and replay the biased submission through the pipeline from different injection points. First, you bypass the preprocessing agent and send raw code directly to the quality assessment agent. If bias disappears, the preprocessing agent is the source. If bias persists, you continue downstream, isolating each agent until you identify where disparate treatment begins.

## Mitigate bias through architectural and monitoring controls

Once you identify bias sources, you implement targeted mitigations at three intervention points:

**Source-level debiasing** addresses bias in agent prompts and logic. When the preprocessing agent shows framing bias, you audit its system prompts for language that treats developer context differently. Phrases like "similar to patterns seen in novice code" or "consistent with experienced developer practices" introduce bias. You revise prompts to focus exclusively on code characteristics: "implements authentication using JWT tokens" rather than "implements authentication similarly to other submissions from this developer."

**Architectural mitigation** removes bias opportunities through system design. For code review, you implement blind processing: the preprocessing and quality assessment agents never receive developer identity, commit history, or team membership. Only after quality and security analysis completes does the orchestrator merge results with author context for notification routing. This architectural choice makes identity-based bias impossible at critical judgment stages.

**Monitoring-based correction** catches bias that evades other controls. You configure the disparity detector to not only flag bias but also trigger corrective workflows. When a recommendation shows consistency bias above threshold, the system automatically routes it to a human reviewer along with the disparity test results. The reviewer examines both versions of the recommendation and determines which to deliver to the developer. These human corrections feed back into agent fine-tuning as examples of unbiased judgment.

With fairness metrics defined, automated detection running, and bias sources traceable through provenance, you ensure Fabrikam's multi-agent system delivers equitable code reviews. The next critical governance dimension is transparency—developers need to understand not just what the agents recommend, but how multiple agents collaborated to reach those conclusions.
