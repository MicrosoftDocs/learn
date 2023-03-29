
API Management provides the core functionality to ensure a successful API program through developer engagement, business insights, analytics, security, and protection. Each API consists of one or more operations, and each API can be added to one or more products. To use an API, developers subscribe to a product that contains that API, and then they can call the API's operation, subject to any usage policies that may be in effect.

## API Management components

Azure API Management is made up of an *API gateway*, a *management plane*, and a *developer portal*. These components are Azure-hosted and fully managed by default. API Management is available in various [tiers](/azure/api-management/api-management-features) differing in capacity and features.

* The **API gateway** is the endpoint that:
    * Accepts API calls and routes them to appropriate backends
    * Verifies API keys and other credentials presented with requests
    * Enforces usage quotas and rate limits
    * Transforms requests and responses specified in policy statements
    * Caches responses to improve response latency and minimize the load on backend services
    * Emits logs, metrics, and traces for monitoring, reporting, and troubleshooting

* The **management plane** is the administrative interface where you set up your API program. Use it to:
    * Provision and configure API Management service settings
    * Define or import API schema
    * Package APIs into products
    * Set up policies like quotas or transformations on the APIs
    * Get insights from analytics
    * Manage users

* The **Developer portal** is an automatically generated, fully customizable website with the documentation of your APIs. Using the developer portal, developers can:
    * Read API documentation
    * Call an API via the interactive console
    * Create an account and subscribe to get API keys
    * Access analytics on their own usage
    * Download API definitions
    * Manage API keys

## Products

Products are how APIs are surfaced to developers. Products in API Management have one or more APIs, and are configured with a title, description, and terms of use. Products can be **Open** or **Protected**. Protected products must be subscribed to before they can be used, while open products can be used without a subscription. Subscription approval is configured at the product level and can either require administrator approval, or be autoapproved.

## Groups

Groups are used to manage the visibility of products to developers. API Management has the following immutable system groups:

* **Administrators** - Manage API Management service instances and create the APIs, operations, and products that are used by developers. Azure subscription administrators are members of this group.
* **Developers** - Authenticated developer portal users that build applications using your APIs. Developers are granted access to the developer portal and build applications that call the operations of an API.
* **Guests** - Unauthenticated developer portal users. They can be granted certain read-only access, like the ability to view APIs but not call them.

In addition to these system groups, administrators can create custom groups or use external groups in associated Azure Active Directory tenants. 

## Developers

Developers represent the user accounts in an API Management service instance. Developers can be created or invited to join by administrators, or they can sign up from the Developer portal. Each developer is a member of one or more groups, and can subscribe to the products that grant visibility to those groups.

## Policies

Policies are a collection of statements that are executed sequentially on the request or response of an API. Popular statements include format conversion from XML to JSON and call rate limiting to restrict the number of incoming calls from a developer, and many other policies are available.

Policy expressions can be used as attribute values or text values in any of the API Management policies, unless the policy specifies otherwise. Some policies such as the Control flow and Set variable policies are based on policy expressions.

Policies can be applied at different scopes, depending on your needs: global (all APIs), a product, a specific API, or an API operation.
