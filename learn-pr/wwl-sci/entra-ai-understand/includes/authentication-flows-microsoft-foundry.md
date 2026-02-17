Understanding that identity governs access isn't enough. You also need to understand how an identity proves who it is when calling an AI endpoint.

Every request to an AI endpoint must include valid authentication credentials. Microsoft Foundry relies on industry-standard OAuth 2.0 flows and Microsoft Entra ID to issue and validate access tokens.

At a high level, authentication answers three questions:

- Who is calling the model?
- From where is the request originating?
- What credential is being presented?

## OAuth 2.0 and token issuance

AI endpoints use OAuth 2.0 to authenticate callers. When a user, application, or workload attempts to access a protected AI resource, Microsoft Entra ID evaluates the request and issues an access token if authentication succeeds.

That token represents the authenticated identity. It contains claims about:

- The identity
- The tenant
- Assigned roles or permissions
- Token lifetime

The caller includes the access token in requests to the AI endpoint. The service validates the token before processing the request.

For example, a web application that calls an AI endpoint uses its service principal to request a token from Microsoft Entra ID. If authentication succeeds, Microsoft Entra issues an access token. The application includes that token in its request, and the AI endpoint validates it before processing the prompt.

If the token is invalid, expired, or improperly scoped, the request fails before reaching the model.

## Interactive and non-interactive authentication

Authentication flows differ depending on who or what is calling the endpoint.

Interactive authentication typically involves a human user. For example:

- A developer signs in to deploy a model through Microsoft Foundry.
- An administrator configures AI resources in the Azure portal.

In these cases, the user authenticates through Microsoft Entra ID, and an access token is issued for that session.

Non-interactive authentication is used by applications and workloads. Examples include:

- A web application calling a model endpoint
- An automation workflow deploying updates
- A backend service retrieving embeddings

In these scenarios, authentication occurs without human interaction. The application uses a service principal or managed identity to obtain an access token from Microsoft Entra ID.

At runtime, the AI endpoint doesn't distinguish between human and application requests. It validates the token and evaluates authorization based on the identity represented in that token.

## Token flow between client and AI endpoint

The authentication sequence follows a consistent pattern:

1. The client requests an access token from Microsoft Entra ID.
1. Microsoft Entra ID authenticates the caller and issues a token if the request is valid.
1. The client includes the token in the request to the AI endpoint.
1. The endpoint validates the token before evaluating authorization.

Only after successful authentication and authorization does the service process the model request.

This flow ensures that every AI interaction in Microsoft Foundry is tied to a verified identity and evaluated against assigned permissions.

Understanding this sequence prepares you to analyze authentication failures, token misuse, and access control misconfigurations in AI environments. It also clarifies how different identity types authenticate and why that distinction matters.
