Your company wants to improve how it provides services to doctors, and how it collaborates with external healthcare organizations. You've been asked to investigate what other capabilities and services Azure AD could provide for the organization.

You'll explore some essential features for Azure AD, and how they can be used. For example, you'll look at features like Azure Active Directory business-to-business (B2B), Azure Active Directory business-to-consumer (B2C), Azure Active Directory Domain Services, and Azure Identity Protection. And you'll see which features you can use to help improve how you manage applications with Azure AD.

## Azure Active Directory B2B

Use Azure AD to invite external users to your tenant. Your organization can then collaborate with external healthcare partner staff members through Azure AD B2B Collaboration. For example, your company works with external healthcare partners who would be invited as guest users to your tenant. When the work is done, access for those external healthcare partners can be revoked until it's needed again.

Here's the B2B collaboration process:

![B2B process](../media/4-b2b-process.svg)

1. The external user receives either an email invitation with a redemption link, or gets a direct link.
1. The user selects the redemption link to access the application(s) to which they've been invited.
1. If multi-factor authentication is configured, the user receives a verification code on their phone.
1. The user provides the code they've received.
1. The user can then access the application, whether it's on-premises or in the cloud.

This feature is available for all licensing tiers in Azure AD.

## Azure Active Directory B2C (Azure AD B2C)

You can also use Azure Active Directory B2C to manage your customers' identities and access. Your doctor's accounts should have protected access to resources and services. Use Azure AD B2C to securely authenticate the doctors through their preferred identity providers. AD B2C also helps you monitor for threats like brute force and denial-of-service attacks on doctor's user accounts. To use Azure AD B2C, you register your applications. You then configure user flows to dictate the journey the user takes to access an application.

For example, a sign-in user flow that describes the process required might go like this:

![User flow](../media/4-signin-user-flow.svg)

1. The user goes to the application they want to access, on their browser or mobile phone.
1. The user is asked to complete the sign-in form.
1. If the credentials are verified, and multi-factor authentication is enabled, the user receives a verification code on their phone.
1. The user provides the code they've received.
1. The user is then granted access to the application.

This feature is available on a pay-as-you-go basis.

## Azure Active Directory Domain Services

Azure Active Directory Domain Services (Azure AD DS) lets you add virtual machines to a domain without needing domain controllers. Your internal staff users can access virtual machines using their company Azure AD credentials. You use this service to reduce the complexity of migrating on-premises applications to Azure. An organization could also use Azure AD DS to handle its infrastructure if it runs both on-premises and in the cloud. The process might go like this:

![Azure AD DS](../media/4-azure-ad-domain-services.svg)

1. The organization deploys its applications and servers in a virtual network on Azure.
1. Identity information is synchronized between the on-premises Active Directory and the organization's tenant in Azure AD, using a tool called Azure AD Connect sync.
1. The company then enables Azure AD DS on their Azure AD tenant.
1. The applications and servers in Azure can now use features like domain joining, Kerberos authentication, and more.

This feature is available for pay-as-you-go, based on the total number of objects including users, groups, and domain-joined computers, in your Azure AD DS-managed domain.

## Application management

Your company could be using many different applications that users, both internal and external, rely on for various purposes. Users might want to access these applications from different devices and locations. You can use Azure AD as a cloud-based solution to manage user access for all of these applications.

You can manage different categories of applications with Azure AD:

- **Azure AD Gallery applications**. Thousands of SaaS applications have already been integrated with Azure AD. You can find these applications in the Azure Active Directory Marketplace.

    ![Azure AD Marketplace](../media/4-azure-ad-marketplace.png)

- **Custom-developed applications**. You can register these applications, which are built by your company, with Azure AD. You then control and monitor authentication for these applications.

    ![Custom developed applications](../media/4-applications.png)

- **Non-gallery applications**. You can also manually add any applications that you don't see listed in the gallery.

    ![Non-gallery applications](../media/4-non-gallery-applications.png)

- **On-premises applications**. You can add on-premises applications by configuring an Azure AD Application Proxy. This process will create secure remote access for applications you have on-premises. To connect them, you download and install the application proxy connector on-premises.

    ![On-premises applications](../media/4-add-on-premises-application.png)

There are other Azure AD features you can use to benefit your applications.

### Protect your apps with Conditional Access policies

Use Conditional Access policies to require users to go through additional authentication challenges before accessing an application. For example, you would configure a Conditional Access policy to ask users to complete a multi-factor authentication challenge after their credentials have been verified, before they access the application.

![Azure AD reports](../media/4-conditional-access-policy.png)

Conditional Access policies are available for Premium P1 and Premium P2 license tiers.

### Monitor your application access

Azure AD can help monitor your application sign-ins by generating reports that cover sign-in dates, user details, applications the user has used, risk detection, location, and more. Those reports can then be accessed through the Azure portal, or via specific APIs for programmatic usage.

![Azure AD reports](../media/4-reports.png)

Reports are available for all licensing tiers.

## Azure Active Directory Identity Protection

Azure Active Directory Identity Protection helps you to automatically detect, remediate, and investigate identity-based risks for users. Identity Protection also lets you export all the information collected about risks to third-party tools and solutions for additional analysis.

Identity Protection uses risk policies to automatically detect, and respond to, threats for you. You configure a risk policy to decide how you want Identity Protection to respond to a particular type of risk. Using policies in this way saves time, and gives you peace of mind.

![Identity Protection flow](../media/4-identity-protection-flow.svg)

With automated risk detection and remediation through Identity Protection, the administrator first configures the risk policies, which then monitor for identity risks. When a risk is detected, the policies enforce measures to remediate it. For example, a policy might ask a user to reset their password in response to a detected risk. The user then resets their password, and the risk is remediated.

You configure risk policies through the Azure portal. For example, the risk policy below detects user risks and remediates them by asking the user to reset their password.

![Risk policies](../media/4-risk-policy.png)

Identity Protection is available for the Premium P2 licensing tier.