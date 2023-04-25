Let's start with a quick overview of Azure API Management and its core features. This overview should help you decide whether Azure API Management might be a suitable solution for reducing your company's API complexity.

## What is API lifecycle management?

*API lifecycle management* is the process of administering an API through its entire lifespan&mdash;from its design and creation to its obsolescence and retirement. For the purposes of this module, we'll pick up after your APIs have already been designed, coded, and deployed. Let's concentrate on the rest of the API lifecycle management tasks, which include:

- Providing API documentation, testing, and code samples.
- Onboarding and off-boarding users.
- Managing API subscriptions and the distribution of subscription keys.
- Implementing API revisions in a controlled and safe way.
- Managing multiple versions of an API.
- Implementing API access controls, such as authentication and call rate limits.
- Providing API reporting for usage, errors, and so on.
- Managing analytics for both your company and for the developers who use the APIs.

## Azure API Management definition

*Azure API Management* is a cloud service that gives you a platform for publishing, securing, maintaining, and analyzing all your company's APIs. Azure API Management accomplishes these tasks by offering three main components:

- Gateway
- Administration interface
- Developer portal

:::image type="content" source="../media/2-what-is-azure-api-management-overview.png" alt-text="The main components of Azure API Management include the administration interface, gateway, and developer portal." lightbox="../media/2-what-is-azure-api-management-overview.png":::

> [!IMPORTANT]
> Azure API Management does *not* host your actual APIs; your APIs remain where they were originally deployed. Instead, Azure API Management acts as a kind of façade or "front door" for your APIs. In this way, Azure API Management *decouples* your APIs by letting you set API policies and other management options in Azure, while leaving your deployed backend APIs untouched.

## Gateway

The *Azure API Management gateway* is an Azure endpoint that accepts all calls from all your APIs. The gateway:

- Verifies API subscription keys and other credentials.
- Enforces your usage quotas and rate limits.
- Transforms the API as needed for backend compatibility.
- Routes each call to its appropriate backend server.
- Caches backend responses.
- Collects call metadata for analytics workloads.

## Administration interface

The *Azure API Management administration interface* is a set of Azure portal pages and tools that enable you to administer your service and your APIs. In addition to provisioning, scaling, and monitoring the service, you use the administrative interface for:

- Defining or importing API specifications
- Implementing usage policies such as quotas and rate limits
- Setting security policies
- Managing users
- Packaging APIs into products
- Defining API transformations
- Managing API revisions and versions
- Running analytics on your API metadata

## Developer portal

The *Azure API Management developer portal* is a fully customizable website that enables developers to interact with your APIs through:

- Reviewing the documentation for each API.
- Trying an API by using the interactive console.
- Reviewing code samples in different programming languages.
- Subscribing to an API and getting an API subscription key.
- Running analytics on the developer's usage.

## Azure API Management tiers

Azure API Management provides several service tiers, each offering a distinct set of features, capacities, and pricing. The following table lists the tiers in order from lowest to highest price and compares some key capabilities.

|**Criteria**  |**Consumption**  |**Developer**  |**Basic**  |**Standard**  |**Premium**  |
| --- | --- | --- | --- | --- | --- |
|**Designed for**    | Lightweight usage        | Evaluation, testing, and other nonproduction usage        | Entry-level production usage        | Medium-volume production usage        | High-volume or enterprise production usage        |
|**Cache**     | External only        | 10 megabytes (MB)         | 50 MB        | 1 gigabyte (GB)        | 5 GB        |
|**Service-level agreement (SLA)**     | 99.95%        | None        | 99.95%        | 99.95%        | 99.99%        |
|**Developer portal**     | No         | Yes        | Yes        | Yes        | Yes        |
|**Built-in analytics**     | No        | Yes        | Yes        | Yes        | Yes        |
|**Throughput (estimated requests/sec)**     | N/A        | 500        | 1,000        | 2,500        | 4,000        |

> [!NOTE]
> The pricing for the Consumption tier is per API call, where the first million calls are free, and the remainder are then billed at a fixed rate per 10,000 calls. Pricing for all the other tiers is per hour.

## Apply policies to API requests and responses

One of the biggest problems with having multiple published APIs is that each API requires a separate set of policies. Here, a *policy* is a setting or action that controls the behavior of the API. For example, if you want to enforce a *rate limit* (the maximum number of API calls allowed from a single source in a given time period) you'd include that limit as part of the policies for an API. A rate limit is just one example, but there are numerous policies you can apply. Multiply that by several different APIs and you have a management nightmare.

Azure API Management solves the API policy problem by enabling you to set policies for all your APIs in a single place, which is the Azure API Management administration interface. With Azure API Management, you can set policies in many categories. A partial list includes:

- **Access restriction**. These policies determine when an API request is allowed through the gateway. For example, enforce rate limits and usage quotas, filter caller IPs, and check for a valid JSON Web Token (JWT).
- **Authentication**. Authenticate API calls, for example, by using Basic authentication, a client certificate, or a managed identity.
- **Caching**. Improve API performance by storing and retrieving responses in the cache.
- **Validation**. Validate API calls by comparing certain parameters to what's in your API specification. For example, validate the request or response body, the request header parameters, and the response headers.

Flexibly combine your policies in *policy definitions*, which are XML documents that consist of a series of statements, each of which represents a policy and its parameters. Policy definitions let you configure separate policies at different stages of the API request-response pipeline:

:::image type="content" source="../media/2-what-is-azure-api-management-policies.png" alt-text="A consumer's API request enters the Azure API Management gateway where it passes through inbound policies before being sent to the backend server. The API response then passes through the gateway's outbound policies before being sent to the originating API consumer." lightbox="../media/2-what-is-azure-api-management-policies.png":::
