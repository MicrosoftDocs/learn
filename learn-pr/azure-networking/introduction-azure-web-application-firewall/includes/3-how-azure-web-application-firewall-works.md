You're familiar with the basic features and benefits of Azure Web Application Firewall. Now let's examine how Azure Web Application Firewall works. In particular, let's consider how features such as rule sets and rule groups allow Azure Web Application Firewall to help protect web apps from common exploits. This information helps you evaluate whether Azure Web Application Firewall is the right solution for your company.

## Deployment options

You can deploy Azure Web Application Firewall as part of an Azure front-end solution for your web apps. You'll begin by creating an Azure Web Application Firewall policy, which includes the following settings:

- Which product integration you want to use
- Which managed rule set you want to use
- Any custom rules you want to add
- Which mode you want to use

## Microsoft managed rule sets, rule groups, and rules

Azure Web Application Firewall thwarts known exploits by applying rules to an app's incoming HTTP/HTTPS requests. A rule is a firewall code designed to recognize and prevent a particular threat.

The rules that Azure Web Application Firewall uses to detect and block common vulnerabilities are mostly managed rules that belong to various rule groups. Each rule group is a collection of rules and a managed rule set is collection of rule groups. Managed rule sets include Microsoft Threat Intelligence based rule groups, CVE (Common Vulnerabilities and Exposures) rule groups, and core rule groups (CRS).

The CRS rules are defined by the Open Web Application Security Project (OWASP). Microsoft's team of security experts codes, maintains, and updates managed rules. The rules are modified or added to as needed. When a managed rule changes, Microsoft updates Azure Web Application Firewall automatically and without app downtime.

The following screenshot shows some of the rules and rule groups in Microsoft Default Rule set 2.1 (DRS2.1). This should give you a sense of the depth of protection offered by Azure Web Application Firewall.

:::image type="content" source="../media/3-waf-rule-sets.png" alt-text="Screen shot show WAF managed rules.":::

## Bot rules

Bot rules identify bad bots, good bots, and unknown bots based on Microsoft Threat Intelligence and proprietary WAF rules.

:::image type="content" source="../media/3-waf-bot-rules.png" alt-text="Screenshot showing WAF bot rules.":::

## Custom rules

The managed rules Azure Web Application Firewall offers might not cover a specific threat that your web applications are experiencing. If so, you can create a custom rule. You can build custom rules by creating conditions that include the following components:

- Match type such as geo location, IP address, size, string
- Match variables such as RequestHeader, QueryString, RequestUri, RequestBody, Cookies, or PostArgs
- HTTP/HTTPS request methods such as POST or PUT
- Operators such as **Equal**, **Contains**, **Regex**, **Begins with**, **Any**, **Ends with**
- An action such as **Allow**, **Block**, **Log or Redirect**

## Geo-filtering

By default, WAF responds to all user requests regardless of location where the request is coming from. In some scenarios, you may want to restrict the access to your web application by countries/regions. The geo-filtering custom rule enables you to define a specific path on your endpoint to either allow or block access from specified countries/regions. The geo-filtering rule uses a two-letter country/region code of interest.

For a geo-filtering rule, a match variable is either RemoteAddr or SocketAddr. RemoteAddr is the original client IP address that is usually sent via X-Forwarded-For request header. SocketAddr is the source IP address that WAF sees. If your user is behind a proxy, SocketAddr is often the proxy server address.

You can combine a GeoMatch condition and a REQUEST_URI string match condition to create a path-based geo-filtering rule.

## IP restriction

Azure Web Application Firewall custom rules control access to web applications by specifying a list of IP addresses or IP address ranges.

The IP restriction custom rule lets you control access to your web applications. It does this by specifying an IP address or an IP address range in Classless Inter-Domain Routing(CIDR) format.

By default, your web application is accessible from the Internet. However, sometimes you want to limit access to clients from a list of known IP address or IP address ranges. You can achieve this by creating an IP matching rule that blocks access to your web app from IP addresses not listed in the custom rule.

## Rate limiting

Azure Web Application Firewall custom rules support rate limiting to control access based on matching conditions and the rates of incoming requests.

This custom rule enables you to detect abnormally high levels of traffic and block some types of application layer denial of service attacks. Rate limiting also protects you against clients that have accidentally been misconfigured to send large volumes of requests in a short time period. The custom rule is defined by the rate limit counting duration (either one minute or five-minute intervals) and the rate limit threshold (the maximum number of requests allowed in the rate limit duration).

## Detection mode vs prevention mode

Azure Web Application Firewall can operate in one of two modes. The mode you choose depends on how you want the firewall to deal with incoming HTTP/HTTPS requests that match one of its rules:

- **Detection mode**: Logs the request but allows the request to go through.
- **Prevention mode**: Logs the request but doesn't allow the request to go through.

A common scenario is to run Azure Web Application Firewall in detection mode when you're testing an app. In detection mode, you can check for two types of problems:

- **False positives**: Legitimate requests that the firewall flags as malicious.
- **False negatives**: Malicious requests that the firewall allows.

Once the app is ready to be deployed, you switch to prevention mode.

## Using Microsoft Sentinel with Azure WAF

Azure WAF combined with Microsoft Sentinel can provide security information event management for WAF resources.  Using Microsoft Sentinel, you can access the WAF data connector to Sentinel using Log Analytics.  The WAF workbooks show analytics for WAF on Azure Front Door and WAF on Application Gateway. The WAF analytic rules detect SQLi and XSS attacks from AFD and Application Gateway logs. The WAF Notebook allows investigation of SQL injection incidents on Azure Front Door.

:::image type="content" source="../media/3-waf-sentinel-1.png" alt-text="Screenshot showing Sentinel WAF settings.":::

:::image type="content" source="../media/3-waf-events.png" alt-text="Screenshot showing WAF events.":::
