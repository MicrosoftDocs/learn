Microsoft Entra pass-through authentication allows your users to sign in to both on-premises and cloud-based applications by using the same passwords. Pass-through authentication signs users in by validating their passwords directly against on-premises Active Directory.

## Enable the feature

Enable pass-through authentication through [Microsoft Entra Connect](/azure/active-directory/hybrid/whatis-hybrid-identity).

If you're installing Microsoft Entra Connect for the first time, choose the [custom installation path](/azure/active-directory/hybrid/how-to-connect-install-custom). At the **User sign-in** page, choose **Pass-through authentication** as the **Sign On method**. On successful completion, a pass-through authentication agent is installed on the same server as Microsoft Entra Connect. In addition, the pass-through authentication feature is enabled on your tenant.

:::image type="content" source="../media/single-sign-on-fd559a4b.png" alt-text="Screenshot of the Microsoft Entra Connect user interface. The User sign-in option is selected and the user has choices of different types of sign-in options.":::


If you have already installed Microsoft Entra Connect by using the express installation or the custom installation path, select the **Change user sign-in** task on Microsoft Entra Connect, and then select **Next**. Then select **Pass-through authentication** as the sign-in method. On successful completion, a pass-through authentication agent is installed on the same server as Microsoft Entra Connect and the feature is enabled on your tenant.

:::image type="content" source="../media/change-user-sign-in-60b54bee.png" alt-text="Screenshot of the Microsoft Entra Connect Tasks screen when you can select how users sign into Microsoft Entra ID after the on-premises connection is made.":::


> [!IMPORTANT]
> Pass-through authentication is a tenant-level feature. Turning it on affects the sign-in for users across all the managed domains in your tenant. If you're switching from Active Directory Federation Services (AD FS) to Pass-through authentication, you should wait at least 12 hours before shutting down your AD FS infrastructure. This wait time is to ensure that users can keep signing in to Exchange ActiveSync during the transition.
