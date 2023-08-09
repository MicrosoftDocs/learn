

Joining a device to Azure AD is not a complicated procedure. You can do it right after the Windows OS installation, or you can do it later, at any time. To join a Windows device to Azure AD at the end of Windows setup process, follow these steps:

1.  When you turn on your new device and start the setup process, you should see the Getting Ready message. Follow the prompts to set up your device.
2.  Start by customizing your region and language. Then accept the Microsoft Software License Terms.
    
    :::image type="content" source="../media/customize-region-a7af67b2.png" alt-text="Screenshot of the Customize for your region screen.":::
    

3.  Select the network you want to use for connecting to the internet.
4.  Select **This device belongs to my organization**.
    
    :::image type="content" source="../media/personal-computer-owner-02d1488b.png" alt-text="Screenshot showing Who owns this PC? screen.":::
    

5.  Enter the credentials that were provided to you by your organization, and then select **Sign in**.
    
    :::image type="content" source="../media/work-account-sign-419af822.png" alt-text="Screenshot of the Sign in screen.":::
    

6.  Your device locates a matching tenant in Azure AD. If you’re in a federated domain, you’re redirected to your on-premises Secure Token Service (STS) server, for example, Active Directory Federation Services (AD FS).
7.  If you’re a user in a non-federated domain, enter your credentials directly on the Azure AD-hosted page.
8.  You’re prompted for a multi-factor authentication challenge.
9.  Azure AD checks whether an enrollment in mobile device management is required.
10. Windows registers the device in the organization’s directory in Azure AD and enrolls it in mobile device management, if applicable.
11. If you are:
    
     -  A managed user, Windows takes you to the desktop through the automatic sign-in process.
     -  A federated user, you’re directed to the Windows sign-in screen to enter your credentials.
