While DLP policies in the Microsoft 365 Compliance center protect data in Microsoft 365 services from being shared, DLP policies in Power Platform are used to restrict the communication between connectors. A connector in Power Platform is a wrapper or an API that allows predefined triggers and actions to access the data behind it.

1. There are three groups you can use to categorize your connectors:

| **Category**| **Actions**|
| :--- | :--- |
| Business| Allows connections only to other connectors in the business group|
| Non-Business| Allows connections only to other connectors in the non-business group|
| Blocked| Blocks any connection attempts to these connectors|

Connectors can reside in only one group at a time. For example, the SharePoint Online connector can only be part of the business group or the non-business group and not both at the same time. By moving the SharePoint Online and another 3rd party connector to the Business group, you're preventing users from creating flows and apps that combine these two connectors with any of the connectors in the Non-Business or Blocked groups without affecting the existing workflows that use both SharePoint Online connectors.

There is no specification as to the type of data you can share over the connector. For example, if you access a SharePoint Online connector you can access the content of a library no matter what is placed in that library.

To protect data in your organization, you can use PowerApps to create and enforce policies that define the consumer connectors for which specific business data can be shared. These DLP policies ensure that data is managed in a uniform manner across your organization, and they prevent important business data from being accidentally published to connectors such as social media sites.

While the blocked group exists, not all Connectors can be added to the blocked group. In this case the Block action will be greyed, and a warning will appear.

> [!NOTE]
> If you select the blocked group as default, all new blockable connectors will be blocked by default and unblockable connectors will be added to the non-business group.
An environment is a space to store, manage, and share your organization's business data, apps, and flows. It also serves as a container to separate apps that may have different roles, security requirements, or target audiences.

Tenant-level policies can be defined to include or exclude specific environments. To follow the steps described here for tenant-level policies, one of the following permissions is required:

- Power Platform admin permissions

- Microsoft 365 Global admin permissions

To create environment-level policies, you need to have Power Apps Environment Admin permissions.

If you want to create a DLP Policy to deny connectivity between SharePoint Online and non-business apps using Power Platform admin center, follow these steps:

1. In Power Platform admin center, select **Data policies**, and then select **+** **New policy**.

1. Enter a policy name, and then select **Next**.

1. Review the various attributes and settings you can make on the **Assign Connectors** page.

1. Select **SharePoint** connector, and then select **Move to Business** button from the top menu bar. You can also use the ellipsis (three dots) to the right of the connector name.

1. After you've completed all the connector assignment across the **Business**/**Non-Business**/**Blocked** groups, select **Next**.

1. On the Define scope page, you can choose the environments to add to this policy. Select **Exclude certain environments** and select **Next**.

1. On the **Add Environments** page, for tenant-level policies, the list will show the tenant-level admin all the environments in the tenant. For environment-level policies, this list will only show the subset of environments in the tenant that are managed by the user who has signed in as an environment admin. Select the environments you want to include in the policy and add them to the policy scope by using **Add to policy** from the top menu bar. Then select **Next**.

1. On the Review and create policy page you can review all settings. Select **Create Policy**.

1. Or you can use the PowerApps PowerShell module using the **New-DlpPolicy** cmdlet to create a DLP policy for Power Platform.

