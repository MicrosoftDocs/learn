There are a number of tools you can use to resolve compliance issues for end user's devices and apps, as well as your tenant.

## Intune Tenant Status
The Microsoft Intune Tenant Status page is a centralized hub where you can view current and important details about your tenant. Details include license availability and use, connector status, and important communications about the Intune service. Tenant details provide at-a-glance information about your tenant. View details like your tenant name and location, your MDM Authority, and your tenants service release number. 

> [!TIP]
> A tenant is an instance of Azure Active Directory (Azure AD). Your subscription to Intune is hosted by an Azure AD Tenant. 

## Connector status
You can use the connector status pane as a one-stop location to review the status of all available connectors for Intune.  

Connectors are connections you configure to external services. For example, the *Apple Volume Purchase Program* service or the *Windows Autopilot* service.  Status for this type of connector is based on the last successful synchronization time. Connectors are also cCertificates or credentials that are required to connect to an external unmanaged service* like *Apple Push Notification Services* (APNS) certificates. Status for this type of connector is based on the expiry timestamp of the certificate or credential.  

## Service health dashboard  
On the Service health dashboard you can view details for *Service incidents* that affect your tenant, and *Intune news* that provides information about updates and planned changes.

### Intune Service Health and message center
View details for active incidents and advisories without having to navigate to the Microsoft 365 Service Health Dashboard or the Message Center, both located in the [Microsoft 365 admin center](https://admin.microsoft.com). Only incidents that affect your tenant are shown.  

### Intune Message Center  
View informational communications from the Intune service team without having to navigate to the Office Message Center. Communications include messages about changes that have recently happened to the Intune service, or that are on the way for your tenant.  

## Troubleshooting portal

The troubleshooting portal lets help desk operators and Intune administrators view user information to address user help requests. Organizations that include a help desk can assign the **Help desk operator** to a group of users. The help desk operator role can use the **Troubleshoot** pane.

The **Troubleshoot** pane also shows user enrollment issues. Details about the issue and suggested remediation steps can help administrators and help desk operators troubleshoot problems. Certain enrollment issues aren't captured and some errors might not have remediation suggestions.

When a user contacts support with a technical issue with Intune, the help desk operator enters the user's name. Intune shows useful data that can help resolve many tier-1 issues, including:

- User status
- Assignments
- Compliance issues
- Device not responding
- Device not getting VPN or Wi-Fi settings
- App installation failure

## Intune reports

Microsoft Intune reports allow you to more effectively and proactively monitor the health and activity of endpoints across your organization, and also provides other reporting data across Intune. For example, you will be able to see reports about device compliance, device health, and device trends. In addition, you can create custom reports to obtain more specific data. 

The report types are organized into the following focus areas:
- **Operational** - Provides timely, targeted data that helps you focus and take action. Admins, subject matter experts, and helpdesk will find these reports most helpful.
- **Organizational** - Provides a broader summary of an overall view, such as device management state. Managers and admins will find these reports most helpful.
- **Historical** - Provides patterns and trends over a period of time. Managers and admins will find these reports most helpful.
- **Specialist** - Allows you to use raw data to create your own custom reports. Admins will find these reports most helpful.

The reporting framework provides a consistent and more comprehensive reporting experience. The available reports provide the following functionality:
- **Search and sort** – You can search and sort across every column, no matter how large the dataset.
- **Data paging** – You can scan your data based on paging, either page-by-page or by jumping to a specific page.
- **Performance** - You can quickly generate and view reports created from large tenants.
- **Export** – You can quickly export reporting data generated from large tenants.

## Endpoint analytics

It's not uncommon for end users to experience long boot times or other disruptions. These disruptions can be due to a combination of:
- Legacy hardware
- Software configurations that aren't optimized for the end-user experience
- Issues caused by configuration changes and updates

These issues and other end-user experience problems persist because IT doesn't have much visibility into the end-user experience. Generally, the only visibility into these issues comes from a slow costly support channel that doesn't usually provide clear information about what needs to be optimized. It's not only IT support bearing the cost of these problems. The time information workers spend dealing with issues is also costly. Performance, reliability, and support issues that reduce user productivity can have a large impact on an organization's bottom line as well.

Endpoint analytics aims to improve user productivity and reduce IT support costs by providing insights into the user experience. The insights enable IT to optimize the end-user experience with proactive support and to detect regressions to the user experience by assessing user impact of configuration changes.

Endpoint analytics currently focuses on three things:
- **Recommended software**: Recommendations for providing the best user experience.
- **Proactive remediation scripting**: Fix common support issues before end-users notice issues.
- **Start up performance**: Help IT get users from power-on to productivity quickly without lengthy boot and sign in delays.

## Client health with co-management

The health of your network is directly connected to the health of the devices moving in and out of it. Intune can communicate with an unhealthy client, even when it isn't on your network. Use co-management to combine this feature with Configuration Manager's ability to report back 98% of known healthy clients. Then you can detect, assess, and provide visibility across all clients in real time. Intune also adds the support needed for compliance upgrades across all connected clients.

Assessing client health is a top priority. The **CCMeval** utility is external to the Configuration Manager client. It provides client health monitoring and auto remediation. However, this reporting relies on a device being physically or virtually on your internal network. Co-management helps to address this issue.

With co-management, Intune can report on the client health state. It provides timestamp information for the validity of the data. This information tells you if your devices are healthy, able to connect, able to install apps, or can update to the required OS builds.