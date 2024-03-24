
Application Gateway has a series of components that combine to route requests to a pool of web servers and to check the health of these web servers.

:::image type="content" source="../media/app-gateway-config-f068f2b5.png" alt-text="Diagram showing how Azure Application Gateway routes requests to a pool of web servers":::


### Frontend configuration

You can configure the application gateway to have a public IP address, a private IP address, or both. A public IP address is required when you host a back end that clients must access over the Internet via an Internet-facing virtual IP.

### Backend configuration

The backend pool is used to route requests to the backend servers that serve the request. Backend pools can be composed of NICs, virtual machine scale sets, public IP addresses, internal IP addresses, fully qualified domain names (FQDN), and multi-tenant back-ends like Azure App Service. You can create an empty backend pool with your application gateway and then add backend targets to the backend pool.

## Configure health probes

Azure Application Gateway by default monitors the health of all resources in its back-end pool and automatically removes any resource considered unhealthy from the pool. Application Gateway continues to monitor the unhealthy instances and adds them back to the healthy back-end pool once they become available and respond to health probes. By default, Application gateway sends the health probes with the same port that is defined in the back-end HTTP settings. A custom probe port can be configured using a custom health probe.

The source IP address that the Application Gateway uses for health probes depends on the backend pool:

 -  If the server address in the backend pool is a public endpoint, then the source address is the application gateway's frontend public IP address.
 -  If the server address in the backend pool is a private endpoint, then the source IP address is from the application gateway subnet's private IP address space. :::image type="content" source="../media/app-gateway-probe-6300f27a.png" alt-text="example heath probe for Azure App Gateway":::
    

### Default health probe

An application gateway automatically configures a default health probe when you don't set up any custom probe configurations. The monitoring behavior works by making an HTTP GET request to the IP addresses or FQDN configured in the back-end pool. For default probes if the backend http settings are configured for HTTPS, the probe uses HTTPS to test health of the backend servers.

For example: You configure your application gateway to use back-end servers A, B, and C to receive HTTP network traffic on port 80. The default health monitoring tests the three servers every 30 seconds for a healthy HTTP response with a 30 second timeout for each request. A healthy HTTP response has a status code between 200 and 399. In this case, the HTTP GET request for the health probe looks like http://127.0.0.1/.

If the default probe check fails for server A, the application gateway stops forwarding requests to this server. The default probe continues to check for server A every 30 seconds. When server A responds successfully to one request from a default health probe, application gateway starts forwarding the requests to the server again.

**Default health probe settings**

The following table lists the default health probe settings:

| **Probe property**  |            **Value**             |                                                                                                                                                                                                        **Description**                                                                                                                                                                                                        |
|:-------------------:|:--------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
|      Probe URL      | `<protocol>://127.0.0.1:<port>/` |                                                                                                                                                              The protocol and port are inherited from the backend HTTP settings to which the probe is associated                                                                                                                                                              |
|      Interval       |                30                |                                                                                                                                                                          The amount of time in seconds to wait before the next health probe is sent.                                                                                                                                                                          |
|      Time-out       |                30                |                                                                                                      The amount of time in seconds the application gateway waits for a probe response before marking the probe as unhealthy. If a probe returns as healthy, the corresponding backend is immediately marked as healthy.                                                                                                       |
| Unhealthy threshold |                3                 | Governs how many probes to send in case there's a failure of the regular health probe. In v1 SKU, these additional health probes are sent in quick succession to determine the health of the backend quickly and don't wait for the probe interval. In the case of v2 SKU, the health probes wait the interval. The back-end server is marked down after the consecutive probe failure count reaches the unhealthy threshold. |

**Probe intervals**

All instances of Application Gateway probe the backend independent of each other. The same probe configuration applies to each Application Gateway instance. For example, if the probe configuration is to send health probes every 30 seconds and the application gateway has two instances, then both instances send the health probe every 30 seconds.

If there are multiple listeners, then each listener probes the backend independent of each other.

### Custom health probe

Custom probes give you more granular control over the health monitoring. When using custom probes, you can configure a custom hostname, URL path, probe interval, and how many failed responses to accept before marking the back-end pool instance as unhealthy, etc.

**Custom health probe settings**

The following table provides definitions for the properties of a custom health probe.

| **Probe property**  |                                                                                  **Description**                                                                                  |
|:-------------------:|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
|        Name         |                                        Name of the probe. This name is used to identify and refer to the probe in back-end HTTP settings.                                         |
|      Protocol       |                           Protocol used to send the probe. This property must match with the protocol defined in the back-end HTTP settings it is associated to                   |
|        Host         | Host name to send the probe with. In v1 SKU, this value is used only for the host header of the probe request. In v2 SKU, it is used both as host header and SNI                  |
|        Path         |                                                             Relative path of the probe. A valid path starts with '/'                                                              |
|        Port         |  If defined, this property is used as the destination port. Otherwise, it uses the same port as the HTTP settings that it is associated to. This property is only available in the v2 SKU  |
|      Interval       |                                             Probe interval in seconds. This value is the time interval between two consecutive probes                                             |
|      Time-out       |                             Probe time-out in seconds. If a valid response isn't received within this time-out period, the probe is marked as failed                              |
| Unhealthy threshold |                          Probe retry count. The back-end server is marked down after the consecutive probe failure count reaches the unhealthy threshold                          |

### Probe matching

By default, an HTTP(S) response with status code between 200 and 399 is considered healthy. Custom health probes additionally support two matching criteria. Matching criteria can be used to optionally modify the default interpretation of what makes a healthy response.

The following are matching criteria:

 -  HTTP response status code match - Probe matching criterion for accepting user specified http response code or response code ranges. Individual comma-separated response status codes or a range of status code is supported.
 -  HTTP response body match - Probe matching criterion that looks at HTTP response body and matches with a user specified string. The match only looks for presence of user specified string in response body and isn't a full regular expression match.

Match criteria can be specified using the New-AzApplicationGatewayProbeHealthResponseMatch cmdlet.

## Configure listeners

A listener is a logical entity that checks for incoming connection requests by using the port, protocol, host, and IP address. When you configure a listener, you must enter values that match the corresponding values in the incoming request on the gateway.

When you create an application gateway by using the Azure portal, you also create a default listener by choosing the protocol and port for the listener. You can choose whether to enable HTTP2 support on the listener. After you create the application gateway, you can edit the settings of that default listener (appGatewayHttpListener) or create new listeners.

:::image type="content" source="../media/app-gateway-error-codes-acd1bd6a.png" alt-text="app gateway listener configuration":::


### Listener type

When you create a new listener, you must choose between basic and multi-site.

 -  **Basic:** All requests for any domain will be accepted and forwarded to backend pools.
 -  **Multi-site:** Forward requests to different backend pools based on the host header or host names. You must specify a host name that matches with the incoming request. This is because Application Gateway relies on HTTP 1.1 host headers to host more than one website on the same public IP address and port.

### Order of processing listeners

For the v1 SKU, requests are matched according to the order of the rules and the type of listener. If a rule with basic listener comes first in the order, it's processed first and accepts any request for that port and IP combination. To avoid this, configure the rules with multi-site listeners first and push the rule with the basic listener to the last in the list.

For the v2 SKU, multi-site listeners are processed before basic listeners.

### Front-end IP address

Choose the front-end IP address that you plan to associate with this listener. The listener will listen to incoming requests on this IP.

### Front-end port

Choose the front-end port. Select an existing port or create a new one. Choose any value from the allowed range of ports. You can use not only well-known ports, such as 80 and 443, but any allowed custom port that's suitable. A port can be used for public-facing listeners or private-facing listeners.

### Protocol

Choose HTTP or HTTPS:

 -  **HTTP:** traffic between the client and the application gateway is unencrypted.
 -  **HTTPS:** enables TLS termination or end-to-end TLS encryption. The TLS connection terminates at the application gateway. Traffic between the client and the application gateway is encrypted. If you want end-to-end TLS encryption, you must choose HTTPS and configure the back-end HTTP setting. This ensures that traffic is re-encrypted when it travels from the application gateway to the back end.

To configure TLS termination and end-to-end TLS encryption, you must add a certificate to the listener to enable the application gateway to derive a symmetric key. The symmetric key is used to encrypt and decrypt the traffic that's sent to the gateway. The gateway certificate must be in Personal Information Exchange (PFX) format. This format lets you export the private key that the gateway uses to encrypt and decrypt traffic.

## Redirection overview

You can use application gateway to redirect traffic. It has a generic redirection mechanism which allows for redirecting traffic received at one listener to another listener or to an external site. This simplifies application configuration, optimizes the resource usage, and supports new redirection scenarios including global and path-based redirection.

A common redirection scenario for many web applications is to support automatic HTTP to HTTPS redirection to ensure all communication between application and its users occurs over an encrypted path. In the past, customers have used techniques such as creating a dedicated backend pool whose sole purpose is to redirect requests it receives on HTTP to HTTPS. With redirection support in Application Gateway, you can accomplish this simply by adding a new redirect configuration to a routing rule and specifying another listener with HTTPS protocol as the target listener.

The following types of redirection are supported:

 -  301 Permanent Redirect
 -  302 Found
 -  303 See Other
 -  307 Temporary Redirect

Application Gateway redirection support offers the following capabilities:

 -  **Global redirection:** Redirects from one listener to another listener on the gateway. This enables HTTP to HTTPS redirection on a site.
 -  **Path-based redirection:** Enables HTTP to HTTPS redirection only on a specific site area, for example a shopping cart area denoted by /cart/\*.
 -  **Redirect to external site:** Requires a new redirect configuration object, which specifies the target listener or external site to which redirection is desired. The configuration element also supports options to enable appending the URI path and query string to the redirected URL. The redirect configuration is attached to the source listener via a new rule.

For more information on configuring redirection in Application Gateway, see [URL path-based redirection using PowerShell - Azure Application Gateway \| Microsoft Docs](/azure/application-gateway/tutorial-url-redirect-powershell).

## Application Gateway request routing rules

When you create an application gateway using the Azure portal, you create a default rule (rule1). This rule binds the default listener (appGatewayHttpListener) with the default back-end pool (appGatewayBackendPool) and the default back-end HTTP settings (appGatewayBackendHttpSettings). After you create the gateway, you can edit the settings of the default rule or create new rules.

Rule types:

 -  Basic forwards all requests on the associated listener (for example, blog.contoso.com/\*) to a single back-end pool.
 -  Path-based routes requests from specific URL paths to specific back-end pools.

### Order of processing rules

For the v1 and v2 SKU, pattern matching of incoming requests is processed in the order that the paths are listed in the URL path map of the path-based rule. If a request matches the pattern in two or more paths in the path map, the path that's listed first is matched. And the request is forwarded to the back end that's associated with that path.

### Associated listener

Associate a listener to the rule so that the request-routing rule that's associated with the listener is evaluated to determine the back-end pool to route the request to.

### Associated back-end pool

Associate to the rule the back-end pool that contains the back-end targets that serve requests that the listener receives.

For a basic rule, only one back-end pool is allowed. All requests on the associated listener are forwarded to that back-end pool.

For a path-based rule, add multiple back-end pools that correspond to each URL path. The requests that match the URL path that's entered are forwarded to the corresponding back-end pool. Also, add a default back-end pool. Requests that don't match any URL path in the rule are forwarded to that pool.

### Associated back-end HTTP setting

Add a back-end HTTP setting for each rule. Requests are routed from the application gateway to the back-end targets by using the port number, protocol, and other information that's specified in this setting.

For a basic rule, only one back-end HTTP setting is allowed. All requests on the associated listener are forwarded to the corresponding back-end targets by using this HTTP setting.

For a path-based rule, add multiple back-end HTTP settings that correspond to each URL path. Requests that match the URL path in this setting are forwarded to the corresponding back-end targets by using the HTTP settings that correspond to each URL path. Also, add a default HTTP setting. Requests that don't match any URL path in this rule are forwarded to the default back-end pool by using the default HTTP setting.

### Redirection setting

If redirection is configured for a basic rule, all requests on the associated listener are redirected to the target. This is global redirection. If redirection is configured for a path-based rule, only requests in a specific site area are redirected. An example is a shopping cart area that's denoted by /cart/\*. This is path-based redirection.

**Redirection type**

Choose the type of redirection required: Permanent(301), Temporary(307), Found(302), or See other(303).

**Redirection target**

Choose another listener or an external site as the redirection target.

**Listener**

Choose listener as the redirection target to redirect traffic from one listener to another on the gateway.

**External** **site**

Choose external site when you want to redirect the traffic on the listener that's associated with this rule to an external site. You can choose to include the query string from the original request in the request that's forwarded to the redirection target. You can't forward the path to the external site that was in the original request.

### Rewrite HTTP headers and URL

By using rewrite rules, you can add, remove, or update HTTP(S) request and response headers as well as URL path and query string parameters as the request and response packets move between the client and backend pools via the application gateway.

The headers and URL parameters can be set to static values or to other headers and server variables. This helps with important use cases, such as extracting client IP addresses, removing sensitive information about the backend, adding more security, and so on.

## Configure URL-based routing

URL Path Based Routing allows you to route traffic to back-end server pools based on URL Paths of the request. One use case is to route requests for different content types to different backend server pools.

**For the v1 SKU, rules are processed in the order they are listed in the portal. If a basic listener is listed first and matches an incoming request, it gets processed by that listener. For the v2 SKU, exact matches have higher precedence. However, it is highly recommended to configure multi-site listeners first prior to configuring a basic listener. This ensures that traffic gets routed to the right back end**.

### UrlPathMap configuration element

The urlPathMap element is used to specify Path patterns to back-end server pool mappings. The following code example is the snippet of urlPathMap element from template file.

```JSON
"urlPathMaps": [{

 "name": "{urlpathMapName}",

 "id": "/subscriptions/{subscriptionId}/../microsoft.network/applicationGateways/{gatewayName}/urlPathMaps/{urlpathMapName}",

 "properties": {

 "defaultBackendAddressPool": {

 "id": "/subscriptions/{subscriptionId}/../microsoft.network/applicationGateways/{gatewayName}/backendAddressPools/{poolName1}"

 },

 "defaultBackendHttpSettings": {

 "id": "/subscriptions/{subscriptionId}/../microsoft.network/applicationGateways/{gatewayName}/backendHttpSettingsList/{settingname1}"

 },

 "pathRules": [{

 "name": "{pathRuleName}",

 "properties": {

 "paths": [

 "{pathPattern}"

 ],

 "backendAddressPool": {

 "id": "/subscriptions/{subscriptionId}/../microsoft.network/applicationGateways/{gatewayName}/backendAddressPools/{poolName2}"

 },

 "backendHttpsettings": {

 "id": "/subscriptions/{subscriptionId}/../microsoft.network/applicationGateways/{gatewayName}/backendHttpsettingsList/{settingName2}"

 }

 }

 }]

 }

}]

```

### PathPattern

PathPattern is a list of path patterns to match. Each must start with / and the only place a "\*" is allowed is at the end following a "/." The string fed to the path matcher does not include any text after the first? or \#, and those chars are not allowed here. Otherwise, any characters allowed in a URL are allowed in PathPattern. The supported patterns depend on whether you deploy Application Gateway v1 or v2.

**PathBasedRouting rule**

RequestRoutingRule of type PathBasedRouting is used to bind a listener to a urlPathMap. All requests that are received for this listener are routed based on policy specified in urlPathMap.

## Configure rewrite policies in Application Gateway

Application Gateway allows you to rewrite selected content of requests and responses. With this feature, you can translate URLs, query string parameters as well as modify request and response headers. It also allows you to add conditions to ensure that the URL or the specified headers are rewritten only when certain conditions are met. These conditions are based on the request and response information.

HTTP header and URL rewrite features are only available for the Application Gateway v2 SKU.

### Supported rewrite types

Application Gateway supports multiple rewrite types.

**Request and response headers**

HTTP headers allow a client and server to pass additional information with a request or response. By rewriting these headers, you can accomplish important tasks, such as adding security-related header fields like HSTS/ X-XSS-Protection, removing response header fields that might reveal sensitive information, and removing port information from X-Forwarded-For headers.

Application Gateway allows you to add, remove, or update HTTP request and response headers while the request and response packets move between the client and back-end pools.

:::image type="content" source="../media/header-rewrite-overview-026d12c8.png" alt-text="HTTP header rewrite":::


**URL path and query string**

With URL rewrite capability in Application Gateway, you can:

 -  Rewrite the host name, path, and query string of the request URL
 -  Choose to rewrite the URL of all requests on a listener or only those requests which match one or more of the conditions you set. These conditions are based on the request and response properties (request, header, response header and server variables).
 -  Choose to route the request (select the backend pool) based on either the original URL or the rewritten URL. :::image type="content" source="../media/url-rewrite-overview-a5378a09.png" alt-text="Application Gateway URL rewrite":::
    

### Rewrite actions

You use rewrite actions to specify the URL, request headers or response headers that you want to rewrite and the new value to which you intend to rewrite them to. The value of a URL or a new or existing header can be set to these types of values:

 -  Text
 -  Request header. To specify a request header, you need to use the syntax \{http\_req\_headerName\}
 -  Response header. To specify a response header, you need to use the syntax \{http\_resp\_headerName\}
 -  Server variable. To specify a server variable, you need to use the syntax \{var\_serverVariable\}. See the list of supported server variables

A combination of text, a request header, a response header, and a server variable.

### Rewrite conditions

You can use rewrite conditions, an optional configuration, to evaluate the content of HTTP(S) requests and responses and perform a rewrite only when one or more conditions are met. The application gateway uses these types of variables to evaluate the content of requests and responses:

 -  HTTP headers in the request
 -  HTTP headers in the response
 -  Application Gateway server variables

You can use a condition to evaluate whether a specified variable is present, whether a specified variable matches a specific value, or whether a specified variable matches a specific pattern.

### Rewrite configuration

To configure a rewrite rule, you need to create a rewrite rule set and add the rewrite rule configuration in it.

A rewrite rule set contains:

 -  **Request routing rule association:** The rewrite configuration is associated to the source listener via the routing rule. When you use a basic routing rule, the rewrite configuration is associated with a source listener and is a global header rewrite. When you use a path-based routing rule, the rewrite configuration is defined on the URL path map. In that case, it applies only to the specific path area of a site. You can create multiple rewrite sets and apply each rewrite set to multiple listeners. But you can apply only one rewrite set to a specific listener.
 -  **Rewrite Condition:** It is an optional configuration. Rewrite conditions evaluate the content of the HTTP(S) requests and responses. The rewrite action will occur if the HTTP(S) request or response matches the rewrite condition. If you associate more than one condition with an action, the action occurs only when all the conditions are met. In other words, the operation is a logical AND operation.
 -  **Rewrite type:** There are three types of rewrites available:
    
     -  Rewriting request headers
     -  Rewriting response headers
     -  Rewriting URL components
        
         -  **URL path:** The value to which the path is to be rewritten to.
         -  **URL Query String:** The value to which the query string is to be rewritten to.
         -  **Re-evaluate path map:** Used to determine whether the URL path map is to be re-evaluated or not. If kept unchecked, the original URL path will be used to match the path-pattern in the URL path map. If set to true, the URL path map will be re-evaluated to check the match with the rewritten path. Enabling this switch helps in routing the request to a different backend pool post rewrite.

For more information on Configuring rewrites in application Gateway, see [Rewrite HTTP headers and URL with Azure Application Gateway \| Microsoft Docs](/azure/application-gateway/rewrite-http-headers-url).