Your goal is to change the tenant display name.

1. Browse to the [Azure portal](https://portal.azure.com/) and sign in using an Administrator account for the directory.
2. Select the **Show portal menu** hamburger icon and then select **Microsoft Entra ID**.
    
   :::image type="content" source="../media/azure-portal-menu-azure-active-directory.png" alt-text="Screenshot of the Azure portal menu with Microsoft Entra ID selected.":::
    
3. In the left navigation, in the Manage section, select **Properties**.
4. In the **Name** box, change the tenant name. For example, Contoso Marketing Company can be changed to Contoso Marketing Company 2.
5. Select **Save** to update the tenant properties.

### Find the Country / region associated with your tenant

6. In the **Microsoft Entra ID** screen, in the Manage section, select **Properties**.
7. Under **Tenant properties**, locate **Country / region** and review the information.
    
   > [!IMPORTANT]
   > When the tenant is created, the Country / region is specified at that time. This setting can't be changed later.

### Find the location associated with your tenant

Just as the Country / region is found in the Microsoft Entra ID Properties dialog, so is the location information.

8. In the **Properties** screen, under **Tenant properties**, locate **Location** and review the information.
    
   :::image type="content" source="../media/azure-active-directory-properties-country-location.png" alt-text="Screenshot of the Microsoft Entra ID Properties with the Country or region settings highlighted.":::
    
### Find the tenant ID

Azure subscriptions have a trust relationship with Microsoft Entra ID. Microsoft Entra ID is trusted to authenticate users, services, and devices for the subscription. Each subscription has a tenant ID associated with it, and there are a few ways you can find the tenant ID for your subscription.

9. In the **Microsoft Entra ID** screen, in the Manage section, select **Properties**.
10. Under **Tenant properties**, locate **Tenant ID**. Tenant ID is your unique tenant identifier.
    
    :::image type="content" source="../media/portal-tenant-identifier.png" alt-text="Screenshot of the Tenant properties page with the Tenant ID box highlighted.":::
    

### Change the Technical contact, add your privacy info, Global privacy contact, and Privacy statement URL

Microsoft strongly recommends you add both your global privacy contact and your organization's privacy statement, so your internal employees and external guests can review your policies. Because privacy statements are uniquely created and tailored for each business, we strongly recommend you contact a lawyer for assistance.

> [!NOTE]
> For information about viewing or deleting personal data, see [Azure Data Subject Requests](/microsoft-365/compliance/gdpr-dsr-azure). For more information, see the [Service Trust portal](https://servicetrust.microsoft.com/ViewPage/GDPRGetStarted).

You add your organization's privacy information in the **Properties** area of Microsoft Entra ID. To access the Properties area and add your privacy information:

11. In the **Microsoft Entra ID** screen, in the Manage section, select **Properties**.
    
   :::image type="content" source="../media/properties-area.png" alt-text="Screenshot of the tenant properties with the Technical contact, Global contact, and Privacy statement boxes highlighted.":::
    
12. Add your privacy info for your employees:
    
   - **Technical contact**. Type the email address for the person to contact for technical support within your organization.
   - **Global privacy contact**. Type the email address for the person to contact for inquiries about personal data privacy. This person is also who Microsoft contacts if there's a data breach. If there's no person listed here, Microsoft contacts the administrator who owns the tenant.
   - **Privacy statement URL**. Type the link to your organization's document that describes how your organization handles both internal and external guest's data privacy.
        
      :::image type="content" source="../media/active-directory-privacy-statement-contact.png" alt-text="Screenshot of the B 2 B Collaboration Review permissions box with Accept / Cancel buttons.":::
        
13. Select **Save**.
