Contoso Financial Services' development team deployed several Copilot Studio agents to handle client-facing interactions and internal data queries. These agents interact with sensitive financial data through Power Platform connectors, and some are accessible externally. The security team has one key concern: if an agent behaves unexpectedly—from prompt injection, a misconfigured connector, or a compromised user session—do they know? And do records exist to investigate?

Real-time runtime protection for Copilot Studio agents answers that question. Microsoft Defender for Cloud Apps provides three layers of capability for agent protection: discovery and hunting to find agents across your environment, audit, and alerts to capture agent activity. Then you have surface policy violations, and real-time protection to inspect and intercept agent interactions as they happen.

Enabling that protection requires coordinating across two administrative surfaces—the Microsoft Defender portal and the Power Platform admin center. This module walks you through that configuration, shows you what to verify after setup, and explains what outputs to expect in Microsoft Defender XDR.

## Learning objectives

In this module, you learn how to:

- Describe the AI agent protection capabilities available in Microsoft Defender for Cloud Apps
- Enable real-time protection for Copilot Studio agents in the Microsoft Defender portal
- Verify that agent protection outputs appear in the Microsoft Defender XDR inventory, alerts, and Advanced Hunting

## Prerequisites

Before you begin, you should have:

- Familiarity with Microsoft Copilot Studio and agent development concepts
- Experience with Microsoft Defender portal administration
- Understanding of Microsoft Defender for Cloud Apps capabilities
- One of the following licenses: a **Microsoft Agent 365** license, or both a **Microsoft Defender for Cloud Apps** license and a **Microsoft Copilot Studio** license
- Preview features enabled for both **Microsoft Defender for Cloud** and **Microsoft Defender XDR** in your tenant
