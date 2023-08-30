Azure API Management helps organizations unlock the potential of their data and services by publishing APIs to external partners, and internal developers. Businesses are extending their operations as a digital platform by creating new channels, finding new customers, and driving deeper engagement with existing ones. API Management provides the core competencies to ensure a successful API program through developer engagement, business insights, analytics, security, and protection. You can use API Management to take any backend and launch a full-fledged API program based on it.

To use API Management, administrators define _APIs_ in the portal. Each API consists of one or more operations, and can be added to one or more products. To use an API, developers subscribe to a product that contains that API, and then call the API's operations, subject to any usage policies that might be in effect. Common scenarios include:

* Securing mobile infrastructure by gating access with API keys, preventing distributed denial of service (DDoS) attacks by using throttling, or using advanced security policies like JSON web token (JWT) validation.

* Offering fast partner onboarding through the developer portal to independent software vendor (ISV) partner ecosystems. Enabling them to build an API facade to decouple from internal implementations that aren't ready for partner consumption.

* Running an internal API program that offers a centralized location for the organization to communicate between the API gateway and the backend. Communications about the availability and latest changes to APIs would be on a secured channel with gated access based on organizational accounts.

## Components of API Management

API Management is made up of the following components:

### API gateway

The API gateway is the endpoint that:

* Accepts API calls and routes them to the backend.
* Verifies API keys, JWT tokens, certificates, and other credentials.
* Enforces usage quotas and rate limits.
* Transforms your API on the fly without code modifications.
* Caches backend responses, where the capability is set up.
* Logs call metadata for analytics purposes.

### Azure portal

The Azure portal is the administrative interface where you set up your API program. You can also use it to:

* Define or import API schema.
* Package APIs into products.
* Set up policies such as quotas or transformations on the APIs.
* Get insights from analytics.
* Manage users.

### Developer portal

The developer portal serves as the main web presence for developers. From here they can:

* Read API documentation.
* Try out an API via the interactive console.
* Create an account and subscribe to get API keys.
* Access analytics on their own usage.
