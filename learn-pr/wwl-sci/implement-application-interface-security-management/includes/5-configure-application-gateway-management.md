Authentication, network, and backend connection controls secure the path to traditional REST APIs. Azure OpenAI endpoints present other challenges that those controls alone don't address: consumption is measured in tokens rather than calls, responses are often similar enough to cache, and multiple model deployments can share load. API Management's AI Gateway capabilities extend the platform with policies and features purpose-built for these characteristics.

## Understand AI Gateway capabilities in API Management

API Management functions as a security and governance layer between AI consumers and Azure OpenAI backends. Instead of applications calling Azure OpenAI directly with API keys, they call through API Management. The gateway enforces authentication, applies rate limits based on token consumption, logs usage per subscriber, and can serve cached responses for semantically similar prompts.

This architecture gives Contoso Retail's security team a centralized enforcement point for every request that reaches the Azure OpenAI backend. Consumer applications—whether they're front-end apps, Function-based orchestrators, or Azure AI Foundry agent workflows—all pass through the same policy pipeline. Policies apply consistently regardless of which application is calling.

Routing AI requests through API Management also abstracts the backend endpoint. If you add a second OpenAI deployment for load distribution or failover, you update the backend configuration in API Management—consumer applications don't need to know the backend changed.

## Route AI requests using managed identity authentication

Rather than storing Azure OpenAI API keys in API Management configuration, use **managed identity** to authenticate the gateway to the OpenAI resource. This eliminates stored credentials from the configuration entirely.

To configure managed identity authentication for an Azure OpenAI backend:

1. Enable the **system-assigned managed identity** on your API Management instance in the **Managed identities** screen.
2. In the Azure portal, go to your Azure OpenAI resource and assign the **Cognitive Services OpenAI User** role to the API Management managed identity.
3. In API Management, configure the backend for the Azure OpenAI endpoint. Set authentication to **Managed identity** and specify the resource URI `https://cognitiveservices.azure.com/`.
4. Add a `set-header` policy in the inbound section to remove any `api-key` header callers might include, ensuring the gateway always uses managed identity—never a caller-provided key.

With this configuration, no API key exists in the API Management policy or backend configuration. The managed identity acquires a token from Microsoft Entra ID on each request automatically, and the OpenAI resource validates it. Revoking the managed identity's role assignment on the OpenAI resource immediately blocks all calls through API Management—access control lives at the Azure RBAC layer, not in stored credentials.

## Enforce token-based rate limits

Standard call-count rate limiting doesn't prevent excessive Azure OpenAI cost. A single request can consume thousands of tokens. Limiting to 100 calls per minute still allows a subscriber to exhaust your provisioned throughput with a handful of expensive requests. The `azure-openai-token-limit` policy addresses this by governing consumption based on token usage rather than call count.

```xml
<inbound>
  <azure-openai-token-limit
    counter-key="@(context.Subscription.Id)"
    tokens-per-minute="10000"
    estimate-prompt-tokens="false"
    remaining-tokens-header-name="x-remaining-tokens"
    remaining-tokens-variable-name="remainingTokens" />
  <base />
</inbound>
```

Key elements of this policy:

- **`tokens-per-minute`**: Sets the token consumption limit per counter key per minute. This aligns rate limiting with the actual cost driver for OpenAI workloads.
- **`counter-key`**: Identifies the consumer for rate limiting purposes. The key uses `context.Subscription.Id` limits each subscription independently, so one high-volume subscriber doesn't affect others.
- **`remaining-tokens-header-name`**: Returns the remaining token allowance in a response header so clients can manage their own pacing before hitting a limit.

When a request would exceed the token limit, the policy returns `429 Too Many Requests` before the request reaches the OpenAI backend—preventing overuse without consuming tokens for the rejected call.

Apply `azure-openai-token-limit` at the product scope to enforce per-subscription limits across all AI consumers in the product.

## Reduce redundant AI calls with semantic caching

Many LLM use cases—FAQ bots, documentation assistants, and product lookup tools—receive conceptually similar or identical prompts from different users. The `azure-openai-semantic-cache-lookup` and `azure-openai-semantic-cache-store` policies cache OpenAI responses and serve cached results for semantically similar prompts, reducing both cost and latency without compromising the response quality the caller receives.

Configure semantic caching with a pair of policies—one on the inbound side and one on the outbound side:

```xml
<inbound>
  <azure-openai-semantic-cache-lookup
    score-threshold="0.05"
    embeddings-backend-id="text-embedding-backend" />
  <base />
</inbound>
<outbound>
  <azure-openai-semantic-cache-store duration="3600" />
  <base />
</outbound>
```

The `score-threshold` controls how similar a new prompt must be to a cached prompt before the cached response is returned. Lower values are more permissive (serve cache for more similar prompts). The cache store policy persists responses for the duration specified in seconds.

> [!NOTE]
> Semantic caching requires an Azure OpenAI embedding model deployment to compute similarity scores between prompts. Configure a separate embeddings backend in API Management and reference it in the `embeddings-backend-id` parameter.

## Monitor AI usage for governance

AI costs and capacity planning require visibility into which subscribers are consuming tokens, which prompts generate errors, and what the latency profile looks like per model deployment. API Management's integration with Azure Monitor and Application Insights captures this data per request.

Enable Application Insights logging in API Management and configure it to capture token counts, response latencies, model errors, and HTTP status codes for AI APIs. Use Azure Monitor workbooks to visualize token consumption per subscription, track `429` error rates to identify subscribers approaching limits, and detect latency outliers that can indicate backend capacity issues.

> [!IMPORTANT]
> Logging request and response bodies for AI APIs captures prompt and completion text. Verify that this aligns with your data handling policies before enabling detailed logging in production—prompts can contain sensitive user input or proprietary business context.

When autonomous agents—including Function-based orchestrators and Azure AI Foundry agent workflows—call Azure OpenAI through API Management, the same token-limit and logging policies apply regardless of whether the caller is a human-facing application or an automated agent. This prevents runaway agent loops from exhausting provisioned throughput and ensures every AI interaction is captured in your governance logs.
