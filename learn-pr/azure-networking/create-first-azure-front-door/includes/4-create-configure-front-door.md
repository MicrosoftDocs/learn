Front Door has several components that combine to accelerate requests to web applications while maintaining high availability at a global scale. Let's take a look at the different components that make up the Front Door service and how they play a part in routing the end user's requests.

:::image type="content" source="../media/4-front-door-flow.png" alt-text="Diagram of Azure Front Door components in a flow chart.":::

### Endpoints

An endpoint is a logical grouping of one or more routes and security policies that is associated to a domain. A Standard or Premium tier profile can support more than one endpoint.

### Routes

Front Door routing rules determine how each request gets processed once it arrives at the at Front Door edge. A route contains information for mapping domains and URL paths to a specific origin group. Within a route, you can configure the protocols used for requests that get forwarded to the origin. You can also enable caching for faster response of frequently requested content and set up rule sets for how to handle specific request types.

### Origins

An origin is an application deployment that Azure Front Door retrieves contents from when caching isn't available. Front Door supports origins both hosted in Azure, on-premises and in another cloud. When defining an origin you need to specify the type, hostname, host header, certificate subject name validation, priority and weight. Defining these fields helps Front Door determine which origin resource is best to respond to incoming requests.

### Origin groups

An origin group is a set of origins receiving similar traffic for their application. This logical grouping of applications can be in the same region or across different regions. By default, requests are sent to the origins with the lowest latency. That behavior can change by modifying the priority and weight of each origin in the origin group. You can also enable session affinity with in an origin group to ensure all requests from the same user gets sent to the same origin resource.

### Rules engine

A rule set is a customized rules engine that groups a combination of rules into a single set. A rule set can be associated with multiple routes. These rules are processed at the Front Door edge before requests are forwarded on to the origin. A single rule can have up to 10 match conditions and 5 actions.

#### Rules match conditions

The match conditions identify the specific type of requests the action should take. When multiple match conditions are used in a rule, they're grouped together using an AND logic.

The following type of match conditions can be found in a rule set:

* Filter requests based on a specific IP address, port, or country/region.
* Filter requests by header information.
* Filter requests from mobile devices or desktop devices.
* Filter requests from request file name and file extension.
* Filter requests by hostname, TLS protocol, request URL, protocol, path, query string, post args, and other values.

#### Rules actions

An action is the behavior applied to the request type when it matches the match condition(s). The following are actions you can currently take once a request matches a condition:

* **Route configuration override** - to override the origin group or the caching configuration to use for the request.
* **Modify request header** - to append, overwrite, or delete the header value in the request that is sent to the origin.
* **Modify response header** - to append, overwrite, or delete the header value in the response before being sent back to the client.
* **URL redirect** - to redirect clients to a different URL. Front Door sends the response.
* **URL rewrite** - to rewrite the path of the request being sent to the origin.

### Security policy

Front Door supports Web Application Firewall (WAF) policy and rules. A security policy in a Front Door profile contains multiple WAF policies that can be used for different domains in the profile. WAF rules defend your web service against common exploits and vulnerabilities such as SQL injections, cross-site scripting, Java attacks and many more. The following features are currently supported for WAF on Front Door:

* **Policy settings** - Allows you to control access to your web applications by using a set of custom and managed rules.
* **Manage rules** - Provide an easy way to deploy protection against a common set of security threats. Since Azure manages the rule sets, the rules are updated as needed to protect against new attack signatures.
* **Custom rules** - Allows you to control access to your web applications based on the conditions you define. A custom WAF rule consists of a priority number, rule type, match conditions, and an action.
* **Exclusion list** - Allows you to omit certain request attributes from a WAF evaluation and allow the rest of the request to be process as normal.
* **Geo-filtering** - Allows you to restrict access to your web application by countries/regions.
* **Bot protection** - Provides bot rules to identify good bots and protect from bad bots.
* **IP restriction** - Lets you control access to your web applications by specifying a list of IP addresses or IP address ranges.
* **Rate limiting** - A custom rate limit rule control access based on matching conditions and the rates of incoming requests.
* **Tuning** - Lets you tune the WAF rules to suit the needs of your application and organization WAF requirements. Tuning features you can expect to see are defining rules exclusions, creating custom rules, and disabling of rules.
* **Monitoring and logging** - Monitoring and logging is provided through integration with Azure Monitor and Azure Monitor logs.

## Front Door tiers

Front Door has three tiers, Classic, Standard, and Premium. Each tier supports many features and optimization that you can use. Standard tier is content-delivery optimized while Premium tier is security optimized. See the following table for a full list of support features for each tier.

### Feature comparison between tiers

| Features and optimization | Standard | Premium | Classic |
|--|--|--|--|
| Static file delivery | Yes | Yes | Yes |
| Dynamic site deliver | Yes | Yes | Yes |
| Custom domains | Yes - DNS TXT record based domain validation | Yes - DNS TXT record based domain validation | Yes - CNAME based validation |
| Cache manage (purge, rules, and compression) | Yes | Yes | Yes |
| Origin load balancing | Yes | Yes | Yes |
| Path based routing | Yes | Yes | Yes |
| Rules engine | Yes | Yes | Yes |
| Server variable | Yes | Yes | No |
| Regular expression in rules engine | Yes | Yes | No |
| Expanded metrics | Yes | Yes | No |
| Advanced analytics/built-in reports | Yes | Yes - includes WAF report | No |
| Raw logs - access logs and WAF logs | Yes | Yes | Yes |
| Health probe log | Yes | Yes | No |
| Custom Web Application Firewall (WAF) rules | Yes | Yes | Yes |
| Microsoft managed rule set | No | Yes | Yes - Only default rule set 1.1 or below |
| Bot protection | No | Yes | No |
| Private link support | No | Yes | No |
| Simplified price (base + usage) | Yes | Yes | No |
| Azure Policy integration | Yes | Yes | No |
| Azure Advisory integration | Yes | Yes | No |

## Create and configure a profile

You can create and configure Front Door using the Azure portal, Azure PowerShell or, the Azure CLI. For Azure CLI, use the `az afd profile create` command to create a new profile. If you prefer Azure PowerShell, you can use the `New-AzFrontDoor` cmdlet. You can complete most operations from the Front Door manager by using the Azure portal.

Let's create and configure a Front Door profile for the motor vehicle department websites that we previously deployed.