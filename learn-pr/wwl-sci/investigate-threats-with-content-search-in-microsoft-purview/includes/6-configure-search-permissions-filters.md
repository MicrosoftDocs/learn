Search permissions filtering enables an organization's eDiscovery manager to search only a subset of mailboxes and sites in the organization. Permissions filtering can also let that same eDiscovery manager search only for mailbox or site content that meets a specific search criteria. For example:

 -  You may let an eDiscovery manager search only the mailboxes of users in a specific location or department. You do so by creating a filter that uses a supported recipient filter to limit which mailboxes a specific user or group of users can search.
 -  You can also create a filter that specifies what mailbox content a user can search for. You do so by creating a filter that uses a searchable message property.
 -  You can let an eDiscovery manager search only specific SharePoint sites in your organization. You do so by creating a filter that limits which site can be searched.
 -  You can also create a filter that specifies what site content can be searched. You do so by creating a filter that uses a searchable site property.

Search permissions filters are applied when you search for content in the Microsoft Purview compliance portal by using any of its search features:

 -  Content search
 -  Microsoft Purview eDiscovery (Standard)
 -  Microsoft Purview eDiscovery (Premium)

When a search permissions filter is applied to a specific user, that user can perform the following search-related actions:

 -  Search for content
 -  Preview search results
 -  Export search results
 -  Purge items returned by a search

You can also use search permissions filtering to create logical boundaries (called **compliance boundaries**) within an organization. These boundaries control the user content locations (such as mailboxes, SharePoint sites, and OneDrive accounts) that specific eDiscovery managers can search. For more information, see [Set up compliance boundaries for eDiscovery investigations](/microsoft-365/compliance/set-up-compliance-boundaries?azure-portal=true).

The following diagram shows how compliance security filters are used to create compliance boundaries.

:::image type="content" source="../media/compliance-boundaries-in-microsoft-365-4e70eaec.jpg" alt-text="Diagram showing how compliance security filters are used to create compliance boundaries.":::


The following four cmdlets in the Security and Compliance PowerShell module enable organizations to configure and manage search permissions filters:

| **Cmdlet**                      | **Description**                                             |
| ------------------------------- | ----------------------------------------------------------- |
| New-ComplianceSecurityFilter    | This cmdlet creates a new search permissions filter.        |
| Get-ComplianceSecurityFilters   | This cmdlet returns a list of search permissions filters.   |
| Set-ComplianceSecurityFilter    | This cmdlet modifies an existing search permissions filter. |
| Remove-ComplianceSecurityFilter | This cmdlet deletes a search filter.                        |

### Requirements to configure permissions filtering

An organization must satisfy the following requirements before it can configure permissions filtering:

 -  To run the compliance security filter cmdlets, you must be a member of the **Organization Management** role group in the compliance portal.
 -  You have to connect to both the Exchange Online PowerShell module and the Security and Compliance PowerShell module to use the compliance security filter cmdlets. This requirement is necessary because these cmdlets access mailbox properties.
 -  Search permissions filtering is applicable to inactive mailboxes. As such, you can use mailbox and mailbox content filtering to limit who can search an inactive mailbox.
 -  Search permissions filtering can't be used to limit who can search public folders in Exchange.
 -  There's no limit to the number of search permissions filters that can be created in an organization. However, a search query can have a maximum of 100 conditions. In this case, a condition is defined as something that's connected to the query by a Boolean operator (such as AND, OR, and NEAR). The limit for the number of conditions includes the search query itself plus all search permissions filters that are applied to the user who runs the search. Therefore, the more search permissions filters you have (especially if these filters are applied to the same user or group of users), the better the chance of exceeding the maximum number of conditions for a search. To prevent your organization from reaching the conditions limit, keep the number of search permissions filters in your organization to as few as possible to meet your business requirements. For more information, see [Set up compliance boundaries for eDiscovery investigations](/microsoft-365/compliance/set-up-compliance-boundaries?azure-portal=true).

### New-ComplianceSecurityFilter

The **New-ComplianceSecurityFilter** is used to create a search permissions filter. Here's the basic syntax for this cmdlet:

```powershell
New-ComplianceSecurityFilter -FilterName <name of filter> -Users <user or role group> -Filters <filter>
```

The following sections describe the parameters for this cmdlet. All parameters are required to create a search permissions filter.

#### FilterName

The *FilterName* parameter specifies the name of the permissions filter. This name is used to identity a filter when using the **Get-ComplianceSecurityFilter**, **Set-ComplianceSecurityFilter**, and **Remove-ComplianceSecurityFilter** cmdlets.

### Filters

The *Filters* parameter specifies the search criteria for the compliance security filter. You can create three different types of filters:

 -  **Mailbox or OneDrive filtering**. This type of filter specifies the mailboxes and OneDrive accounts the assigned users (specified by the *Users* parameter) can search. This type of filter is called a **content location** filter because it defines the content locations that a user can search.
    
    The syntax for this type of filter is **Mailbox\_ MailboxPropertyName**, where **MailboxPropertyName** specifies a mailbox property used to scope the mailboxes and OneDrive accounts that can be searched. For example, the mailbox filter "Mailbox\_CustomAttribute10 -eq 'OttawaUsers'" would allow the user assigned this filter to search only the mailboxes and OneDrive accounts that have the value "OttawaUsers" in the CustomAttribute10 property.
    
    Any supported filterable recipient property can be used for the **MailboxPropertyName** property in a mailbox or OneDrive filter. The following table list four commonly used recipient properties used to create a mailbox or OneDrive filter. The table also includes an example of using the property in a filter.
    
    | **Property name** | **Example**                                    |
    | ----------------- | ---------------------------------------------- |
    | Alias             | "Mailbox\_Alias -like 'v-'"                    |
    | Company           | "Mailbox\_Company -eq 'Contoso'"               |
    | CountryOrRegion   | "Mailbox\_CountryOrRegion -eq 'United States'" |
    | Department        | "Mailbox\_Department -eq 'Finance'"            |
 -  **Mailbox content filtering**. This type of filter is applied on the content that can be searched. This type of filter is called a **content filter** because it specifies the mailbox content or searchable email properties the assigned users can search for.
    
    The syntax for this type of filter is **MailboxContent\_\_SearchablePropertyName**, where **SearchablePropertyName** specifies a Keyword Query Language (KQL) property that can be specified in a search. For example, the mailbox content filter "MailboxContent\_Recipients -like 'contoso.com'" would allow the user assigned this filter to only search for messages sent to recipients in the contoso.com domain.
    
    For a list of searchable email properties, see [Keyword queries and search conditions for eDiscovery](/microsoft-365/compliance/keyword-queries-and-search-conditions?azure-portal=true).
    
    > [!IMPORTANT]
    > A single search filter can't contain a mailbox filter and a mailbox content filter. To combine these two filters into a single filter, you must use a [filters list](/microsoft-365/compliance/permissions-filtering-for-content-search?azure-portal=true). But a filter can contain a more complex query of the same type. For example, "Mailbox\_CustomAttribute10 -eq 'FTE' -and Mailbox\_MemberOfGroup -eq '$($DG.DistinguishedName)'"
 -  **Site and site content filtering**. There are two SharePoint- and OneDrive-related filters that you can use to specify what site or site content the assigned users can search.
     -  Site\_*SearchableSiteProperty*
     -  SiteContent\_*SearchableSiteProperty*
    
    These two filters are interchangeable. For example, "Site\_Path -like 'https://contoso.sharepoint.com/sites/doctors'" and "SiteContent\_Path -like 'https://contoso.sharepoint.com/sites/doctors'" return the same results. For a list of searchable site properties, see [Keyword queries and search conditions for eDiscovery](/microsoft-365/compliance/keyword-queries-and-search-conditions?azure-portal=true) For a more complete list, see [Overview of crawled and managed properties in SharePoint](/SharePoint/technical-reference/crawled-and-managed-properties-overview?azure-portal=true). Properties marked with a Yes in the Queryable column can be used to create a site or site content filter.
    
    > [!IMPORTANT]
    > Setting up a site filter with one of the supported properties doesn't mean the site property in the filter will propagate to all documents on that site. Instead, it means the user is still responsible for populating the specific property fields associated with the documents on that site in order for the site filter to work and capture the right content.
    
    For example, let's assume the user has a security filter "Site\_RefineableString00 -eq 'abc'" applied. The user then runs a search using keyword query "xyz". The security filter gets appended to the query and the actual query running would be "xyz AND RefineableString0:'abc'". The user needs to ensure that documents on the site indeed have values in the RefineableString00 field as"abc". If not, the search query won't return any results.

Keep the following considerations in mind when configuring the *Filters* parameter for search permissions filters:

 -  Unlike mailboxes, there isn't a content location filter for sites even though the *Site* filter looks like a location filter. All filters for SharePoint and OneDrive are content filters (which is also why *Site\_* and *SiteContent\_* filters are interchangeable).
    
    Why? Because site-related properties like *Path* are stamped directly on the documents. It's a result of the way that SharePoint is designed. In SharePoint, there isn't a "site object" with properties, like there is with Exchange mailboxes. Therefore, the *Path* property is stamped on the document and contains the URL of the site where the document is located. As a result, a *Site* filter is considered a content filter and not a content location filter.
 -  Organizations must create a search permissions filter to explicitly prevent users from searching content locations in a specific service (such as preventing a user from searching any Exchange mailbox or any SharePoint site). In other words, creating a search permissions filter that allows a user to search all SharePoint sites in the organization doesn't prevent that user from searching mailboxes.
    
    For example, to allow SharePoint admins to only search SharePoint sites, you must create a filter that prevents them from searching mailboxes. Similarly, to allow Exchange admins to only search mailboxes, you must create a filter that prevents them from searching sites.

### Users

The *Users* parameter specifies the users who get this filter applied to their searches. Users can be identified by their alias or primary SMTP address. You can specify multiple values separated by commas. You can also assign the filter to all users by using the value **All**.

You can also use the *Users* parameter to specify a compliance portal role group. By doing so, you can create a custom role group and then assign that role group a search permissions filter.

For example, let's say you have a custom role group for eDiscovery managers for the U.S. subsidiary of a multi-national corporation. You can use the *Users* parameter to specify this role group (by using the Name property of the role group). You can then use the *Filter* parameter to allow only mailboxes in the U.S. to be searched. You can't specify distribution groups with this parameter.\|

### Examples of creating search permissions filters

This section provides examples of using the **New-ComplianceSecurityFilter** cmdlet to create a search permissions filter.

This example allows members of the "US Discovery Managers" role group to search only the mailboxes and OneDrive accounts in the United States.

```powershell
New-ComplianceSecurityFilter -FilterName USDiscoveryManagers -Users "US Discovery Managers" -Filters "Mailbox_CountryOrRegion -eq 'United States'"
```

This example allows the user "annb@contoso.com" to perform search actions only for mailboxes and OneDrive accounts in Canada. This filter contains the three-digit numeric country code for Canada from ISO 3166-1.

```powershell
New-ComplianceSecurityFilter -FilterName CountryFilter -Users annb@contoso.com -Filters "Mailbox_CountryCode -eq '124'"
```

This example allows the users "donh" and "suzanf" to search only the mailboxes and OneDrive accounts that have the value 'Marketing' for the CustomAttribute1 mailbox property.

```powershell
New-ComplianceSecurityFilter -FilterName MarketingFilter -Users donh,suzanf -Filters "Mailbox_CustomAttribute1 -eq 'Marketing'"
```

This example allows members of the "Fourth Coffee eDiscovery Managers" role group to search only the mailboxes and OneDrive accounts that have the value 'FourthCoffee' for the Department mailbox property. The filter also allows the role group members to search for documents in the Fourth Coffee SharePoint site.

```powershell
New-ComplianceSecurityFilter -FilterName "Fourth Coffee Security Filter" -Users "Fourth Coffee eDiscovery Managers", "Fourth Coffee Investigators" -Filters "Mailbox_Department -eq 'FourthCoffee'", "SiteContent_Path -like 'https://contoso.sharepoint.com/sites/FourthCoffee' -or SiteContent_Path -like 'https://contoso-my.sharepoint.com/personal'"
```

> [!NOTE]
> In the previous example, an extra site content filter (SiteContent\_Path -like 'https://contoso-my.sharepoint.com/personal') has to be included so that role group members can search for documents in OneDrive accounts. If this filter isn't included, the filter would only allow role group members to search for documents located in https://contoso.sharepoint.com/sites/FourthCoffee.

This example allows members of the eDiscovery Manager role group to search only the mailboxes and OneDrive accounts of members of the Ottawa Users distribution group. The Get-DistributionGroup cmdlet in Exchange Online PowerShell is used to find the members of the Ottawa Users group.

```powershell
$DG = Get-DistributionGroup "Ottawa Users"
```

```powershell
New-ComplianceSecurityFilter -FilterName DGFilter -Users eDiscoveryManager -Filters "Mailbox_MemberOfGroup -eq '$($DG.DistinguishedName)'"
```

This example prevents any user from performing search actions on the mailboxes and OneDrive accounts of members of the Executive Team distribution group. That means users can delete content from these mailboxes. The Get-DistributionGroup cmdlet in Exchange Online PowerShell is used to find the members of the Executive Team group.

```powershell
$DG = Get-DistributionGroup "Executive Team"
```

```powershell
New-ComplianceSecurityFilter -FilterName NoExecutivesPreview -Users All -Filters "Mailbox_MemberOfGroup -ne '$($DG.DistinguishedName)'"
```

This example allows members of the OneDrive eDiscovery Managers custom role group to only search for content in OneDrive accounts in the organization.

```powershell
New-ComplianceSecurityFilter -FilterName OneDriveOnly -Users "OneDrive eDiscovery Managers" -Filters "SiteContent_Path -like 'https://contoso-my.sharepoint.com/personal'"
```

This example restricts the user to performing search actions only on email messages sent during the calendar year 2020.

```powershell
New-ComplianceSecurityFilter -FilterName EmailDateRestrictionFilter -Users donh@contoso.com -Filters "MailboxContent_Received -ge '01-01-2020' -and MailboxContent_Received -le '12-31-2020'"
```

Similar to the previous example, this example restricts the user to performing search actions only on documents that were last changed sometime in the calendar year 2020.

```powershell
New-ComplianceSecurityFilter -FilterName DocumentDateRestrictionFilter -Users donh@contoso.com -Filters "SiteContent_LastModifiedTime -ge '01-01-2020' -and SiteContent_LastModifiedTime -le '12-31-2020'"
```

This example prevents members of the "OneDrive Discovery Managers" role group from performing search actions on any mailbox in the organization.

```powershell
New-ComplianceSecurityFilter -FilterName NoEXO -Users "OneDrive Discovery Managers" -Filters "Mailbox_Alias -notlike '*'"
```

This example prevents anyone in the organization from performing search actions on email messages that were sent or received by "janets" or "sarad".

```powershell
New-ComplianceSecurityFilter -FilterName NoSaraJanet -Users All -Filters "MailboxContent_Participants -notlike 'janets@contoso.onmicrosoft.com' -and MailboxContent_Participants -notlike 'sarad@contoso.onmicrosoft.com'"
```

This example uses a filters list to combine mailbox and site filters. In this example, the mailbox filter is a content location filter and the site filter is a content filter.

```powershell
New-ComplianceSecurityFilter -FilterName "Coho Winery Security Filter" -Users "Coho Winery eDiscovery Managers", "Coho Winery Investigators" -Filters "Mailbox_Department -eq 'CohoWinery'", "SiteContent_Path -like 'https://contoso.sharepoint.com/sites/CohoWinery'"
```

## Knowledge check

Choose the best response for the following question. Then select “Check your answers.”