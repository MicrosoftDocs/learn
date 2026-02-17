The Azure Copilot Troubleshooting agent helps you diagnose and resolve issues with workloads running in Azure. The Troubleshooting agent can assist with problems such as a VM that won't start, an application generating errors, a service misconfiguration, or a resource-level problem. Where the observability agent identifies root causes, the Troubleshooting agent is able to fix problems or guide you through the fix. The agent provides immediate solutions or actionable diagnostics whenever incidents occur.

The Troubleshooting agent is invoked when you specifically ask for help with a problem or when an issue is detected and a direct fix is needed. The Troubleshooting agent workflow is as follows:

- When pointed to a problem, such as you prompting "my VM is down" or by linking from an observability finding, the agent runs targeted diagnostics for that resource.
- Using the data, the agent tries to determine what's causing the issue. The agent uses known patterns from Microsoft's documentation and possibly machine learning to map symptoms to causes.
- Once a cause is identified, the Troubleshooting agent will either give you the exact steps to fix it, or offer an automated one-select fix.
- If the agent can't fully resolve the issue, or it detects something that likely requires deeper investigation, such as an internal platform issue or an unknown bug, it helps you escalate to Microsoft Support by creating a support ticket. The Troubleshooting agent will also autogather relevant diagnostic information into that support request.

The Troubleshooting agent reduces the need to manually navigate Azure's many troubleshoot wizards or search documentation, since it encapsulates that knowledge. This provides you with faster recovery from incidents.
