Configuring the environment and assigning appropriate roles are essential steps before using Microsoft Priva Tracker Scanning (preview). These steps ensure that tracking technologies can be identified, categorized, and managed effectively across your organization's websites, enabling transparency and alignment with privacy practices.

> [!IMPORTANT]
> To use Microsoft Priva Tracker Scanning (preview), your organization must have the enterprise version of Microsoft Purview data governance solutions. This version provides access to the necessary tools and features required for effective tracker scanning. For more information on upgrading, see [Upgrade from the free to enterprise version of Microsoft Purview governance solutions](/purview/upgrade?azure-portal=true).

## Prerequisites

Before configuring Microsoft Priva Tracker Scanning, ensure that your organization meets the following requirements:

### Roles and permissions

Proper role assignment is essential for users to perform tasks in Tracker Scanning. The following roles define the permissions available:

| Role | Permissions |
|-----|-----|
| **Data Source Administrator** | Register, edit, and update websites. |
| **Privacy Curator** | View and edit all privacy objects, create and categorize trackers, promote trackers, and view tags. |
| **Privacy Reader** | Review scan results, view the tracker library, and access identified trackers without making edits. |

For more information, see [Data governance roles and permissions in Microsoft Purview](/purview/data-governance-roles-permissions?azure-portal=true).

### Access tracker scanning

Tracker Scanning is located in the Microsoft Priva portal. Follow these steps to access it:

1. Navigate to the [Microsoft Priva portal](https://purview.microsoft.com/priva?azure-portal=true).
1. Select the **Tracker Scanning** tile from the top row of solutions.
1. If the **Tracker Scanning** tile isn't visible, select **View all solutions**, and under the **Privacy** heading, select **Tracker Scanning**.

## Register websites

Once the prerequisites are met, the next step is to register your organization's websites in Tracker Scanning. Registration connects websites to Tracker Scanning, allowing you to monitor and manage trackers effectively.

The **Registered websites** page is where you manage all sites added to Tracker Scanning. Each registered site includes key details, such as its URL, owner, description, and the region where the website's domain is hosted. Selecting a website opens its details page, where you can create and manage scans, review identified trackers, and organize them into categories. The details page also allows you to view associated [consent models](/privacy/priva/consent-management-create?azure-portal=true) for the registered website.

Registering a website ensures that tracker scanning can identify tracking technologies, detect potential compliance issues (like missing consent banners), and provide insights for improving privacy practices. This step is typically completed by someone familiar with the website's domain and scanning requirements.

To register a website:

1. Navigate to the **Registered websites** page and select **Register**.
1. Enter the following details:
   - **Name and description**: Provide a meaningful name and description for the website.
   - **Website URL**: Add the URL of the website to scan.
   - **Regulatory country or region**: Select the location where the website is hosted.
   - **Owner**: Specify the name or email of the user responsible for the site.
   - **Business domain**: Use the [default domain](/purview/concept-domains?azure-portal=true) for setting up websites and scans.
   - **Collection**: Choose the collection that the website should belong to. Collections help group related websites, making it easier to organize and manage them within Tracker Scanning. For more information, see [Manage domains and collections in the Microsoft Purview Data Map](/purview/how-to-create-and-manage-domains-collections?azure-portal=true).

1. Select **Create** to complete the process.

After registration, websites appear on the **Registered websites** page. From there, you can manage scans, view tracker details, and organize trackers into categories to align with your organization's privacy goals.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
