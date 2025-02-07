Setting up Microsoft Priva effectively requires configuring key features and permissions to align with your organization's privacy management needs. These configurations ensure that Priva's tools operate seamlessly and securely to address privacy risks and compliance requirements.

## Subscriptions and licensing

### Licensing for generally available (GA) solutions

For solutions like **Privacy Risk Management** and **Subject Rights Requests for data within Microsoft 365**, ensure that your organization has the appropriate licenses. Licensing tiers for Subject Rights Requests depend on the volume of requests, and extra requests can be purchased as needed.

- **Free trial:** You can explore these features with a [free Priva trial](/privacy/priva/priva-trial?azure-portal=true).

### Licensing for preview solutions

Preview solutions include:

- Consent Management (preview)
- Privacy Assessments (preview)
- Subject Rights Requests for data beyond Microsoft 365 (preview)
- Tracker Scanning (preview)
- Privacy Risk Management for multicloud locations (preview)

Some features integrate with **Microsoft Purview Data Governance** tools, such as Data Map and Unified Catalog. If these tools aren't configured in your organization, refer to [Get started with data governance solutions](/purview/purview-portal?azure-portal=true#get-started-with-data-governance-solutions) for guidance.

## Roles and permissions

Microsoft Priva uses role-based access control (RBAC) to manage access and capabilities. Assign appropriate roles to users based on the solutions they need to access.

### Roles for GA solutions

Roles for **Privacy Risk Management** and **Subject Rights Requests for data within Microsoft 365** can be managed through the **Settings** > **Roles and scopes** section in the Microsoft Priva portal. Detailed guidance is available at [Permissions in the Microsoft Purview portal](/purview/purview-permissions?azure-portal=true).

### Roles for preview solutions

Roles for preview solutions, such as **Consent Management** and **Privacy Assessments**, are managed through the Data Map in the Priva portal. Learn more about role assignments at [Governance roles and permissions](/purview/data-governance-roles-permissions?azure-portal=true).

## Configuring Priva settings

### Anonymization

Enable anonymization to mask user identities in Privacy Risk Management. This setting replaces identifiable usernames with generic labels to protect privacy while reviewing sensitive data. Anonymization doesn't apply to Subject Rights Requests.

To configure anonymization:

1. From the [Microsoft Priva portal](https://purview.microsoft.com/priva?azure-portal=true), navigate to the **Settings** card, then select **Privacy Risk Management**.
1. On the **Microsoft Priva settings** page, selected the desired option for **Anonymization**.

:::image type="content" source="../media/priva-anonymization.png" alt-text="Screenshot showing the anonymization options in the Microsoft Priva settings." lightbox=" ../media/priva-anonymization.png":::

### User notification emails

Privacy Risk Management policies can send notification emails to users when a policy match is detected. These emails include recommendations for corrective actions and a link to privacy training.

To manage email notifications:

1. From the Microsoft Priva settings page, navigate to **User notification emails**.
1. Select or deselect the option to **Send user notification emails to users**.
1. Specify an internal email account as the sender by selecting the **Customize sender alias** option.

Get full details on how to set up and customize user notification emails:

- [User notifications in privacy risk management](/privacy/priva/risk-management-notifications?azure-portal=true)
- [Define outcomes: user email notifications and Teams tips](/privacy/priva/risk-management-policies?azure-portal=true#define-outcomes-user-email-notifications-and-teams-tips)

### Teams collaboration

Integrate Microsoft Teams with Subject Rights Requests to streamline collaboration with stakeholders. Turning on this feature automatically creates a Teams channel for each request, enabling efficient data reviews and discussions.

To enable Teams collaboration:

1. From the Microsoft Priva settings page, navigate to **Teams collaboration**.
1. Select the checkbox for **Turn on Microsoft Teams capabilities for subject rights requests**.

### Data matching

The **Data matching** section in Microsoft Priva includes three tabs that allow you to define, manage, and upload personal data schemas and sensitive information types for Subject Rights Requests.

#### Personal data schema

A personal data schema describes the attributes of your data subjects. This schema helps identify and categorize personal data during Subject Rights Requests.

To configure a personal data schema:

1. Navigate to **Data matching** in **Microsoft Priva settings**.
1. Select the **Personal data schema** tab.
1. Select **Add** to upload your schema file in XML format and associated rule package.
   - Find an example schema and learn more about creating a schema.

#### Sensitive info types

The **Sensitive info types** tab enables you to define custom types that classify sensitive data based on exact data values rather than generic patterns. These types are used across compliance solutions to ensure precise detection of sensitive information.

To create sensitive info types:

1. Set up a personal data match (PDM) schema.
1. Define the PDM info type based on this schema.
1. Use this info type in compliance solutions like data classification and privacy risk management.

#### Personal data upload

The **Personal data upload** tab allows you to provide personal data that matches the schema defined in the Personal data schema tab. This data can be uploaded as a file or sourced directly from Azure.

To upload personal data:

1. Select the **Personal data upload** tab.
1. Choose to upload your file manually or import data from Azure.
1. Follow guidelines on uploading personal data.

:::image type="content" source="../media/priva-data-matching.png" alt-text="Screenshot showing the data matching options in the Microsoft Priva settings." lightbox=" ../media/priva-data-matching.png":::

### Data retention periods

Set data retention periods for Subject Rights Requests to determine how long collected data and reports are stored after a request is closed. Options include 30 or 90 days.

To configure data retention:

1. Navigate to **Data retention periods** in **Microsoft Priva settings**.
1. Specify your preferred retention period.

### Data review tags

Manage data review tags to mark content items retrieved during Subject Rights Requests. Priva provides two default tags, **Follow-up** and **Update**, and allows customization of 21 extra tags.

To edit tags:

1. Navigate to **Data review tags** in **Microsoft Priva settings**.
1. Select the tag to edit and update its name or description.
1. Save your changes.

## Accessing Priva solutions

Priva solutions can be accessed through the [Microsoft Priva portal (preview)](https://purview.microsoft.com/priva?azure-portal=true). Depending on your setup, you might also use the classic Microsoft Purview compliance or governance portals.

| Solution| Priva portal (preview) | Classic Microsoft Purview compliance portal | Classic Microsoft Purview governance portal |
|-----|-----|-----|-----|
| Consent Management (preview) | ✓ | | ✓ |
| Privacy Assessments (preview) | ✓ | | ✓ |
| Privacy Risk Management | ✓  | ✓ | |
| Subject Rights Requests (preview) |✓| | ✓ |
| Subject Rights Requests (GA) | ✓ | ✓ | |
| Tracker Scanning (preview) | ✓ | | ✓ |

## Next steps

After configuring Microsoft Priva, explore its tools to manage privacy risks, improve compliance, and streamline data handling processes.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
