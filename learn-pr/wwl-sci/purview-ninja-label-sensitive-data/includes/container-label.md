Container labels are important because they allow administrators to consistently enforce protections and compliance rules across entire sites or groups. They can be used to restrict access from unmanaged devices and prevent discovery of private teams. By applying labels at the container level, organizations can ensure scalable, automated data protection that doesn't rely solely on individual user actions.

## Scope of container labels

It's important to note that container-level labels influence site and group settings. However, they don't automatically apply to individual files or emails within those containers. Further configuration is required to achieve comprehensive content protection.

### Default sensitivity labels for document libraries

Organizations can configure a default sensitivity label for a SharePoint document library.

- This approach ensures that new or edited files without an existing label, or those with a lower-priority label, are automatically protected.

- Location-based labeling delivers consistent data protection without the need to inspect file content.

- The default label will override lower-priority labels unless a higher-priority label is manually applied.

- The timing of label application can vary depending on how files are created or uploaded:

- Labels are applied immediately in Office for the web.

### Extending permissions with SharePoint

When SharePoint is configured with a sensitivity label to extend permissions, the applied restrictions persist even after documents are downloaded.

- Users who had read-only access within the SharePoint site will continue to have view-only access to the file after downloading, while those without access can't open the file at all.

- This protection applies to both unlabeled files and those with nonencrypted labels and prevents files from being copied or moved to other sites unless specific permissions are granted.

## Sharing link defaults

Sensitivity labels in Microsoft Purview can define the default sharing link type for SharePoint sites, OneDrive accounts, and individual documents. By setting predefined scopes and permissions, organizations can prevent over-sharing and ensure that default sharing options are automatically selected when users select the Share button. These defaults can be overridden manually if necessary. If a document has a more restrictive label than the site's default, the document's settings will take precedence during sharing, maintaining the highest level of protection where needed.

## On-demand classification

In addition to the above, on-demand classification plays a large role in data management. On-demand classification enables administrators to scan and label inactive or historical files stored in SharePoint and OneDrive using the latest sensitive information types and policies.

- This feature addresses gaps left by real-time classification systems by targeting files at rest that might be unlabeled or have outdated labels.

- When used together with continuous classification, it offers a comprehensive approach to ensure both active and dormant content meets current security standards.

## Customizable sensitivity labels

Customizable sensitivity labels, using automated or manual classification, help organizations consistently secure and monitor sensitive data with precise access controls, even when sharing externally or during organizational changes.
