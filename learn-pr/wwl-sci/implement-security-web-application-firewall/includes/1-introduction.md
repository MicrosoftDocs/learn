Contoso Retail's customer-facing e-commerce application runs on Azure App Service and is exposed directly to the public internet. A recent penetration test revealed three security gaps that remain unaddressed in the current deployment. The application has no authentication enforcement at the platform level—any unauthenticated request reaches the application code. App Service accepts inbound traffic from any source IP address, which means an attacker who discovers the App Service hostname can bypass any security control placed in front of it. There's no Web Application Firewall protecting the application, and the penetration test demonstrated a successful SQL injection attack against the product search endpoint.

These three gaps form a layered problem. Closing one without the others leaves meaningful risk open. Platform-level authentication doesn't prevent an attacker from routing around a Web Application Firewall (WAF) by targeting the App Service directly. A WAF placed in front of the application provides no protection if the application still accepts direct traffic from the internet. Each layer depends on the others to be effective.

In this module, you work through each of the three layers in order. You start by securing the App Service platform itself—configuring authentication with Microsoft Entra ID, assigning a managed identity for outbound service calls, enforcing HTTPS, and applying access restrictions and network controls that limit where inbound traffic can originate. You then configure a Web Application Firewall policy on Application Gateway. Then select managed rule sets, setting WAF modes, and defining exclusions and custom rules. Finally, you connect the two components so that all inbound traffic passes through WAF inspection before reaching App Service, and you learn how to monitor WAF logs and tune the policy to reduce false positives.

## Learning objectives

After completing this module, you'll be able to:

- Implement authentication, managed identity, and network controls for Azure App Service
- Configure Web Application Firewall policies including managed rule sets and custom rules
- Integrate Web Application Firewall with App Service to enforce edge-layer protection
