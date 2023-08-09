As you know, Azure AD has a gallery that contains thousands of pre-integrated applications. Many of the applications your organization uses are probably already in the gallery. If an app is added to your Azure AD tenant, you can configure properties for the app, manage user access to the app, and configure SSO so users can sign in to the app with their Azure AD credentials. This unit will show you how to configure properties for the app.

## Configure application (app) properties

To edit the app properties:

1.  In the Azure AD portal, select **Enterprise applications**. Then find and select the application you want to configure.
2.  In the **Manage** section, select **Properties** to open the **Properties** pane for editing.
3.  Take a moment to understand the options available. The options available will depend on how the app is integrated with Azure AD. For example, an app that uses SAML-based SSO will have fields such as *User access URL* whereas an app that uses OIDC-based SSO won't. Apps added through **Azure Active Directory &gt; App registrations** are by default OIDC-based apps, while apps added **through Azure Active Directory &gt; Enterprise applications** might use any SSO standard. All apps will have fields for configuring when an app appears and can be used. These fields are:
    
    
     -  **Enabled for users to sign in?** determines whether users assigned to the application can sign in.
     -  **User assignment required?** determines whether users who aren't assigned to the application can sign in.
     -  **Visible to users?** determines whether users assigned to an app can see it in [My Apps](https://myapps.microsoft.com/) and Microsoft 365 app launcher. (See the waffle menu in the upper-left corner of a Microsoft 365 website.)
    
    The three options can be toggled independently of each other, and the resulting behavior is not always obvious. This table might help:
    
    | **Enabled for users to sign in?** | **User assignment required?** | **Visible to users?** | **Behavior for users who have either been assigned to the app or not.**                                     |
    | --------------------------------- | ----------------------------- | --------------------- | ----------------------------------------------------------------------------------------------------------- |
    | Yes                               | Yes                           | Yes                   | Assigned users can see the app and sign in. Unassigned users can't see the app and can't sign in.           |
    | Yes                               | Yes                           | No                    | Assigned uses can't see the app but they can sign in. Unassigned users can't see the app and can't sign in. |
    | Yes                               | No                            | Yes                   | Assigned users can see the app and sign in. Unassigned users can't see the app but can sign in.             |
    | Yes                               | No                            | No                    | Assigned users can't see the app but can sign in. Unassigned users can't see the app but can sign in.       |
    | No                                | Yes                           | Yes                   | Assigned users can't see the app and can't sign in. Unassigned users can't see the app and can't sign in.   |
    | No                                | Yes                           | No                    | Assigned users can't see the app and can't sign in. Unassigned users can't see the app and can't sign in.   |
    | No                                | No                            | Yes                   | Assigned users can't see the app and can't sign in. Unassigned users can't see the app and can't sign in.   |
    | No                                | No                            | No                    | Assigned users can't see the app and can't sign in. Unassigned users can't see the app and can't sign in.   |
4.  When you're finished, select **Save**.

## Use a custom logo

1.  To use a custom logo:
2.  Create a logo that's 215 by 215 pixels and save it in .png format.
3.  In the Azure AD portal, select **Enterprise applications**. Then find and select the application you want to configure.
4.  In the **Manage** section, select **Properties** to open the **Properties** pane for editing.
5.  Select the icon to upload the logo.
6.  When you're finished, select **Save**.
    
    :::image type="content" source="../media/change-logo-e0f408d6.png" alt-text="Screenshot of the Properties screen that shows how to change the logo. Size of the logo is important.":::
    

## Add notes

You can use the notes field to add any information that is relevant for the management of the application.

1.  In the Azure AD portal, select **Enterprise applications**. Then find and select the application you want to configure.
2.  In the **Manage** section, select **Properties** to open the **Properties** pane for editing.
3.  Update the Notes field, select **Save**.
    
    :::image type="content" source="../media/notes-application-87b49b66.png" alt-text="Screenshot of the Properties screen that shows how to change the notes. These notes help your users know when and how to use the apps.":::
    
