## What are terms of use for Entitlement Management

:::image type="content" source="../media/terms-of-use-entitlement.png" alt-text="Screenshot of terms of use settings. You can set Name, Display Name, link to a PDF document with the terms, and some settings to ensure the user sees the terms of use.":::

Microsoft Entra terms of use policies use the PDF format to present content. The PDF file can be any content, such as existing contract documents, allowing you to collect end-user agreements during user sign-in. To support users on mobile devices, the recommended font size in the PDF is 24 point. Remember that terms of use PDF documents can contain an End User License Agreement (EULA). The user has to commit to before access resources based on their entitlement settings.

## Add terms of use

Once you finalize your terms of use document, use the following procedure to add it.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a Global administrator.
2. Open **ID Governance**.
3. In the left navigation menu open Entitlement Management, then under **Terms of use**, select **Terms of use**.
4. On the Terms of use page, on the top menu, select **+ New terms**.
    
   :::image type="content" source="../media/new-terms-of-use.png" alt-text="Screenshot of the Terms of use page with New terms highlighted.  Update the terms of use as needed.":::
    
5. In the **Name** box, enter **Testing terms of use**. Set the name the terms-of-use in the admin center.
6. In the **Display name** box, enter **Contoso Terms of Use**. The title that users see when they sign-in.
7. Select the **Terms of use document box**, browse to your finalized terms of use PDF, and select it. For this exercise, you can choose any PDF you have. Another option is use Microsoft Word to create the terms of use doc and then save as PDF.
8. Select the language for your terms of use document. The language option allows you to upload multiple terms of use, each with a different language. The version of the terms of use that an end user sees, is based on their browser preferences.
9. To require end users to view the terms of use before accepting them, set **Require users to expand the terms of use** to **On**.
10. To require end users to accept your terms of use on every device they're accessing from, set **Require users to consent on every device** to **On**. Users are required to install other applications if this option is enabled.
    
   > [!WARNING]
   > Consent on every device requires users to register each device with Microsoft Entra ID before getting access.

11. If you want to expire terms of use consents on a schedule, set **Expire consents** to **On**. When set to On, two extra schedule settings are displayed.
    
   :::image type="content" source="../media/new-terms-of-use-create.png" alt-text="Screenshot of the Expire consents settings to set start date, frequency, and duration.":::
    
12. Use the **Expire starting on** and **Frequency** settings to specify the schedule for terms of use expirations. The following table shows the result for a couple of example settings:
    
   | **Expire starting on** | **Frequency** | **Result**                                                                                                                                          |
   | ---------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
   | Today's date           | Monthly       | The users must accept the terms of use and then reaccept every month, starting today.                                                               |
   | Date in the future     | Monthly       | The users must accept the terms of use, starting today. When the future date occurs, consents expire and then users must reaccept every month. |
    
   For example, if you set the expire starting on date to **Jan 1** and frequency to **Monthly**, here's how expirations might occur for two users:
    
   | **User** | **First accept date** | **First expire date** | **Second expire date** | **Third expire date** |
   | -------- | --------------------- | --------------------- | ---------------------- | --------------------- |
   | Alice    | January 1             | February 1            | March 1                | April 1               |
   | Bob      | January 15            | February 1            | March 1                | April 1               |

13. Use the **Duration before reacceptance requires (days)** setting to specify the number of days before the user must reaccept the terms of use. This setting allows users to follow their own schedule. For example, if you set the duration to **30** days, here's how expirations might occur for two users:
    
   | **User** | **First accept date** | **First expire date** | **Second expire date** | **Third expire date** |
   | -------- | --------------------- | --------------------- | ---------------------- | --------------------- |
   | Alice    | January 1             | January 31            | March 2                | April 1               |
   | Bob      | January 15            | February 14           | March 16               | April 15              |

14. Under **Conditional Access**, select **Custom policy**.
    
   | **Template**                           | **Description**                                                                               |
   | -------------------------------------- | --------------------------------------------------------------------------------------------- |
   | Custom policy                          | Select the users, groups, and apps that the terms of use applies to.                  |
   | Create Conditional Access policy later | Terms of use appears in the grant control list when creating a Conditional Access policy. |

15. When complete, select **Create**.
    
   :::image type="content" source="../media/new-terms-of-use-create.png" alt-text="Screenshot of the New terms of use page with configured options highlighted.":::
    
16. When the terms of use are created, you're redirected to the Conditional Access policy page. On the page, in the **Name** box, enter **Enforce ToU**.
17. Under **Assignments**, select **Users and groups**.
18. On the include tab, select **Users and groups** check box.
19. In the Select pane, select an account you would like to use to test the terms of use policy. If you choose your administrator account, like all Conditional Access policies, be sure you have another account with enough permissions to change the Conditional Access policy. You need to ensure your administrator account isn't locked out should the Conditional Access policy result in an undesirable outcome.
20. Select **Cloud apps or actions**.
21. Select **All cloud apps**.
22. Under **Access controls**, select **Grant**.
23. In the Grant pane, select **Testing terms of use** and then select **Select**.
24. Under **Enable policy**, select **On**.
25. When complete, select **Create**.
    
   :::image type="content" source="../media/terms-of-use-conditional-access-policy.png" alt-text="Screenshot of the Conditional Access policy with configuration options highlighted.":::
    
26. If you chose to use your own account, you can refresh your browser. You're prompted to sign in again. When you sign in, you again must accept the terms of use.

## View report of who accepted and declined

The terms-of-use-screen shows a count of the users who accepted and declined. These counts and who accepted/declined are stored for the life of the terms of use.

1. In Microsoft Azure, in **Identity Governance**, then **Terms of use**, locate your terms of use.
2. For the terms of use, select the numbers under **Accepted** or **Declined** to view the current state for users.
    
   :::image type="content" source="../media/terms-of-use-accept-decline.png" alt-text="Screenshot of the terms of use with the Accepted and Declined columns highlighted.":::
    
3. In this exercise, you might not have any accepted or declined terms of use. In the following example, the **Accepted** value was selected. You can see the reported user information for those that accepted the terms of use.
    
   :::image type="content" source="../media/accepted-terms-of-use.png" alt-text="Screenshot of the Terms of use consents pane listing the users that accepted.":::
    
4. To view the history for an individual user, select the ellipsis to the right of the user name and then **View History**.
    
   :::image type="content" source="../media/view-history-menu.png" alt-text="Screenshot of the View History context menu for a user.  Have a look at the user's actions with the package.":::
    
5. In the view history pane, you see a history of all the accepts, declines, and expirations.
    
   :::image type="content" source="../media/view-history-pane.png" alt-text="Screenshot of the View History pane lists the history accepts, declines, and expirations for a user.":::

## What terms of use look like for users

1. Once the terms of use are created and enforced, users who are in scope see the terms of use page.

   :::image type="content" source="../media/user-terms-of-use.png" alt-text="Screenshot of an Example terms of use that appears when a user connects to the system and gets their entitlement package.":::
    
2. Users can view the terms of use and, if necessary, use buttons to zoom in and out.
    
   :::image type="content" source="../media/zoom-buttons.png" alt-text="Screenshot of the View of terms of use with zoom buttons, in case the user need more detail in viewing.":::
    
3. On mobile devices, the terms of use display similar to the following example.
    
   :::image type="content" source="../media/mobile-terms-of-use.png" alt-text="Screenshot of an Example terms of use that appears when a user signs in on a mobile device.":::

### How users can review their terms of use

Users can review and see the terms of use that they accepted by using the following procedure.

1. Browse to [https://myaccount.microsoft.com](https://myapps.microsoft.com/) and then sign in using your user account.
2. On the Overview page, select VIEW SETTINGS AND PRIVACY.
    
   :::image type="content" source="../media/my-account-settings-privacy.png" alt-text="Screenshot of a popup, which says View settings and privacy. So the user see data used and shared.":::
    
3. On the Settings and Privacy page, select the **Privacy** tab.
    
   :::image type="content" source="../media/my-account-settings-privacy-organization-notes.png" alt-text="Screenshot of the settings and privacy page with organization notice highlighted. The terms of use are enforced.":::
    
4. Under **Organization’s notice**, you can review the terms of use you accepted.

## Edit terms of use details

You can edit some details of terms of use, but you can't modify an existing document. The following procedure describes how to edit the details.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a Global administrator.
2. Open ID Governance and the select **Entitlement management**.
3. In the left navigation menu, under **Terms of use**, select **Terms of use**.
4. Select the terms of use you want to edit.
5. On the top menu, select **Edit terms**.
6. In the Edit terms of use pane, you can change the following settings:
    
   - **Name** – the internal name of the ToU that isn't shared with end users.
   - **Display name** – the name that end users can see when viewing the ToU.
   - **Require users to expand the terms of use** – set to **On** forces the end use to expand the terms of use document before accepting it.
   - **Update an existing terms-of-use** document.
   - You can add a language to an existing ToU. There are other settings you can change, such as require users to consent on every device, and expire consents. You can also set duration before reacceptance, or Conditional Access policy. You must create a new terms-of-use.
    
   :::image type="content" source="../media/edit-terms-of-use.png" alt-text="Screenshot of the Identity Governance terms of use being edited. The creator can set specific terms.":::
    
7. Once you're done, select **Save** to save your changes.

## Update an existing terms-of-use document

You can be required to update the terms of use document.

1. Select the terms of use you want to edit.
2. Select **Edit terms**.
3. In the **Language Options** table, identify the terms of use language you want to update and then, in the **Action** column, select **Update**.
    
   :::image type="content" source="../media/edit-terms-of-use-update.png" alt-text="Screenshot of the terms of use with the update option highlighted. Make the changes you need.":::
    
4. In the Update terms of use version pane, you can upload a new version of your terms of use document.
5. Additionally, you can use the **Require reaccept** toggle button if you want to require your users to accept this new version the next time they sign in. If you don't require your users to reaccept, their previous consent stays current. Only new users who haven't consented before or whose consent expires see the new version.
    
   :::image type="content" source="../media/update-terms-of-use-version.png" alt-text="Screenshot of the update terms of use version pane with the upload required pdf and require reaccept highlighted.":::
    
6. Once you upload your new pdf and decided on reaccept, select **Add**.
7. You now see the most recent version under the Document column.
