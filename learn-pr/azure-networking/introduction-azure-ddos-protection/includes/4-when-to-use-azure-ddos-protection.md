Here we compare the DDoS infrastructure protection and DDoS Protection tiers to get a better idea of the benefits of upgrading. In this unit, you learn more about the key differences between these tiers and about building resiliency against DDoS attacks into your applications.

## Build DDoS-resilient services on Azure

Azure DDoS infrastructure protection automatically protects every deployed service in Azure at no extra cost and also doesn’t require changes to the configuration of applications or users.

When deciding to upgrade from Azure DDoS infrastructure protection to Azure DDoS Protection, it’s important to do a risk analysis for a DDoS attack on your key Azure resources. Even with the built-in DDoS services that are available, it's preferable not to rely only on post-deployment protection. Building an application that's resilient and tested to withstand or quickly recover from a denial-of-service attack is important.  

### The Azure framework for workload resiliency

The Azure team has published a framework for designing your workload for resiliency. This framework is a collection of guiding principles that you can follow to improve the quality of a workload.

When building or deploying your workload, it’s important to design for:

- Security. Identify and document security requirements early in the development life cycle. This practice helps you ensure that security is a priority throughout the entire lifecycle of an application. Poorly designed applications can have inefficient routines that use excessive resources, which can cause a service outage, even with a low request rate.
- Scalability. Azure offers horizontal autoscaling of an application, but you must design your application to meet this demand if there's a DDoS attack. When the application depends on a single deployment of a service, it results in a single point of failure. Provisioning multiple instances makes your system more resilient and more scalable.
- Defense-in-depth. Defense-in-depth is a well-accepted strategy that uses multiple security measures to protect an organization's assets. You can lower the chance of a successful attack by layering and even duplicating security defenses for Azure services. You can also enhance the security and robustness of your design by knowing and understanding the capabilities of the built-in Azure platform. Another benefit of using Azure services is a reduction in the attack surface of your application. Defense-in-depth incorporates all the organization's security measures to address all issues related to securing an application.

These measures can help you enhance security and meet regulatory requirements. After addressing the considerations for building DDoS resilient applications, you now need to determine which features of Azure DDoS Protection you need. The following table compares the key features of DDoS Protection and DDoS infrastructure protection.

| Feature                                            | DDoS infrastructure protection | DDoS Protection |
| -------------------------------------------------- | :--------: | :-----------: |
| Active traffic monitoring & always  on detection   |   Yes      |     Yes       |
| Automatic attack mitigation                        |   Yes      |     Yes       |
| Availability guarantee                             |   No       |     Yes       |
| Cost Protection                                    |   No       |     Yes       |
| Mitigation policies tuned to customer  application |   No       |     Yes       |
| Metrics & Alerts                                   |   No       |     Yes       |
| Mitigation Reports                                 |   No       |     Yes       |
| Mitigation flow logs                               |   No       |     Yes       |
| DDoS rapid response support                        |   No       |     Yes       |

### Additional DDoS Protection features

With DDoS Protection, the traffic always remains within the Azure datacenter. Keeping the traffic within the local datacenter helps with performance as well, because DDoS Network Protection is doing the attack mitigation in an Azure datacenter. Azure DDoS Protection mitigates the attack traffic closest to the application. However, if Microsoft identifies that the attack volume is significant. It uses the global scale of Azure networking, to defend against the attack from where it originates.

Microsoft uses this defense-in-depth strategy to protect your backend services and your Azure services such as Azure Front Door and Azure Application Gateway.

DDoS Protection offers more features than DDoS infrastructure protection. If you determine that certain applications are critical; for example, a high-volume, revenue-generating Ecommerce website, then DDoS Protection is the recommended choice.
