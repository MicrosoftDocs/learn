You are the administrator for Contoso, Ltd. You’ve been asked to evaluate the DSR process in the Microsoft cloud. You have created a use-case scenario for fulfilling a DSR.

## Setup

1. Sign into the [Azure Active Directory portal](https://aad.portal.azure.com).
2. Select **Azure Active Directory**, and then select the **Overview** blade if it's not already active.  
3. In the **Tenant information** tile for the Default Directory, copy or record the **Primary domain** value (for example, yourprimarydomain.onmicrosoft.com).
4. Download [datasubject01.csv](https://github.com/RichardLuckett/learn-pr/blob/NEW-azure-data-subject-requests/learn-pr/azure/azure-data-subject-requests/media/DataSubject01.csv).<!--Richard: this is not a link we can use-->.
5. Using Excel or Notepad, open the **datasubject01.csv** file, and then edit the **User name [userPrincipalName] Required** field for Avery. Replace **@contoso.com** with the primary domain value that you copied earlier in step 2 (**@_yourprimarydomain_.onmicrosoft.com**).

> [!IMPORTANT]
> The next step will fail if you don't use a valid domain name from your Azure AD. Optionally, you can search and replace @contoso.com with @yourprimarydomain.onmicrosoft.com in the file.

6. Save and close the file.
1. Select **All Services**, and then select **Users**.
1. In the **Bulk operations** list, select **Bulk create**.
1. In the **Bulk create user** dialog box, select **Select a file**.  
1. In the **Open** dialog box, navigate to the path where datasubject01.csv was downloaded<!--Richard: this might need an update-->, select **datasubject01.csv**, and then select **Open**.
1. Select **Submit**, and then verify that the creation was successful.
1. Close the confirmation.

## Review a DSR and determine appropriate process

1. Review DSR:
   - DSR form received today
   - Identity verified today
     - Avery Howard is a financial planning client, who resides in the United Kingdom.
     - Avery was contacted and was able to provide national ID card verification.

|||
|---|---|
|Subject's Name|Avery Howard|
|Date of Birth|11-18-1999|
|Address|123 Park Square, Bristol, BS12 3CD, UNITED KINGDOM|
|Telephone|+44 07123 456789|
|Email|avery@_yourprimarydomain_.microsoftonline.com|
|With regard to|Right to erasure (right to be forgotten)|
|Preferred feedback method|In writing to address|

2. Identify which of the following steps you’ll use in the DSR process, and then fulfill the DSR:
    - Discover
    - Access
    - Rectify
    - Restrict
    - Delete
    - Export / Receive

> [!NOTE]
> The first step you’ll use is Discover and the next step is Delete.

## Use the Azure Active Directory admin center to connect to Azure AD

You'll now use the Azure Active Directory admin center to discover the personal information in Azure AD:

1. Verify that you're still signed into the Azure Active Directory admin center.
1. Select **Azure Active Directory**, select **Users**, and then select the **All users** blade if it's not already active.  
1. Select **Search users**, and then enter **Avery**.  
1. Select **Avery Howard** to review the data subject's profile.
1. Review and confirm that the personal information contained in the profile matches the subject's information in the DSR.

## Fulfill DSR

You'll now fulfill the DSR by deleting the data subject's user account:

1. In the **All users** blade, select the data subject's user account (Avery Howard) check box.  
2. Select **Delete user**, and then select **Yes** to confirm.
3. Select **Deleted users**.
1. In the **Deleted users** blade, select the data subject's user account check box.
1. Select **Delete permanently**, and then select **Yes** to confirm.

## Results

After completing this exercise, you'll have successfully reviewed and fulfilled a DSR for customer data in Azure. This meets your requirement to validate the DSR process in Azure.

## Clean up the resources

> [!NOTE]
> If you’ve completed all the steps in this exercise, you won’t have any resources that you need to clean up. However, if you’ve only partially completed the exercise, then complete the following steps:

1. In the Azure Active Directory admin center, select **All Users**.
3. Search for and select **Avery Howard**.
4. Select **Delete user**, and then select **Yes** to confirm.
5. Select **Deleted users**.
1. In the **Deleted users** blade, select the data subject's user account check box.
1. Select **Delete permanently**, and then select **Yes** to confirm.
