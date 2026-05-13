The penetration test against Contoso Retail's e-commerce application revealed three gaps: no platform-level authentication enforcement, no restriction on where inbound traffic could originate, and no WAF defending against application-layer attacks. This module addressed all three with controls you can configure, enforce at scale, and monitor continuously.

## Review what you configured

The first gap — no authentication enforcement — is now addressed at the platform layer. You configured EasyAuth on App Service with Microsoft Entra ID as the identity provider and set the unauthenticated request action to Require authentication. Unauthenticated requests are blocked before they reach application code. The managed identity you enabled eliminates the need for stored credentials in app settings, and Key Vault references ensure secrets stay in the vault rather than in deployment artifacts or configuration blades.

The second gap — no network restriction on inbound traffic — is closed through access restrictions and private endpoint deployment. App Service now accepts inbound traffic only from the Application Gateway, preventing attackers from bypassing WAF inspection by targeting the App Service hostname directly. VNet integration provides outbound private access to backend resources, and HTTPS Only with minimum TLS 1.2 closes protocol-level exposure.

The third gap — no edge-layer protection against application attacks — is addressed through the WAF policy on Application Gateway. You selected CRS 3.2 as the managed rule set to cover the OWASP Top 10 attack categories including SQL injection, deployed in Detection mode for initial tuning, and configured targeted exclusions to reduce false positives before switching to Prevention mode. Custom rules and per-site policy associations give you flexibility to adapt the WAF to your application's specific requirements.

These three layers work as a system. WAF without backend restriction can be bypassed. Backend restriction without WAF leaves application-layer attacks uninspected. Platform authentication without network controls still exposes the application to unauthenticated requests from unintended sources. Security effectiveness requires all three layers in place together.

## Learn more

- [Authentication and authorization in Azure App Service](/azure/app-service/overview-authentication-authorization)
- [Azure App Service networking features](/azure/app-service/networking-features)
- [What is Azure Web Application Firewall on Azure Application Gateway?](/azure/web-application-firewall/ag/ag-overview)
