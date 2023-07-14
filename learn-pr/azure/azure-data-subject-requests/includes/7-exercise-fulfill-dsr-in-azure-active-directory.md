As Contoso’s administrator, you must evaluate the DSR process in the Microsoft Cloud. You plan to create a use-case scenario for responding to a DSR that requests Microsoft Cloud-based data be deleted.

> [!Note]
> If you choose to perform the exercise in this module, be aware you might incur costs in your Azure Subscription. To estimate the cost, refer to [Azure Pricing](https://azure.microsoft.com/pricing/calculator/).

In this exercise you will complete the following tasks:
- Task 1: Create a user
- Task 2: Review the DSR to determine the appropriate process
- Task 3: Locate and verify the personal information of the DSR in Azure AD
- Task 4: Fulfill the DSR by deleting the relevant data
- Task 5: Clean up resources

## Task 1: Create a user

To set up a new user, perform the following steps:

1. Sign in to the [Azure Active Directory portal](https://aad.portal.azure.com).
2. Select **Azure Active Directory**, and then select the **Overview** blade if it's not already active.  
3. In the **Tenant information** tile for the Default Directory, copy or record the **Primary domain** value (for example, yourprimarydomain.onmicrosoft.com).
4. Select **Users**, select **New User**, and then verify that the **Create user** option is selected in the **New User** blade.
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

## Task 2: Review the DSR to determine the appropriate process

To determine the appropriate process, perform the following steps:

1. Review the DSR:
In this task, we'll step through a scenario where we receive a DSR from a user, then identify the steps we need to perform in order to fulfill that request. There are no actual tasks to complete other than become familiar with the processes and steps involved.

   - DSR form received today
   - Identity verified today, as follows
     - Avery Howard is a financial planning client who resides in the United Kingdom.
     - Avery was contacted, and they provided verification with a national/regional ID card.

    |Field|Details|
    |---|---|
    |Subject's name|Avery Howard|
    |Date of Birth|11-18-1999|
    |Address|123 Park Square, Bristol, BS12 3CD, UNITED KINGDOM|
    |Telephone|+44 07123 456789|
    |Email|avery@_yourprimarydomain_.microsoftonline.com|
    |With regard to|Right to erasure (right to be forgotten)|
    |Preferred feedback method|In writing to address|

1. Now that you’ve confirmed the user’s request to delete, first search for (discover) the user in Azure AD, then delete the user. Identify which of the following steps you’ll use in the DSR process, and then fulfill the DSR:
    - Discover
    - Access
    - Rectify
    - Restrict
    - Delete
    - Export/Receive

> [!NOTE]
> In this exercise, the first step you’ll use is discover, and the next step is delete.

## Task 3: Locate and verify the personal information of the DSR in Azure AD

You'll now use the Azure Active Directory admin center to find personal information in Azure AD:

1. Verify that you're still signed in to the Azure Active Directory admin center.
1. Select **Azure Active Directory**, select **Users**, and then select the **All users** blade if it's not already active.  
1. Select **Search users**, and then enter **Avery**.  
1. Select **Avery Howard** to review the data subject's profile.
1. Review and confirm that the personal information contained in the profile matches the subject's information in the DSR.

## Task 4: Fulfill the DSR by deleting the relevant data

You'll now respond to  the DSR by deleting the data subject's user account:

1. In the **All users** blade, select the check box for the data subject's user account (Avery Howard).  
1. Select **Delete**, and then select **Yes** to confirm.
1. Select **Deleted users**.
1. In the **Deleted users** blade, select the data subject's user account check box.
1. Select **Delete permanently**, and then select **Yes** to confirm.

## Task 5: Clean up resources

> [!NOTE]
> Your Azure subscription may incur some costs if you do not delete all the resources created during this exercise.

If you’ve completed all the steps in this exercise, you won’t have any resources to clean up. However, if you’ve only partially completed the exercise, complete the following steps:

1. In the Azure Active Directory admin center, select **All Users**.
1. Search for and select **Avery Howard**.
1. Select **Delete**, and then select **Yes** to confirm.
1. Select **Deleted users**.
1. In the **Deleted users** blade, select the data subject's user account check box.
1. Select **Delete permanently**, and then select **Yes** to confirm.

Congratulations! In this exercise, you've successfully reviewed and responded to a DSR for Azure-based customer data. This meets your requirement to validate the DSR process in Azure.
