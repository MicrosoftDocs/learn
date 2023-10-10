Most government customers have requirements in place for handling security incidents, including data-breach notifications. Security incident response, including breach notification, is a subset of Microsoft's overall incident management plan for Azure. All Microsoft employees are trained to identify and escalate potential security incidents. A dedicated team of security engineers within the Microsoft Security Response Center (MSRC) is responsible for managing the security-incident response for Azure. Microsoft follows a five-step incident response process when managing both security and availability incidents for Azure services. The process includes the following stages:

1. Detect
1. Assess
1. Diagnose
1. Stabilize and recover
1. Close

The goal of this process is to restore normal service operations and security as quickly as possible after an issue is detected, and an investigation started. For more information, see [Incident management implementation guidance: Azure and Office 365](https://servicetrust.microsoft.com/ViewPage/TrustDocumentsV3?command=Download&downloadType=Document&downloadId=a8a7cb87-9710-4d09-8748-0835b6754e95&tab=7f51cb60-3d6c-11e9-b2af-7bb9f5d2d913&docTab=7f51cb60-3d6c-11e9-b2af-7bb9f5d2d913_FAQ_and_White_Papers).

If during the investigation of a security or privacy event, Microsoft becomes aware that customer or personal data has been exposed or accessed by an unauthorized party, the security-incident manager must trigger the incident notification subprocess in consultation with Microsoft legal affairs division. This subprocess is designed to fulfill incident-notification requirements stipulated in Azure customer contracts (see *Security Incident Notification* in the Microsoft Online Services Terms [Data Protection Addendum](https://aka.ms/DPA)). Customer notification and external reporting obligations (if any) are triggered by the declaration of a security incident. The customer notification subprocess begins in parallel with security incident investigation and mitigation phases to minimize any impact of the security incident.

In line with the EU GDPR requirements, Microsoft will notify customers, Data Protection Authorities, and data subjects (each as applicable) of any breach of customer or personal data within 72 hours of incident declaration. The notification process upon a declared security or privacy incident will occur as quickly as possible while considering the security risks of proceeding quickly. In practice, this means that most notifications will take place well before the 72-hr deadline to which Microsoft commits contractually. Notification of a security or privacy incident will be delivered to one or more of a customer's administrators by any means Microsoft selects, including via email. Customers should [provide security contact details](/azure/defender-for-cloud/configure-email-notifications) for their Azure subscription. Microsoft will use this information to contact the customer if the MSRC discovers that customer data has been exposed or accessed by an unlawful or unauthorized party. To ensure that notification can be delivered, the customer is responsible for maintaining correct administrative contact information for each applicable subscription.

Most Azure security and privacy investigations don't result in declared security incidents. The overwhelming majority of external threats don't lead to breaches of customer or personal data because of extensive platform-security measures that Microsoft has in place. Microsoft has deployed extensive monitoring and diagnostics infrastructure throughout Azure that relies on big-data analytics and machine learning to get insight into the platform health, including real-time threat intelligence. While Microsoft takes all platform attacks seriously, it would be impractical to notify customers of potential attacks at the platform level.

Microsoft will notify customers of any breach of customer or personal data within 72 hours of incident declaration. Customers can monitor potential threats and respond to incidents on their own using Microsoft Defender for Cloud.

## Shared responsibility

Microsoft is responsible for monitoring and remediating security and availability incidents affecting the Azure platform and notifying customers of any security breaches involving customer or personal data. Azure has a mature security and privacy incident-management process that's used for this purpose. It's critical to understand the [shared responsibility](/azure/security/fundamentals/shared-responsibility), and which security tasks are handled by the cloud provider and which tasks are handled by you. Customers are responsible for monitoring their own resources provisioned in Azure.

The NIST [SP 800-145](https://csrc.nist.gov/publications/detail/sp/800-145/final) standard defines the following cloud service models: Infrastructure as a Service (IaaS), Platform as a Service (PaaS), and Software as a Service (SaaS). With on-premises deployment in their own datacenter, customers assume the responsibility for all layers in the stack. As workloads get migrated to the cloud, Microsoft assumes progressively more responsibility, depending on the cloud-service model. For example, with the IaaS model, Microsoft’s responsibility ends at the hypervisor layer, and customers are responsible for all layers above the virtualization layer, including maintaining the base operating system in guest virtual machines.

The following table is a simplified version of the shared responsibility model in cloud computing. Each customer environment is isolated on top of Azure infrastructure. Items in italics are managed by the customer and items in regular font are managed by the vendor.

| On-premises     | Infrastructure (as a Service) | Platform (as a Service) | Software (as a Service) |
|-----------------|-------------------------------|-------------------------|-------------------------|
| *Applications*  | *Applications*                | *Applications*          | Applications            |
| *Data*          | *Data*                        | *Data*                  | Data                    |
| *Runtime*       | *Runtime*                     | Runtime                 | Runtime                 |
| *Middleware*    | *Middleware*                  | Middleware              | Middleware              |
| *O/S*           | *O/S*                         | O/S                     | O/S                     |
| *Virtualization*| Virtualization                | Virtualization          | Virtualization          |
| *Servers*       | Servers                       | Servers                 | Servers                 |
| *Storage*       | Storage                       | Storage                 | Storage                 |
| *Networking*    | Networking                    | Networking              | Networking              |
| **Azure**       | **Azure**                     | **Azure**               | **Office 365**          |

In line with the shared-responsibility model, Microsoft doesn’t inspect, approve, or monitor individual customer applications deployed in Azure. For example, Microsoft doesn’t know what ports need to be open for customer’s application to function correctly, what the back-end data schema looks like, what constitutes normal network traffic for the application, and so on.

Next, let’s explore further options for data protection.
