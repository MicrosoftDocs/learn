
Web applications are increasingly targeted by malicious attacks that exploit commonly known vulnerabilities. Preventing such attacks in application code is challenging. It can require rigorous maintenance, patching, and monitoring.

Web Application Firewall (WAF) provides centralized protection of your web applications from common exploits and vulnerabilities. A centralized WAF helps make security management simpler, improves the response time to a security threat, and allows patching a known vulnerability in one place, instead of securing each individual web application. A WAF also gives application administrators better assurance of protection against threats and intrusions.

Among the types of threats that WAF can protect against are distributed denial of service (DDoS) attacks that occur at the application layer. While Azure DDoS Protection services protect customers against DDoS attacks that can occur at the network and transport layers, Azure WAF protects web applications against application-layer DDoS attacks, such as HTTP Floods. These defenses can prevent attackers from reaching your application and affecting your application's availability and performance.

:::image type="content" source="../media/2-web-app-firewall.png" alt-text="Diagram showing how the Web Application Firewall provides protection against common exploits." lightbox="../media/2-web-app-firewall.png":::

## Common attacks WAF protects against

WAF defends against a wide range of threats defined in the Open Web Application Security Project (OWASP) core rule set—a set of generic attack detection rules designed as a baseline for any WAF. Common attacks WAF protects against include:

- **SQL injection**: Attackers insert malicious SQL code into input fields to manipulate or extract data from the application's backend database. SQL injection can expose sensitive data or allow attackers to modify or delete database records.
- **Cross-site scripting (XSS)**: Attackers inject malicious scripts into web pages that other users view. The scripts can steal session tokens, credentials, or sensitive data from the affected user's browser.
- **HTTP floods**: High volumes of HTTP requests overwhelm a web application at the application layer. This type of distributed denial of service (DDoS) attack targets layer 7 (the application layer), which Azure DDoS Protection alone doesn't cover. Azure WAF detects and blocks abnormal traffic patterns at this layer.
- **Remote file inclusion**: Attackers trick a web application into including a malicious remote file, which then executes on the server and can give the attacker unauthorized access.

By using a centralized WAF, you can patch newly discovered vulnerabilities in one place rather than updating protection on every individual web application. This simplifies security management and reduces the window of exposure when new threats emerge.

## Supported deployment options

Azure Web Application Firewall can be deployed with several Microsoft services, giving you flexibility to protect web applications wherever they're hosted:

- **Azure Application Gateway**: Provides regional WAF protection for web applications hosted behind the gateway. Application Gateway WAF includes deep HTTP packet inspection and supports complex routing decisions—making it well suited for applications hosted in a single Azure region.
- **Azure Front Door**: Microsoft's global content delivery network (CDN) and application delivery platform. WAF on Azure Front Door provides global protection, blocking attacks closer to the source before traffic reaches your infrastructure. This is useful for globally distributed applications that need consistent protection across all regions.
- **Azure Content Delivery Network**: WAF on Azure CDN extends protection to static and dynamic content delivered through the CDN.

Each deployment option provides WAF capabilities customized for its specific service and scale requirements.

#### Integration with Microsoft Security Copilot

Azure Web Application Firewall is integrated with Microsoft Security Copilot.

For organizations onboarded to Microsoft Security Copilot, users can experience the Copilot integration through the standalone experience.

Azure Web Application Firewall integration in Copilot enables deep investigation of Azure WAF events, using natural language prompts and responses. It can help you investigate WAF logs triggered by Azure WAF in a matter of minutes and provide related attack vectors. Azure WAF integration with Copilot provides visibility into your environment’s threat landscape.

To use the Azure WAF integration in Copilot, the Azure WAF plugin in Security Copilot must be turned on and configured.

:::image type="content" source="../media/azure-web-firewall-plugin.png" lightbox="../media/azure-web-firewall-plugin.png" alt-text="Screen capture of the Azure Web Application Firewall plugin.":::

Azure Web Application Firewall capabilities in Copilot are built-in prompts that you can use but you can also enter your own prompts based on the capabilities supported.

:::image type="content" source="../media/azure-web-application-firewall-capabilities.png" lightbox="../media/azure-web-application-firewall-capabilities.png" alt-text="Screen capture of the Azure Web Application Firewall capabilities that can be run in the standalone experience.":::

The summary and resources unit of this module provides a link to more detailed information on Azure Web Application Firewall integration in Microsoft Security Copilot.
