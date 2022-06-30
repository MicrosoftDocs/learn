Several clinicians from partnering clinics will need access to your health records application. Let's take a look at how B2B collaboration will let them conveniently access your application while keeping sensitive data secure.

## What is Azure AD B2B collaboration?

Azure AD B2B collaboration is a method for sharing applications and resources with anyone outside of your organization. You can invite external users to access applications including Office 365 apps, software-as-a-service (SaaS) apps, and line-of-business applications. With B2B collaboration, you invite the external user using their preferred work, school, or social account. Then they use that account for authentication whenever they access your application.

Once you invite a user to B2B collaboration, a user object is created for them in the same Azure AD directory where you manage your employees. This user object can be managed like other user objects in your directory, meaning you can assign permissions, add it to groups, and so on.

There are no credentials associated with B2B collaboration users in your organization. Instead, they authenticate with their own organization or identity provider, and then your organization checks the B2B collaboration user’s eligibility for B2B collaboration.

## What happens when you invite a B2B collaboration user

The following steps show how Azure AD B2B lets you collaborate with external partner users. The numbers in the diagram are explained below.

![Diagram of Azure AD B2B overview.](../media/2-guest-user.png)

1. **Send a B2B collaboration invitation to the user**

    First, you invite the external user as B2B collaboration user to your directory. There are different ways you can invite a B2B collaboration user, such as through Azure PowerShell or the Azure portal. You can invite users as individuals one at a time, or in bulk. To invite an individual by using the Azure portal, you fill in a form with your B2B collaboration user's details and a custom invitation message.

    ![Screenshot of the invitation form.](../media/2-invitation-form.png)

    B2B collaboration users will show up in your directory, in the list of users. From here, you can manage users by making changes, removing users, or adding new ones.

    [ ![Screenshot of the guest user in your directory.](../media/2-invite-guest-user.png) ](../media/2-invite-guest-user.png#lightbox)

1. **The B2B collaboration user accepts your invitation and reviews privacy information**

    The B2B collaboration user receives an invitation via email, and then uses the **Accept invitation** link to access the applications you want to share with them. The first time they use this link, they'll be asked to consent to privacy information and terms of use.

    ![Screenshot of the email invitation.](../media/2-email-confirmation.png)

1. **The user completes multi-factor authentication**

    At this point, if you've enabled multi-factor authentication, the user provides these extra details for their account. When multi-factor authentication is configured, the user must enter a verification code, sent to their mobile device, before they're granted access.

    ![Screenshot of the multi-factor authentication dialog box.](../media/2-mfa.png)

1. **The user finds your applications on their access panel**

    Your B2B collaboration user is then forwarded to the access panel page, where they can access all the applications and services you've shared with them. These applications and services can be cloud-based, or on-premises.

    ![Screenshot of access panel page, showing shared apps.](../media/2-shared-apps.png)
