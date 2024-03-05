Web Application Firewall (WAF) provides centralized protection of your web applications from common exploits and vulnerabilities. Web applications are increasingly targeted by malicious attacks that exploit commonly known vulnerabilities. SQL injection and cross-site scripting are among the most common attacks.

:::image type="content" source="../media/waf-overview-3bcd34eb.png" alt-text="WAF overview diagram showing a global WAF policy can allow or deny access to resources in Azure regions or on-premises.":::

Preventing such attacks in application code is challenging. It can require rigorous maintenance, patching, and monitoring at multiple layers of the application topology. A centralized web application firewall helps make security management much simpler. A WAF also gives application administrators better assurance of protection against threats and intrusions.

A WAF solution can react to a security threat faster by centrally patching a known vulnerability, instead of securing each individual web application.

## Web Application Firewall policy modes

When you create a Web Application Firewall (WAF) policy, by default the WAF policy is in Detection mode. In Detection mode, WAF does not block any requests; instead, requests matching the WAF rules are logged at WAF logs. To see WAF in action, you can change the mode settings from Detection to Prevention. In Prevention mode, requests that match rules that are defined in Default Rule Set (DRS) are blocked and logged at WAF logs.

:::image type="content" source="../media/waf-policy-modes-4a04568d.png" alt-text="Screenshot that shows the WAF policy modes.":::

## Web Application Firewall Default Rule Set rule groups and rules

Azure Front Door web application firewall (WAF) protects web applications from common vulnerabilities and exploits. Azure-managed rule sets provide an easy way to deploy protection against a common set of security threats. Since such rule sets are managed by Azure, the rules are updated as needed to protect against new attack signatures.

### Managed rules

Azure-managed Default Rule Set includes rules against the following threat categories:

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

:::image type="content" source="../media/waf-policy-managed-rules-32844b21.png" alt-text="Screenshot that shows WAF policy managed rules.":::

### Custom rules

Azure WAF with Front Door allows you to control access to your web applications based on the conditions you define. A custom WAF rule consists of a priority number, rule type, match conditions, and an action. There are two types of custom rules: match rules and rate limit rules. A match rule controls access based on a set of matching conditions while a rate limit rule controls access based on matching conditions and the rates of incoming requests. You may disable a custom rule to prevent it from being evaluated, but still keep the configuration.

When creating a WAF policy, you can create a custom rule by selecting **Add custom rule** under the **Custom rules** section. This launches the custom rule configuration page.

:::image type="content" source="../media/waf-policy-custom-rules-1-b9339192.png" alt-text="Screenshot that shows the WAF policy add custom rule.":::

The example screenshot below shows the configuration of a custom rule to block a request if the query string contains **blockme**.

:::image type="content" source="../media/waf-policy-custom-rules-2-2e6e0ef2.png" alt-text="Screenshot that shows the WAF policy custom rule configuration.":::

## Create a Web Application Firewall policy on Azure Front Door

This section describes how to create a basic Azure Web Application Firewall (WAF) policy and apply it to a profile in Azure Front Door.

The key stages to create a WAF policy on Azure Front Door using the Azure portal are:

1. **Create a Web Application Firewall policy**

   This is where you create a basic WAF policy with managed Default Rule Set (DRS).
1. **Associate the WAF policy with a Front Door profile**

   This is where you associate the WAF policy created in stage 1 with a Front Door profile. This association can be done during the creation of the WAF policy, or it can be done on a previously created WAF policy. During the association you specify the Front Door profile and the domain/s within the Front Door profile you want the WAF policy to be applied to. During this stage if the domain is associated to a WAF policy, it is shown as grayed out. You must first remove the domain from the associated policy, and then re-associate the domain to a new WAF policy.
1. **Configure WAF policy settings and rules**

   This is an optional stage, where you can configure policy settings such as the **Mode** (Prevention or Detection) and configure managed rules and custom rules.

To view the detailed steps for all these tasks, see [Tutorial: Create a Web Application Firewall policy on Azure Front Door using the Azure portal](/azure/web-application-firewall/afds/waf-front-door-create-portal).
