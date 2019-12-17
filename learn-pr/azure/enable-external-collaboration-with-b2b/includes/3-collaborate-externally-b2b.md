
You'll need to invite the clinicians as guest users in Azure AD B2B to share an application with them securely.

Here, you're going to learn how to collaborate with external users using their existing identities. You'll see how invitation and redemption works in Azure AD B2B. Then you'll learn how to enable application owners to manage guest users for their applications. Finally, you'll explore how to protect shared applications through policies.

## Collaborate with external users using their identities

With Azure AD B2B, external users can use their identities to collaborate with your organization. Their identities are managed by the partner themselves. But they can also be identities that are managed by another external identity provider on their behalf. Below you'll see what it looks like for an external user when they access applications using their identity through Azure AD B2B. Their existing identity is used to give them access to the applications.

![External user using their identity](../media/3-access-panel.png)

 <!--Original image is from video on this page: https://docs.microsoft.com/en-us/azure/active-directory/b2b/what-is-b2b -->

Your collaborating partners don't have to deal with new identities that they need to keep track of themselves. And you don't take on the additional responsibility of managing external user identities.

## Invitation and redemption workflow

First, you need to check your external collaboration settings are enabled in Azure. The **Manage external collaboration settings** pane in the Azure portal helps you check these settings. You also use the pane to turn off invitations, and select which users are allowed to invite guest users.

![External collaboration settings](../media/3-external-collaboration-settings.png)

You can then invite your guest user. The user will receive an email invitation like the one below. The user then selects the link in the email invitation to access your applications. 

![User receives an email](../media/3-user-accepts-invitation.png)

<!-- Original image: https://docs.microsoft.com/en-us/azure/active-directory/b2b/media/quickstart-add-users-portal/quickstart-users-portal-email-small.png -->

## Enable application owners to manage guest users

An organization can have application owners, who decide who is and isn't allowed to use a particular application. These owners will typically have a good idea of what type of usage is expected from an application. They're in a good position to decide who should be a guest user for a particular application.

Azure AD B2B allows you to delegate guest user access to these application owners. You configure self-service management to allow application owners to use the applications access panel to invite guest users to a particular application.

First, you allow self-service group management for your directory in the Azure portal.

![Self service group management](../media/3-self-service-group-management.png)

You then create a group for the application, and set the owner for it. Then you configure the application for self-service and assign your group to it.

## Protect your shared applications through policies

You can use Conditional Access policies to intelligently grant or deny access, according to factors that aren't credential-based. Conditional Access policies can add extra layers of security to your applications and resources by enforcing conditions. A user who has otherwise verified credentials are denied if they don't meet certain conditions. 

These conditions might be device-based. You can make it mandatory for users to be on specific device platforms, such as Android or Windows, before they're granted access to resources. Conditions can also be location-based. You block users if they don't meet the required location criteria when attempting to access your applications.

You enforce policies by going to your application in the Azure Active Directory settings in the Azure portal. Then you use the Conditional Access policies form to create a new policy. You select which users should be affected by the policy, and decide on the conditions you want to put in place. For example, only allowing users to sign in from an approved location. You can enforce policies at an application level, tenant level, or user level.
