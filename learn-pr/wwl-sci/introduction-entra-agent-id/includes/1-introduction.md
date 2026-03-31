The emergence of AI agents as autonomous enterprise systems introduces unique security and operational challenges that existing identity models weren't designed to address. Organizations need a way to distinguish operations performed by AI agents from operations performed by human users or traditional applications, while maintaining appropriate security controls and governance.

Microsoft Entra Agent ID provides specialized identity constructs designed specifically for AI agents operating in enterprise environments. These identity constructs enable secure authentication and authorization patterns that address the unique requirements of autonomous AI systems.

## Scenario: Managing AI Agent identities

Imagine you're an Identity and Access Administrator at a large organization that's adopting AI agents across multiple departments. Your marketing team uses AI agents in Microsoft Copilot Studio to answer customer inquiries. Your development team builds agents in Microsoft Foundry that access company data. Your IT team deploys agents in Azure App Service to automate workflows.

Each of these agents needs an identity to authenticate and access resources securely. However, using traditional service principals or managed identities doesn't provide the visibility, governance, or security controls designed for AI agents. You need to:

- Distinguish AI agent operations from human user operations in audit logs
- Apply consistent security policies to all agents of a particular type
- Prevent agents from gaining excessive privileges
- Scale identity management to potentially thousands of agents that might be created and destroyed rapidly

Microsoft Entra Agent ID addresses these challenges by providing specialized identity types designed for AI agents.

## Content description

In this module, you learn about Microsoft Entra Agent ID and how it differs from other identity types like service principals and managed identities. You explore which Microsoft products automatically create agent identities and how to view and manage them through the Microsoft Entra admin center. You also learn about the roles required to manage agent identities and how to query them programmatically using Microsoft Graph.

## What is the main goal

By the end of this module, you'll understand what Microsoft Entra Agent ID is. You can explain how it compares to other identity types. You can define which Microsoft products use the Agent ID, and how to view and manage agent identities in your organization.
