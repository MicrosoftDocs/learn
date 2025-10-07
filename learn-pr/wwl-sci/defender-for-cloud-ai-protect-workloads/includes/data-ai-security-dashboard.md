## Review insights in the Data & AI security dashboard

The **Data & AI security** view serves as the main workspace for assessing AI and data posture. It consolidates security findings, alerts, and attack paths so you can evaluate protection coverage at a glance.

- **Overview** shows all data and AI resources by cloud and protection status, whether fully, partially, or not protected.
- **Top issues** lists the most critical recommendations, alerts, and attack paths that need attention.
- **Data closer look** highlights sensitive data discovery results, common information types, and any internet-exposed data assets.
- **AI closer look** summarizes discovered AI services, prompt and response alerts, and internet-exposed resources used for grounding or fine-tuning.

Each section provides entry points for investigation. For example, selecting an attack path opens contextual details that show how a misconfigured storage account could expose grounding data to the internet.

## Use initial findings to strengthen AI security posture

With discovery complete, focus on a few key checks before moving on:

- Confirm that AI services use **private endpoints** rather than public access.
- Verify that **managed identities** are used for Azure AI accounts instead of embedded credentials.
- Review **sensitive data findings** associated with AI storage or indexes, and ensure encryption at rest is enabled.
- Note any internet-exposed data or compute resources that support AI workloads. These should be addressed first in Cloud Security Posture Management (CSPM).

By enabling the AI workloads plan and reviewing insights in the Data & AI dashboard, you now have visibility into where AI resources exist, how they're protected, and which configuration issues present the highest risk.

Now that you know how to enable the AI workloads plan and interpret the insights in the Data & AI dashboard, you can use these findings to identify and remediate configuration risks that affect your organization’s AI security posture.