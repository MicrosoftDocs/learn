Microsoft Priva Privacy Risk Management allows organizations to create custom policies tailored to address specific privacy risks. Unlike template-based policies, custom policies provide the flexibility to configure all aspects of a policy, including conditions, notifications, and alerts. These policies can be designed for **data overexposure**, **data transfers**, and **data minimization**, each addressing unique privacy scenarios.

### Steps to create a custom policy

1. Sign in to the [Priva portal (preview)](https://purview.microsoft.com/priva?azure-portal=true) using your admin credentials.
1. Navigate to the **Privacy Risk Management** solution card then select **Policies**.
1. Select **Create a policy**, then choose the **Custom** option to launch the policy creation wizard.
1. On the **Name your policy and choose a template** page, select a desired policy template, enter a descriptive name and optional description for the policy. Select **Next**.

   :::image type="content" source="../media/name-policy-choose-template.png" alt-text="Screenshot showing selecting a policy template with a name and description for a Data overexposure policy." lightbox="../media/name-policy-choose-template.png":::

1. On the **Choose data sources to apply the policy** page, select the types of personal data the policy detects. The available data sources depend on the policy template you select. Use the table to understand which data sources are supported for each policy type:

   | Data source | Data overexposure | Data transfers | Data minimization |
   |-----|-----|-----|-----|
   | Exchange | Not available | ✓ | ✓ |
   | SharePoint sites | ✓ | ✓ | ✓ |
   | OneDrive accounts | ✓  | ✓ | ✓ |
   | Teams chat and channel messages | Not available | ✓ | ✓ |
   | Azure Storage (preview) | ✓ | Not available | Not available |
   | Azure SQL (preview) | ✓ | Not available | Not available |
   | Amazon S3 (preview)| ✓ | Not available | Not available |

   After selecting data sources, select **Next**.

1. On the **Choose data to monitor** page, select the types of personal data the policy detects. Options include:

   - **Classification groups**: Predefined groupings of sensitive information types.
   - **Sensitive information types or trainable classifiers**: Customizable options for specific data types or machine learning-based classifiers.

   When finished, select **Next**.

1. On the **Choose users and groups covered by this policy**, choose to apply the policy to all users or specific users and groups. Select **Next**.

1. On the **Choose conditions for the policy** page, define the conditions specific to your selected policy type. Conditions determine the scenarios the policy detects, such as public access, external sharing, or inactivity. The conditions available depend on the policy template selected:

   - **Data overexposure**:
     - Public access: Detects when anyone with a link can access the data.
     - External access: Detects when external users or guests have access.
     - Internal access: Detects when all users in the organization have access.
   - **Data transfers**:
     - Transfers outside the organization: Tracks external sharing.
     - Transfers across regions: Monitors data movement between geographic regions.
     - Transfers between users or groups: Detects movement of data between specific departments or roles.
   - **Data minimization**:
     - Inactivity: Detects items that haven’t been modified for a specified number of days (for example, 30, 60, 90, or 120 days).

   After defining conditions, select **Next**.

1. On the **Define outcomes when a policy match is detected** page, configure user notifications and remediation actions specific to the selected policy template. Examples include:

   - **Data overexposure**:
     - Notifications prompt content owners to restrict access or make items private.
     - Multicloud support (preview) extends protection to Azure Storage, Azure SQL, and Amazon S3.
   - **Data transfers**:
     - Notifications in Teams and email provide remediation options like revoking access or keeping the item.
     - Microsoft Teams notifications offer in-the-moment guidance.
   - **Data minimization**:
     - Users receive notifications prompting them to delete or keep the data.

   After defining outcomes, select **Next**.

1. On the **Specify alerts and thresholds** page, set thresholds and severity levels for admin alerts. Select **Next**.

1. On the **Decide policy mode** page, choose to **Test it out first** or **Turn it on right away**. Select **Next**.

1. Review your settings and select **Submit** to create the policy.

After a few seconds, you'll see a confirmation that the policy was created. Select **Done** on the confirmation page, which takes you to the **Policies** page where you see the new policy at the top of the page.

### Refine and activate policies

Custom policies can begin in **test mode**, allowing you to review and refine conditions without generating alerts. Insights such as matches by location, user, or data type help validate the policy’s effectiveness. Once satisfied, activate the policy to enforce conditions and trigger alerts.

Custom policies empower organizations to address unique privacy risks, ensuring comprehensive protection and compliance while safeguarding trust.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
