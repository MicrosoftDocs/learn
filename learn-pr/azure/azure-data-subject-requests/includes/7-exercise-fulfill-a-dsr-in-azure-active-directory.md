You're the administrator for Contoso, Ltd. You’ve been asked to evaluate the DSR process in the Microsoft cloud. You've created a use-case scenario for fulfilling a DSR.

## Setup
<!-- ID/SME: We always need sentences introducing bulleted or numbered lists. Please add one here, explaining what the following steps are for. -->
1. Sign in to the [Azure Active Directory portal](https://aad.portal.azure.com).<!-- ID/SME: This link takes me to the Azure Active Directory admin center, not the portal. -->
2. Select **Azure Active Directory**, and then select the **Overview** blade if it's not already active.  
3. In the **Tenant information** tile for the Default Directory, copy or record the **Primary domain** value (for example, yourprimarydomain.onmicrosoft.com).
4. Select **Users**, select **New User**, and then verify that the **Create user** option is selected.
5. Enter the following information, and then select **Create**:
   - User name: **Avery@yourprimarydomain.onmicrosoft.com**
   - Name: **Avery Howard**
   - First name: **Avery**
   - Last name: **Howard**
   - Password: **Auto-generate password**
   - Block sign in: **No**
   - Usage location: **United Kingdom**
   - Job title: **B2C**
   - Department: **Finance**
   - Company name: **Contoso**
6. Select **Avery Howard** from the user list to review the user's properties.
7. Select **Edit**.
8. Use the following information to modify Avery's personal information, and then select **Save**:
   - Street Address: **123 Park Square**
   - State or province: **Bristol**
   - Country or region: **United Kingdom**
   - ZIP or postal code: **BS12 3CD**
   - Mobile phone: **+44 07123 456789**

## Review a DSR and determine the appropriate process
<!-- ID/SME: We always need sentences introducing bulleted or numbered lists. Please add one here, explaining what the following steps are for. -->
1. Review a DSR:
   - DSR form received today
   - Identity verified today
     - Avery Howard is a financial planning client who resides in the United Kingdom.
     - Avery was contacted and provided verification with a national ID card.

|||
|---|---|
|Subject's name|Avery Howard|
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
> In this exercise, the first step you’ll use is discover, and the next step is delete.

## Use the Azure Active Directory admin center to connect to Azure AD

You'll now use the Azure Active Directory admin center to discover the personal information in Azure AD:

1. Verify that you're still signed in to the Azure Active Directory admin center.
1. Select **Azure Active Directory**, select **Users**, and then select the **All users** blade if it's not already active.  
1. Select **Search users**, and then enter **Avery**.  
1. Select **Avery Howard** to review the data subject's profile.
1. Review and confirm that the personal information contained in the profile matches the subject's information in the DSR.

## Fulfill the DSR

You'll now fulfill the DSR by deleting the data subject's user account:

1. In the **All users** blade, select the data subject's user account (Avery Howard) check box.  
2. Select **Delete user**, and then select **Yes** to confirm.
3. Select **Deleted users**.
1. In the **Deleted users** blade, select the data subject's user account check box.
1. Select **Delete permanently**, and then select **Yes** to confirm.

## Results

After completing this exercise, you should have successfully reviewed and fulfilled a DSR for customer data in Azure. This meets your requirement to validate the DSR process in Azure.

## Clean up the resources

> [!NOTE]
> If you’ve completed all the steps in this exercise, you won’t have any resources that need cleaning up. However, if you’ve only partially completed the exercise, then complete the following steps:

1. In the Azure Active Directory admin center, select **All Users**.
3. Search for and select **Avery Howard**.
4. Select **Delete user**, and then select **Yes** to confirm.
5. Select **Deleted users**.
1. In the **Deleted users** blade, select the data subject's user account check box.
1. Select **Delete permanently**, and then select **Yes** to confirm.
