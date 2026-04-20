Sensitivity labels only protect data when you apply them consistently across the places where people work. In this module, you moved through the major Microsoft 365 workloads where labels matter and learned what decisions each one involves.

Here's what you learned:

- **Container labels for Teams, SharePoint, and Groups**: Sensitivity labels applied to containers enforce privacy, external sharing, and Conditional Access settings at the site or group level, not at the document level. Understanding this distinction helps you layer container labels with document-level labels effectively.
- **Office apps and file compatibility**: Built-in labeling in Office replaces the retired Azure Information Protection (AIP) add-in. Labels work fully with Open XML formats, support PDF export, and provide a sensitivity bar for consistent user experience. Cross-organizational sharing attaches label metadata, but encryption is what actually secures the content.
- **Copilot and sensitivity labels**: Copilot inherits the highest-priority label from source content and respects encryption restrictions. Labels with the Extract right allow Copilot to summarize; without it, Copilot links to the content instead.
- **Meeting protection**: Sensitivity labels control lobby bypass, presenter roles, recording permissions, and encryption for audio and video. Labels also inherit from files shared during meetings.
- **Applying labels across services**: Each surface (Outlook groups, SharePoint sites, document libraries, Teams admin center, and Teams client) serves a different purpose. Choose based on who manages the label and at what scope.
- **Power BI**: Labels propagate from semantic models to reports and dashboards, and they follow exported data to Excel, PowerPoint, and PDF.

In a typical deployment, these layers work together. A container label on the SharePoint site controls who can share from it, and a library default label classifies the files inside. Meeting labels protect the board discussion, and Copilot inherits the highest label when drafting from those sources. The exported Power BI dashboard carries its label into the PDF. Each layer handles a different risk, and gaps in any one of them leave data exposed.

## Resources

- [Use sensitivity labels to protect content in Microsoft Teams, Microsoft 365 groups, and SharePoint sites](/purview/sensitivity-labels-teams-groups-sites?azure-portal=true)
- [Use sensitivity labels to protect calendar items, Teams meetings, and chat](/purview/sensitivity-labels-meetings?azure-portal=true)
- [Manage sensitivity labels in Office apps](/purview/sensitivity-labels-office-apps?azure-portal=true)
- [Microsoft Purview data security and compliance protections for Microsoft 365 Copilot](/purview/ai-microsoft-purview?azure-portal=true)
- [Minimum versions for sensitivity labels in Office apps](/purview/sensitivity-labels-versions?azure-portal=true)
- [Sensitivity labels in Power BI](/fabric/enterprise/powerbi/service-security-sensitivity-label-overview?azure-portal=true)
- [How to apply sensitivity labels in Power BI](/fabric/enterprise/powerbi/service-security-apply-data-sensitivity-labels?azure-portal=true)
