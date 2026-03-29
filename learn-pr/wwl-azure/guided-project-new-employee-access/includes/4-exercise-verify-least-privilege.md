This guided project consists of the following exercises:

 - Create user and group
 - Assign RBAC role at scope
 - **Verify least-privilege model**

In this exercise, you validate the access model you built by checking permissions with IAM, reviewing the audit trail, and signing in as the new user to experience the Reader role firsthand. This is where you confirm that least-privilege access is working exactly as intended.

This exercise includes the following tasks:

 - Check access with IAM
 - Review the role assignment in the Activity Log
 - Enable Temporary Access Pass
 - Generate a Temporary Access Pass for Alex
 - Sign in as Alex and test permissions

**Outcome:** Validation that read access is granted and write access is not granted.

## Task 1: Check access with IAM

Use the Check access feature to preview what permissions the new user has at the resource group scope. This powerful validation tool shows you exactly what actions are allowed and denied.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-access-model** from the list.
3.  In the left menu, select **Access control (IAM)**.
4.  Select **Check access**.
5.  Search for and select **Alex Guided Project** (the user account you created earlier).
6.  Confirm the results show a **Reader** role assignment inherited through the **gp-rg-readers** group.

> [!NOTE]
> **Validation step:** Confirm Check access shows the **Reader** role inherited from the **gp-rg-readers** group.

## Task 2: Review the role assignment in the Activity Log

Check the Activity Log to see the audit trail of the role assignment you created. Every RBAC change in Azure is recorded, which is critical for security auditing and compliance.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-access-model** from the list.
3.  In the left menu, select **Activity log**.
3.  Look for an entry with **Operation name** of **Create role assignment**.
4.  Select the entry to view the details, including who made the change, when it happened, and what role was assigned.
5.  Note the **Event initiated by** field, which shows your account as the person who created the assignment.

> [!NOTE]
> **Validation step:** Confirm the Activity Log shows a **Create role assignment** entry with your account in the **Event initiated by** field.

## Task 3: Enable Temporary Access Pass

Enable Temporary Access Pass (TAP) as an authentication method for your tenant. TAP is a time-limited passcode that satisfies MFA requirements, so the test account can sign in without setting up a phone or authenticator app.

1.  In the portal search bar, search for **Authentication methods** and select **Authentication methods** (under Microsoft Entra ID).
2.  Select **Policies**.
3.  Select **Temporary Access Pass**.
4.  Set **Enable** to **Yes**.
5.  Under **Target**, select **All users** or select **Add groups** and add **gp-rg-readers**.
6.  Select **Save**.

> [!NOTE]
> **Validation step:** Confirm Temporary Access Pass is enabled before proceeding.

## Task 4: Generate a Temporary Access Pass for Alex

Create a TAP for Alex. This one-time passcode lets Alex sign in to the portal without MFA setup.

1.  In the portal search bar, search for **Microsoft Entra ID** and select **Microsoft Entra ID**.
2.  In the left menu under **Manage**, select **Users**.
3.  Select **Alex Guided Project** (click the name, not the checkbox).
4.  In the left menu, select **Authentication methods**.
5.  Select **+ Add authentication method**.
6.  For **Choose method**, select **Temporary Access Pass**.
7.  Leave the defaults (1 hour lifetime, one-time use) and select **Add**.
8.  Copy the **Temporary Access Pass** code that appears and save it—this is the only time you can see it.

> [!NOTE]
> **Validation step:** Confirm the TAP code is generated and saved. You need it for the next task.

## Task 5: Sign in as Alex and test permissions

Sign in as Alex to experience the Reader role firsthand. This is the strongest validation—you see exactly what Alex can and cannot do in the portal.

1.  Open a new **InPrivate** (Edge) or **Incognito** (Chrome) browser window.
2.  Go to [https://portal.azure.com](https://portal.azure.com).
3.  Enter the user principal name you recorded earlier (for example, **alexgp@yourtenant.onmicrosoft.com**).
4.  If the password field appears, select **Sign-in options** or **Use a Temporary Access Pass** to switch to the TAP input.
5.  Paste the **Temporary Access Pass** code and select **Sign in**.
6.  When prompted to update your password, create a new password and select **Sign in**.
6.  After signing in, search for **Resource groups** in the portal search bar and select **Resource groups**.
7.  Select **rg-gp-access-model** from the list. Confirm you can view the resource group and its resources—this proves read access works.
8.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
9.  Select **+ Create**.
10. On the **Basics** tab, select **rg-gp-access-model** as the resource group.
11. For **Storage account name**, enter any name (for example, **stgptestperm** followed by your initials).
12. For **Region**, use the same region as the resource group.
13. For **Preferred Storage Type**, select **Azure Blob Storage or Azure Data Lake Storage Gen 2**.
14. For **Performance**, select **Standard**.
15. For **Redundancy**, select **Locally-redundant storage (LRS)**.
16. Select **Review + create**.
16. Confirm the creation fails with a permissions error—Alex has Reader access only and cannot create resources.
13. Close the InPrivate/Incognito window and return to your main browser session.

> [!NOTE]
> **Validation step:** Confirm that Alex can view resources in **rg-gp-access-model** but cannot create new resources. This proves the least-privilege model is working.
