In this module, you learned about the HTTP(S) traffic-management capabilities of Azure Application Gateway Standard_v2 and WAF_v2. You learned that Application Gateway can route traffic to a pool of web servers based on the URL path of a request. The pool of web servers can be Azure virtual machines, Azure virtual machine scale sets, Azure App Service, and even on-premises servers. You learned that Application Gateway provides HTTP load balancing and can provide WAF inspection when configured with WAF_v2 and an enabled WAF policy. Detection mode logs rule matches; Prevention mode can block requests according to the policy. You also learned that TLS encrypts traffic between users and the gateway when the listener uses HTTPS, and between the gateway and application servers when the backend HTTP settings use HTTPS.

## Learn more

- [What is Azure Application Gateway?](/azure/application-gateway/overview?azure-portal=true)
- [Azure Application Gateway features](/azure/application-gateway/features?azure-portal=true)
- [How an application gateway works](/azure/application-gateway/how-application-gateway-works?azure-portal=true)
- [Application gateway components](/azure/application-gateway/application-gateway-components?azure-portal=true)
- [Quickstart: Direct web traffic with Azure Application Gateway using the Azure portal](/azure/application-gateway/quick-create-portal). This quickstart requires an Azure subscription and creates billable resources.
