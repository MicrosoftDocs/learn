Contoso Ltd. is developing an internal assistant that uses **Azure OpenAI** for natural language responses and **Azure AI Search** to retrieve company data. The workload runs on Azure infrastructure managed by the security team, which maintains network isolation, access control, and **Defender for Cloud** posture policies.

As deployment approaches, the cloud security engineer must evaluate how to extend existing protections to cover data handling, model behavior, and workload posture across the AI lifecycle.

---

### **Knowledge check**

```yaml
- content: |
    Which layer of an AI workload handles user input, connects it to the model, and returns responses?
  choices:
    - content: Data layer
    - content: Application layer
      isCorrect: true
      explanation: The application layer manages user interaction, routes prompts to the model, and delivers responses. In AI workloads, this layer often integrates APIs or copilots that connect to model endpoints.
    - content: Retrieval layer
    - content: Orchestration layer

- content: |
    Which type of risk occurs when attackers manipulate a model through crafted inputs or malicious documents?
  choices:
    - content: Model drift
    - content: Prompt injection
      isCorrect: true
      explanation: Prompt injection is an attempt to alter a model’s instructions directly or indirectly through malicious input. Security engineers should account for this in their threat models.
    - content: Data exfiltration
    - content: Model overfitting

- content: |
    Contoso wants to prevent its AI assistant from producing harmful or ungrounded responses. Which Azure control addresses this concern?
  choices:
    - content: Azure Policy
    - content: Prompt Shields
    - content: Content Safety
      isCorrect: true
      explanation: Content Safety evaluates model outputs and filters harmful, ungrounded, or sensitive responses before delivery. It complements infrastructure controls like network isolation and access management.
    - content: Network isolation

- content: |
    Which Azure service helps the cloud security engineer identify misconfigurations and threats across the AI infrastructure?
  choices:
    - content: Microsoft Purview
    - content: Microsoft Defender for Cloud
      isCorrect: true
      explanation: Microsoft Defender for Cloud provides cloud security posture management (CSPM) and workload protection. It helps engineers assess AI infrastructure, detect threats, and align configurations with best practices.
    - content: Microsoft Entra ID
    - content: Azure AI Foundry

- content: |
    To achieve a complete protection strategy for Contoso’s AI assistant, which combination of tools should the engineer use?
  choices:
    - content: Microsoft Purview and Microsoft Entra ID
    - content: Azure AI Foundry and Microsoft Defender for Cloud
    - content: Microsoft Purview, Azure AI Foundry, Microsoft Defender for Cloud, and Microsoft Entra ID
      isCorrect: true
      explanation: Together, these tools provide unified coverage across data governance, model guardrails, workload posture, and identity protection. Entra ID enforces access through RBAC and conditional access, while Defender for Cloud extends CSPM to AI workloads.
    - content: Azure AI Foundry and Azure AI Search
```
