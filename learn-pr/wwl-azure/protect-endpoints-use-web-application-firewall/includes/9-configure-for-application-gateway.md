Now that you have successfully deployed Application Gateway and you can connect to your application.

Also, you can configure a Web Application Firewall on your Application Gateway.

Web Application Firewall (WAF) provides centralized protection of your web applications from common exploits and vulnerabilities. Web applications are increasingly targeted by malicious attacks that exploit commonly known vulnerabilities. SQL injection and cross-site scripting are among the most common attacks.

:::image type="content" source="../media/web-application-firewall-overview-34f0acc2.png" alt-text="Diagram that shows how Web Application Firewall provides centralized protection for web applications.":::


To finalize the setup, enable the Web Application Firewall policy. Once the policy is enabled, you'll automatically start flagging noncompliant requests. To avoid blocking requests, configure with detection mode.<br>

```Bash
az network application-gateway waf-policy policy-setting update \
    --mode Detection \
    --policy-name $WAF_POLICY_NAME \
    --resource-group $RESOURCE_GROUP \
    --state Enabled


```
