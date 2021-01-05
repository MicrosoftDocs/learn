
### Build DDoS-resilient services on Azure

Every deployed service in Azure is automatically protected by Azure's DDoS (Basic) Protection at no additional cost. DDoS Protection Basic requires no application or user configuration changes.

When deciding to upgrade your Azure DDoS Basic Protect to Azure DDoS Standard protection, it is important to do a risk analysis for a DDoS attack on your key Azure resources. Even with the builtin DDoS services that are available, it makes good sense not to relay only on post deployment protection. Building an application that is resilient and tested to withstand, or quickly recovery from a denial of service attack is important.  

The Azure team has published the Fundamental Framework for best practices. This framework is a collection of guiding principles, that if followed, can improve quality of a workload. When building or deploying your workload, it is important to:

- **Design for security** - Identify and document security requirements early in the development life cycle. This process  will help to ensure that security is a priority throughout the entire lifecycle of an application. Poorly designed applications, can have inefficient routines that use excessive amount of resources. This design can cause a service outage, even with a low request rate.

- **Design for scalability** - Though Azure offers auto horizontal scaling of an application, the application needs to be designed to meet this demand, in the event of a DDoS attack. When the application depends on a single deployment of a service, a single point of failure, is created. Provisioning multiple instances makes your system more resilient and more scalable.

- **Defense in depth** - Defense in depth is a well-accepted strategy that usages  multiple security measures to protect an organization's assets. Layering and even duplicating security defenses for Azure services, reduces the chance of a successful attack. Knowing and understanding the built-in Azure platform capabilities, can enhance the security and robustness of your design. The additional benefit of using Azure services, it helps to reduce the attack surface of your application. Defense in depth incorporates all of the organization's security measures to address all issues related to securing an application.

The above measures have the potential to enhance security and meet regulatory requirements. Now that the considerations for building DDoS resilient application have been addressed. What features of Azure DDoS Protection services are needed.

The following table outlines key features of the Azure DDoS Protection Standard as compared to DDoS Protection Basic.

| Feature  | DDoS Protection Basic | DDoS Protection Standard                 |
| -------- | --------------------- | ---------------------------------------- |
| Active traffic monitoring and always  on detection  | Yes  |  Yes           |
| Automatic attack mitigation        | Yes     |            Yes               |
| Availability guarantee                              | Azure Region          | Per  Application                                             |
| Cost Protection                                     | No                    | Yes                                                          |
| Mitigation policies tuned to  customers application | No                    | Tuned  for each applications traffic volume                  |
| Metrics and alerts                                  | No                    | Yes –  Azure Monitor logs for attack metrics and diagnostics |
| Mitigation reports                                  | No                    | Yes –  Post attack                                           |
| Mitigation flow logs                                | No                    | Yes                                                          |
| DDoS rapid response support                         | No                    | Access  to Azure DDoS experts during an attack               |
| Service Level Agreement                             | Azure  Region         | Application  guarantee and cost protection                   |

With DDoS protection standard, the traffic always remains within the Azure data center.

Keeping the traffic data center helps with performance as well, because DDoS Standard Protection is doing the attack mitigation in an Azure data center. Azure DDoS Protection Standard mitigates the attack traffic closest to the application. But if Microsoft identities that the attack volume is significant, then Microsoft will will use the global scale of their Azure networking to defend the attack where it is originating.

 Your Azure services like Azure Front Door, and Azure Application Gateway, and your backend services are protected using this defense in-depth strategy.

As show in the above table, DDoS Protection Standard offers many additional features then the Basic Protection. If you determine that certain applications are critical, for example, a high-volume, dollar generating, Ecommerce website, DDoS standard Protection is a natural choice.
