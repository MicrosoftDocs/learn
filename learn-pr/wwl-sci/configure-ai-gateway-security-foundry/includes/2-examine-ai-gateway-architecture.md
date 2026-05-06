AI Gateway acts as a managed security layer between your applications and AI model deployments, enforcing authentication and access policies at a single control point. In Microsoft Foundry, AI Gateway is powered by **Azure API Management (APIM)**—a fully managed service that becomes the actual enforcement engine for authentication, rate limiting, policy application, and diagnostic logging. At Contoso Financial Services, multiple applications currently share the same model endpoint and API key—creating a risk where compromising one application exposes all model access. Here, you examine how AI Gateway architecture addresses this security gap by centralizing authentication, rate limiting, and audit logging.

| Component | Role |
|-----------|------|
| **Callers** | Client applications, agents, or services that request model inference |
| **AI Gateway (APIM instance)** | Azure API Management instance that enforces authentication, applies policies, logs traffic, and routes requests to model deployments |
| **Model deployments** | Backend AI models that receive and respond to requests only after passing gateway validation |
| **Azure Monitor / Log Analytics** | Destination for AI Policy Manager (APIM) diagnostic logs, enabling KQL queries, dashboards, and alert rules |

Agents are a common caller type in AI workloads. A Microsoft Foundry agent is an autonomous AI workflow that can call the model dozens of times per user interaction as it reasons through tasks, uses tools, or orchestrates subagents. Unlike a human-operated application that makes one model call per user action, an agent can generate bursts of model traffic that are difficult to predict. Unknown model traffic for agents makes gateway rate limits and per-caller authentication especially important: without them, a single runaway agent can exhaust model capacity for every other caller, and without per-caller logging, agent activity is invisible in your audit trail.

## The security problem AI Gateway solves

Without a gateway, any application with the model endpoint URL and API key can call the model directly. This approach creates several security risks that grow as your AI deployment expands.

First, there's no authentication enforcement per caller. If you share a single API key across five applications, you can't distinguish which application made which request. When one application is compromised, the attacker gains access to all model deployments using that key.

Second, there's no rate limiting or quota control. A runaway application or malicious actor can consume all available model capacity, blocking legitimate users. Without a control layer, you must implement rate limiting in each calling application—a maintenance burden that invites inconsistent enforcement.

Third, there's no centralized audit trail. Requests go directly from applications to models, bypassing any logging infrastructure you maintain. Investigating suspicious activity or tracking usage patterns requires aggregating logs from every application individually.

## How AI Gateway centralizes security controls

AI Gateway sits between callers and model deployments as a reverse proxy. All requests flow through the APIM instance, which validates authentication, applies rate limits, and logs traffic before routing to the target model. Because APIM is the underlying engine, monitoring and advanced configuration—such as custom policies, load balancing, and detailed diagnostic logs—are managed through the APIM experience in the Azure portal, not exclusively through the Foundry portal.

The gateway enforces caller-specific authentication using either API keys or Microsoft Entra tokens. With Microsoft Entra token authentication, each application uses its own managed identity to request a token. The gateway validates the token and identifies the caller before allowing the request to proceed. This approach eliminates shared credentials and gives you per-application visibility into model usage.

Rate limiting operates at the gateway layer, not within each application. You configure token limits per caller or per subscription, and the gateway rejects requests that exceed the threshold. Limits protect model capacity from any single application monopolizing resources.

All request metadata—timestamp, caller identity, token count, response code, latency—flows to Azure Monitor through diagnostic logging. You gain a complete audit trail of model access without modifying calling applications.

## Gateway architecture for Contoso's scenario

Contoso operates three applications that call the same AI model: a document analysis tool, a regulatory research agent, and a customer-facing chatbot. Today, all three use a shared API key stored in environment variables.

With AI Gateway in place, the shared key is replaced with individual managed identities for each application. The document analysis tool receives a token limit of 50,000 tokens per hour to handle peak processing loads. The regulatory research agent gets 30,000 tokens per hour for background analysis. The customer chatbot receives 20,000 tokens per hour with burst capacity for high-traffic periods.

The gateway routes all three applications through a single inbound endpoint, validates each request's Microsoft Entra token, checks the caller's token quota, and logs the request before forwarding to the model deployment. If the regulatory research agent is compromised, the attacker can't access the other applications' quotas or impersonate their identities.

:::image type="content" source="../media/gateway-architecture-before-after.png" alt-text="Diagram of AI Gateway architecture comparing direct model access with shared API key versus secured access through APIM." lightbox="../media/gateway-architecture-before-after.png":::
