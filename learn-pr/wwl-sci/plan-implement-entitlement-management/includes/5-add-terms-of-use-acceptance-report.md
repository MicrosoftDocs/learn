## What are terms of use for Entitlement Management

:::image type="content" source="../media/sc300-terms-of-use-entitlement-eb2a99ab.png" alt-text="Screenshot of terms of use settings.  You can set Name, Display Name, link to a PDF document with the terms, and some settings to ensure the user actually sees the terms of use.":::


Azure AD terms of use policies use the PDF format to present content. The PDF file can be any content, such as existing contract documents, allowing you to collect end-user agreements during user sign in. To support users on mobile devices, the recommended font size in the PDF is 24 point. Remember that terms of use PDF documents can contain an End User License Agreement (EULA). The user has to commit to before access resources based on their entitlement settings.

## Add terms of use

Once you have finalized your terms of use document, use the following procedure to add it.

1.  Sign in to the [Azure portal](https://portal.azure.com/) as a Global administrator.
2.  Open **Azure Active Directory** and the select **Identity Governance**.
3.  In the left navigation menu, under **Terms of use**, select **Terms of use**.
4.  On the Terms of use page, on the top menu, select **+ New terms**.
    
    :::image type="content" source="../media/new-terms-of-use-f50f193c.png" alt-text="Screen image displaying the Terms of use page with New terms highlighted":::
    
5.  In the **Name** box, enter **Testing terms of use**. This is the terms of use that will be used in the Azure portal.
6.  In the **Display name** box, enter **Contoso Terms of Use**. This is the title that users see when they sign in.
7.  Select the **Terms of use document box**, browse to your finalized terms of use PDF, and select it. For this exercise you can choose any PDF you may have. Another option is use Microsoft Word to create a terms of use doc and then save as PDF.
8.  Select the language for your terms of use document. The language option allows you to upload multiple terms of use, each with a different language. The version of the terms of use that an end user will see will be based on their browser preferences.
9.  To require end users to view the terms of use prior to accepting them, set **Require users to expand the terms of use** to **On**.
10. To require end users to accept your terms of use on every device they are accessing from, set **Require users to consent on every device** to **On**. Users may be required to install additional applications if this option is enabled.
    
    > [!WARNING]
    > Consent on every device will require users to register each device with Azure AD prior to getting access.
11. If you want to expire terms of use consents on a schedule, set **Expire consents** to **On**. When set to On, two extra schedule settings are displayed.
    
    :::image type="content" source="../media/new-terms-of-use-create-43bc7285.png" alt-text="Expire consents settings to set start date, frequency, and duration":::
    
12. Use the **Expire starting on** and **Frequency** settings to specify the schedule for terms of use expirations. The following table shows the result for a couple of example settings:
    
    :::row:::
      :::column:::
        **Expire starting on**
      :::column-end:::
      :::column:::
        **Frequency**
      :::column-end:::
      :::column:::
        **Result**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Today's date
      :::column-end:::
      :::column:::
        Monthly
      :::column-end:::
      :::column:::
        Starting today, users must accept the terms of use and then reaccept every month.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Date in the future
      :::column-end:::
      :::column:::
        Monthly
      :::column-end:::
      :::column:::
        Starting today, users must accept the terms of use. When the future date occurs, consents will expire and then users must reaccept every month.
      :::column-end:::
    :::row-end:::
    
    
    For example, if you set the expire starting on date to **Jan 1** and frequency to **Monthly**, here is how expirations might occur for two users:
    
    :::row:::
      :::column:::
        **User**
      :::column-end:::
      :::column:::
        **First accept date**
      :::column-end:::
      :::column:::
        **First expire date**
      :::column-end:::
      :::column:::
        **Second expire date**
      :::column-end:::
      :::column:::
        **Third expire date**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Alice
      :::column-end:::
      :::column:::
        January 1
      :::column-end:::
      :::column:::
        February 1
      :::column-end:::
      :::column:::
        March 1
      :::column-end:::
      :::column:::
        April 1
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Bob
      :::column-end:::
      :::column:::
        January 15
      :::column-end:::
      :::column:::
        February 1
      :::column-end:::
      :::column:::
        March 1
      :::column-end:::
      :::column:::
        April 1
      :::column-end:::
    :::row-end:::
    
13. Use the **Duration before reacceptance requires (days)** setting to specify the number of days before the user must reaccept the terms of use. This setting allows users to follow their own schedule. For example, if you set the duration to **30** days, here is how expirations might occur for two users:
    
    :::row:::
      :::column:::
        **User**
      :::column-end:::
      :::column:::
        **First accept date**
      :::column-end:::
      :::column:::
        **First expire date**
      :::column-end:::
      :::column:::
        **Second expire date**
      :::column-end:::
      :::column:::
        **Third expire date**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Alice
      :::column-end:::
      :::column:::
        January 1
      :::column-end:::
      :::column:::
        January 31
      :::column-end:::
      :::column:::
        March 2
      :::column-end:::
      :::column:::
        April 1
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Bob
      :::column-end:::
      :::column:::
        January 15
      :::column-end:::
      :::column:::
        February 14
      :::column-end:::
      :::column:::
        March 16
      :::column-end:::
      :::column:::
        April 15
      :::column-end:::
    :::row-end:::
    
    
    > [!NOTE]
    > It is possible to use the Expire consents and Duration before reacceptance requires (days) settings together, but typically you use one or the other.
14. Under **Conditional Access**, select **Custom policy**.
    
    :::row:::
      :::column:::
        **Template**
      :::column-end:::
      :::column:::
        **Description**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Custom policy**
      :::column-end:::
      :::column:::
        Select the users, groups, and apps that the terms of use will be applied to.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Create Conditional Access policy later**
      :::column-end:::
      :::column:::
        This terms of use will appear in the grant control list when creating a Conditional Access policy.
      :::column-end:::
    :::row-end:::
    
    
    > [!IMPORTANT]
    > Conditional Access policy controls (including terms of use) do not support enforcement on service accounts. We recommend excluding all service accounts from the Conditional Access policy. Custom Conditional Access policies enable granular terms of use, down to a specific cloud application or group of users. For more information, see Quickstart: Require terms of use to be accepted before accessing cloud apps.
15. When complete, select **Create**.
    
    :::image type="content" source="../media/new-terms-of-use-create-43bc7285.png" alt-text="Screen image displaying the New terms of use page with configured options highlighted":::
    
16. When the terms of use is created, you will automatically be redirected to the Conditional Access policy page. On the page, in the **Name** box, enter **Enforce ToU**.
17. Under **Assignments**, select **Users and groups**.
18. On the include tab, select **Users and groups** check box.
19. In the Select pane, select an account you would like to use to test the terms of use policy. If you choose your administrator account, like all Conditional Access policies, be sure you have another account with enough permissions to change the Conditional Access policy. This is to ensure your administrator account will not be locked out should the Conditional Access policy result in an undesirable outcome.
20. Select **Cloud apps or actions**.
21. Select **All cloud apps**.
22. Under **Access controls**, select **Grant**.
23. In the Grant pane, select **Testing terms of use** and then select **Select**.
24. Under **Enable policy**, select **On**.
25. When complete, select **Create**.
    
    :::image type="content" source="../media/terms-of-use-conditional-access-policy-bf0a3ae5.png" alt-text="Screen image displaying the Conditional Access policy with configuration options highlighted":::
    
26. If you chose to use your own account, you can refresh your browser. You will be prompted to sign in again. When you sign in, you will be required to accept the terms of use.

## View report of who has accepted and declined

The Terms of use screen shows a count of the users who have accepted and declined. These counts and who accepted/declined are stored for the life of the terms of use.

1.  In Microsoft Azure, in **Identity Governance** &gt; **Terms of use**, locate your terms of use.
2.  For a terms of use, select the numbers under **Accepted** or **Declined** to view the current state for users.
    
    :::image type="content" source="../media/terms-of-use-accept-decline-bb78f857.png" alt-text="Screen image displaying the terms of use with the Accepted and Declined columns highlighted":::
    
3.  In this exercise, you may not have any accepted or declined terms of use. In the following example, the **Accepted** value was selected. You can see the reported user information for those that have accepted the terms of use.
    
    :::image type="content" source="../media/accepted-terms-of-use-9e3c6bb6.png" alt-text="Terms of use consents pane listing the users that have accepted":::
    
4.  To view the history for an individual user, select the ellipsis to the right of the user name and then **View History**.
    
    :::image type="content" source="../media/view-history-menu-b1219c91.png" alt-text="View History context menu for a user":::
    
5.  In the view history pane, you see a history of all the accepts, declines, and expirations.
    
    :::image type="content" source="../media/view-history-pane-4831c950.png" alt-text="View History pane lists the history accepts, declines, and expirations for a user":::
    

## What terms of use looks like for users

1.  Once a terms of use is created and enforced, users who are in scope will see the terms of use page.
    
    :::image type="content" source="../media/user-terms-of-use-b17057b8.png" alt-text="Example terms of use that appears when a user signs in":::
    
2.  Users can view the terms of use and, if necessary, use buttons to zoom in and out.
    
    :::image type="content" source="../media/zoom-buttons-a525d9e6.png" alt-text="View of terms of use with zoom buttons":::
    

3.  On mobile devices, the terms of use will be displayed similar to the following example.
    
    :::image type="content" source="../media/mobile-terms-of-use-f474a960.png" alt-text="Example terms of use that appears when a user signs in on a mobile device":::
    

### How users can review their terms of use

Users can review and see the terms of use that they have accepted by using the following procedure.

1.  Browse to [https://myaccount.microsoft.com](https://myapps.microsoft.com/) and then sign in using your user account.
2.  On the Overview page, select VIEW SETTINGS AND PRIVACY.
    
    :::image type="content" source="../media/my-account-settings-privacy-035c38bb.png" alt-text="Screen image of a popup which says View settings and privacy":::
    

3.  On the Settings &amp; Privacy page, select the **Privacy** tab.
    
    :::image type="content" source="../media/my-account-settings-privacy-organization-notes-db514a84.png" alt-text="Screen image displaying the settings and privacy page with organization notice highlighted. There is a terms of use enforced.":::
    
4.  Under **Organization’s notice**, you can review the terms of use you have accepted.

## Edit terms of use details

You can edit some details of terms of use, but you can't modify an existing document. The following procedure describes how to edit the details.

1.  Sign in to the [Azure portal](https://portal.azure.com/) as a Global administrator.
2.  Open Azure Active Directory and the select **Identity Governance**.
3.  In the left navigation menu, under **Terms of use**, select **Terms of use**.
4.  Select the terms of use you want to edit.
5.  On the top menu, select **Edit terms**.
6.  In the Edit terms of use pane, you can change the following settings:
    
     -  **Name** – this is the internal name of the ToU that is not shared with end users.
     -  **Display name** – this is the name that end users can see when viewing the ToU.
     -  **Require users to expand the terms of use** – Setting this to **On** will force the end use to expand the terms of use document before accepting it.
     -  **Update an existing terms of use** document.
     -  You can add a language to an existing ToU. There are other settings you can change, such as require users to consent on every device, and expire consents. You can also set duration before reacceptance, or Conditional Access policy. You must create a new terms of use. :::image type="content" source="../media/edit-terms-of-use-1ca5ade5.png" alt-text="Screen image of the Identity Governance terms of use being edited.":::
        
7.  Once you are done, select **Save** to save your changes.

## Update an existing terms of use document

You may, on occasion, be required to update the terms of use document.

1.  Select the terms of use you want to edit.
2.  Select **Edit terms**.
3.  In the **Language Options** table, identify the terms of use language you want to update and then, in the **Action** column, select **Update**.
    
    :::image type="content" source="../media/edit-terms-of-use-update-af71738a.png" alt-text="Screen image displaying the terms of use with the update option highlighted":::
    
4.  In the Update terms of use version pane, you can upload a new version of your terms of use document.
5.  Additionally, you can use the **Require reaccept** toggle button if you want to require your users to accept this new version the next time they sign in. If you do not require your users to reaccept, their previous consent will stay current. Only new users who have not consented before or whose consent expires will see the new version.
    
    :::image type="content" source="../media/update-terms-of-use-version-b5bb708d.png" alt-text="Screen image displaying the update terms of use version pane with the upload required pdf and require re-accept highlighted":::
    
6.  Once you have uploaded your new pdf and decided on reaccept, select **Add**.
7.  You will now see the most recent version under the Document column.
