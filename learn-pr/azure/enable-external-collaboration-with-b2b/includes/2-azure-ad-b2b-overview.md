As you prepare to use B2B collaboration for external clinicians who need access to your app, let's take a look at how the feature works.

## What is Azure AD B2B collaboration?

Azure AD B2B collaboration is a way to invite anyone to access the apps and resources you want to share with them. When an external user accepts a B2B collaboration invitation from you, they can access the apps and resources you want to share with them, including Office 365 apps, software-as-a-service (SaaS) apps, and line-of-business applications.

Once you invite a user to B2B collaboration, a user object is created for them in the same Azure AD directory where you manage your employees. This user object can be managed like other user objects in your directory, meaning you can assign permissions, add it to groups, and so on.

There are no credentials associated with B2B collaboration users. Instead, they authenticate with their home organization or identity provider, and then your organization checks the B2B collaboration user’s eligibility for B2B collaboration.

## What happens when you invite a B2B collaboration user

The following steps show how Azure AD B2B lets you collaborate with external partner users. The numbers in the diagram are explained in the subsequent sections.

![Diagram of Azure AD B2B overview.](../media/2-guest-user.png)

1. **Send a B2B collaboration invitation to the user**

    First, you invite the external user as B2B collaboration user to your directory. There are different ways you can invite a B2B collaboration user, such as through Azure PowerShell or the Azure portal. You can invite users as individuals one at a time, or in bulk. For example, to invite an individual by using the Azure portal, you fill in a form with your B2B collaboration user's details and a custom invitation message.

    ![Screenshot of the invitation form.](../media/2-invitation-form.png)

    B2B collaboration users will show up in your directory, in the list of users. From here, you can manage users by making changes, removing users, or adding new ones.

    ![Screenshot of inviting a user in the Azure portal.](../media/2-invite-guest-user.png)

1. **The B2B collaboration user accepts your invitation and reviews permissions**

    At the second stage in the diagram, the B2B collaboration user receives an invitation via email, and then uses the **Accept invitation** link to access the services you want to share with them.

    :::image type="content" source="../media/2-email-confirmation.png" alt-text="Screenshot of the email confirmation." loc-scope="other"::: <!-- APEX10 -->

    The first time the link is used, the user is asked for consent. In this way, Azure AD B2B helps to provide transparency for partner users. Your external users will always know what information they're sharing. The user must accept the permissions needed by Azure AD B2B before they can gain access.

    ![Screenshot of permissions dialog box.](../media/2-consent-screen.png)

1. **The user completes multi-factor authentication**

    At this point, if you've enabled multi-factor authentication, the user provides these extra details for their account. When multi-factor authentication is configured, the user must enter a verification code sent to their mobile device, before they're granted access.

    ![Screenshot of multi-factor authentication dialog box.](../media/2-mfa.png)

1. **The user finds your apps on their access panel**

    Your B2B collaboration user is then forwarded to the access panel page, where they can access all the applications and services you've shared with them. These applications and services can be cloud-based, or on-premises. Here's what it looks like for an external user when they access applications by using their identity through Azure AD B2B collaboration.

    :::image type="content" source="../media/2-shared-apps.png" alt-text="Screenshot of access panel page, showing shared apps." loc-scope="other"::: <!-- APEX10 -->

## Adding protection through multi-factor authentication

Conditional Access policies, such as multi-factor authentication, can add extra layers of security to your application. Even if your B2B collaboration user authenticates through their identity provider, they'd still need to meet a device challenge before they could access your application.

You enforce multi-factor authentication by adding a new Conditional Access policy to your application's Azure AD settings in the portal. Then you select the users that should be affected by the policy (guest users in our case). Then you decide on the conditions you want to put in place. We'll talk about this in more detail later.
