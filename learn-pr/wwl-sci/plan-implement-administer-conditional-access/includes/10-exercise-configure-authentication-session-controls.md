## Configure sign in frequency controls using a conditional access policy

1. Sign in to the [Azure portal](https://portal.azure.com/) using a Global administrator account.
1. Open the portal menu and then select **Azure Active Directory**.
1. On the Azure Active Directory blade, under **Manage**, select **Security**.
1. On the Security blade, in the left navigation, select **Conditional access**.
1. On the top menu, select **New policy**.
    
    :::image type="content" source="../media/conditional-access-new-policy-c60e6317.png" alt-text="Screenshot of the Conditional Access blade with New policy highlighted.":::
    
1. In the **Name** box, enter **Sign in frequency**.
1. Under **Assignments**, select **Users and groups**.
1. On the Include tab, select the **Users and groups** check box.
1. In the Select pane, select your administrator account and then select **Select**.
1. Select **Cloud apps or actions**.
1. Verify **Cloud apps** is selected and then select **Select apps**.
1. In the Select pane, select **Office 365** and then select **Select**.
1. Under **Access controls**, select **Session**.
1. In the **Session** pane, select **Sign-in frequency**.
1. In the value box, enter **30**.
1. Select the units menu, select **Days**, and then select **Select**.
1. Under **Enable policy**, select **Report-only**, and then select **Create**.
    
    :::image type="content" source="../media/create-session-conditional-access-policy-0f474d5f.png" alt-text="Screenshot of the new conditional access policy with policy settings highlighted.":::
    
