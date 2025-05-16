Although low-code development platforms can help to accelerate the application development process, there are also security risks that organizations must consider. For example, citizen developers who might lack the security awareness of professional developers could introduce security vulnerabilities.

Beyond the low-code aspect, SAP BTP applications also have the following aspects that make them a target for cyber threats:

- They **access sensitive business data**, such as customer lists, opportunities, orders, financial data, and manufacturing processes.
- They **access and integrate** with multiple different business applications and data stores.
- They **enable key business processes**.
- They're **created by citizen developers** who might not be security savvy or aware of cyber threats.
- They're **used by a wide range of users**, internal and external.

For more information, see [Nice patch SAP! Revisiting your SAP BTP security measures after AI Core vulnerability fix](https://community.sap.com/t5/technology-blogs-by-members/nice-patch-sap-revisiting-your-sap-btp-security-measures-after-ai-core/ba-p/13770662) (blog).

## Explore how the solution addresses BTP security risks

To counter these vulnerabilities, it's crucial for organizations to quickly detect and respond to threats on BTP applications. With the Microsoft Sentinel Solution for SAP BTP, you can:

- Gain visibility to activities **on** BTP applications; including creation, modification, permissions change, execution, and more.
- Gain visibility to activities **in** BTP applications; including who uses the application, which business applications the BTP application accesses, business data Create, Read, Update, Delete (CRUD) activities, and more.
- **Detect suspicious or illegitimate activities**. The activities include: suspicious logins, illegitimate changes of application settings and user permission, data exfiltration, bypassing of SOD policies, and more.
- **Investigate and respond** to threats originating from the BTP application: Find an application owner, understand relationships between applications, suspend applications or users, and more.
- **Monitor** on-premises and SaaS SAP environments.

The solution includes these elements, each of which is described in the following units:

- The **BTP activity workbook**, which provides a dashboard overview of subaccounts and a grid of identity management events.
- **Built-in analytics rules** for identity management and low-code application development scenarios.
- The **SAP BTP** connector, which allows you to connect your BTP subaccounts and global account to Microsoft Sentinel via the [Audit Log service for SAP BTP API](https://help.sap.com/docs/btp/sap-business-technology-platform/security-events-logged-by-cf-services).
