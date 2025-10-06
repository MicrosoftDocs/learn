The risks introduced by AI workloads require protections that go beyond traditional cloud security measures. Guardrails are applied to inputs and outputs to help keep models from being misused or manipulated. In Azure, these protections include mechanisms like **Prompt Shields** and **Content Safety** that address threats specific to generative AI.

## Two categories of AI guardrails

Guardrails for AI workloads can be grouped into two categories:

- **Prompt Shields**: Defenses focused on model inputs. They identify and block attempts to manipulate a model through direct or indirect prompt injection.
- **Content Safety**: Defenses focused on model outputs. They detect and filter harmful, ungrounded, or sensitive content before it's returned to the user.

Together, these controls address the most common risks: malicious prompts, unsafe outputs, and unintended disclosure of sensitive data.

## Why these guardrails matter

Traditional controls like identity, secrets, and network isolation secure the infrastructure, but they don't address risks created by model inputs and outputs. Without additional guardrails, a model might still be tricked into revealing sensitive information or producing harmful content, even if the underlying infrastructure is secure.

Common situations where guardrails are needed include:

- A retrieval-augmented assistant receives a malicious document that attempts to redirect its behavior through indirect prompt injection. **Prompt Shields** are designed to intercept and block this manipulation.
- A model generates an output that contains harmful or ungrounded information. **Content Safety** policies can detect and filter that response before it reaches the end user.

## Implications for security practice

Understanding guardrails at this conceptual level is important before configuring or validating them in practice. They should be viewed as part of a layered defense strategy where:

- **Traditional protections** secure the infrastructure and services.
- **AI-specific guardrails** address risks that emerge from model behavior itself.

These guardrails also support responsible AI goals by reducing harmful or ungrounded outputs and enabling policy enforcement on model responses.
