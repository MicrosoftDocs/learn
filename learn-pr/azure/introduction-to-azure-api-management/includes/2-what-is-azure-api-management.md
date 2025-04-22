Let's start with a quick overview of Azure API Management and its core features. This overview should help you decide whether Azure API Management might be a suitable solution for reducing your company's API complexity.

## What is API lifecycle management?

*API lifecycle management* is the process of administering an API through its entire lifespan. For the purposes of this module, we'll pick up after your APIs have already been designed, coded, and deployed. Let's concentrate on the rest of the API lifecycle management tasks, which include:

- Providing API documentation, testing, and code samples.
- Onboarding and off-boarding users.
- Managing API subscriptions and the distribution of subscription keys.
- Implementing API revisions in a controlled and safe way.
- Managing multiple versions of an API.
- Implementing API access controls, such as authentication and call rate limits.
- Providing API reporting for usage, errors, and so on.
- Managing analytics for both your company and for the developers who use the APIs.

## Azure API Management definition

*Azure API Management* is a cloud service that gives you a platform for publishing, securing, maintaining, and analyzing all your company's APIs. The following image helps depict this service:

:::image type="content" source="../media/2-what-is-azure-api-management-overview.png" alt-text="The main components of Azure API Management include the administration interface, gateway, and developer portal." lightbox="../media/2-what-is-azure-api-management-overview.png":::

> [!IMPORTANT]
> Azure API Management doesn't host your actual APIs; your APIs remain where they were originally deployed. Instead, Azure API Management acts as a kind of "front door" for your APIs. In this way, Azure API Management *decouples* your APIs by letting you set API policies and other management options in Azure, while leaving your deployed backend APIs untouched.

Azure API Management accomplishes these tasks by offering three main components, which we'll dive into next.

### Gateway component

The *Azure API Management gateway* is an Azure endpoint that accepts all calls from all your APIs. The gateway verifies API subscription keys and other credentials, enforces your usage quotas and rate limits, and transforms the API as needed for backend compatibility. It also routes each call to its appropriate backend server, caches backend responses, and collects call metadata for analytics workloads.

### Administration interface component

The *Azure API Management administration interface* is a set of Azure portal pages and tools that enable you to administer your service and your APIs. You use the administrative interface for provisioning, scaling, and monitoring the service. You can also define or import API specifications, implement usage policies, set security policies, and manage users. Finally, you can package APIs into products, define API transformations, manage API revisions and versions, and run analytics on your API metadata.

### Developer portal component

The *Azure API Management developer portal* is a fully customizable website that enables developers to interact with your APIs. They can review documentation, try an API, review code samples, subscribe to an API, and run analytics on the developer's usage.

## Apply policies to API requests and responses

One of the biggest problems with having multiple published APIs is that each API requires a separate set of policies, which is a setting or action that controls the behavior of the API. Azure API Management solves the API policy problem by enabling you to set policies for all your APIs in a single place. You can set policies in many categories, but a partial list includes:

- **Access restriction**. These policies determine when an API request is allowed through the gateway. For example, enforce rate limits and usage quotas, filter caller IPs, and check for a valid JSON Web Token (JWT).
- **Authentication**. Authenticate API calls by using Basic authentication, a client certificate, or a managed identity as examples.
- **Caching**. Improve API performance by storing and retrieving responses in the cache.
- **Validation**. Validate API calls by comparing certain parameters to what's in your API specification. For example, validate the request or response body, the request header parameters, and the response headers.

Flexibly combine your policies in *policy definitions*, which are XML documents that consist of a series of statements representing a policy and its parameters. Policy definitions let you configure separate policies at different stages of the API request-response pipeline as shown here:

:::image type="content" source="../media/2-what-is-azure-api-management-policies.png" alt-text="A consumer's API request enters the Azure API Management gateway where it passes through inbound policies before being sent to the backend server. The API response then passes through the gateway's outbound policies before being sent to the originating API consumer." lightbox="../media/2-what-is-azure-api-management-policies.png":::
