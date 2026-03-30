Privacy regulations such as CCPA, LGPD, PIPEDA, and other privacy laws grant individuals rights over their personal data and require organizations to implement controls that protect that data throughout its lifecycle. As a security architect, you design privacy solutions that address these regulatory requirements while enabling your organization to use data responsibly.

## Microsoft solutions that address privacy

Data privacy and data protection go hand in hand. Microsoft Priva and Microsoft Purview provide a unified platform to help you comply with data privacy regulations. Priva focuses specifically on privacy operations, while several Microsoft Purview solutions provide complementary data protection capabilities that support privacy requirements:

<!--Source: https://learn.microsoft.com/microsoft-365/solutions/data-privacy-protection-->

| Solution | Privacy role |
| -------- | ------------ |
| **Microsoft Priva** | Purpose-built privacy operations: risk management policies and automated subject rights request fulfillment |
| **Microsoft Purview Compliance Manager** | Tracks privacy compliance posture through assessments and improvement actions; Priva actions contribute to compliance score (automated detection in preview) |
| **Microsoft Purview Data Loss Prevention** | Prevents personal data from being shared inappropriately; Priva extends DLP by delivering privacy-specific insights and user remediation via email |
| **Microsoft Purview Information Protection** | Sensitivity labels classify and protect personal data in documents and emails |
| **Microsoft Purview Data Lifecycle Management** | Retention policies and labels help enforce data minimization by managing how long personal data is stored |
| **Microsoft Purview Audit** | Tracks access to and actions on personal data for accountability and incident response |

<!--Sources: https://learn.microsoft.com/privacy/priva/priva-setup, https://learn.microsoft.com/microsoft-365/solutions/data-privacy-protection-->

## Microsoft Priva

Microsoft Priva provides two generally available solutions, accessed through the [Microsoft Priva portal](https://purview.microsoft.com/priva): **Privacy Risk Management** and **Subject Rights Requests**.

<!--Source: https://learn.microsoft.com/privacy/priva/priva-overview-->

Priva uses Microsoft Purview [data classifications](/purview/concept-classification) and [sensitive information types (SITs)](/microsoft-365/compliance/sensitive-information-type-learn-about) to identify personal data across Exchange Online, SharePoint Online, OneDrive for Business, Microsoft Teams, and data sources registered through Microsoft Purview.

## Designing with Privacy Risk Management

Privacy Risk Management provides customizable policies that identify privacy risks in your Microsoft 365 environment and enable easy remediation. When you start using Priva, a default version of each policy type is automatically set up and running.

<!--Source: https://learn.microsoft.com/privacy/priva/risk-management-->

Design your strategy around three policy types:

- **Data overexposure:** Detects personal data that is publicly accessible or has overly broad access. Remediation options include making content private, notifying content owners, or tagging items for review.
- **Data transfer:** Monitors transfers of personal data across geographic boundaries, departmental boundaries, or outside your organization. Users receive email notifications with corrective actions they can take directly.
- **Data minimization:** Identifies personal data stored beyond a configured retention threshold, helping reduce privacy risk from aging data. Items can be marked for deletion, or owners notified for review.

When policy matches are found, admins review alerts and create issues for further action. Email and Teams notifications inform content owners directly about policy matches. The Reports page presents consolidated insights on policy trends and data classification.

## Designing for subject rights requests

Privacy regulations grant individuals—or *data subjects*—the right to review or manage personal data that organizations have collected about them. These subject rights requests (SRRs) require organizations to locate all relevant personal data and respond within regulatory timeframes.

<!--Source: https://learn.microsoft.com/privacy/priva/subject-rights-requests-->

Priva Subject Rights Requests provides automation, insights, and workflows to fulfill requests efficiently. It supports four request types:

<!--Source: https://learn.microsoft.com/privacy/priva/subject-rights-requests-create#request-types-->

- **Access:** Summary of the data subject's personal information held in Microsoft 365
- **Export:** Summary and exported file of content items reviewed and marked as included
- **Tagged list for follow up:** Summary of files tagged during data review
- **Delete:** Deletes content items after they are marked as included and approval is complete

### Architectural considerations for the SRR workflow

<!--Sources: https://learn.microsoft.com/privacy/priva/subject-rights-requests-workflow, https://learn.microsoft.com/privacy/priva/subject-rights-requests-automate-->

Priva automates the SRR lifecycle through stages—data estimation, retrieval, review, report generation, and closure. When designing your SRR solution, focus on:

- **Data scope and volume:** Priva retrieves content from Exchange Online, SharePoint Online, OneDrive for Business, and Teams into Azure Blob Storage. Plan storage and review capacity based on expected data volumes per request.
- **Review process design:** A dedicated Teams channel is automatically created for each request. Design your review process around who should be assigned as collaborators, how priority items (content with sensitivity labels, multi-person data, or retention labels) are escalated, and how built-in redaction tools fit into your data handling procedures.
- **Approval workflows for delete requests:** Delete requests require an additional approval substage. Define who has authority to approve deletions and how this integrates with your organization's data governance policies.
- **Integration and automation:** Use Power Automate templates to connect SRR workflows with ticketing systems like ServiceNow, and use the Microsoft Graph subject rights request API for programmatic access when building custom integrations.

<!--Source: https://learn.microsoft.com/privacy/priva/subject-rights-requests-automate-->

## Design considerations for security architects

When designing your privacy solution:

- **Start with Priva and Purview together:** Use Priva for privacy-specific operations and Purview solutions for data protection, classification, and lifecycle management to address privacy requirements holistically
- **Review default policies first:** The default privacy risk management policies are automatically enabled; customize them based on your highest privacy risks
- **Configure anonymization:** Turn on anonymization in Priva settings to show anonymized usernames when reviewing privacy risk alerts
- **Define response SLAs:** Establish service level agreements for subject rights requests that meet regulatory timeframes (default completion deadline is two weeks past creation)
- **Automate where possible:** Use Power Automate templates to connect Priva with ticketing systems, and use the Microsoft Graph subject rights request API for programmatic integration
- **Plan for scale:** Design workflows that can handle increased request volumes; purchase subject rights requests in blocks of 1, 10, or 100
- **Train content owners:** Enable user notification emails so data owners can remediate privacy risks directly from email notifications
- **Configure data retention:** Set retention periods (30 or 90 days) for subject rights request data after requests are closed
- **Integrate with Compliance Manager:** Priva actions contribute to your compliance score; automated detection of Priva improvement actions is in preview
- **Set appropriate permissions:** Assign users to Priva role groups following the principle of least privilege

<!--Sources:
- https://learn.microsoft.com/privacy/priva/priva-setup
- https://learn.microsoft.com/privacy/priva/priva-settings
- https://learn.microsoft.com/privacy/priva/subject-rights-requests-automate
- https://learn.microsoft.com/microsoft-365/solutions/data-privacy-protection
-->
