AI workloads introduce risks that don't appear in traditional applications and infrastructure. Many familiar attack surfaces remain, such as storage, APIs, identities, and networks. What changes is that AI adds three categories of risk: prompt injection, data leakage, and model abuse. Recognizing these risks is essential before applying the protections covered in later modules.

## Three categories of AI security risks

AI risks can be grouped into three main categories that security teams need to account for:

- **Prompt injection**: Inputs designed to manipulate a model into ignoring instructions, disclosing sensitive data, or performing unintended actions. Prompt injection can be direct, through user input, or indirect, through malicious content retrieved from external sources.
- **Data leakage**: Sensitive information might be revealed in outputs, logs, cached prompts, or evaluation datasets. Leakage can occur from user inputs, training data, or organizational knowledge sources.
- **Model abuse and misuse**: Attackers or careless users might exploit AI capabilities to generate harmful content, automate fraud, or produce material outside the intended scope of the workload.

These categories are broad, but they capture the main ways AI workloads differ from traditional systems.

## How these risks surface in Azure workloads

AI risks appear in Azure through common design patterns, such as:

- A chatbot that uses **Azure OpenAI** for model responses and **Azure AI Search** for retrieval, which could be manipulated through crafted prompts. If retrieved content includes untrusted documents, indirect prompt injection becomes a realistic threat. Outputs might also surface sensitive data pulled from internal knowledge bases or cached conversations.

- A model exposed through a public API, which could be targeted to generate abusive or fraudulent content. Even if the underlying infrastructure is secure, the model's responses can create new liabilities for the organization.

## Implications for security

The presence of these risks doesn't replace the need for traditional cloud protections. Identity, secrets, networks, and posture remain central. What is different is that AI workloads require **guardrails around inputs and outputs** to address risks that emerge from model behavior itself.

Understanding these risk categories and how they map to Azure workloads sets the stage for evaluating the guardrails and protections available in the platform.
