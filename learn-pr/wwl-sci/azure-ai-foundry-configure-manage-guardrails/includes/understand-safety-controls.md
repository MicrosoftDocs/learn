Guardrails in **Azure AI Foundry** combine several safety controls that protect models from harmful, ungrounded, or policy-violating behavior.
These controls evaluate both the prompts that enter a model and the responses it generates, giving security and operations teams visibility and control over the full interaction flow.

The **Guardrails + controls** workspace brings these protections together so they can be configured, tested, and tuned in one place. Each control addresses a different type of risk, and together they form a layered defense for responsible and secure AI operations.

You can preview how these controls behave in the **Try it out** section of the workspace. This feature lets you test sample prompts and outputs to see how moderation, protected material detection, or jailbreak protection respond before applying policies to production environments.

## Overview of safety controls

Safety controls in Azure AI Foundry operate on two levels:

- **Input protections** review prompts before they reach the model, detecting and blocking jailbreaks, indirect attacks, or content that violates internal policies.
- **Output protections** evaluate model responses to prevent the release of unsafe or confidential information.

These controls can be applied individually or in combination, depending on your organization's risk tolerance and compliance needs. They allow teams to implement consistent safeguards across AI workloads while retaining flexibility in how policies are enforced.

## Prompt Shields

**Prompt Shields** detect and stop jailbreak and indirect prompt-injection attempts. They analyze incoming text for manipulation patterns that might override system instructions or extract restricted data.

When configuring Prompt Shields, you can choose how the system reacts:

- **Annotate only** adds metadata that flags a possible attack without blocking the prompt.
- **Annotate and block** stops the prompt from reaching the model and records the event for review.

Prompt Shields reinforce model boundaries and help prevent malicious or unintended instructions from compromising AI behavior.

## Content filters

**Content filters** classify and filter model input and output across multiple harm categories, including:

- **Violence**
- **Hate**
- **Sexual**
- **Self-harm**

Each category includes a severity slider that determines how aggressively the filter responds. For example, a _medium blocking_ level stops both moderate and highly severe content, while a _high blocking_ level enforces the strictest control.

Content filters use the same detection technology as **Azure AI Content Safety**, integrated directly into Foundry for real-time evaluation.
They help ensure consistent moderation across all model interactions.

## Blocklists and protected material

**Blocklists** enforce organization-specific or regulatory policies by blocking exact terms or patterns that should never appear in prompts or model outputs.
They're often used to prevent disclosure of internal identifiers, project names, or proprietary code terms.

**Protected material detection** identifies proprietary or non-Microsoft content that shouldn't appear in generated text or code. It can annotate or block results when detected, reducing the risk of exposing confidential or copyrighted material.

Together, these controls strengthen compliance with internal data-handling standards and external obligations.

## Groundedness (preview)

**Groundedness detection** evaluates whether a model's response is supported by its source data.
It helps identify fabricated or unverified statements that could lead to misinformation or analytical errors.

Because this feature is in preview, behavior and accuracy might evolve as the model improves. Even so, groundedness detection plays an important role in assessing the reliability of model responses before they're shared or deployed.

Azure AI Foundry brings all these safety controls together in one environment, allowing teams to design, test, and validate protections that align with organizational risk posture.

Understanding how each control operates is the foundation for building guardrails that aren't only effective but also verifiable. This ensures that AI systems remain secure, compliant, and trustworthy.
