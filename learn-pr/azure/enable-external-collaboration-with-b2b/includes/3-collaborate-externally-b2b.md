
You'll need to invite the clinicians as guest users in Azure AD B2B to share an application with them securely.

Here, you'll learn how to collaborate with external users using their identities. You'll see how invitation and redemption works in Azure AD B2B, to collaborate with external users. You'll learn how you enable application owners to manage guest users for their applications. And explore how you can protect your shared applications through policies.

## Collaborate with external users using their identities

With Azure AD B2B, your external users can use their own identities to collaborate with your organization. Their identities can be identities that are managed by the partner themselves. But they can also be identities that are managed by another external identity provider on their behalf. Below we can see what it looks like for an external user when they access applications using their identity through Azure AD B2B.

![External user using their identity](../media/3-user-added-using-their-identity.png)

 <!--Original image is from video on this page: https://docs.microsoft.com/en-us/azure/active-directory/b2b/what-is-b2b -->

Your collaborating partners don't have to deal with new identities that they need to keep track of themselves. And you don't take on the additional responsibility of managing external user identities.

## Invitation and redemption workflow

First you'll need to check your external collaboration settings are enabled in Azure. The **Manage external collaboration settings** pane in the Azure portal helps you check your settings. The pane also makes it possible to turn off invitations, and select which users are allowed to invite guest users.

You then proceed to add guest users. You'll use a new guest user form, which lets you input the guest user's email address along with any customized message you want to include in the body of the invitation. After you send the invitation, the user is listed in your directory as a guest type user. The user will receive an invitation in their email like the one below.

![User receives an email](../media/3-user-accepts-invitation.png)

<!-- Original image: https://docs.microsoft.com/en-us/azure/active-directory/b2b/media/quickstart-add-users-portal/quickstart-users-portal-email-small.png -->

The user can use the link in the email invitation to access the application.

## Enable application owners to manage guest users

An organization can have application owners. Application owners can decide who uses an application and who is not allowed to use a particular application. These users will typically have a good idea of what type of usage is expected from an application and are in a good position to decide who should be a guest user for a particular application.

![Application owner adding user](../media/3-application-owner.png)

<!--Original image: https://docs.microsoft.com/en-us/azure/active-directory/b2b/media/what-is-b2b/add-member.png -->

Azure AD B2B allows you to delegate guest user access to these application owners. You configure self-service management to allow application owners to use the applications access panel to invite guest users to a particular application. You first allow self-service group management for your directory in the Azure portal. You create a group for the application, and set the owner for the group. You then finally configure the application for self-service and assign your group to the application.

## Protect your shared applications through policies

Conditional Access policies are a way for you to be able to intelligently grant or deny access based on factors that are not credential-based. Conditional Access policies can add additional layers of security to your applications and resources by enforcing conditions. A user who has otherwise verified credentials can have their access denied if they do not meet conditions. These conditions can be device-based, where you can make it mandatory for users to be on specific device platforms such as Android or Windows before they can be granted access to resources. Conditions can also be location-based, where you block users if they do not meet the required location criteria when they attempt to access your applications.

You enforce policies by going to your application in your Azure Active Directory settings in the Azure portal, and use the Conditional Access policies form to create a new policy. You select which users should be affected by the policy. And can decide which conditions you want to put place, such as only allowing users to sign in from an approved location. You can enforce policies at an application level, tenant level, or user level.
