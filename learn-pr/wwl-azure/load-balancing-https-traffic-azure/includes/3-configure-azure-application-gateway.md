Application Gateway has a series of components that combine to route requests to a pool of web servers and to check the health of these web servers.

:::image type="content" source="../media/app-gateway-config-f068f2b5.png" alt-text="Diagram showing how Azure Application Gateway routes requests to a pool of web servers.":::


### Frontend configuration

You can configure the application gateway to have a public IP address, a private IP address, or both. A public IP address is required when you host a back end that clients must access over the Internet via an Internet-facing virtual IP.

### Backend configuration

The backend pool is used to route requests to the backend servers that serve the request. Backend pools can be composed of NICs, virtual machine scale sets, public IP addresses, internal IP addresses, fully qualified domain names (FQDN), and multitenant back-ends like Azure App Service. You can create an empty backend pool with your application gateway and then add backend targets to the backend pool.

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
|        Host         | Host name to send the probe with. In v1 SKU, this value is used only for the host header of the probe request. In v2 SKU, it's used both as host header and SNI                  |
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

For more information on configuring redirection in Application Gateway, see [URL path-based redirection using PowerShell - Azure Application Gateway \| Microsoft Learn](/azure/application-gateway/tutorial-url-redirect-powershell).

## Application Gateway request routing rules

A request routing rule is a key component of an application gateway because it determines how to route traffic on the listener. The rule binds the listener, the backend server pool, and the backend HTTP settings.

When a listener accepts a request, the request routing rule forwards the request to the backend or redirects it elsewhere. If the request is forwarded to the backend, the request routing rule defines which backend server pool to forward it to. The request routing rule also determines if the headers in the request are to be rewritten. One listener can be attached to one rule.

There are two types of request routing rules:

- **Basic:** All requests on the associated listener (for example, blog.contoso.com/*) are forwarded to the associated backend pool by using the associated HTTP setting.

- **Path-based:** This routing rule lets you route the requests on the associated listener to a specific backend pool, based on the URL in the request. If the path of the URL in a request matches the path pattern in a path-based rule, the rule routes that request. It applies the path pattern only to the URL path, not to its query parameters. If the URL path on a listener request doesn't match any of the path-based rules, it routes the request to the default backend pool and HTTP settings.

## HTTP settings

An application gateway routes traffic to the backend servers (specified in the request routing rule that include HTTP settings) by using the port number, protocol, and other settings detailed in this component.

The port and protocol used in the HTTP settings determine whether the traffic between the application gateway and backend servers is encrypted (providing end-to-end TLS) or unencrypted.

This component is also used to:

- Determine whether a user session is to be kept on the same server by using the cookie-based session affinity.

- Gracefully remove backend pool members by using connection draining.

- Associate a custom probe to monitor the backend health, set the request timeout interval, override host name and path in the request, and provide one-click ease to specify settings for the App Service backend.
