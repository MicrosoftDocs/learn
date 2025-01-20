
Web Application Firewall (WAF) provides centralized protection of your web applications from common exploits and vulnerabilities. SQL injection and cross-site scripting are among the most common attacks.

:::image type="content" source="../media/waf-overview-3bcd34eb.png" alt-text="Diagram of a global WAF policy with allow and deny access.":::

Preventing attacks in application code is challenging. Prevention can require rigorous maintenance, patching, and monitoring at multiple layers of the application. A centralized WAF helps make security management simpler. A WAF also gives application administrators better assurance of protection against threats and intrusions.

A WAF solution can react to a security threat faster by centrally patching a known vulnerability, instead of securing each individual web application.

## Web Application Firewall policy modes

There are two WAF policy modes: Detection and Prevention. By default, a WAF policy is in Detection mode. In Detection mode, WAF doesn't block any requests. Instead, requests matching the WAF rules are logged. In Prevention mode, requests that match rules are blocked and logged.

:::image type="content" source="../media/waf-policy-modes-4a04568d.png" alt-text="Screenshot of the WAF policy modes.":::

## Web Application Firewall Default Rule Set rule groups and rules

Azure Front Door web application firewall protects web applications from common vulnerabilities and exploits. Azure-managed rule sets provide an easy way to deploy protection against a common set of security threats. An Azure rule set is updated as needed to protect against new attack signatures.

### Managed rules

Azure-managed Default Rule Set includes rules against these threat categories:

- Cross-site scripting
- Java attacks
- Local file inclusion
- PHP injection attacks
- Remote command execution
- Remote file inclusion
- Session fixation
- SQL injection protection
- Protocol attackers

Azure-managed Default Rule Set is enabled by default. The current default version is DefaultRuleSet\_2.1. Other rule sets are available in the drop-down box.

To disable an individual rule, select the checkbox in front of the rule number, and select **Disable** at the top of the page. To change action types for individual rules within the rule set, select the checkbox in front of the rule number, and then select **Change action** at the top of the page.

:::image type="content" source="../media/waf-policy-managed-rules-32844b21.png" alt-text="Screenshot of the WAF policy managed rules.":::

### Custom rules

Azure WAF with Front Door allows you to control access to your web applications based on the conditions you define. A custom WAF rule consists of a priority number, rule type, match conditions, and an action. 

There are two types of custom rules: match rules and rate limit rules. A match rule determines access based on a set of matching conditions. A rate limit rule determines access based on matching conditions and the rates of incoming requests. 

When creating a WAF policy, you can create a custom rule by selecting **Add custom rule** under the **Custom rules** section. This launches the custom rule configuration page.

:::image type="content" source="../media/waf-policy-custom-rules-1-b9339192.png" alt-text="Screenshot of the WAF policy add custom rule.":::

This example image shows the configuration of a custom rule to block a request if the query string contains **blockme**.

:::image type="content" source="../media/waf-policy-custom-rules-2-2e6e0ef2.png" alt-text="Screenshot of the WAF policy custom rule configuration.":::

## Create a Web Application Firewall policy on Azure Front Door

This section describes how to create a basic Azure WAF policy and apply it to a profile in Azure Front Door.

The key steps to create a WAF policy on Azure Front Door using the Azure portal are:

1. **Create a Web Application Firewall policy**. Create a basic WAF policy with managed Default Rule Set (DRS).

1. **Associate the WAF policy with a Front Door profile**. Associate the WAF policy with a Front Door profile. This association can be done during the creation of the WAF policy, or it can be done on a previously created WAF policy. In the association, specify the Front Door profile and the domain to apply the policy.

1. **Configure WAF policy settings and rules**. An optional step, where you can configure policy settings such as the **Mode** (Prevention or Detection) and configure managed rules and custom rules.

To view the detailed steps for all these tasks, see [Tutorial: Create a Web Application Firewall policy on Azure Front Door using the Azure portal](/azure/web-application-firewall/afds/waf-front-door-create-portal).