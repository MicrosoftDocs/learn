This module focuses on hands-on governance scenarios designed to help learners implement effective controls for AI workloads using Microsoft Foundry and related Azure services. Through practical, real-world exercises, learners explore how governance constructs such as policies, initiatives, content filters, and guardrails are used to enforce organizational standards while still enabling responsible AI innovation.


## Module Overview

This module guides learners through securing AI deployments in Microsoft Foundry by restricting approved models and implementing layered content‑safety controls to balance safe, realistic outputs with strong protections.

The module includes five interactive exercises:

- **Exercise 1:** Demonstrates how to configure custom Azure Policy initiatives to restrict which AI models can be deployed across Microsoft Foundry projects and Azure Machine Learning environments.  
- **Exercise 2:** Introduces content safety by walking through the configuration of content filters using the classic approach in Microsoft Foundry.  
- **Exercise 3:** Builds on content safety by configuring jailbreak protections and newer guardrail‑based approaches available in Microsoft Foundry.  
- **Exercise 4:** Focuses on tuning content filters and prompt shields to produce context‑appropriate AI responses while mitigating harmful or abusive outputs.  
- **Exercise 5:** Teaches how to apply and balance guardrails to protect against prompt attacks and intellectual property risks while maintaining realistic AI behavior.


Learners can find the full list of labs and launch each exercise directly by visiting Govern [AI-Ready Infrastructure](https://go.microsoft.com/fwlink/?linkid=2346535) GitHub repository, which serves as the single entry point for the course’s hands‑on activities.

## Exercise 1: Restrict deployable models with a custom Azure initiative

#### Estimated duration
15 minutes
### Background information
When using models from Microsoft Foundry and Azure OpenAI with Microsoft Foundry, you can implement custom policies to restrict which specific models users can deploy. This capability is available for Microsoft Foundry project and hub-based project. In addition, you can use a built-in policy definition to apply similar restrictions to ensure that Azure Machine Learning deployments use only approved Registry models. To minimize the number of policy assignments, it's possible to combine multiple policy definitions into initiatives.

### Scenario

Your company is planning to strengthen governance over AI model usage by defining clear deployment boundaries across its AI platforms. In Microsoft Foundry projects, custom policies are implemented to restrict which specific models users can deploy. This approach ensures that only approved models are available within both project-level and hub-based environments, promoting consistency, compliance, and alignment with organizational standards.

At the same time, the organization applies built-in policy definitions to Azure Machine Learning workspaces to allow deployments only from a set of preapproved Registry models. Combining these individual policies into initiatives, the company can enforce a unified set of compliance controls across Microsoft Foundry and Azure Machine Learning workloads, simplifying management while maintaining strong governance across all AI solutions.

- Restricts model deployments in Microsoft Foundry projects to approved models only  
- Ensures consistent governance across project and hub-based environments  
- Limits Azure Machine Learning deployments to preapproved Registry models  
- Uses policy initiatives to enforce compliance across multiple AI platforms  

:::image type="content" source="../media/consistent-governance-multiple-projects.png" alt-text="Diagram showing how to apply built-in policy definitions to Azure Machine Learning workspaces.":::


### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create and assign policies, you should have the Owner or Resource Policy Contributor role assigned at the Azure subscription level.
- Familiarity with Azure Policy

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2346528)

## Exercise 2: Configure content filters with jailbreak protection (classic)

#### Estimated duration
15 minutes

### Background information
The content filtering system integrated into Microsoft Foundry runs alongside the core models, including image generation models. It uses a collection of multi-class classification models to detect four categories of harmful content (violence, hate, and self-harm) at four severity levels (safe, low, medium, and high), and optional binary classifiers for detecting jailbreak risk (incorporated into prompt shields), existing text, and code in public repositories.
The default content filtering configuration is set to filter at the medium severity threshold for all four content harms categories for both prompts and completions. That means that content that is detected at severity level medium or high is filtered, while content detected at severity level low or safe isn't filtered.
Prompt shields and protected text and code models are optional and on by default. For prompt shields and protected material text and code models, the configurability feature allows all customers to turn the models on and off. The models are on by default and can be turned off to match your requirements.

### Scenario
Your company is developing an AI-powered training and simulation platform for professionals in fields such as law enforcement, healthcare, and social work. In these contexts, realistic scenarios sometimes require references to violence, hate, or self-harm in order to train staff to recognize, respond to, and de-escalate critical situations. Because overly aggressive filtering would block content that is both intentional and necessary for simulation accuracy, the organization decides to lower severity thresholds to block only the most extreme cases. This configuration still prevents harmful misuse but allows the AI to produce controlled, context-appropriate outputs that better align with training objectives.
Additionally, since some scenarios involve exploring how individuals might attempt to manipulate AI systems, direct jailbreak detection should be enabled, while indirect jailbreak shields are turned off to allow testing of those edge cases in a controlled environment. To further protect compliance and intellectual property boundaries, output filters are used to protect material checks to block copyrighted or publicly available code/text from surfacing in generated content.

:::image type="content" source="../media/context-appropriate-outputs-align.png" alt-text="Diagram showing how users may attempt to manipulate or stress-test agent behavior.":::


### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription or the target resource group level.
- Familiarity with Azure AI Content Safety

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2346703)


## Exercise 3: Configure content filters with jailbreak protection (new)
#### Estimated duration
20 minutes

### Background information

Microsoft Foundry includes built-in safety and security guardrails that apply to both core models, including image generation models, and agents developed using the Foundry Agent Service (agent guardrails are in preview as of December 2025). These guardrails run alongside models and agents to detect and mitigate harmful or undesirable behavior using classification models designed to identify risks such as violence, hate, self-harm, prompt attacks, and protected material in text or code.

Guardrails define how and where risks are evaluated and what action is taken when a risk is detected. Risks can be assessed at multiple intervention points, including user input and model output for both models and agents, and additionally at tool call and tool response stages for agents. When a risk is detected, the guardrail can annotate or block the output, depending on the configured action and the applicability of the control to models or agents.

By default, model deployments use the Microsoft.DefaultV2 guardrail. Agents inherit the guardrail of the underlying model unless a specific guardrail is assigned to the agent. When an agent-level guardrail is applied, it fully overrides the model's guardrail, and all risk detection for that agent is based on the agent's configuration. Guardrail behavior may vary depending on API configuration and application design, and agent guardrails currently apply only to agents built in the Foundry Agent Service.

### Scenario

Your company is building an AI-powered training and simulation platform using Microsoft Foundry agents for professionals in domains such as law enforcement, healthcare, and social work. These simulations require agents to generate and reason over realistic situations that may include references to violence, hate, or self-harm in order to help trainees recognize, respond to, and de-escalate high-risk scenarios. To support this goal, the organization configures agent-level guardrails with lower severity thresholds so that only high-risk content is blocked, while contextually appropriate material is allowed to pass through for training purposes.

Because the platform is designed to evaluate how users may attempt to manipulate or stress-test agent behavior, guardrails are configured to detect and block direct user prompt attacks while allowing certain indirect attack patterns to surface during controlled exercises. Agent guardrails are applied at the user input and output intervention points, and selectively at tool call and tool response stages where tools are used to enrich simulations. To maintain compliance and protect intellectual property, protected material checks for text and code are enabled to prevent the agent from returning copyrighted or publicly available content in its responses, while still allowing realistic, policy-compliant training interactions.

:::image type="content" source="../media/guardrails-configured-detect-block-prompt.png" alt-text="Diagram showing users may attempt to manipulate or stress-test agent behavior.":::

### Prerequisites

* **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
* **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription or the target resource group level.
* Familiarity with guardrails and controls in Microsoft Foundry


[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2346529)

## Exercise 4: Configure content filters with prompt shields (classic)
### Estimated duration
10 minutes

### Background information
The content filtering system integrated into Microsoft Foundry runs alongside the core models, including image generation models. It uses a collection of multi-class classification models to detect four categories of harmful content at four severity levels (safe, low, medium, and high), and optional binary classifiers for detecting jailbreak risk (incorporated into prompt shields), existing text, and code in public repositories.

The default content filtering configuration is set to filter at the medium severity threshold for all four content harms categories for both prompts and completions. That means that content that is detected at severity level medium or high is filtered, while content detected at severity level low or safe isn't filtered by the content filters.

Prompt shields and protected text and code models are optional and on by default. For prompt shields and protected material text and code models, the configurability feature allows all customers to turn the models on and off. The models are on by default and can be turned off to match your requirements.

### Scenario
Your company is developing an AI-powered training and simulation platform for professionals in fields such as law enforcement, healthcare, and social work. In these contexts, realistic scenarios sometimes require references to violence, hate, or self-harm in order to train staff to recognize, respond to, and de-escalate critical situations. Because overly aggressive filtering would block content that is both intentional and necessary for simulation accuracy, the organization decides to lower severity thresholds to block only the most extreme cases. This configuration still prevents harmful misuse but allows the AI to produce controlled, context-appropriate outputs that better align with training objectives.
Additionally, since some scenarios involve exploring how individuals might attempt to manipulate AI systems, direct jailbreak detection should be enabled, while indirect jailbreak shields are turned off to allow testing of those edge cases in a controlled environment. To further protect compliance and intellectual property boundaries, output filters are used to protect material checks to block copyrighted or publicly available code/text from surfacing in generated content.


### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription or the target resource group level.
- Familiarity with Azure AI Content Safety

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2346706)

## Exercise 5: Configure content filters with prompt shields (new)

### Estimated duration
20 minutes

### Background information
Microsoft Foundry includes built-in safety and security guardrails that apply to both core models, including image generation models, and agents developed using the Foundry Agent Service (agent guardrails are in preview as of December 2025). These guardrails run alongside models and agents to detect and mitigate harmful or undesirable behavior using classification models designed to identify risks such as violence, hate, self-harm, prompt attacks, and protected material in text or code.

Guardrails define how and where risks are evaluated and what action is taken when a risk is detected. Risks can be assessed at multiple intervention points, including user input and model output for both models and agents, and additionally at tool call and tool response stages for agents. When a risk is detected, the guardrail can annotate or block the output, depending on the configured action and the applicability of the control to models or agents.

By default, model deployments use the Microsoft.DefaultV2 guardrail. Agents inherit the guardrail of the underlying model unless a specific guardrail is assigned to the agent. When an agent-level guardrail is applied, it fully overrides the model's guardrail, and all risk detection for that agent is based on the agent's configuration. Guardrail behavior may vary depending on API configuration and application design, and agent guardrails currently apply only to agents built in the Foundry Agent Service.

### Scenario
Your company is building an AI-powered training and simulation platform using Microsoft Foundry agents for professionals in domains such as law enforcement, healthcare, and social work. These simulations require agents to generate and reason over realistic situations that may include references to violence, hate, or self-harm in order to help trainees recognize, respond to, and de-escalate high-risk scenarios. To support this goal, the organization configures agent-level guardrails with lower severity thresholds so that only high-risk content is blocked, while contextually appropriate material is allowed to pass through for training purposes.


- The platform is intentionally designed to observe and evaluate user attempts to manipulate or stress‑test agent behavior through controlled exercises.
- Guardrails are configured to block direct prompt attacks while allowing select indirect attack patterns to surface for testing and analysis.
- These guardrails operate at user input and output boundaries, and selectively during tool calls and tool responses to support enriched simulations.
- Protected material checks for text and code are enforced to ensure compliance and safeguard intellectual property while enabling realistic, policy‑compliant training interactions.

:::image type="content" source="../media/configure-agent-level-guardrails.png" alt-text="Diagram showing how an organization configures agent-level guardrails with lower severity thresholds.":::

### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription or the target resource group level.
- Familiarity with guardrails and controls in Microsoft Foundry

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2346433)
