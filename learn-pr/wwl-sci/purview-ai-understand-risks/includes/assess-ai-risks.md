Assessing AI-related data exposure starts with visibility into how sensitive content is shared and accessed. Microsoft Purview uses **Data Security Posture Management (DSPM) for AI** to evaluate risks across supported AI tools and connected data sources. These assessments allow security teams to spot overshared content, risky access patterns, and sensitive files that appear in AI interactions.

## Interpret data exposure assessments in DSPM for AI

DSPM for AI performs **data risk assessments** that evaluate whether sensitive content is at risk based on how it is shared or accessed by AI tools.

### Default and custom assessments

Purview includes **default assessments** that cover common exposure scenarios, such as:

- Oversharing in SharePoint Online
- External guest access to sensitive files
- Anonymous sharing links
- Unmanaged AI tools interacting with sensitive or labeled data

Organizations can also define **custom assessments** to reflect their own conditions. For example, a team might:

- Filter files by sensitivity labels, content types, or keywords
- Focus on specific types of AI access or sharing behavior
- Apply rules to selected SharePoint sites or user groups

Each assessment produces a **risk score**, a list of affected files, and recommended actions to reduce exposure.

## Address oversharing risks in SharePoint Online

Overshared files in SharePoint Online are one of the most common ways AI tools can access or summarize sensitive data. DSPM highlights these risks in assessment reports by flagging:

- Files shared with anonymous links
- Files accessible to external guests
- Files shared broadly with internal groups, such as "Everyone except external users"

Reports include recommended steps. For example, security teams can:

- Remove guest or public access
- Limit permissions to authorized groups
- Apply sensitivity labels to restrict access, which prevents Copilot from including content if the user doesn't have permission
- Adjust DLP policies to block, warn, or require justification when sensitive data appears in prompts or is pasted into AI sites

These actions can be applied one file at a time or incorporated into a broader policy strategy.

## Investigate prompt-based access with Activity Explorer

The **Activity Explorer** in DSPM for AI shows how AI prompts result in file-level access. It provides details such as:

- Which user or app accessed the content
- The sensitivity label on the file
- The date and time of access
- How many times the file was accessed through AI interactions

This information can reveal patterns such as:

- AI tools that frequently access sensitive or overshared files
- Users generating high volumes of AI-driven activity
- Gaps in existing policies that require attention

With these insights, security teams can investigate risks and make targeted adjustments to reduce exposure.
