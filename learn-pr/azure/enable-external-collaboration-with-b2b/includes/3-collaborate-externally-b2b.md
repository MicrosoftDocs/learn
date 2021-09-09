
You'll need to invite the clinicians as guest users in Azure Active Directory B2B (Azure AD B2B) to share your company's healthcare application with them securely.

## Collaborate with external users who are using their identities

With Azure AD B2B, external users can use their identities to collaborate with your organization. Their identities are managed by the partner themselves, or by another external identity provider on their behalf. Here's what it looks like for an external user when they access applications by using their identity through Azure AD B2B.

:::image type="content" source="../media/3-user-added-using-their-identity.png" alt-text="Screenshot of apps access page for external user." loc-scope="other"::: <!-- APEX10 -->

Your collaborating partners don't have to keep track of new identities, and you don't take on the additional responsibility of managing external user identities.

## Invitation and redemption workflow

First, go to the **Manage external collaboration settings** pane in the Azure portal, and confirm that your external collaboration settings are enabled. You also use this pane to turn off invitations, and select which users are allowed to invite guest users.

To add guest users, you'll use a new form. This form lets you input the guest user's email address, and any customized message you want to include in the body of the invitation. After you send the invitation, the user is listed in your directory as a guest type user. The user receives an email invitation, like the following.

:::image type="content" source="../media/3-user-accepts-invitation.png" alt-text="Screenshot of invitation email." loc-scope="other"::: <!-- APEX 10 -->

The user selects the link in the email invitation to access the application.

## Enable application owners to manage guest users

An organization can have application owners, who decide who is and isn't allowed to use a particular application. These owners typically have a good idea of what type of usage is expected from an application. They're in a good position to decide who should be a guest user for a particular application.

Azure AD B2B allows you to delegate guest user access to these application owners. You configure self-service management to allow application owners to use the applications access panel, to invite guest users to a particular application. First, you allow self-service group management for your directory in the Azure portal. You create a group for the application, and set the owner for it. Then, you configure the application for self-service and assign your group to it.

## Protect your shared applications through policies

You can use Conditional Access policies to intelligently grant or deny access, according to factors that aren't credential-based. Conditional Access policies can add extra layers of security to your applications and resources by enforcing conditions. A user who has otherwise verified credentials is denied if they don't meet certain conditions.

These conditions might be device-based. You can make it mandatory for users to be on specific device platforms, such as Android or Windows, before they're granted access to resources. Conditions can also be location-based. You block users if they don't meet the required location criteria when they're attempting to access your applications.

You enforce policies by going to your application in the Azure AD settings in the Azure portal. Then you use the Conditional Access policies form to create a new policy. You select which users should be affected by the policy, and decide on the conditions you want to put in place. For example, you might only allow users to sign in from an approved location. You can enforce policies at an application level, tenant level, or user level.
