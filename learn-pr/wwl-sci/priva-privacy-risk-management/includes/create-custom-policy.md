Template defaults don't fit every organization. The classification groups a template ships with might catch content your organization doesn't consider sensitive, or the policy might watch sources where the actual risk is low. Custom policies use the same two templates as a starting point (**Data overexposure** or **Data transfers**), but the wizard steps through every setting you can move: which data sources to include, which sensitive information types or trainable classifiers to look for, which users are in scope, and how alerts and notifications behave. The goal is still to create detection, but the wizard exposes every setting rather than starting from defaults.

### Steps to create a custom policy

1. Sign in to the [Priva portal](https://purview.microsoft.com/priva?azure-portal=true) using your admin credentials.
1. Navigate to the **Privacy Risk Management** solution card then select **Policies**.
1. Select **Create a policy**. In the **Custom** box on the flyout, select **Create** to open the policy creation wizard.
1. On the **Name and type** page, select the **Data overexposure** or **Data transfers** template, enter a descriptive name and optional description for the policy, then select **Next**.

   :::image type="content" source="../media/name-policy-choose-template.png" alt-text="Screenshot showing selecting a policy template with a name and description for a Data overexposure policy." lightbox="../media/name-policy-choose-template.png":::

1. On the **Data sources** page, select the Microsoft 365 sources where the policy looks for matches. The available sources depend on the template you selected:

   | Data source | Data overexposure | Data transfers |
   | --- | --- | --- |
   | Exchange | Not available | ✓ |
   | SharePoint sites | ✓ | ✓ |
   | OneDrive accounts | ✓ | ✓ |
   | Teams chat and channel messages | Not available | ✓ |

   For SharePoint, you can choose **All SharePoint sites** or **Specific SharePoint sites** and add site URLs. After selecting data sources, select **Next**.

1. On the **Data to monitor** page, choose the type of personal data the policy detects:

   - **Classification groups**: Predefined groupings of sensitive information types tied to regulations or common personal-data categories.
   - **Sensitive information types or trainable classifiers**: Individual sensitive info types (for example, Social Security numbers) or trainable classifiers. A single group can mix both.

   When finished, select **Next**.

1. On the **Users and groups** page, apply the policy to all users and groups or to specific users and groups. Select **Next**.

1. On the **Conditions** page, define the conditions for detecting a match. The available conditions depend on the template:

   - **Data overexposure**:
     - **Public**: Anyone with a link can access the content.
     - **External**: Specific people outside the organization have access.
     - **Internal**: All users in the organization have access.
   - **Data transfers**:
     - Transfers outside the organization.
     - Transfers between geographic regions.
     - Transfers between users, based on Microsoft Entra attributes like department, postal code, or job title.
     - Transfers between Microsoft 365 groups, covering the Exchange mailboxes and SharePoint sites associated with those groups.
     - Transfers between SharePoint sites, when an item containing personal data is copied or moved from one site to another.

   Selecting more than one condition widens the scope of matches. After defining conditions, select **Next**.

1. On the **Outcomes** page, configure what happens when a match is detected. Options vary by template and can include Microsoft Teams tips that give users in-the-moment guidance when their action would generate a policy match, and admin remediation actions such as **Notify owner**, **Make private**, **Apply retention label**, or **Apply sensitivity label**. When finished, select **Next**.

1. On the **Alerts** page, turn on admin alerts and set frequency, threshold, and severity:

   - **Frequency**: Alert on each match, when a threshold is reached, or when a recommended condition is met (for example, a high volume of personal data, or personal data covered by specific regulations).
   - **Severity**: Low, Medium, or High.

   If you selected a trainable classifier in the **Data to monitor** step, the **High volume of personal data** threshold isn't available for this policy, because trainable classifier detections are counted per item rather than per instance. The other frequency options still work.

   Select **Next**.

1. On the **Mode** page, choose **Test it out first** or **Turn it on right away**, then select **Next**.

1. On the **Finish** page, review your settings. Select **Edit** under any section to adjust its settings. When you're satisfied, select **Submit** to create the policy.

After a few seconds, you see a confirmation that the policy was created. Select **Done** on the confirmation page to return to the **Policies** page, where the new policy appears at the top of the list.

### Refine and activate policies

Custom policies typically start in **test mode**, which evaluates the last 30 days of activity and lets you review matches without generating alerts or notifications. Microsoft recommends running a policy in test mode for at least five days before turning it on. Insights such as matches by location, user, or data type help you validate the policy's conditions before you activate it.

### Worked example: shape of a Data overexposure policy

An organization protecting medical histories in SharePoint and OneDrive could build a Data overexposure policy from the wizard options alone. It might look like this:

- **Name and type**: Data overexposure template.
- **Data sources**: SharePoint sites (scoped to the specific sites holding patient records) and OneDrive accounts.
- **Data to monitor**: The HIPAA classification group, optionally combined with a trainable classifier or sensitive information types specific to the organization's medical record format.
- **Users and groups**: Limit to the departments handling patient data, rather than all users, to keep the initial signal focused.
- **Conditions**: Public and External. Adding Internal would broaden the scope significantly and is a call to make once test mode data is in.
- **Outcomes**: Notify owner as the default remediation, with a sensitivity label applied when a match is confirmed as real risk.
- **Alerts**: condition-based frequency to keep volume manageable, with severity Medium or High depending on the classification group triggered.
- **Mode**: Test for at least five days to see what the policy catches before turning it on.

The specific choices are illustrative. What generalizes is the shape: a regulation-aligned classification group, the access conditions the organization treats as risky, and test mode data driving the final settings before activation.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
