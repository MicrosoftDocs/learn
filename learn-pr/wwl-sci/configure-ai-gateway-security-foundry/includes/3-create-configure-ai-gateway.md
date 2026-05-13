Creating an AI Gateway in Microsoft Foundry establishes the security layer between your applications and model deployments, replacing direct endpoint access with centralized authentication and policy enforcement. Contoso Financial Services needs to replace its shared API key approach with individual caller authentication and token rate limits to prevent any single application from monopolizing model capacity. Here, you learn how to create a gateway instance, configure route policies, set token limits, and enable authentication.

| Configuration Step | Purpose |
|--------------------|---------|
| **Create gateway instance** | Deploy the managed reverse proxy within your Foundry project |
| **Configure route policies** | Direct incoming requests to specific model deployments based on caller or criteria |
| **Set token rate limits** | Control token consumption per caller to protect model capacity |
| **Configure authentication** | Enforce caller identity validation using API keys or Microsoft Entra tokens |
| **Review and test** | Verify configuration and validate with sample requests |

## Create the AI Gateway instance

To create an AI Gateway, sign in to **Microsoft Foundry** at [ai.azure.com](https://ai.azure.com)—not the Azure portal. Select **Operate** > **Admin console**, then open the **AI Gateway** tab and select **Add AI Gateway**.

Select the Foundry resource you want to associate with the gateway. Then choose whether to create a new API Management instance or reuse an existing one.

> [!TIP]
> **Create new** deploys a **Basic v2** Azure API Management instance—designed for development and testing. For production workloads, select **Use existing** and associate a Standard v2 or Premium v2 AI Policy Manager (APIM) instance. Premium v2 is required if your Foundry resource has public network access disabled and you need virtual network injection with private endpoint support.

Provide a name for the gateway and select **Add**. Provisioning typically completes within 5–10 minutes. Verify that the gateway appears in the list with a status of **Enabled**.

AI Gateway is enabled at the Foundry **resource** level—not the individual project level. After creation, new projects are gateway-enabled by default. Existing projects must be manually enabled: select the gateway name, locate the project in the list, and select **Add project to gateway**.

## Configure route policies

Route policies determine how the gateway directs incoming requests to backend model deployments. Each route maps from the gateway's inbound endpoint to a specific model deployment, optionally filtering by caller identity, endpoint path, or request headers.

Open the gateway's route configuration panel and create a new route. Select the source as the gateway's inbound endpoint and the destination as your target model deployment. If you operate multiple models, create separate routes for each deployment.

With advanced routing, you direct different callers to different models based on their identity. For example, route internal applications to a premium model deployment with higher token limits, while external-facing agents use a standard model with lower per-request costs. Route policies also support A/B testing scenarios where you direct a subset of traffic to a new model version for validation.

For Contoso's scenario, configure three routes: one from the gateway to the production model deployment used by all three applications. Later, if Contoso deploys a specialized model for regulatory research, you add a second route that directs only the research agent to the specialized deployment.

## Set token rate limits

Token rate limits prevent a single project from monopolizing available model capacity. In Microsoft Foundry, rate limits apply at the **project level** per model deployment—each project can have independent tokens-per-minute (TPM) limits and total quota settings. This design lets you allocate capacity fairly across teams and workloads without depending on individual callers to self-limit.

To configure token limits, go to **Operate** > **Admin** in the Foundry portal, select the gateway, then select **Token management** > **+ Set limit**. Choose the project and the model deployment to restrict, then enter a value for **Limit (Token-per-minute)**.

Token enforcement has two complementary dimensions:

- **TPM rate limit—limits token consumption to a configured maximum per minute. When requests exceed this limit, the caller receives a `429 Too Many Requests` response.
- **Total token quota—limits token consumption to a configured maximum per quota period (hourly, daily, weekly, monthly, or yearly). When requests exhaust the quota, the caller receives a `403 Forbidden` response.

Understanding both response codes matters for application error handling: a `429` signals a temporary rate limit that resets at the next minute boundary, while a `403` means the project's total quota for the period is exhausted.

At Contoso, the security team configures separate project-level limits for the shared model deployment: 50,000 TPM for the document analysis project to handle peak processing loads, 30,000 TPM for the regulatory research project, and 20,000 TPM for the customer chatbot project. Each project's limit is independent—if the document analysis project hits its rate limit, the other projects continue operating normally.

:::image type="content" source="../media/gateway-token-allocation.png" alt-text="Bar chart showing project-level TPM limits: 50,000 for Document Analysis, 30,000 for Regulatory Research, and 20,000 for Customer Chatbot." lightbox="../media/gateway-token-allocation.png":::

## Configure authentication

Authentication determines how the gateway validates caller identity. AI Gateway supports two primary modes: API key authentication and Microsoft Entra token authentication.

With API key authentication, each caller presents a unique API key in the request header. The gateway validates the key against registered callers and identifies the request source. While simpler to implement, API keys require secure storage and regular rotation to maintain security.

With Microsoft Entra token authentication, each calling application uses a managed identity or service principal to request an access token from Microsoft Entra ID. The application includes the token in the request header, and the gateway validates the token's signature, expiration, and claims before routing the request. This approach eliminates stored credentials and integrates with your organization's identity governance policies.

For production environments, configure Microsoft Entra token authentication. In the gateway's authentication settings, select **Microsoft Entra ID** as the authentication provider. Specify the required token audience and issuer to ensure the gateway only accepts tokens issued for your Foundry environment.

For each calling application, assign a managed identity (system-assigned or user-assigned) and grant the identity permission to access the gateway. Update application code to request a Microsoft Entra token and include it in the `Authorization: Bearer <token>` header with each model request.

For **Microsoft Foundry-deployed agents**, authentication works through the managed identity assigned to the agent resource in Foundry. Each agent has a unique client ID that the gateway records in diagnostic logs as the caller identity—giving security teams per-agent visibility into model usage rather than attributing all traffic to a single application identity. When the admin assigns gateway permissions, scope each agent's managed identity access to only the model deployments it legitimately needs. If an agent is compromised or begins generating unexpected traffic, you can revoke its role assignment without disrupting other agents or applications.

Contoso assigns a system-assigned managed identity to each of its three applications. The gateway is configured to require Microsoft Entra tokens with the audience set to the gateway's resource ID. Applications request tokens using their managed identities and include them in all model inference requests.

## Review gateway configuration

Before directing production traffic to the gateway, verify your configuration settings. Confirm that route policies correctly map inbound requests to target model deployments. Check that token rate limits align with expected usage patterns and total model capacity.

Test authentication by making a sample request from one of your calling applications. Ensure the application successfully obtains a Microsoft Entra token, includes it in the request header, and receives a valid response from the gateway. Verify that the request appears in diagnostic logs with the correct caller identity.

Monitor the gateway's metrics during initial rollout to detect configuration issues early. Watch for elevated rates of authentication failures or rate limit rejections, which indicate misconfigured caller identities or token quotas.
