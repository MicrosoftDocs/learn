Assign endpoint data loss prevention (DLP) policies to groups of remote workers or devices and ensure policy synchronization across all endpoints. The example illustrates how to configure these settings.

:::image type="content" source="../media/scope-endpoint-data-loss-prevention.png" alt-text="Screenshot showing Microsoft 365 policy setup with location and device scope options, including selected group 'Remote Users' and device settings." lightbox="../media/scope-endpoint-data-loss-prevention.png":::

User group is organized list of individuals who are working remotely. Outside of users, this policy can be applied to devices ONLY used for and by remote workers.

Conditions include the **Group** operator "Any of these" to detect when either an SSN or a Highly Confidential label is involved. This applies when the user interacting with the content has an Insider Risk level of "Elevated risk level."

:::image type="content" source="../media/data-loss-prevention-adaptive-protection.png" alt-text="Screenshot showing Remote Upload Prevention policy using Adaptive Protection to block high-risk remote users from sharing sensitive content." lightbox="../media/data-loss-prevention-adaptive-protection.png":::

The AND operator combines the content conditions and insider risk level, so both must be met for the policy to apply. Administrators can also add multiple risk levels if needed.

:::image type="content" source="../media/adaptive-protection-settings.png" alt-text="Screenshot showing Adaptive Protection settings for insider risk levels with options for elevated, moderate, and minor risk levels." lightbox="../media/adaptive-protection-settings.png":::

> [!NOTE]
> Remote workers often access company data from various networks and devices, which can introduce vulnerabilities.

Endpoint DLP allows organizations to assign policies to specific user groups, such as remote employees, and establish conditions based on risk levels.

- For example, if a user is flagged with an "Elevated risk level" due to insider risk indicators, DLP policies can respond dynamically. These policies might restrict the user's ability to copy, print, or upload sensitive content, such as Social Security Numbers or highly confidential documents.

- This adaptive approach ensures that risky behavior is contained before it leads to data loss. Use [adaptive protection](/purview/insider-risk-management-adaptive-protection#risk-levels-and-preventive-controls) to dynamically restrict risky users based on behavior as a condition within the policy.

For conditions, the high risk activities being identified here are copy/paste, print, and upload sensitive content.

:::image type="content" source="../media/endpoint-data-loss-prevention-upload-paste-actions.png" alt-text="Screenshot showing endpoint DLP actions to audit or block device activities like uploads and pastes to restricted cloud services or browsers." lightbox="../media/endpoint-data-loss-prevention-upload-paste-actions.png":::

:::image type="content" source="../media/endpoint-data-loss-prevention-file-activities.png" alt-text="Screenshot showing file activity restrictions for sensitive content, with options to audit or block actions like USB copy, print, and RDP transfer." lightbox="../media/endpoint-data-loss-prevention-file-activities.png":::

Copy to clipboard can have different restrictions based on configurations.

:::image type="content" source="../media/endpoint-data-loss-prevention-network-restrictions.png" alt-text="Screenshot showing file activity and network restriction settings, with options to block USB copy and audit actions on corporate network and VPN." lightbox="../media/endpoint-data-loss-prevention-network-restrictions.png":::

With endpoint DLP, administrators can configure advanced settings to audit and block high-risk activities like copying to clipboard, printing, or uploading content to restricted cloud services.

- This granular control prevents unauthorized data transfers and helps ensure compliance with regulatory requirements.

- For remote workers, these controls are essential because traditional perimeter defenses, like firewalls, might not be effective when employees operate outside the corporate network.
