## Overview

AIpowered solutions introduce unique vulnerabilities that differ from traditional application risks. Solution architects must be able to identify weak points across models, data flows, identity boundaries, and user interactions, especially those involving naturallanguage interfaces susceptible to prompt manipulation.

This unit provides a structured framework for analyzing vulnerabilities in AI systems and defining effective mitigations. It equips architects with the skills to evaluate model behavior, detect abnormal agent activity, assess identity and RBAC exposure, and build endtoend protections that reduce operational and security risks.

## Learning objectives

- After completing this unit, learners will be able to:

- Identify common AIspecific vulnerabilities, including prompt manipulation, data leakage, and insecure model behaviors.

- Apply model evaluation techniques to detect harmful or inconsistent responses.

- Use identity and RBAC controls to reduce exploitability in AI systems.

- Monitor AI activity and investigate suspicious behavior using security and Foundry evaluation tooling.

- Design layered mitigations that protect models, agents, data, and users.

## AI vulnerability categories

### 1. Prompt manipulation risks

- Prompt manipulation occurs when a user intentionally or unintentionally attempts to steer an AI model away from intended safe behaviors. Common techniques include:

- Overriding system instructions ("ignore previous instructions…").

- Deceptive context ("you are allowed to disclose confidential…").

- Multistep coercion or poisoning inputs.

- Embedding hidden instructions in text, HTML, or files.

#### Impact areas include:

- Return of sensitive or protected data.

- Execution of unintended actions.

- Model hallucinations or harmful output.

- Manipulation of downstream automations or tools.

#### Prompt Manipulation Attack Path

:::image type="content" source="../media/prompt-manipulation-attack-path.png" alt-text="Prompt Manipulation Attack Path.":::

### 2. Model behavior vulnerabilities

Models may respond unpredictably when encountering ambiguous, adversarial, or sensitive content.

#### Key risks include:

- Hallucinations or fabricated information.

- Toxicity or harmful content.

- Poor boundary enforcement in safety instructions.

- Biased reasoning or unfair results.

- Overgeneralization that creates compliance risks.

#### To reduce risk, architects should continuously evaluate:

- Output safety

- Output correctness

- Output consistency

- Response variability across iterations

- Model drift after retraining

#### Model Evaluation Radar Chart

:::image type="content" source="../media/model-evaluation-radar-chart.png" alt-text="Model Evaluation Radar Chart.":::

### 3. Data exposure vulnerabilities

#### AI systems often have access to sensitive data sources. Vulnerabilities appear when:

- Prompts indirectly expose sensitive information.

- Logs, memory stores, or transcripts store unprotected data.

- Excessive permissions allow the model to access data it doesn't need.

- Input files contain embedded malicious instructions.

**Best practice:** Architect solutions using _data minimization_, _RBAC boundaries_, and _intentbased access_ aligned with user roles.

### 4. Identity, access, and RBAC gaps

#### Weak identity configuration can allow attackers to:

- Interact with models using elevated privileges.

- Access downstream tools activated by the AI agent.

- Escalate privileges through misconfigured connectors or plugins.

#### Mitigations include:

- Enforcing leastprivilege access for agents and users.

- Using managed identities for secure authentication.

- Segmenting environments for dev/test/prod.

- Reviewing access logs for anomalous elevation attempts.

#### RBAC Boundary Diagram

:::image type="content" source="../media/rbac-boundary-diagram.png" alt-text="RBAC Boundary Diagram.":::

### 5. Agent and workflow-level vulnerabilities

#### AI agents that automate tasks increase risk through:

- Autonomous tool use without proper guardrails.

- Misinterpretation of instructions triggering unintended actions.

- Poor auditing and lack of rollback capability.

- Unsecured flows calling thirdparty endpoints.

#### Architects must ensure:

- Agents act only within clearly defined tool capability boundaries.

- Auditing and monitoring are enabled endtoend.

- Evaluation pipelines test workflows before production deployment.

## Mitigation strategies

### 1. Implement robust AI activity monitoring

Monitoring is central to detecting prompt attacks, unusual model behavior, and unauthorized access.

#### Architects should:

- Monitor AI activity logs for anomalies.

- Investigate spikes in harmful or unexpected output.

- Use dashboards that track riskbased indicators.

- Capture and analyze user prompts, tool calls, and actions.

### 2. Evaluate and test models regularly

#### Use structured evaluation pipelines to:

- Test prompt resilience.

- Validate expected safety behavior.

- Assess impact of new model versions or retraining.

- Identify abnormal responses before release.

### 3. Enforce strict identity and RBAC controls

- Apply leastprivilege principle.

- Use managed identities for models, agents, and pipelines.

- Restrict data access to only what the AI needs.

- Implement approval workflows for privileged operations.

### 4. Strengthen input and output filtering

- Block code execution attempts.

- Strip unsafe HTML or embedded prompts.

- Apply safety filters on model outputs.

- Limit file types the AI may accept.

### 5. Apply layered defense

#### A layered approach reduces singlepoint failure risk:

- Identity and access boundaries

- Secure data governance

- Model evaluation and testing

- Monitoring and anomaly detection

- Incident response readiness

#### Layered AI Security Stack

:::image type="content" source="../media/layered-ai-security-stack.png" alt-text="ALayered AI Security Stack.":::

## References

- [https://learn.microsoft.com/en-us/training/modules/purview-ai-developer-apps/investigate-respond-ai-activity](/training/modules/purview-ai-developer-apps/investigate-respond-ai-activity)

- [https://learn.microsoft.com/en-us/microsoft-agent-365/admin/threat-protection](/microsoft-agent-365/admin/threat-protection)

- [https://learn.microsoft.com/en-us/azure/ai-foundry/how-to/develop/agent-evaluate-sdk?view=foundry-classic](/azure/ai-foundry/how-to/develop/agent-evaluate-sdk)