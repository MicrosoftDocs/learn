Retention helps organizations control how long data is kept and when it can be deleted. However, not all content needs the same retention approach. Understanding when to use retention, what it can and can't do, and how it compares to other tools like data loss prevention (DLP) is key to using it effectively.

## When retention is needed

Retention is useful in many scenarios where data must be preserved for a period of time or removed after it's no longer needed. These needs might be driven by legal, regulatory, operational, or internal business requirements.

For example:

- A company might need to retain employee records for seven years after separation, in case of future audits or legal disputes.
- A finance department might need to retain year-end reports for five years to meet regulatory requirements.
- A project team might want to delete temporary planning documents after one year to reduce data clutter and minimize risk.

Retention can also help prevent accidental or intentional deletion of important information. When a retention rule is in place, content is preserved even if a user tries to delete it.

## Retention vs data loss prevention

Retention and data loss prevention (DLP) both help protect information, but they do so in different ways.

- **DLP** is focused on preventing sensitive information from being shared or exposed. It looks at how users interact with content. Based on the action, it can block or warn about risky behavior such as copying, pasting, uploading, or sending sensitive data.
- **Retention** is focused on controlling how long data is kept. It ensures that content is preserved for a required time and deleted when it's no longer needed.

These tools are often used together. For example, DLP might prevent users from sharing sensitive documents externally, while a retention policy ensures those same documents are preserved for three years to meet internal business requirements.

## Scoping retention to specific users, sites, or content types

Retention doesn't have to apply to everyone or everything in your environment. Microsoft Purview lets you target retention settings to the locations and content that require them.

You can:

- Apply retention to specific mailboxes, OneDrive accounts, or SharePoint sites
- Target content based on sensitivity labels, file types, or custom metadata
- Use adaptive scopes to dynamically target users, groups, or sites based on Microsoft Entra ID attributes

This flexibility makes it possible to apply different retention rules to different teams, regions, or types of content. A policy might apply to all users in the HR department, while another targets project sites tagged with a specific classification.

## What retention doesn't do

Retention is designed to control how long content is kept. It's not a tool for:

- Blocking access to content
- Encrypting or protecting content in transit
- Monitoring or detecting data movement
- Preventing sharing or accidental exposure

Retention doesn't stop users from reading or editing content. It simply ensures the content is preserved or removed based on the configured rules. For other protection needs, retention should be used alongside tools like sensitivity labels, DLP, and encryption.
