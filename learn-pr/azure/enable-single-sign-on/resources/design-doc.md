# Title

Enable single sign-on for applications by using Azure Active Directory

## Role(s)

Administrator

## Level

Intermediate

## Product(s)

Azure Active Directory

## Prerequisites

- An Azure AD subscription. If you don't have a subscription, you can get a free account.
- One of the following roles in the Azure AD tenant: Global Administrator, Cloud Application Administrator, Application Administrator
- A single sign-on enabled subscription for the application

## Summary

Define the URLs that are necessary for secure access, create a signing certificate, and configure single sign-on properties for the application. When the user attempts to sign in, the appropriate URLs are accessed to enable them to use the same credentials to sign in to all the applications they need.

## Learning objectives

Upon completion of this module, the learner will be able to configure Azure Active Directory and applications to enable users to sign in once to access all the applications they need.

1. Identify an application that supports SAML-based single sign-on and add it from the application gallery to their Azure AD tenant.
2. Configure the appropriate single sign-on URLs needed in the Azure AD tenant. URLs and a certificate will also be gathered for configuring the application at the host.
3. Configure the application properties for single sign-on at the host of the application.
4. Test the single sign-on experience by using test user accounts.

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Navigate to the application gallery | Find available applications | Exercise | 1 | Combine with Install an application |
| Identify SSO support | Enable single sign on for the new application | Knowledge check | 1 | Combine with Install an application |
| Install an application from the gallery | Add a new application | Exercise | 1 | Yes |
| Navigate to SSO configuration in the portal | Find SSO configuration | Exercise | 2 | Combine with Define URLs |
| Define URLs | Configure SSO | Knowledge check | 2 | Yes |
| Create certificate | Secure access | Exercise | 2 | Combine with Define URLs |
| Sign in to the application host | Access application configuration | Exercise | 3 | Combine with Configure application |
| Configure application | Enable single sign on at the host | Knowledge check | 3 | Yes |
| Create a user account in the Azure portal | Test sign in from portal | Exercise | 4 | Combine with Test sign-in |
| Create a user account at the application host | Test sign in from the host | Exercise | 4 | Combine with Test sign-in |
| Test sign-in | Verify succesful single sign-in | Exercise | 4 | Yes |

## Outline the units

Add more units as needed for your content

1. Introduction

    Provide a scenario of a real-world job task that shows how the technology is used in practice:

    Suppose you’re an IT administrator at a retail company that depends on many applications for users to complete their work, such as marketing, sales, and operations. A team asked for a new application to be added to help with company promotion. The application needs to be made available to team members as appropriate.

    You realize that this addition causes users to sign in to yet another application using specific credentials for it. Users get frustrated because they have to sign in many times a day depending on the applications they use. You want to be able to configure the system so that a user can sign in once and get access to all applications and resources that they need to work effectively.

1. Identify enterprise applications that support SSO

    - Search for an application in the gallery
        - Navigate to Enterprise applications in the Azure portal
        - Search for the application and verify SSO support
    - Identify the SSO methods that the application supports
        - Select the application in the gallery to view overview
    - Add the application to the Azure AD tenant
        - Click Create

    Knowledge check

    How does an administrator know which SSO methods an application supports?
    - Find the information on the overview page in the gallery.
    - Find the information on the applications list page in Enterprise applications.
    - Contact the owner of the application and ask what methods are supported.

1. Exercise - Add an SSO supported enterprise application

    List the steps that apply the learning content from previous unit:

    1. Go to the Azure Active Directory Admin Center and sign in using one of the roles listed in the prerequisites.
    1. In the left menu, select **Enterprise applications**. The **All applications pane** opens and displays a list of the applications in your Azure AD tenant.
    1. In the Enterprise applications pane, select **New application**.
    1. The Browse Azure AD Gallery pane opens and displays tiles for cloud platforms, on-premises applications, and featured applications. Applications listed in the Featured applications section have icons indicating whether they support federated single sign-on (SSO) and provisioning and the overview for the application lists the specific methods that are supported. Search for and select the application. In this module, **Azure AD SAML Toolkit** is being used.
    1. Enter a name that you want to use to recognize the instance of the application. For example, Azure AD SAML Toolkit 1.
    1. Select **Create**.

    If you choose to install an application that uses OpenID Connect based SSO, instead of seeing a **Create** button, you see a button that redirects you to the application sign-in or sign-up page depending on whether you already have an account there.

1. Identify the SSO properties and resources for an enterprise application

    - Set Basic SAML Configuration values
        - Identifier (Entity ID)
        - Reply URL (Assertion Consumer Service URL)
        - Sign on URL
        - Relay State
        - Logout Url
    - Define attributes and claims
        - Add new claim
    - Create a SAML signing certificate
        - Download certificate
        - Record App Federation Metadata Url
    - Create a test user account
  
    Knowledge check

    Which SSO properties are needed to configure the application at its host?
    - **Reply URL**, **Azure AD Identifier**, and **Logout URL**.
    - **Sign on URL**, **Reply URL**, and **Sign out URL**.
    - **Login URL**, **Azure AD Identifier**, and **Logout URL**.

1. Exercise - Configure single sign-on for the application in the Azure portal

    1. Go to the Azure Active Directory Admin Center and sign in using one of the roles listed in the prerequisites.
    1. In the left menu, select **Enterprise applications**. The **All applications** pane opens and displays a list of the applications in your Azure AD tenant. Search for and select the application that you want to use. For example, **Azure AD SAML Toolkit 1**.
    1. In the **Manage** section of the left menu, select **Single sign-on** to open the **Single sign-on** pane for editing.
    1. Select **SAML** to open the SSO configuration page.
    1. Select **Edit** in the Basic SAML Configuration section on the **Set up single sign-on** pane.
    1. For **Reply URL (Assertion Consumer Service URL)**, enter `https://samltoolkit.azurewebsites.net/SAML/Consume`.
    1. For **Sign on URL**, enter `https://samltoolkit.azurewebsites.net/`.
    1. Select **Save**.
    1. In the SAML Signing Certificate section, select **Download for Certificate (Raw)** to download the SAML signing certificate and save it to be used later.
    1. In the **Set up Azure AD SAML Toolkit 1** section, record the values of the **Login URL**, **Azure AD Identifier**, and **Logout URL** properties to be used later when configuring the application at its host.

    Create a test user account and assign it to the application

    1. Go to the Azure Active Directory Admin Center and sign in using one of the roles listed in the prerequisites.
    1. In the left menu, select **Users**.
    1. Select **New user** at the top of the pane.
    1. In the **User name** field, enter the name for the account. For example, contosouser1@contoso.com. Be sure to change contoso.com to the name of your tenant domain.
    1. In the **Name** field, enter the name of the user of the account. For example, `contosouser1`.
    1. Leave **Auto-generate password** selected, and then select **Show password**. Write down the value that's displayed in the **Password** box.
    1. Select **Create**.
    1. In the Azure Active Directory Admin Center, select **Enterprise applications**, and then search for and select the application to which you want to assign the user account. For example, the application that you previously created named **Azure AD SAML Toolkit 1**.
    1. In the left pane, select **Users and groups**, and then select **Add user/group**.
    1. On the **Add Assignment** pane, select **None Selected** under **Users and groups**.
    1. Search for and select the user account that you want to assign to the application. For example, `contosouser1@contoso.com`.
    1. Select **Select**.
    1. On the **Add Assignment** pane, select **Assign** at the bottom of the pane.

1. Discover how to configure SSO for the application at its host

    - Set previously copied URLs
        - Login URL
        - Azure AD Identifier
        - Logout URL
    - Enter App Federation Metadata Url or upload certificate
    - Create a test user account

    Knowledge check

    What is the purpose of the **Azure AD Identifier**?
    - Identifies the application in the Azure portal.
    - Identifies the Azure AD tenant where the application is registered.
    - Identifies the service principal that represents the application.

1. Exercise - Configure single sign-on properties for the application at its host

    These steps will vary depending on the application

    Create a test user account for the application

    1. Open a new browser window and browse to the sign-in URL for the application. For the Azure AD SAML Toolkit application, the address is `https://samltoolkit.azurewebsites.net`.
    1. Select **Register** in the upper right corner of the page.
    1. For **Email**, enter the email address of the user that will access the application. For example, the user account was created that uses the address of `contosouser1@contoso.com`. Be sure to change contoso.com to the domain of your tenant.
    1. Enter a **Password** and confirm it.
    1. Select **Register**.

    Configure SAML setting for the application

    1. Signed in with the credentials of the user account that you created, select **SAML Configuration** at the upper-left corner of the page.
    1. Select Create in the middle of the page.
    1. For **Login URL**, **Azure AD Identifier**, and **Logout URL**, enter the values that you recorded earlier.
    1. Select **Choose file** to upload the certificate that you previously downloaded.
    1. Select **Create**.
    1. Record the values of the **SP Initiated Login URL** and the **Assertion Consumer Service (ACS) URL** to be used later.

    Update single sign-on values

    1. In the Azure portal, select **Edit in the Basic SAML Configuration** section on the **Set up single sign-on** pane for the application.
    1. For **Reply URL (Assertion Consumer Service URL)**, enter the **Assertion Consumer Service (ACS) URL** value that you previously recorded.
    1. For **Sign on URL**, enter the **SP Initiated Login URL** value that you previously recorded.
    1. Select **Save**.

1. Verify SSO property configuration

    In the Test single sign-on with Azure AD SAML Toolkit 1 section, on the Set up single sign-on pane, select **Test**. Sign in to the application using the Azure AD credentials of the user account that you assigned to the application.

1. Summary

    We wanted to make sure that users in our organization only need to sign in once to their Azure AD tenant and then access all applications that they need, instead of signing in to each application individually.

    By configuring SSO in the tenant by using the Azure portal, we can define all of the URLs and the certificate that are needed for secure access. We also configured the application at its host to be able to securely connect to application using the user accounts that we created and assigned.

    Tested the SSO experience that was configured.

## Notes

How to handle a situation where there could be many variations of SSO configuration at the application host?
