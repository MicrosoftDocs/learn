SAP BTP is a cloud-based solution that provides a wide range of tools and services for developers to build, run, and manage applications.

The Microsoft Sentinel solution for SAP BTP monitors and protects your SAP Business Technology Platform (BTP) system by collecting audits and activity logs from the BTP-based apps, and detecting threats, suspicious activities, illegitimate activities, and more.

## What SAP services are covered

The Microsoft Sentinel Solution for SAP BTP covers all SAP BTP services that log security-relevant events to the [SAP Audit Log Management service](https://help.sap.com/docs/btp/sap-business-technology-platform/security-events-logged-by-cf-services). Among the supported services are:

- **SAP Cloud Integration - Integration Suite**: Connects different SAP applications and systems, both on-premises and in the cloud, to facilitate data exchange and integration processes.
- **SAP Cloud Identity Service - Identity Authentication**: Provides secure and seamless access to SAP applications through single sign-on (SSO), multi-factor authentication (MFA), and proxy scenarios with Microsoft Entra ID.
- **SAP Business Application Studio (BAS)**: A cloud-based development environment that provides tools and services for building, testing, and deploying applications on SAP BTP using low-code and pro-code approaches.
- **SAP Build Apps**: A low-code development platform for creating custom business applications quickly using visual modeling and prebuilt components.
- **SAP Build Work Zone**: A unified point of access to SAP applications (such as SAP S/4HANA), custom-built, and third-party applications and extensions, both on the cloud and on-premises.
- **SAP Datasphere - SAP Business Data Cloud**: A cloud-based data management and analytics platform for collecting, storing, processing, and analyzing data from various sources.
- **SAP AI Core**: A service for building, deploying, and managing AI models and applications on SAP BTP.
- **SAP Event Mesh**: Enables event-driven architecture and real-time data processing on SAP BTP.

## Solution architecture

The following image illustrates how Microsoft Sentinel retrieves the complete BTP's audit log information using the SAP Audit Log Management service. The Microsoft Sentinel solution for SAP BTP provides built-in analytics rules and detections for selected scenarios, which you can extend to cover more of the audit log information and events.

:::image type="content" source="../media/sap-business-technology-platform-solution-overview.png" alt-text="Diagram that shows an SAP BTP landscape integrated with Microsoft Sentinel." lightbox="../media/sap-business-technology-platform-solution-overview.png":::

> [!NOTE]
> Custom apps developed on SAP BTP using the Cloud Foundry environment or SAP Cloud Application Programming (CAP) Model don't write to the SAP Audit Log Management service by default. Audit-relevant events on custom apps need to be implemented by the app developer. See the [SAP CAP documentation](https://cap.cloud.sap/docs/guides/data-privacy/audit-logging#use-sap-audit-log-service) for details.

## Why it's important to monitor BTP activity

While low-code development platforms have become increasingly popular among businesses looking to accelerate their application development processes, there are also security risks that organizations must consider. One key concern is the risk of security vulnerabilities introduced by citizen developers, some of whom might lack the security awareness of the traditional pro-dev community. To counter these vulnerabilities, it's crucial for organizations to quickly detect and respond to threats on BTP applications.

Beyond the low-code aspect, BTP applications have the following aspects that make them a target for cyber threats:

- **Access sensitive business data**, such as customers, opportunities, orders, financial data, and manufacturing processes.
- **Access and integrate** with multiple different business applications and data stores.
- **Enable key business processes**.
- **Are created by citizen developers** who might not be security savvy or aware of cyber threats.
- **Used by wide range of users**, internal and external.

For more information, see [Nice patch SAP! Revisiting your SAP BTP security measures after AI Core vulnerability fix](https://community.sap.com/t5/technology-blogs-by-members/nice-patch-sap-revisiting-your-sap-btp-security-measures-after-ai-core/ba-p/13770662).

## How the solution addresses BTP security risks

With the Microsoft Sentinel solution for SAP BTP, you can:

- Gain visibility to activities **on** BTP applications, including creation, modification, permissions change, execution, and more.
- Gain visibility to activities **in** BTP applications, including who uses the application, which business applications the BTP application accesses, business data Create, Read, Update, Delete (CRUD) activities, and more.
- Detect suspicious or illegitimate activities. The activities include: suspicious logins, illegitimate changes of application settings and user permission, data exfiltration, bypassing of SOD policies, and more.
- Investigate and respond to threats originating from the BTP application: Find an application owner, understand relationships between applications, suspend applications or users, and more.
- Monitor on-premises and SaaS SAP environments.

The solution includes:

- The **SAP BTP** connector, which allows you to connect your BTP subaccounts and global account to Microsoft Sentinel via the [Audit Log service for SAP BTP API](https://help.sap.com/docs/btp/sap-business-technology-platform/security-events-logged-by-cf-services). Learn how to [install the solution and data connector](https://learn.microsoft.com/azure/sentinel/sap/deploy-sap-btp-solution).
- **[Built-in analytics rules](https://learn.microsoft.com/azure/sentinel/sap/sap-btp-security-content#built-in-analytics-rules)** for SAP Integration Suite, SAP Cloud Identity Services, low-code application development scenarios using event sources such as Trust and Authorization Provider, Business Application Studio (BAS) and more.
- The **[BTP activity workbook](https://learn.microsoft.com/azure/sentinel/sap/sap-btp-security-content#sap-btp-workbook)**, which provides a dashboard overview of subaccounts and a grid of threat related events.
