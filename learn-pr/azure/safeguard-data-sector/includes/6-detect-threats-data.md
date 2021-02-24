Microsoft uses extensive protections for the Azure cloud platform and offers a wide range of Azure services to help customers monitor and protect their provisioned cloud resources from attacks. Customers can deploy a range of Azure services to safeguard their applications and data and rely on the mature security and privacy incident management process that's in place.

## Microsoft Graph Security API

Aside from controls implemented by Microsoft to safeguard customer data, government customers deployed in Azure get considerable benefits from security research that Microsoft conducts to protect the cloud platform. Microsoft global threat intelligence is one of the largest in the industry and it’s derived from one of the most diverse sets of threat telemetry sources. It’s both the volume and diversity of threat telemetry that makes Microsoft machine learning algorithms applied to that telemetry so powerful.

The Microsoft [Graph Security API](https://www.microsoft.com/security/business/graph-security-api?rtc=1) uses advanced analytics to synthesize large amounts of threat intelligence and security signals from across Microsoft products, services, and partners to combat cyberthreats. Millions of unique threat indicators across the most diverse set of sources are generated every day by Microsoft and its partners, then shared across Microsoft products and services (Figure 4). Across its portfolio of global services, each month Microsoft scans more than 400 billion email messages for phishing and malware, processes 450 billion authentications, executes more than 18 billion page scans, and scans more than 1.2 billion devices for threats. Importantly, this data always goes through strict privacy and compliance boundaries before being used for security analysis.

:::row:::
:::column span="2":::
The Microsoft Graph Security API provides an unparalleled view into the evolving threat landscape and enables rapid innovation to detect and respond to threats. Machine learning models and Artificial Intelligence reason over vast security signals to identify vulnerabilities and threats. The Microsoft Graph Security API provides a common gateway to [share and act on security insights](https://docs.microsoft.com/graph/security-concept-overview) across the Microsoft platform and partner solutions. Azure customers benefit directly from the Microsoft Graph Security API as Microsoft makes the vast threat telemetry and advanced analytics [available in Microsoft online services](https://docs.microsoft.com/graph/api/resources/security-api-overview?view=graph-rest-1.0), including Azure Security Center. These services can help customers address their own security requirements in the cloud. .
:::column-end:::
:::column span="2":::
:::image type="complex" source="../media/PENDING.png" alt-text="Microsoft global threat intelligence is one of the largest in the industry.":::
Pending
:::image-end:::
:::column-end:::
:::row-end:::

## Breach notification process

Most government customers have requirements in place for handling security incidents, including data breach notifications. Security incident response, including breach notification, is a subset of Microsoft's overall incident management plan for Azure. All Microsoft employees are trained to identify and escalate potential security incidents. A dedicated team of security engineers within the Microsoft Security Response Center (MSRC) is responsible for managing the security incident response for Azure. Microsoft follows a 5-step incident response process when managing both security and availability incidents for Azure services. The process includes the following stages: 1) detect, 2) assess, 3) diagnose, 4) stabilize and recover, and 5) close. The goal of this process is to restore normal service operations and security as quickly as possible after an issue is detected, and an investigation started. For more information, see [Incident management implementation guidance: Azure and Office 365](https://servicetrust.microsoft.com/ViewPage/TrustDocumentsV3?command=Download&downloadType=Document&downloadId=a8a7cb87-9710-4d09-8748-0835b6754e95&tab=7f51cb60-3d6c-11e9-b2af-7bb9f5d2d913&docTab=7f51cb60-3d6c-11e9-b2af-7bb9f5d2d913_FAQ_and_White_Papers).

If during the investigation of a security or privacy event, Microsoft becomes aware that customer or personal data has been exposed or accessed by an unauthorized party, the security incident manager must trigger the incident notification subprocess in consultation with Microsoft legal affairs division. This subprocess is designed to fulfill incident notification requirements stipulated in Azure customer contracts (see *Security Incident Notification* in the Microsoft Online Services Terms [Data Protection Addendum](https://aka.ms/DPA)). Customer notification and external reporting obligations (if any) are triggered by the declaration of a security incident. The customer notification subprocess begins in parallel with security incident investigation and mitigation phases to minimize any impact of the security incident.

In line with the EU GDPR requirements, Microsoft will notify customers, Data Protection Authorities, and data subjects (each as applicable) of any breach of customer or personal data within 72 hours of incident declaration. The notification process upon a declared security or privacy incident will occur as quickly as possible while considering the security risks of proceeding quickly. In practice, this means that most notifications will take place well before the 72-hr deadline to which Microsoft commits contractually. Notification of a security or privacy incident will be delivered to one or more of a customer's administrators by any means Microsoft selects, including via email. Customers should [provide security contact details](https://docs.microsoft.com/azure/security-center/security-center-provide-security-contact-details) for their Azure subscription. This information will be used by Microsoft to contact the customer if the MSRC discovers that customer data has been exposed or accessed by an unlawful or unauthorized party. To ensure that notification can be delivered, the customer is responsible for maintaining correct administrative contact information for each applicable subscription.

Most Azure security and privacy investigations don't result in declared security incidents. The overwhelming majority of external threats don't lead to breaches of customer or personal data because of extensive platform security measures that Microsoft has in place. Microsoft has deployed extensive monitoring and diagnostics infrastructure throughout Azure that relies on big-data analytics and machine learning to get insight into the platform health, including real-time threat intelligence. While Microsoft takes all platform attacks seriously, it would be impractical to notify customers of potential attacks at the platform level.

Microsoft will notify customers of any breach of customer or personal data within 72 hours of incident declaration. Customers can monitor potential threats and respond to incidents on their own using Azure Security Center.

## Shared responsibility

Microsoft is responsible for monitoring and remediating security and availability incidents affecting the Azure platform and notifying customers of any security breaches involving customer or personal data. Microsoft Azure has a mature security and privacy incident management process that is used for this purpose. Customers are responsible for monitoring their own resources provisioned in Azure. 

:::row:::
:::column span="2":::
:::image type="complex" source="../media/PENDING.png" alt-text="Shared responsibility model in cloud computing.":::
Pending
:::image-end:::
:::column-end:::
:::column span="2":::
The NIST [SP 800-145](https://csrc.nist.gov/publications/detail/sp/800-145/final) standard defines the following cloud service models: Infrastructure as a Service (IaaS), Platform as a Service (PaaS), and Software as a Service (SaaS). The [shared responsibility](http://aka.ms/sharedresponsibility) model for cloud computing is shown in Figure 5. With on-premises deployment in their own datacenter, customers assume the responsibility for all layers in the stack. As workloads get migrated to the cloud, Microsoft assumes progressively more responsibility, depending on the cloud service model. For example, with the IaaS model, Microsoft's responsibility ends at the Hypervisor layer, and customers are responsible for all layers above the virtualization layer, including maintaining the base operating system in guest Virtual Machines.
:::column-end:::
:::row-end:::

In line with the shared responsibility model, Microsoft doesn't inspect, approve, or monitor individual customer applications deployed in Azure. For example, Microsoft doesn't know what ports need to be open for customer's application to function correctly, what the back-end data schema looks like, what constitutes normal network traffic for the application, and so on.

Next, let’s explore further options for data protection.
