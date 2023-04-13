With Azure Active Directory (Azure AD) entitlement management, you can collaborate with people outside your organization. If you frequently collaborate with users in an external Azure AD directory or domain, you can add them as a connected organization. This article describes how to add a connected organization so that you can allow users outside your organization to request resources in your directory.

## What is a connected organization?

A connected organization is another organization that you have a relationship with. In order for the users in that organization to be able to access your resources, such as your SharePoint Online sites or apps, you'll need a representation of that organization's users in that directory. Because in most cases the users in that organization aren't already in your Azure AD directory, you can use entitlement management to bring them into your Azure AD directory as needed.

There are three ways that entitlement management lets you specify the users that form a connected organization. It could be

 -  users in another Azure AD directory (from any Microsoft cloud),
 -  users in another non-Azure AD directory that has been configured for direct federation, or
 -  users in another non-Azure AD directory, whose email addresses all have the same domain name in common.

## Add a connected organization

To add an external Azure AD directory or domain as a connected organization, follow the instructions in this section. **Prerequisite role:** Global administrator, Identity Governance administrator, or User administrator

1. In the **Azure portal**, select **Azure Active Directory**, and then select **Identity Governance**.
1. In the left pane, select **Connected organizations**, and then select **+ Add connected organization**.
1. Select the **Basics** tab, and then enter a display name and description for the organization.
    
    
     -  The state will automatically be set to Configured when you create a new connected organization. For more information about state properties, see State properties of connected organizations
1. Select the **Directory + domain** tab, and then select **Add directory + domain**.
    
    
     -  The Select directories + domains pane opens.
1. In the search box, enter a domain name to search for the Azure AD directory or domain. Be sure to enter the entire domain name.
    
    
     -  Confirm that the organization name and authentication type are correct.
1. Select **Add** to add the Azure AD directory or domain. Currently, you can add only one Azure AD directory or domain per connected organization.
1. After you've added the Azure AD directory or domain, select Select.
    
    
     -  The organization appears in the list.
1. Select the **Sponsors** tab, and then add optional sponsors for this connected organization.
    
    
     -  Sponsors are internal or external users already in your directory. Sponsors are the point of contact for the relationship with this connected organization.
     -  When you select Add/Remove, a pane opens in which you can choose internal or external sponsors. The pane displays an unfiltered list of users and groups in your directory.
1. Select the **Review + create** tab, review your organization settings, and then select **Create**.
