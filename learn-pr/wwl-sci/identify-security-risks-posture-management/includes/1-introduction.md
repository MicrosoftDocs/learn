Contoso Healthcare Systems operates a large Azure environment that includes core clinical and administrative workloads alongside expanding AI-powered applications — a patient triage assistant built on Azure OpenAI and an AI-driven medical records summarization service running on Azure AI Foundry. The security team receives hundreds of daily security recommendations but has no structured method to determine which risks represent real, exploitable threats to patient data, AI model integrity, or business continuity.

Microsoft Defender for Cloud's Cloud Security Posture Management (CSPM) capabilities provide continuous visibility, risk-based prioritization, attack path analysis, and proactive risk hunting to address exactly this challenge. CSPM helps you identify which misconfigurations and exposures matter most by showing you how attackers could exploit them to reach your critical assets.

In this module, you learn to use CSPM features to identify and prioritize security risks across your Azure environment. Specifically, you:

- Compare Foundational CSPM and Defender CSPM plan capabilities, including AI security posture management features
- Interpret the Cloud Secure Score and security recommendations using the risk-based prioritization model in the Microsoft Defender portal
- Identify externally exploitable attack paths — including those targeting AI workloads — using attack path analysis
  - **Initial Access** — internet-exposed resources that serve as entry points into the environment
  - **Lateral Movement** — paths an attacker can follow from one resource to another, including toward AI services
  - **Exfiltration** — routes that lead to critical data such as patient health records or AI model training datasets
  - **Privilege Escalation** — identity and permission misconfigurations that enable attackers to gain elevated access along a path
- Run graph-based queries in Cloud Security Explorer to proactively discover security risks
