Here we compare the DDoS Protection Basic and DDoS Protection Standard tiers to get a better idea of the benefits of upgrading. in this unit, you’ll learn more about the key differences between these tiers and about building resiliency against DDoS attacks into your applications.

## Build DDoS-resilient services on Azure

Azure DDoS Protection Basic automatically protects every deployed service in Azure at no additional cost and it also doesn’t require changes to the configuration of applications or users.

When deciding to upgrade from Azure DDoS Protection Basic to Azure DDoS Protection Standard, it’s important to do a risk analysis for a DDoS attack on your key Azure resources. Even with the built-in DDoS services that are available, it's preferable not to rely only on post-deployment protection. Building an application that's resilient and tested to withstand or quickly recover from a denial-of-service attack is important.  

> [!NOTE]
> The Azure team has published a framework for best practices. This framework is a collection of guiding principles that you can follow to improve the quality of a workload.

When building or deploying your workload, it’s important to design for:

- Security. Identify and document security requirements early in the development life cycle. This will help you ensure that security is a priority throughout the entire lifecycle of an application. Poorly designed applications can have inefficient routines that use excessive resources, which can cause a service outage, even with a low request rate.
- Scalability. Azure offers auto-horizontal scaling of an application, but you must design your application to meet this demand in case of a DDoS attack. When the application depends on a single deployment of a service, it results in a single point of failure. Provisioning multiple instances makes your system more resilient and more scalable.
- Defense-in-depth. Defense-in-depth is a well-accepted strategy that uses multiple security measures to protect an organization's assets. You can lower the chance of a successful attack by layering and even duplicating security defenses for Azure services. You can also enhance the security and robustness of your design by knowing and understanding the capabilities of the built-in Azure platform. An additional benefit of using Azure services is a reduction in the attack surface of your application. Defense-in-depth incorporates all the organization's security measures to address all issues related to securing an application.

> [!NOTE]
> These measures can help you enhance security and meet regulatory requirements.

After addressing the considerations for building DDoS resilient applications, you now need to determine which features of Azure DDoS Protection you need. The following table compares the key features of DDoS Protection Standard and DDoS Protection Basic.

|Feature|DDoS Protection Basic|DDoS Protection Standard|
|--------|---------------------|----------------------------------------|
|Active traffic monitoring and always-on detection|Yes|Yes|
|Automatic attack mitigation|Yes|Yes|
|Availability guarantee|Azure Region|Per application|
|Cost Protection|No|Yes|
|Mitigation policies tuned to customers application|No|Tuned for each applications traffic volume|
|Metrics and alerts|No                    |Yes–Azure Monitor logs for attack metrics and diagnostics|
|Mitigation reports|No|Yes–Post attack|
|Mitigation flow logs| No| Yes|
|DDoS rapid response support| No|Access  to Azure DDoS experts during an attack|
|Service Level Agreement| Azure Region| Application guarantee and cost protection|

> [!NOTE]
> DDoS Protection Standard offers more features than the DDoS Protection Basic. If you determine that certain applications are critical; for example, a high-volume, revenue-generating Ecommerce website, then DDoS standard Protection is a natural choice.

With DDoS Protection Standard, the traffic always remains within the Azure datacenter. Keeping the traffic within the local datacenter helps with performance as well, because DDoS Standard Protection is doing the attack mitigation in an Azure datacenter. Azure DDoS Protection Standard mitigates the attack traffic closest to the application. However, if Microsoft identifies that the attack volume is significant, then it will use the global scale of their Azure networking to defend the attack where it's originating.

> [!NOTE]
> Microsoft uses this defense-in-depth strategy to protect your backend services and your Azure services such as Azure Front Door and Azure Application Gateway.
