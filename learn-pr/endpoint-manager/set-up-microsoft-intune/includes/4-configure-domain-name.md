When your organization signs up for Microsoft Intune, you're given an initial domain name hosted in Microsoft Entra ID that looks like *your-domain.onmicrosoft.com*. In this example, *your-domain* is the domain name that you chose when you signed up. *onmicrosoft.com* is the suffix assigned to all accounts added to subscriptions. You can optionally configure your organization's custom domain to access Intune, instead of the domain name provided with your subscription.

> [!NOTE]
> Setting up a custom domain name is optional. If you are simply evaluating Intune using the free trial, you can skip the steps in this section.

Microsoft Entra ID is the underlying infrastructure that supports identity management for all Microsoft cloud services. Microsoft Entra ID stores information about license-assignment states for users. A [Microsoft Entra tenant](/previous-versions/azure/azure-services/jj573650(v=azure.100)) hosts your subscription to Intune. The tenant represents your organization. It's a dedicated instance of Microsoft Entra ID that your organization receives at the beginning of a relationship with Microsoft. It's in this Microsoft Entra tenant that you register and manage your end user's devices and apps.

Before you create user accounts or synchronize your on-premises Active Directory for those using Endpoint Configuration Manager, we strongly recommend that you decide whether to use only the *.onmicrosoft.com* domain or to add one or more of your custom domain names. Setting up a custom domain before adding users simplifies user management. Setting up a custom domain lets users sign in with the credentials they use to access your organization's other domain resources.

> [!TIP]
> To learn more about custom domains, see [Managing custom domain names in your Microsoft Entra ID](/azure/active-directory/enterprise-users/domains-manage?azure-portal=true).

You wouldn't rename or remove the initial *onmicrosoft.com* domain name. However, you can add, verify, or remove a custom domain name used with Intune to keep your business identity clear. You must have access to your own custom domain name in order to add it to your Intune tenant.

## Add and verify your custom domain (OPTIONAL)

1. Go to [Microsoft 365 admin center](https://admin.microsoft.com/?azure-portal=true) and sign into your administrator account.
1. In the navigation pane, choose **Setup** > **Get your custom domain set up** > **Get started**.

   > [!TIP]
   > In this step, you see a provided video. Viewing this video also shows you how to add your domain.

1. Add your domain name, then select **Use this domain**.

   :::image type="content" source="../media/sign-up-for-intune-08.png" alt-text="Screenshot of Microsoft 365 admin center - Add a new domain.":::

   If you're using a common domain registrar like GoDaddy or WordPress, verifying your domain is a quick process. In this case, you see a **Sign in** option to verify your domain.

   The **Verify domain** dialog box opens, giving you the values to create the TXT record in your DNS hosting provider.

   - **GoDaddy users**: Microsoft 365 admin center redirects you to GoDaddy's login page. After you enter your credentials and accept the domain change permission agreement, the TXT record is created automatically. You can alternatively [create the TXT record](/microsoft-365/admin/dns/create-dns-records-at-godaddy#add-a-txt-record-for-verification).
   - **Register.com users**: Follow the [step-by-step instructions](/microsoft-365/admin/get-help-with-domains/create-dns-records-at-any-dns-hosting-provider#step-1-add-a-txt-or-mx-record-to-verify-you-own-the-domain) to create the TXT record.

1. If you see the options to add a TXT record, add an MX record, or add a text file to the domain's website, choose how to verify your domain.

   :::image type="content" source="../media/sign-up-for-intune-08a.png" alt-text="Screenshot of Microsoft 365 admin center - Verify your domain.":::

   The steps to add and verify a custom domain can also be [performed in Microsoft Entra ID](/azure/active-directory/fundamentals/add-custom-domain?azure-portal=true).

## Learn more

- For more information about domains, see [Domain FAQ](https://support.office.com/article/About-your-initial-onmicrosoft-com-domain-in-Office-365-B9FC3018-8844-43F3-8DB1-1B3A8E9CFD5A?azure-portal=true).
- You can learn more about how to [simplify Windows enrollment without Microsoft Entra ID P1 or P2](/mem/intune/enrollment/windows-enroll) by creating a DNS CNAME that redirects enrollment to Intune servers.
