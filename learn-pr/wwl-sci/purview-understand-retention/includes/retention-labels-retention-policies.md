Retention helps organizations define how long content should be kept and when it can be deleted. Not all retention settings work the same way. Microsoft Purview uses two main methods to apply retention: retention labels and retention policies. Each plays a different role in managing data and supporting compliance and security goals.

Understanding how these tools work, and when to use them, helps ensure your organization meets its requirements for protecting and managing data.

## How retention differs from deletion

When you delete content in Microsoft 365, it typically moves to a recycle bin or deleted items folder. Eventually, it might be permanently removed from the service.

Retention works differently. Retention settings preserve content for a defined period, even if a user deletes it. That content remains discoverable to authorized personnel during its retention period and is only permanently deleted based on the rule that was configured.

Retention can also delete content automatically when it's no longer needed. This reduces exposure from old or unnecessary content that might still contain sensitive information.

## What are retention labels?

Retention labels are applied to individual items such as emails, documents, or Teams chats. These labels can be applied manually by users or automatically using retention label policies. Label policies allow you to publish labels so users can apply them, or configure rules that apply labels automatically based on conditions such as sensitive info types or keywords.

Each label defines how long the content should be retained and what happens after that time expires. For example, a label might retain a document for seven years and then delete it. Another label might mark content as a record to prevent changes or early deletion.

Retention labels provide flexibility. They allow you to apply different retention settings based on the type or purpose of the content. A financial report might require a longer retention period than a casual chat conversation. Labels can be configured to support both needs.

## What are retention policies?

Retention policies are used to apply retention settings across a broader location. Instead of labeling individual items, a policy can apply a default retention rule to all content within a location, such as all mailboxes or all SharePoint sites.

Retention policies are helpful when:

- A general rule applies across a location
- All content needs to be covered, even if it's unlabeled
- You want to minimize the need for users to take action

Retention labels and policies can be used together. For example, a policy might apply a general rule to all content in a site, while certain files receive more specific retention settings through labels.

## Key retention settings

When configuring a retention label or policy, you choose what action should be taken and when it should occur. Microsoft Purview supports several configurations:

- **Retain-only**: Keeps content for a defined period. No automatic action is taken when the period ends.
- **Delete-only**: Deletes content after a defined period, without preserving it beforehand.
- **Retain then delete**: Retains content for a set time and deletes it automatically when that time expires.

Retention labels can also **mark content as a record**. When this option is used, the content becomes immutable. Users can't edit, move, or delete the item while the label is applied. This setting is often used for content that must be preserved without modification for legal or regulatory purposes.

Retention can also be scoped dynamically using **adaptive scope**. Adaptive scopes allow you to apply a label or policy to a dynamic set of users, sites, or groups based on Microsoft Entra ID attributes. For example, you might apply a retention label only to users in the legal department or to sites with a specific region tag. The full setup for adaptive scopes is covered in a later unit, but it's helpful to know that this option exists when planning a retention strategy.

## How retention works with classification, labeling, and data loss prevention

Retention doesn't replace classification, sensitivity labels, or data loss prevention. These tools are designed to work together to support a secure and compliant environment.

- **Classification** helps identify content that might need protection or special handling.
- **Sensitivity labels** apply encryption and access restrictions to protect data in use or in transit.
- **Data loss prevention policies** monitor and block the sharing of sensitive information.

Retention helps ensure that content is kept or removed based on defined rules. Together, these tools support data protection throughout the entire content lifecycle, from creation to deletion.
