Now that you have successfully deployed Application Gateway and you can connect to your application.

Also, you can configure a Web Application Firewall on your Application Gateway.

Web Application Firewall (WAF) provides centralized protection of your web applications from common exploits and vulnerabilities. Web applications are increasingly targeted by malicious attacks that exploit commonly known vulnerabilities. SQL injection and cross-site scripting are among the most common attacks.

:::image type="content" source="../media/web-application-firewall-overview-34f0acc2.png" alt-text="Diagram that shows how Web Application Firewall provides centralized protection for web applications.":::


In this procedure, you'll connect to your application and configure a Web Application Firewall on your Application Gateway.

1.  Create a new Web Application Firewall policy. By default, a Web Application Firewall policy has the OWASP ruleset associated with it.
    
    ```Bash
    WAF_POLICY_NAME=openlabWAFPolicy
    az network application-gateway waf-policy create \
        --name $WAF_POLICY_NAME \
        --resource-group $RESOURCE_GROUP
    
    
    ```

2.  You can now link this Web Application Firewall policy to the HTTP listener for the incoming requests.
    
    ```Bash
    az network application-gateway http-listener update \
    -g $RESOURCE_GROUP \
        --gateway-name $APPGW_NAME \
    -n appGatewayHttpListener \
        --waf-policy $WAF_POLICY_NAME
    
    ```

3.  To finalize the setup, enable the Web Application Firewall policy. Once the policy is enabled, you'll automatically start flagging noncompliant requests. To avoid blocking requests, configure with detection mode.
    
    ```Bash
    az network application-gateway waf-policy policy-setting update \
        --mode Detection \
        --policy-name $WAF_POLICY_NAME \
        --resource-group $RESOURCE_GROUP \
        --state Enabled
    
    
    ```
