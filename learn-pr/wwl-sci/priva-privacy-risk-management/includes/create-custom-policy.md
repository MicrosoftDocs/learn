Microsoft Priva Privacy Risk Management allows organizations to create custom policies tailored to address specific privacy risks. Unlike template-based policies, custom policies offer flexibility by enabling administrators to configure all aspects of the policy, including conditions, notifications, and alerts.

Custom policies can be tailored for **Data overexposure**, **Data transfers**, and **Data minimization**, each focusing on unique privacy scenarios.

## General steps for creating a custom policy

Follow these steps to create a custom policy:

1. Log in to the [Priva portal (preview)](https://purview.microsoft.com/priva) using your admin credentials.
1. Navigate to the **Privacy Risk Management** solution card then select **Policies**.
1. Select **Create a policy**, then choose the **Custom** option to launch the policy creation wizard.
1. On the **Name your policy and choose a template** page, select a desired policy template, enter a descriptive name and optional description for the policy. Select **Next**.

   :::image type="content" source="../media/name-policy-choose-template.png" alt-text="Screenshot showing selecting a policy template with a name and description for a Data overexposure policy." lightbox="../media/name-policy-choose-template.png":::

1. On the **Choose data sources to apply the policy** page, select the types of personal data the policy will detect. The available data sources depend on the policy template you select. Use the table below to understand which data sources are supported for each policy type:

   | Data source | Data overexposure | Data transfers | Data minimization |
   |-----|-----|-----|-----|
   | Exchange | Not available | ✓ | ✓ |
   | SharePoint sites | ✓ | ✓ | ✓ |
   | OneDrive accounts | ✓  | ✓ | ✓ |
   | Teams chat and channel messages | Not available | ✓ | ✓ |
   | Azure Storage (preview) | ✓ | Not available | Not available |
   | Azure SQL (preview) | ✓ | Not available | Not available |
   | Amazon S3 (preview)| ✓ | Not available | Not available |

   After selecting data sources, click **Next**.

1. On the **Choose data to monitor** page, select the types of personal data the policy will detect. Options include:

   - **Classification groups**: Predefined groupings of sensitive information types.
   - **Sensitive information types or trainable classifiers**: Customizable options for specific data types or machine learning-based classifiers.

   When finished, select **Next**.

1. On the **Choose users and groups covered by this policy**, choose to apply the policy to all users or specific users and groups. Select **Next**.

1. On the **Choose conditions for the policy** page, define the conditions specific to your selected policy type. Conditions determine the scenarios the policy will detect, such as public access, external sharing, or inactivity. Use the links below to jump to the relevant policy type for details:

   - [Data overexposure](#data-overexposure)
   - [Data transfers](#data-transfers)
   - [Data minimization](#data-minimization)

   After defining your conditions, select **Next**.

1. On the **Define outcomes when a policy match is detected** page, configure user notifications and remediation actions when a policy match is detected. Select **Next**.

1. On the **Specify alerts and thresholds** page, set thresholds and severity levels for admin alerts. Select **Next**.

1. On the **Decide policy mode** page, choose to **Test it out first** or **Turn it on right away**. Select **Next**.

1. Review your settings and select **Submit** to create the policy.

After a few seconds, you'll see a confirmation that the policy was created. Select **Done** on the confirmation page, which will take you to the **Policies** page where you see the new policy at the top of the table.

### Policy-specific details

#### Data overexposure

Data overexposure policies help identify personal data with excessive access permissions, minimizing the risk of unauthorized access or data leaks.

- **Conditions**:

  - **Public**: Detects when anyone with a link can access the data.
  - **External**: Detects when external users or guests have access.
  - **Internal**: Detects when all users in the organization have access.

- **Outcomes**:

  - Notifications prompt content owners to restrict access or make items private.
  - Multicloud support (preview) allows extending protection to Azure Storage, Azure SQL, and Amazon S3.

#### Data transfers

Data transfer policies help monitor and control the movement of personal data across organizational or geographical boundaries to ensure compliance and reduce risks.

- **Conditions**:

  - **Transfers outside the organization**: Tracks external sharing.
  - **Transfers across regions**: Monitors data movement between geographic regions.
  - **Transfers between users or groups**: Detects movement of data between specific departments or roles.

- **Outcomes**:

  - Notifications in Teams and email provide remediation options like revoking access or keeping the item.
  - Includes tips in Microsoft Teams for in-the-moment guidance.

#### Data minimization

Data minimization policies identify older, inactive personal data to reduce unnecessary retention risks and support compliance with retention policies.

- **Conditions**:

  - Detects items that have not been modified for a specified number of days (e.g., 30, 60, 90, or 120 days).

- **Outcomes**:

  - Notifications prompt users to delete or keep the data.

### Testing and activating custom policies

You can create policies in test mode to review and refine conditions based on insights before activating them.
