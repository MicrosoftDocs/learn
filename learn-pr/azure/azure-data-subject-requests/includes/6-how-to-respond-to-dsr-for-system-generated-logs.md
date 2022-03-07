The definition of personal data can be broadly interpreted. Therefore, Microsoft-generated logs could contain data that's deemed personal. System-generated logs are an integral part of Microsoft cloud services. However, you can't restrict or rectify data in these logs because it compromises their integrity. Instead, only the tenant administrator can administer an enterprise customer’s DSRs for system-generated logs.

## Azure and Office 365 DSR scenarios for system-generated logs

Microsoft supports the following DSRs for system-generated logs:

- Access 
- Delete
- Export 

Data that can be derived from system-generated logs includes:

- Product and service usage data (user activity logs).
- User search requests and query data.
- Data that products and services generate when a user interacts with system functionality.

### Example 1: Responding to a DSR for Azure-based system-generated logs

A Contoso customer residing in Spain submitted a DSR form through the corporate website. They’re requesting a copy of their personal data that's stored in system-generated logs. To respond to the DSR, take the following steps:

1. The tenant administrator can then use the Azure portal to create an export request:

    1. Sign into the Azure portal.
    1. Select **All services**, and then select **Policy**.
    1. In the **Policy blade**, select **User privacy**, select **Manage User Requests**, and then select **Add export request**.
    1. On the **New export data request** form, provide the following details, and then select **Create**:

      - User
      - Subscription
      - Storage account
      - Container

2. The tenant administrator can export the data, and then send the file to the data subject.

> [!NOTE]
> Personal data can come from the system-generated logs in multiple systems. This can cause the export process to take as long as a month to complete.

### Example 2: Responding to a DSR for Office 365 and Microsoft 365 system-generated logs

One of Contoso's customers who resides in The Netherlands has submitted a DSR form through the corporate website. They’re requesting the deletion of their personal data stored in system-generated logs. To respond to the DSR, take the following steps:

1. Sign into the Azure portal.
1. Navigate to Azure AD, and then select **Users**.
1. In the **All users** blade, select the check box for the data subject's user account.
1. Select **Delete user**, and then select **Yes** to confirm.
1. In the **Deleted users** blade, select the data subject's user account check box.
1. Select **Delete permanently**, and then select **Yes** to confirm.

> [!NOTE]
> In Example two, you used the same process that you used to respond to delete requests for Azure-based personal data. The user’s personal data in the system-generated logs is deleted, as is their user account, providing it doesn’t negatively impact the security or integrity of any Microsoft cloud service. This usually happens within 30 days of the user account’s deletion.
>
> The exception to this 30-day period is with respect to a user's Exchange Online mailbox. To prevent accidental data loss, Exchange Online places data in a holding state for up to 60 days after permanent user-account deletion. You’ll need to contact Microsoft Support if the mailbox data must be removed earlier than the 60-day timeline.

### National clouds

If Contoso had a global presence in one or more national clouds and someone made a DSR export request for system-generated logs, their tenant admin can complete the following steps.

|National cloud|Export steps|
|---|---|
|Office 365 Germany|Same process as Office 365 cloud.|
|Office 365 US Government|Use the Microsoft 365 admin center to submit a request to Microsoft Support|
|Office 365 operated by 21Vianet (China)|Access the Microsoft 365 admin center operated by 21Vianet admin portal. Select **Commerce**, select **Subscription**, select **Privacy**, select **GDPR**, and then enter the required information.|

## Tools used for DSR for system-generated logs

The following table lists tools that you can use for fulfilling DSRs for system-generated logs in the Microsoft Cloud.

|Tool name|Description|
|------|------|
|Microsoft Data Log Export|Tenant administrators can export system-generated logs by using the Microsoft Data Log Export.|
|User Privacy|Located in the **Policy** blade in the Azure portal, you can use this tool to access and export system-generated logs in Office 365.|
|Azure AD Admin Center|You can delete a data subject from Azure AD and its system-generated logs.|
