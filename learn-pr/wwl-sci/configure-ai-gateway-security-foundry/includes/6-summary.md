Contoso Financial Services started this module with a shared API key, multiple applications calling the same model endpoint, and no mechanism to detect or prevent misuse. By the end, every model request passes through a controlled, authenticated, rate-limited, and monitored gateway—and the 2 AM processing loop that could go undetected for weeks was caught within days.

## Review what you accomplished

You examined the AI Gateway architecture and identified the core principle: a managed reverse proxy layer that interposes between callers and model deployments, becoming the single enforcement point for all model access. Without a gateway, security depends on every application implementing its own controls—an approach that scales poorly and fails silently. With a gateway, access control, rate limiting, and logging happen in one place regardless of how many callers exist.

You created and configured a gateway instance in Microsoft Foundry, defining route policies that direct callers to the right model deployments. You then set token rate limits that allocate capacity fairly across applications, and Entra-token authentication that replaces the shared API key with caller-specific credentials. Each of Contoso's three applications now authenticates with its own managed identity—compromising one application's credential no longer grants access to the others.

You then applied access controls and monitoring to the running gateway, enabling diagnostic logging routed to Azure Monitor. You configured alert rules for token consumption anomalies, and wrote KQL queries to detect high-volume requests outside business hours. The monitoring layer turns the gateway from a passive control point into an active detection capability.

In this module, you learned how to:

- Examine the AI Gateway architecture and explain how it secures AI model traffic
- Create and configure an AI Gateway instance in Microsoft Foundry
- Apply access controls and monitoring to secure and audit AI Gateway usage

## What's next

AI Gateway secures model-layer traffic. You should next expand the protection upstream by configuring guardrails in Microsoft Foundry—content filters, block lists, and Prompt Shields that evaluate the content of prompts and responses before they reach your models.
