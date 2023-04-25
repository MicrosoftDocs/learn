
When you use only on-premises AD DS, your users can't reset their forgotten passwords by themselves. AD DS in Windows Server doesn't natively support self-service password reset.

Azure AD optionally provides the self-service password reset functionality. If you use Azure AD Premium P1 or P2 licensing, you can extend this functionality to your local AD DS, when you use the self-service password reset together with the password writeback functionality. When you do this, passwords that users reset in Azure AD are written back to AD DS on premises. This means that a user can change his or her password in both a cloud or on-premises environment.

Before your users start to use self-service password reset, you must enable this functionality in the Azure portal by selecting the Password reset item on your directory tenant administration pane. First, you should decide if this functionality will be enabled for all users or just for a selected group of users. During the pilot phase, we recommend that you limit password reset to a smaller group of users.

The self-service password reset functionality requires that you define alternative methods of authentication for users that have forgotten their passwords. Alternative authentication methods that are supported on Azure AD can be:

 -  Office phone
 -  Mobile phone
 -  Alternative email address
 -  Security questions

:::image type="content" source="../media/azure-active-directory-password-reset-0fa4c0d8.png" alt-text="Screenshot of the Password reset - Authentication methods screen.":::


You must choose how many methods the user must have defined to be able to reset their password. For phone and alternative email options, the user is provided with a security PIN over the phone or in an email message that they can use as an authentication method before resetting the password. If you choose to use security questions, you must define the number of questions required for each user, and you must also predefine the question pool.

We recommend that you offer at least 10 to 15 available questions and that you require that each user register at least four questions for password-reset functionality. If you don't like the pool of predefined questions, you also can define your own questions in your local language.

When you refine requirements for authentication methods, you should configure options for the self-service password reset functionality’s deployment and usage. We recommend that you require all users to register their alternative authentication methods the next time they sign in and also to confirm their authentication methods at least twice a year. This ensures that each user is able to verify their identity by using some alternative methods. Also, if you have directory synchronization implemented, you should consider enabling the password writeback functionality to ensure that passwords that users reset by using self-service password reset in Azure are synced back to AD DS.

Users can register for the self-service password reset functionality by using the Azure AD application portal, available at https://myapps.microsoft.com. They can also use this portal to change the password and to set up alternative methods of verifying identity, such as authentication phone or alternative email address. If users forget their password when accessing a cloud-based resource, such as Microsoft 365, they should select the link **Can’t access your account** to start using an alternative method to reset a password.
