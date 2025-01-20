
Web applications are increasingly targeted by malicious attacks that exploit commonly known vulnerabilities. Preventing such attacks in application code is challenging. It can require rigorous maintenance, patching, and monitoring.

Web Application Firewall (WAF) provides centralized protection of your web applications from common exploits and vulnerabilities. A centralized WAF helps make security management simpler, improves the response time to a security threat, and allows patching a known vulnerability in one place, instead of securing each individual web application. A WAF also gives application administrators better assurance of protection against threats and intrusions.

Among the types of threats that WAF can protect against are distributed denial of service (DDoS) attacks that occur at the application layer. While Azure DDoS Protection services protect customers against DDoS attacks that can occur at the network and transport layers, Azure WAF protects web applications against application-layer DDoS attacks, such as HTTP Floods. These defenses can prevent attackers from reaching your application and affecting your application's availability and performance.

:::image type="content" source="../media/2-web-app-firewall.png" alt-text="Diagram showing how the Web Application Firewall provides protection against common exploits.":::

#### Integration with Microsoft Security Copilot

Azure Web Application Firewall is integrated with Microsoft Security Copilot.

For organizations onboarded to Microsoft Security Copilot, users can experience the Copilot integration through the standalone experience.

Azure Web Application Firewall integration in Copilot enables deep investigation of Azure WAF events, using natural language prompts and responses. It can help you investigate WAF logs triggered by Azure WAF in a matter of minutes and provide related attack vectors. Azure WAF integration with Copilot provides visibility into your environment’s threat landscape.

To use the Azure WAF integration in Copilot, the Azure WAF plugin in Security Copilot must be turned on and configured.

:::image type="content" source="../media/azure-web-firewall-plugin.png" lightbox="../media/azure-web-firewall-plugin.png" alt-text="Screen capture of the Azure Web Application Firewall plugin.":::

Azure Web Application Firewall capabilities in Copilot are built-in prompts that you can use but you can also enter your own prompts based on the capabilities supported.

:::image type="content" source="../media/azure-web-application-firewall-capabilities.png" lightbox="../media/azure-web-application-firewall-capabilities.png" alt-text="Screen capture of the Azure Web Application Firewall capabilities that can be run in the standalone experience.":::

The summary and resources unit of this module provides a link to more detailed information on Azure Web Application Firewall integration in Microsoft Security Copilot.
