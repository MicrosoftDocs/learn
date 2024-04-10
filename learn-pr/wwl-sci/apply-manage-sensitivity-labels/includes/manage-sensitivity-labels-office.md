As our consultancy firm rolls out its new AI-powered service, it's important we keep our sensitive data secure, especially with our marketing team working hard on the launch. Sensitivity labels are a valuable security feature that we can use once we create and publish them in the Microsoft Purview compliance portal.

This unit guides you on how to:

- **Use sensitivity labels in Office apps**: Apply sensitivity labels in Office apps to protect documents and emails.
- **Understand file compatibility**: Identify which file types support sensitivity labels.
- **Cross-organizational protection**: Use sensitivity labels for secure data sharing and management across organizations.
- **Audit label activities**: Use Microsoft Purview to audit sensitivity label use.

## Transitioning to built-in labeling in Office apps

With the [Azure Information Protection (AIP) unified labeling client add-in set to retire in April 2024](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/retirement-notification-for-the-azure-information-protection/ba-p/3791908?azure-portal=true), it's crucial to switch to Office's built-in sensitivity labels. This ensures your data protection is up-to-date, providing access to the latest security features like advanced classifiers. These features are available across Windows, macOS, iOS, Android, and Office on the web without the need for external add-ins.
To integrate these labels smoothly:

- Ensure your Office subscription supports these features.
- Configure and publish label policies through the Microsoft Purview compliance portal for organizational consistency.
- Keep your [Office applications updated to the latest versions that support these labels](/purview/sensitivity-labels-versions?azure-portal=true).

You can manage adjustments using Office policy settings. Use Group Policy or cloud-based tools for detailed control over how labels are applied.

## Sensitivity label support and file compatibility in Office apps

To manage and safeguard your organization's data effectively, you need to understand how sensitivity labels work in different Office applications and document formats. Sensitivity labels let you classify, label, and protect content as it's being created, edited, or shared within and outside of office. This functionality makes them useful for different kinds of files including PDFs.

### Compatibility across document formats

Understanding compatibility across document formats is important, as sensitivity labels offer different levels of support depending on the file type being used within Office apps.

- **Open XML formats**: Sensitivity labels are fully compatible with Open XML formats (.docx, .xlsx, .pptx). To find out the minimum Office version needed to use certain features of sensitivity labels, such as classification, encryption, and labeling automation, see [Minimum versions for sensitivity labels in Office apps](/purview/sensitivity-labels-versions?azure-portal=true).
- **Legacy and non-standard formats**: Compatibility limitations exist for older file formats such as .doc, .xls, and Open Document Formats (.odt, .ods), where built-in labeling might not be available. Configuring SharePoint and OneDrive is also necessary to maintain the integrity of labeled documents within these services.
- **PDF support**: Office applications let you convert documents to PDFs and keep sensitivity labels, content markings, and encryption. It's important to note:

  - PDF attachments in Outlook don't inherit label-based encryption.
  - The potential bypass of labels when printing to PDF.
  - Administrators can manage the application of sensitivity labels to PDFs through Group Policy settings to align with organizational security policies.

### Label application in Office with the sensitivity bar

To see the sensitivity bar in Office applications like Word, Excel, and PowerPoint, your Office version needs to meet specific version requirements. This feature, when supported, displays sensitivity labels in a bar next to the file name at the top window bar.

:::image type="content" source="../media/sensitivity-bar-example.png" alt-text="Screenshot of sensitivity labels on the window title bar." lightbox="../media/sensitivity-bar-example.png":::

When Outlook supports this feature, the sensitivity bar is displayed on the **Subject** line of the email in the classic Outlook experience.

:::image type="content" source="../media/sensitivity-bar-example-outlook.png" alt-text="Screenshot of sensitivity labels on the Outlook Subject line." lightbox="../media/sensitivity-bar-example-outlook.png":::

## Manage sensitivity labels for encryption and collaboration in Office apps

Sensitivity labels offer a modern alternative to traditional Information Rights Management (IRM). They make the encryption process easier and more effective, allowing information protection to be coherent and manageable across documents and emails. These labels provide a consistent way of securing data by automating encryption and giving clear instructions for both users and administrators.

### Encryption and sensitivity label management in Office apps

Office apps are moving from IRM to sensitivity labels for encryption, where users are prompted to use labels for protection settings. This transition  is part of a more user-friendly experience for applying protection to documents and emails.

   :::image type="content" source="../media/irm-redirect-sensitivity-labels.png" alt-text="Screenshot of a dialog box prompting users to use sensitivity labels from the sensitivity bar.":::

Documents automatically inherit encryption from associated emails or previous IRM policies, simplifying the transition to a unified labeling system. Administrators enforce tenant-specific policies to ensure consistent protection and compliance across the organization.

### Collaborating with sensitivity labels across organizations

Sensitivity labels also play a role in securing collaborative efforts across organizational boundaries:

- **Document sharing and metadata**: Sensitivity labels attach metadata to documents and emails, including the organization's tenant information and a unique label identifier (GUID). This metadata keeps label visibility consistent within the same tenant, while external or guest users might not see these labels.
- **Cross-organizational sharing considerations**: Sensitivity labels ensure external document sharing respects the data protection policies of both the sending and receiving organizations. Although Outlook retains label metadata, other email clients might not, potentially impacting label visibility. However, label-based encryption secures the content regardless of metadata visibility.
- **Extended access controls**: External users with Microsoft Entra ID or through guest accounts can also access documents shared outside your organization. This access is enabled by additional configurations for cross-tenant access and conditional access settings.

## Auditing labeling activities

Microsoft Purview allows organizations to monitor and manage data protection and compliance across their digital assets by auditing sensitivity labels. This process involves tracking and logging events related to the usage of sensitivity labels on various items like SharePoint sites, Teams sites, documents, emails, and calendar events. When these items are labeled or unlabeled, specific events are triggered and recorded. These include actions like applying a new sensitivity label to a site or file, changing an existing label, or removing a label completely. Each event is carefully logged, whether the label was applied through Microsoft 365 apps, Office on the web, an auto-labeling policy, or even via PowerShell cmdlets.

For information about the auditing events that sensitivity label activities generate, see the [Sensitivity label activities](/purview/audit-log-activities?azure-portal=true#sensitivity-label-activities) section from [Search the audit log in the Microsoft Purview compliance portal](/purview/audit-new-search?azure-portal=true). The auditing information is visually represented in the content explorer and activity explorer in the data classification dashboard. This visualization helps you understand how your sensitivity labels are being used and where this labeled content is located.

## Knowledge check

Select the best response to the question, then select **Check your answers**.
