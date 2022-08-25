SharePoint Online content can be shared with external users. Because Microsoft OneDrive storage is part of SharePoint Online, there are similar settings for both. When you configure settings for external sharing, the OneDrive settings must be the same or more restrictive than the SharePoint Online settings. The commonly used external sharing settings for SharePoint Online are listed in the following table.

*Table 1: Commonly used external sharing settings for SharePoint Online*

| Permission level                 | Description                                                  |
| -------------------------------- | ------------------------------------------------------------ |
| Anyone                           | Allows users to share files and folders by using links that let anyone who has the link access the files or folders without authenticating. This setting also allows users to share sites with new and existing  guests who authenticate. If you select this setting, you can restrict the **Anyone** links so that they expire within a specific number of  days, or so that they provide only **View** permission. |
| New and existing guests          | Requires people who have received invitations to sign in with their work or school account (if their organization uses Microsoft 365). Alternatively, they can use a Microsoft account, or provide a code to verify their identity. Users can share with guests already in your organization's directory, and they can send invitations to people who will be added to the directory if they sign in. |
| Existing guests                  | Allows sharing only with guests who are already in the directory. These  guests might exist in your directory because they previously accepted sharing invitations or because they were added manually, such as through Azure business-to-business (B2B) collaboration. |
| Only people in your organization | Doesn't allow external sharing.                                 |

## Managing sharing

To configure these permissions for a site, you use the **Set-SPOSite** cmdlet with the *-SharingCapability* parameter. Valid values for the *-SharingCapability* parameter are:

- **ExternalUserAndGuestSharing**
- **ExternalUserSharingOnly**
- **ExistingExternalUserSharingOnly**
- **Disabled**

The following example disables external sharing for a site:

```powershell
Set-SPOSite -https://adatum.sharepoint.com/sites/Marketing -SharingCapability Disabled
```

When you allow sharing with external users, you can restrict sharing based on the user domain by using the *-SharingDomainRestrictionMode* parameter. The following table describes the valid values.

*Table 2: Values to restrict sharing based on the user domain*

| Value     | Description                                                  |
| --------- | ------------------------------------------------------------ |
| **None**      | Doesn't restrict sharing by domain (default).                  |
| **AllowList** | Allows sharing only with external users that have an account on domains specified by using the -SharingAllowedDomainList parameter. |
| **BlockList** | Allows Sharing with external users in all domains except in domains specified by using the -SharingBlockedDomainList parameter. |

## Managing sharing links

When a user shares content from a SharePoint site, a sharing link is sent to the recipient. This link is unique and includes information, such as permissions, to edit the file and who can use it.

You can use the *-DefaultLinkSharingType* parameter to specify the default value for the users who can use the sharing link. Users that are sharing can still select the option that they prefer. The following table lists the valid values.

*Table 3: Values to specify which users can use the sharing link*

| Value           | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| **None**            | Uses the value set at the tenant level.                      |
| **AnonymousAccess** | Sets the default sharing link for this site to an **Anonymous Access** or **Anyone** link. |
| **Internal**        | Sets the default sharing link for this site to the **organization** link or company shareable link. |
| **Direct**          | Sets the default sharing link for this site to the **Specific people** link. |

You can use the *-DefaultLinkPermission* parameter to specify the default value for what users can do to the content via the sharing link. Users that are sharing can still select the option that they prefer. The following table lists the valid values.

*Table 4: Values to specify what users can do to the content through the sharing link*

| Value | Description                                     |
| ----- | ----------------------------------------------- |
| **None**  | Uses the value set at the tenant level.         |
| **View**  | Set the default value to **View** permissions.  |
| **Edit**  | Sets the default value to **Edit** permissions. |

You can configure an expiration time for external sharing links. After a link expires, it can no longer be used to access the linked content. The expiration time can be set independently for anonymous and external users. The following table lists parameters that you can use to configure link expiration for a site.

*Table 5: Parameters to configure link expiration for a site*

| Parameter                                      | Description                                                  |
| ---------------------------------------------- | ------------------------------------------------------------ |
| -OverrideTenantAnonymousLinkExpirationPolicy | To set an expiration time for anonymous links at the site level, set this value to `$true`. When set to `$false`, anonymous link expiration settings from the tenant level are used. |
| -AnonymousLinkExpirationInDays               | This sets the number of days that an anonymous link is valid.          |
| -OverrideTenantExternalUserExpirationPolicy  | To set an expiration time for external user links at the site level, set this value to `$true`. When set to `$false`, external user link expiration settings from the tenant level are used. |
| -ExternalUserExpirationInDays                | This sets the number of days that an external user link is valid.      |

> [!NOTE]
> You can configure some sharing settings at the tenant level by using the **Set-SPOTenant** cmdlet.