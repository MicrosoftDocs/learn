For SharePoint and OneDrive, we block or restrict access to sensitive files. To further secure files in SharePoint and OneDrive, organizations should implement a layered approach that addresses both storage and sharing scenarios:

## Securing files in storage

- Apply sensitivity labels to files and folders, autolabeling is a great tool to set this up. These labels can enforce encryption, restrict access, and control permissions based on content sensitivity.

- Use access control policies to limit who can view, edit, or download files. Ensure that only authorized users and groups have permissions to access sensitive documents. Enable versioning and audit logging to monitor changes and access to sensitive files, providing traceability and supporting compliance requirements.

- Regularly review and update permissions using automated tools or periodic access reviews to ensure stale or unnecessary permissions are removed.

## Securing files when shared internally

- Implement internal sharing restrictions for sensitive files, allowing sharing only with specific users or groups within the organization.

- Using Data Loss Prevention (DLP) policies to detect and encrypt sharing of sensitive information with unauthorized internal users.

- Use Policy Tips to inform users in real time if they attempt to share files in violation of company policies, providing guidance on proper handling and remediation.

## Securing files when shared externally

- Configure external sharing settings to restrict sharing of sensitive files with outside parties. Options include allowing sharing only with trusted domains or blocking external sharing altogether for certain labels or libraries.

- Monitor external sharing activity using **audit logs** and **alerts** to quickly detect and respond to unauthorized sharing attempts.

- Consider integrating Microsoft Defender for Cloud Apps to extend monitoring and control over files shared externally through non-Microsoft cloud platforms.

- Choose conditions like: "Shared outside my org," "Contains sensitive info types", or "Has sensitivity label: Confidential":

   :::image type="content" source="../media/data-loss-prevention-rule-configuration.png" alt-text="Screenshot showing Microsoft 365 content sharing DLP rule setup with conditions for external sharing, sensitive info types, and sensitivity labels." lightbox="../media/data-loss-prevention-rule-configuration.png":::

- Set actions like: Block sharing, notify users with policy tips, or send alerts to security teams:

   :::image type="content" source="../media/data-loss-prevention-actions-notifications.png" alt-text="Screenshot showing Microsoft 365 settings to restrict access and notify users when sensitive content is shared externally or modified in a DLP rule." lightbox="../media/data-loss-prevention-actions-notifications.png":::

## Best practices for protecting sensitive files

Combine sensitivity labels, DLP policies, and automated notifications to create a comprehensive protection framework that adapts to organizational requirements and user behaviors. This approach ensures sensitive files remain secure both at rest and in transit, whether accessed internally or externally.

Enterprises commonly store sensitive data across hybrid environments that include cloud services, on-premises servers, and SaaS applications. Protecting this data is critical to prevent unauthorized access, data breaches, and compliance violations, all of which can lead to financial loss and reputational damage. Microsoft Purview view enables organizations to automatically discover, classify, and protect sensitive information consistently across all environments. This unified approach ensures that regulatory requirements are met and sensitive data remains secure, supporting business continuity and maintaining customer trust.
