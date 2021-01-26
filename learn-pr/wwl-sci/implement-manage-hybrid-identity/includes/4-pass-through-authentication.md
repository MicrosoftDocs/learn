Azure Active Directory (Azure AD) pass-through authentication allows your users to sign in to both on-premises and cloud-based applications by using the same passwords. Pass-through authentication signs users in by validating their passwords directly against on-premises Active Directory.

## Enable the feature

Enable pass-through authentication through [Azure AD Connect](https://docs.microsoft.com/azure/active-directory/hybrid/whatis-hybrid-identity).

If you're installing Azure AD Connect for the first time, choose the [custom installation path](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-install-custom). At the **User sign-in** page, choose **Pass-through authentication** as the **Sign On method**. On successful completion, a pass-through authentication agent is installed on the same server as Azure AD Connect. In addition, the pass-through authentication feature is enabled on your tenant.

> [!div class="mx-imgBorder"]
> ![Azure AD Connect: User sign-in.](../media/sso3.png)

If you have already installed Azure AD Connect by using the express installation or the custom installation path, select the **Change user sign-in** task on Azure AD Connect, and then select **Next**. Then select **Pass-through authentication** as the sign-in method. On successful completion, a pass-through authentication agent is installed on the same server as Azure AD Connect and the feature is enabled on your tenant.

> [!div class="mx-imgBorder"]
> ![Azure AD Connect: Change user sign-in.](../media/change-user-sign-in.png)

> [!IMPORTANT]
> Pass-through authentication is a tenant-level feature. Turning it on affects the sign-in for users across all the managed domains in your tenant. If you're switching from Active Directory Federation Services (AD FS) to Pass-through authentication, you should wait at least 12 hours before shutting down your AD FS infrastructure. This wait time is to ensure that users can keep signing in to Exchange ActiveSync during the transition. 

