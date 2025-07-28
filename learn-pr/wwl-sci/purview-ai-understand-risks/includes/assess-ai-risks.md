Assessing AI-related data exposure starts with visibility into how sensitive content is shared and accessed. Microsoft Purview uses **Data Security Posture Management (DSPM) for AI** to assess potential risks across supported AI tools and connected data sources. These assessments help security teams identify overshared content, risky access patterns, and sensitive files referenced in AI interactions.

:::image type="content" source="../media/dspm-ai-assessment.png" alt-text="Illustration of the DSPM for AI process: discovery, classification, risk assessment, and recommendations." lightbox="../media/dspm-ai-assessment.png":::

## Interpret data exposure assessments in DSPM for AI

DSPM for AI performs ongoing **data exposure risk assessments** to evaluate whether sensitive content is at risk based on how it's shared or accessed by AI tools.

### Default and custom assessments

Microsoft Purview includes **default risk assessments** that evaluate common exposure risks, such as:

- Oversharing in SharePoint Online
- External guest access to sensitive content
- Anonymous access through sharing links
- Unmanaged AI tools accessing labeled data

Organizations can also create **custom assessments** by defining their own conditions. For example, you can:

- Filter files based on sensitivity labels, content types, or specific keywords
- Define the type of AI access or sharing behavior to evaluate
- Apply custom rules to specific SharePoint sites or user groups

Each assessment result includes a **risk score**, a list of affected files, and recommended remediation actions.

## Address oversharing risks in SharePoint

One of the most common AI-related risks involves **overshared content in SharePoint Online**, which can be inadvertently accessed or summarized by AI tools.

DSPM for AI highlights oversharing in risk assessment reports that flag:

- Files shared using anonymous links
- Files shared with external guests who aren't part of the organization
- Files shared with large internal groups, such as "Everyone except external users"

Each flagged item includes recommended actions. For example, you can:

- Remove public or guest access
- Restrict permissions to specific users or groups
- Apply a sensitivity label to limit AI access or enforce encryption
- Create or update a DLP policy that blocks AI access to sensitive content

These actions can be taken individually or included in a broader policy and protection strategy.

## Investigate prompt-based access with Activity Explorer

The **Activity Explorer** in DSPM for AI helps security teams track how AI tools interact with sensitive data. It shows file-level activity that results from AI prompts, including:

- The user or app that accessed the content
- The sensitivity label applied to the file
- The date and time of access
- The number of times a file has been accessed through AI interactions

You can use this data to identify:

- AI tools that frequently access sensitive or overshared files
- Users with high volumes of prompt-based activity
- Potential misuse or missing policies that require attention

This allows security teams to investigate exposure patterns and take corrective action as needed.
