This guided project consists of the following exercises:

 - Create storage and upload file
 - **Create access policy and generate SAS**
 - Test partner access
 - Revoke partner access
 - Configure lifecycle management

In this exercise, you create a stored access policy on the container and generate a SAS URL from it. The stored access policy acts as a control point—if you need to revoke access later, you can delete the policy instead of tracking down individual tokens.

This exercise includes the following tasks:

 - Create a stored access policy
 - Generate a SAS from the stored access policy

**Outcome:** A stored access policy on the container and a SAS URL generated from that policy.

Instead of generating a one-off SAS token with its own permissions and expiry, you'll create a **stored access policy** first. A stored access policy defines the rules (permissions and expiry) at the container level. Any SAS token generated from that policy inherits those rules—and if you delete the policy later, every SAS token linked to it is instantly revoked. This is the enterprise approach to SAS management.

## Task 1: Create a stored access policy

Define a reusable access policy on the container that controls what SAS tokens can do and when they expire.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select the storage account you created (for example, **stgpfilexchg**).
3.  In the left menu, under **Data storage**, select **Containers**.
4.  Select the **partner-drop** container.
5.  In the left menu, under **Settings**, select **Access policy**.
6.  Under **Stored access policies**, select **+ Add policy**.
7.  For **Identifier**, enter **partner-read-policy**.
8.  For **Permissions**, select **Read** only.
9.  For **Start time**, set the date to today's date. The time defaults to 12:00:00 AM, which means the policy is effective immediately.
10. For **Expiry time**, set it to 1 hour from now.
11. Select **OK**.
12. Select **Save** at the top of the page.

> [!IMPORTANT]
> You must select **Save** after adding the policy. If you navigate away without saving, the policy won't be created.

> [!NOTE]
> **Validation step:** Confirm **partner-read-policy** appears in the stored access policies list with **Read** permission.

## Task 2: Generate a SAS from the stored access policy

Now generate a SAS token that inherits its rules from the policy you just created.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select your storage account (for example, **stgpfilexchg**).
3.  In the left menu, under **Data storage**, select **Containers**.
4.  Select the **partner-drop** container.
5.  Select **monthly-report.txt** to open the blob settings.
6.  Select **Generate SAS**.
7.  For **Stored access policy**, select **partner-read-policy** from the dropdown.
8.  Select **Generate SAS token and URL**.
9.  Copy the **Blob SAS URL** and save it securely. You'll use this URL in the next exercise.

> [!NOTE]
> Notice that the **Permissions** and **Expiry** fields are grayed out—they're controlled by the policy, not set individually. This is the key advantage: all tokens share the same rules, and revoking the policy revokes them all.

> [!NOTE]
> **Validation step:** Confirm the SAS URL is generated and the permissions came from the stored access policy.