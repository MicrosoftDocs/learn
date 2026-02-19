Microsoft Purview provides a unified set of data security solutions that help you discover, classify, protect, and govern sensitive information across Microsoft 365. As a security architect, you evaluate how these capabilities work together to reduce data exposure, enforce protection policies, and support compliance requirements. This unit covers the foundational Purview capabilities that apply across all Microsoft 365 workloads: Exchange, SharePoint, OneDrive, and Teams.

## Evaluate data classification capabilities

Before you can protect data, you need to know what data you have and where it resides. Microsoft Purview provides three complementary classification mechanisms.

**Sensitive information types (SITs)** use pattern matching to identify sensitive data. Built-in SITs cover common patterns like credit card numbers, Social Security numbers, and passport numbers across more than 300 types. You can also create custom SITs using regular expressions, keywords, and confidence levels. For the highest accuracy, exact data match (EDM) SITs compare content against hashed values from your actual data—such as employee records or patient databases—to eliminate false positives.

**Trainable classifiers** use machine learning to identify content categories that pattern matching can't easily detect, such as contracts, resumes, financial statements, or source code. Microsoft provides pretrained classifiers for common content types, and you can train custom classifiers with examples from your own data.

The **data classification dashboard** in the Microsoft Purview portal provides visibility into your organization's data landscape. Content explorer shows which items contain specific sensitive information types or have sensitivity labels applied. Activity explorer tracks user actions on classified content, including label changes, file access, and sharing events. These insights help you assess classification coverage and identify gaps in your protection policies.

## Evaluate sensitivity labels and protection policies

Sensitivity labels are the foundational protection mechanism in Microsoft Purview. Each label represents a sensitivity level—such as Public, General, Confidential, or Highly Confidential—and can enforce protection actions automatically when applied.

A sensitivity label can apply any combination of:

- **Encryption** that restricts who can access the content and what usage rights they have (view, edit, copy, print, forward).
- **Content markings** such as headers, footers, and watermarks that provide visual indicators of sensitivity.
- **Access restrictions** that prevent specific actions like forwarding emails or copying content.

**Label policies** control which labels are available to which users, set default labels for new content, and determine whether users must justify downgrading or removing a label. You can scope policies to specific groups or departments.

**Auto-labeling** reduces dependency on users to classify content correctly. Client-side auto-labeling recommends or applies labels in Office apps based on detected sensitive content. Service-side auto-labeling applies labels to content at rest in SharePoint, OneDrive, and Exchange without requiring user action.

When you evaluate sensitivity labels for your organization, consider the label taxonomy carefully. A taxonomy that's too granular creates user confusion. A taxonomy that's too simple fails to differentiate protection requirements. Most organizations benefit from four to six parent labels with sublabels for specific use cases.

## Evaluate data loss prevention across Microsoft 365

DLP policies in Microsoft Purview monitor and protect sensitive content across multiple locations. Unlike sensitivity labels, which protect individual items, DLP policies enforce organizational rules about how sensitive content can be shared, transferred, or accessed.

DLP policies can target the following locations:

| Location | What it protects |
|---|---|
| **Exchange Online** | Email messages and attachments |
| **SharePoint and OneDrive** | Documents stored in sites and libraries |
| **Microsoft Teams** | Chat messages and channel messages |
| **Windows and macOS endpoints** | Files on user devices, including copy to USB, upload to cloud, and print actions |
| **Non-Microsoft cloud apps** | Content in third-party SaaS apps connected through Defender for Cloud Apps |
| **On-premises repositories** | Files in on-premises file shares and SharePoint Server |

Each DLP policy defines conditions based on sensitive information types, sensitivity labels, or trainable classifiers, and specifies actions such as blocking, auditing, or notifying users with policy tips. You can configure rules with different severity levels to distinguish between low-volume accidental sharing and high-volume potential exfiltration.

For security architects, endpoint DLP is particularly important because it extends protection beyond cloud services to the device level. Endpoint DLP can prevent users from copying sensitive content to USB drives, printing protected documents, or uploading files to unauthorized cloud storage services.

## Evaluate encryption key management

Microsoft 365 encrypts all customer content at rest and in transit by default. For organizations with stricter regulatory requirements, Purview provides two additional encryption controls.

**Double Key Encryption (DKE)** uses two keys to protect data: one key that your organization controls on-premises and a second key stored in Azure. Both keys are required to decrypt content. Because Microsoft never has access to your key, DKE-protected content can't be processed by any Microsoft 365 service, including search, eDiscovery, and AI features. Use DKE only for your most restricted content where this trade-off is acceptable.

**Customer Key** provides control over the root encryption keys that Microsoft 365 uses to encrypt data at rest in Exchange Online, SharePoint, OneDrive, and Teams. Unlike DKE, Customer Key still allows Microsoft 365 services to process encrypted content. Customer Key addresses regulatory requirements that mandate control over encryption keys without sacrificing service functionality.

## Evaluate Information Barriers

Information Barriers restrict two-way communication and collaboration between specific user segments in Teams, SharePoint, and OneDrive. This capability addresses conflict-of-interest scenarios common in regulated industries—for example, preventing investment banking teams from sharing information with equity research teams.

When Information Barrier policies are active, restricted users can't find, chat with, call, or share files with each other. The restrictions apply across Teams channels, SharePoint sites, and OneDrive sharing. Policies are defined by segmenting users based on Microsoft Entra attributes such as department, role, or location, and then creating policies that block or allow communication between segments.

## Evaluate Data Security Posture Management

Data Security Posture Management (DSPM) unifies visibility across Microsoft Purview solutions by organizing data security activities around specific objectives. Rather than managing individual solutions separately, DSPM presents guided workflows that group related actions from information protection, DLP, Insider Risk Management, and eDiscovery.

DSPM continuously scans your environment to identify where sensitive data resides, who can access it, and whether protection policies cover it. Key objectives include preventing oversharing, preventing exfiltration to risky locations, and discovering unprotected sensitive data. Each objective provides metrics, recommended actions, and one-click policies to accelerate remediation.

The DSPM dashboard answers four fundamental data security questions: What data do you have? Where is it stored? Who can access it? How is it protected?

## Design considerations for security architects

When you evaluate Microsoft Purview data security solutions, consider the following approaches:

- **Start with classification.** Deploy sensitive information types and trainable classifiers before building DLP policies or label-based protection. Accurate classification is the foundation for all downstream controls.
- **Design a label taxonomy that scales.** Use four to six parent labels with sublabels. Align the taxonomy with your organization's data handling policies and review it periodically as requirements change.
- **Layer auto-labeling with DLP.** Use service-side auto-labeling to classify content at rest and DLP policies to enforce sharing restrictions. This combination provides both persistent protection and real-time enforcement.
- **Reserve DKE for specific use cases.** DKE excludes content from Microsoft 365 service processing. Evaluate the trade-offs carefully and use DKE only when regulatory requirements demand customer-only decryption control.
- **Implement Information Barriers early in regulated environments.** Barrier policies affect collaboration across Teams, SharePoint, and OneDrive. Plan user segmentation during the design phase to avoid disruptions after deployment.
- **Use DSPM as your operational dashboard.** DSPM consolidates insights from multiple Purview solutions into objective-based workflows. Use it to track posture metrics, prioritize remediation, and report progress against data security goals.

In the next unit, you evaluate how these Purview capabilities extend specifically to protect AI interactions in Microsoft 365 Copilot.


