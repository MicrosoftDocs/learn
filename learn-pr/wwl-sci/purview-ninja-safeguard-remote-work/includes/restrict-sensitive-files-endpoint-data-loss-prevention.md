For most organizations, the initial task is to identify sensitive data, as previously outlined in this training, and using both automatic and manual sensitivity labels.

> [!NOTE]
> To prevent screenshots, a file needs to have a sensitivity label applied that prevents Printing.

The next step is to determine high-risk activities for remote workers based on Step 1 conditions.

The screenshot illustrates actions that can be taken for endpoint data loss prevention (DLP):

:::image type="content" source="../media/endpoint-data-loss-prevention-actions.png" alt-text="Screenshot showing endpoint DLP advanced rule actions, including options to restrict access, audit activities, or start a Power Automate workflow." lightbox="../media/endpoint-data-loss-prevention-actions.png":::

Restrict access or encrypt the content in Microsoft 365 locations:

:::image type="content" source="../media/endpoint-data-loss-prevention-restriction-actions.png" alt-text="Screenshot showing endpoint DLP action to restrict access or encrypt content, blocking external users from email and file sharing in Microsoft 365." lightbox="../media/endpoint-data-loss-prevention-restriction-actions.png":::

Audit or restrict activities when users access sensitive sites in Microsoft Edge browser on Windows Devices:

:::image type="content" source="../media/endpoint-data-loss-prevention-restriction-actions.png" alt-text="Screenshot showing endpoint DLP action to audit or block user activity on sensitive sites accessed via Microsoft Edge on Windows devices." lightbox="../media/endpoint-data-loss-prevention-restriction-actions.png":::

## Audit or restrict activities on devices

Endpoint DLP can audit or restrict how sensitive files are used on devices. The next sections outline the activity categories, available settings, and actions you can apply.

### Service domain and browser activities

Endpoint DLP can control uploads to cloud domains and paste actions in supported browsers. These settings help prevent data exfiltration through unapproved browsers or sites.

| Setting | Description| Actions |
|-----| -----|-----|
| **Upload to a restricted cloud service domain or access from an unallowed browser** | Applies only to Microsoft Edge or Chrome with the Purview extension. Detects when protected files are blocked or allowed to upload based on the _Allow/Block cloud service domains_ list. If set to _Block_ or _Block with override_, other unallowed browsers are blocked, and users see a notification prompting them to use Microsoft Edge.¹ | Audit only, Block, Block with override, Allow, Off |
| **Paste to supported browsers** | Detects sensitive info pasted in text fields or web forms on Microsoft Edge, and on Chrome or Firefox with the Microsoft Purview extension.² | Audit only, Block, Block with override, Allow, Off |

> [!NOTE]
> ¹ Users who have the Microsoft Chrome Extension installed on their devices won't be blocked when using Chrome, even if Chrome is listed as an unallowed browser. _Block with override_ isn't supported on Google Chrome.
>
> ² This action doesn't follow the service domain list but does support sensitive service domain groups that are added to the rule. It also doesn't account for other sensitive information that might be copied with the item.

### File activities for all apps

These controls apply to common file operations, such as copying to devices, printing, or moving files to network shares.

| Setting | Description | Actions |
|-----|-----|-----|
| **Don't restrict file activity**| No restrictions applied. | N/A  |
| **Copy to clipboard** | Detects when protected files are copied to the clipboard (Windows/Mac). Enforcement applies only to the copied content; not when pasted. | Audit only, Block, Block with override, Allow, Off |
| **Copy to a removable USB device** | Detects when protected files are copied/moved to USB devices (Windows/Mac). WPD and CD-ROM not supported.| Audit only, Block, Block with override, Allow, Off |
| **Copy to a network share** | Detects when protected files are copied/moved to network shares. | Audit only, Block, Block with override, Allow, Off |
| **Print**  | Detects when protected files are printed from Windows/Mac.| Audit only, Block, Block with override, Allow, Off |
| **Copy or move using an unallowed Bluetooth app** | Detects when files are copied/moved to unallowed Bluetooth apps (defined in endpoint DLP settings). | Audit only, Block, Block with override, Allow, Off |
| **Copy or move using RDP** | Detects when files are copied/moved via Remote Desktop Protocol (RDP). Not supported on Mac. | Audit only, Block, Block with override, Allow, Off |

### File activities for apps in restricted app groups

These rules control access to protected files by apps included in restricted lists or groups.

| Setting | Description | Actions |
|-----|-----|-----|
| **Access by restricted apps** | Detects when apps on the restricted apps list attempt to access protected files. | Audit only, Block, Block with override, Allow, Off |
| **Access by non-restricted apps** | Enforces actions for apps not included in restricted lists or groups. Available only when restricted app rules are enabled. | Audit only, Block, Block with override, Allow, Off |

### Apply restrictions only to unsupported file extensions

These settings scope policies to file extensions not already supported by endpoint DLP.

| Setting| Description | Actions |
|-----|-----|-----|
| **Apply restrictions to unsupported extensions** | Restrictions apply only to unsupported file extensions. You can exclude some extensions or scope to specific groups. Applies to: **Upload to restricted domains**, **Print**, **Copy to USB**, **Copy to network share**. | Audit only, Block, Block with override, Allow, Off |

### Sensitive service domain groups and browser support

The service domains list in endpoint DLP applies only to file uploads to websites. Other actions, such as pasting into a browser, don't follow the service domain list. The table shows which features are supported across browsers when using sensitive service domain groups.

| Browser | Supported features |
|-----| -----|
| **Microsoft Edge** | - Print the site <br> - Copy data from the site <br> - Save the site as local files (save-as) <br> - Paste to supported browsers <br> - Upload to a restricted cloud service domain |
| **Google Chrome** (with the Microsoft Purview extension)| - Paste to supported browsers <br> - Upload to a restricted cloud service domain |
| **Mozilla Firefox** (with the Microsoft Purview extension) | - Upload to a restricted cloud service domain <br> - Paste to supported browsers |

For more information, see [Sensitive service domain groups browser supportability](/purview/dlp-configure-endpoint-settings#sensitive-service-domain-groups).
