Microsoft Foundry's built-in guardrail tools—including Azure AI Content Safety, the AI Red Teaming Agent, and structured output validation—each protect a different surface of your agent pipeline. In this unit, you design a coordinated four-surface guardrail strategy that integrates these tools into a single architecture.

Northwind Health's clinical agents processed 12,000 patient document reviews last month. Injection defenses in Unit 3 blocked 47 direct injection attempts and 12 indirect injections from PDF uploads. But three incidents slipped through: a manipulated tool response caused the medication-safety agent to skip a contraindication check; a crafted patient document caused the output to include patient-identifying information in a section visible to the wrong clinician tier; and a borderline output passed the output filter but contained language a pharmacist flagged as resembling a definitive prescription recommendation rather than an advisory. Individual surface defenses worked. The coordinated multisurface strategy didn't exist.

The problem isn't any single defense—it's the absence of a guardrail *strategy*. Individual defenses scattered across units protect specific surfaces in isolation. A production guardrail architecture integrates those defenses into a coherent four-surface model with explicit coverage gaps, coordination logic, and validation workflows.

## The four-surface intervention model

An agent's attack surface spans four boundaries where malicious or erroneous content can enter or exit the reasoning pipeline. Each boundary requires distinct intervention mechanisms.

### Input surface

The input surface is where user messages and uploaded documents enter the agent. You defend this surface with the techniques from Unit 3: structural delimiters (XML wrappers that separate instruction zones from data zones), Azure AI Content Safety prompt shields (which detect jailbreak attempts and indirect injections), input intent classification (routing requests that claim to override instructions to a rejection path), and input schema validation (ensuring required fields are present and within expected value ranges).

Cross-reference: Unit 3's full input-surface teaching covers the specific API calls, code patterns, and adversarial test coverage for this tier. This section adds only the coordination layer—how input-surface defenses integrate with the other three surfaces.

### Tool-call surface

The tool-call surface is where the agent's reasoning generates a tool invocation. Malicious inputs that survive input-surface defenses could cause the agent to construct harmful tool calls. Defend this surface with:

- **Tool allow-lists**—only tools registered in the agent's manifest can be called; the orchestrator rejects any tool name not in the manifest.
- **Parameter schema validation**—validate parameter values against expected types and ranges before the tool call executes. A drug-lookup tool call with a dose parameter of `"drop table medications"` is rejected at the orchestration layer, not passed to the tool.
- **Parameter content scanning**—apply Azure AI Content Safety (or a custom classifier) to string parameters that will be passed to downstream systems, catching injections that target the tool's backend rather than the agent.
- **Sandboxed execution**—for tools that execute code or shell commands, run in a container with network isolation and file-system restrictions. A guardrail at the call surface limits blast radius if parameter validation is bypassed.

### Tool-response surface

The tool-response surface is where tool results reenter the agent's reasoning context. Tool responses are attacker-controlled input when tools query external systems: a patient record in a database could contain embedded injection instructions, a web search result could include adversarial content, a partner API could return manipulated data. Defend this surface with:

- **Response schema enforcement**—validate tool responses against expected JSON schemas before injecting them into the agent context. Unexpected fields or type mismatches are stripped or rejected.
- **Response content scanning**—apply Azure AI Content Safety to string fields in tool responses, catching indirect injections embedded in external data.
- **PII redaction on tool outputs**—before tool responses are injected into the context, redact personal data that the subsequent agent reasoning doesn't need. This prevents inadvertent leakage from tool results to outputs.
- **Value range validation**—numeric returns (dosage recommendations, lab values, prices) are validated against expected ranges. A drug interaction score of 999 from a partner API is blocked before it influences the agent's clinical reasoning.

### Output surface

The output surface is where the agent's response leaves the reasoning pipeline toward users or downstream systems. Even if injections and manipulation survived earlier surfaces, output-surface guardrails provide the final barrier. Defend this surface with:

- **Azure AI Content Safety on output**—screen final agent responses for harmful content categories and safety violations.
- **Groundedness evaluation**—verify that clinical recommendations are grounded in the retrieved documents, not generated from parametric knowledge. A recommendation that cites a guideline section must match the retrieved guideline content.
- **Policy classifiers**—domain-specific classifiers that check outputs against regulatory policy rules (for example, "no definitive diagnoses without clinician-review language").
- **Output schema validation**—the structured output format requirements in the system prompt create a validation target. Outputs that don't conform to the schema are rejected and the agent is asked to regenerate.

## Coordination across surfaces

A complete guardrail strategy defines how the four surfaces coordinate. Some threats require multiple surfaces to contain them:

- **Cross-surface injection campaign**: An attacker submits a patient document (bypasses input-surface imperfectly), causing the agent to construct a tool call with a manipulated parameter (tool-call surface catches it). If tool-call validation also fails, tool-response scanning catches the manipulated backend query result. Output-surface groundedness verification catches an erroneous recommendation based on the injected content.
- **Exfiltration via tool outputs**: If the input surface is compromised, an attacker could direct the agent to call a tool with patient data as a parameter (tool-call parameter content scanning catches data in unexpected parameters).

Document your cross-surface coverage matrix: for each threat in your threat model, identify which surface is the primary defense and which surfaces are secondary backstops. Gaps in this matrix are priority items for hardening.

## Custom guardrail design pattern

When out-of-the-box Azure AI Content Safety policies don't cover a domain-specific constraint, design a custom guardrail following this four-step pattern:

1. **Define the policy in plain language.** Example: "No specific securities recommendations to retail customers in jurisdictions that require licensed investment advice." Plain-language policies are reviewable by compliance and legal teams.

2. **Choose the detection mechanism** based on precision requirements and latency budget:
   - **Regex/lexical**—fastest (< 1ms), high precision on known phrases, misses paraphrases. Use for exact terminology (specific drug names, regulatory jurisdiction codes).
   - **Classifier model**—10-50ms, catches semantic variations, requires training data. Use for categories with consistent linguistic signals.
   - **LLM-as-judge**—200-800ms, highest accuracy, expensive. Use for nuanced policy violations where language varies widely.
   - **Retrieval-grounded check**—compare agent output against a policy document using vector search. Use when the policy is lengthy and evolving.

3. **Integrate at the correct intervention surface.** Output-surface guardrails catch policy violations after generation. Tool-call-surface guardrails prevent policy violations from influencing tool calls. Choose the earliest surface that can detect the violation; earlier detection is cheaper (you avoid unnecessary LLM calls) and more secure.

4. **Measure performance.** Track false positive rate (legitimate outputs blocked), false negative rate (policy violations that passed), and latency overhead. Established targets: false positive rate < 2% to avoid clinician friction; false negative rate < 0.1% for safety-critical policies.

**Worked example—regulated language guardrail:** Northwind Health must not produce definitive medication instructions that clinicians could act on without review. The policy: "All medication-related statements must include language indicating clinician review is required."

Detection mechanism: a three-layer cascade. Layer 1: regex check for presence of required hedge phrases ("requires clinician review", "clinician approval", "consult your care team") in medication-related paragraphs. Fast, low false-negative risk for compliant outputs. Layer 2: if regex fails, a binary classifier (trained on 2,000 compliant vs. non-compliant examples) evaluates whether the output implies definitiveness. Layer 3: for classifier borderline scores (0.4-0.6), an LLM judge evaluates with the full policy context. Cascade cost: Ninety-five percent of outputs handled by Layer 1 alone.

## Guardrail testing and validation

Guardrails require systematic testing before deployment—a guardrail with high false positive rate breaks the agent's utility; a guardrail with high false negative rate provides false security.

**Coverage matrix:** Create a matrix of [intervention surfaces] × [threat categories] × [adversarial input variations]. For each cell, you need at least one test case. A cell with no test case is an untested coverage gap.

**Synthetic data for guardrail testing:** Generate adversarial inputs at scale by using synthetic dataset design techniques from broader adversarial testing practices. Adversarial input variations include direct statement variants, paraphrase variants, multilanguage variants, encoding variants (base64, hex-encoded injections), multiturn variants (spreading the attack across conversation turns), and typographic obfuscation (l33t speak, homoglyph substitution).

**Test execution:**
- **Fail-closed validation**—for each guardrail, define the expected behavior when triggered (reject, modify, escalate). Confirm guardrail fires on adversarial inputs and produces the expected behavior.
- **False-positive measurement**—run the guardrail against a production-representative benign input set. Measure what percentage of legitimate requests are incorrectly blocked.
- **Regression suite**—maintain a growing test suite that expands with every production incident. Each incident where a guardrail fired incorrectly or missed a violation becomes a test case.

**CI/CD integration:** Integrate guardrail regression tests into your deployment pipeline. Gate deployments on: guardrail false-positive rate < 2% on benign dataset, false-negative rate < defined threshold on adversarial dataset, and no new adversarial input categories with 0% detection rate.

**Microsoft Foundry AI Red Teaming Agent:** The AI Red Teaming Agent automates adversarial testing across Microsoft's responsible AI risk categories—Violence, HateUnfairness, Sexual, SelfHarm, ProtectedMaterial, CodeVulnerability, and UngroundedAttributes—using PyRIT-based attack strategies such as encoding obfuscation, character substitution, and jailbreak injection. Use it to generate adversarial inputs for your coverage matrix automatically, supplementing manually authored test cases with at-scale attack coverage. The key output metric is Attack Success Rate (ASR): the percentage of attacks that successfully elicited an undesirable response from the agent.

## Operational considerations

**Observability hooks for guardrail invocations:** Instrument every guardrail trigger with an OpenTelemetry span using a consistent observability pattern: surface, threat category, detection mechanism triggered, action taken, input hash (for forensics without storing personal data). Aggregate by surface and threat category in your monitoring dashboard.

**Audit-trail requirements:** For regulated environments (HIPAA and high-risk scenarios under the EU AI Act), every guardrail invocation that blocks or modifies an output must be logged in an immutable audit record that uses a standardized schema. Auditors verify that guardrail coverage operates continuously, not only at deployment time.

**Cost considerations:** Each additional detection layer (classifier, LLM judge) adds latency and token cost. Profile your guardrail cascade against your latency and cost optimization budget. For example, if the LLM judge adds 400ms and runs on 30% of outputs, it contributes 120ms to average latency and adds significant monthly token cost. Size your guardrail cascade to your actual threat distribution, not the worst-case threat model.
