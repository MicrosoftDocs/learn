## Configure sign in frequency controls using a conditional access policy

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) using a Global administrator account.
2.  Open the portal menu and then select **Identity**.
3.  On the Identity menu, then select **Protection**.
4.  On the Protection menu, select **Conditional access**.
5.  On the top menu, select **New policy**.
    
    :::image type="content" source="../media/conditional-access-new-policy-c60e6317.png" alt-text="Screenshot of the Conditional Access blade with New policy highlighted.":::
    
6.  In the **Name** box, enter **Sign in frequency**.
7.  Under **Assignments**, select **Users and groups**.
8.  On the Include tab, select the **Users and groups** check box.
9.  In the Select pane, select your administrator account and then select **Select**.
10. Select **Cloud apps or actions**.
11. Verify **Cloud apps** is selected and then select **Select apps**.
12. In the Select pane, select **Office 365** and then select **Select**.
13. Under **Access controls**, select **Session**.
14. In the **Session** pane, select **Sign-in frequency**.
15. In the value box, enter **30**.
16. Select the units menu, select **Days**, and then select **Select**.
17. Under **Enable policy**, select **Report-only**, and then select **Create**.
    
    :::image type="content" source="../media/create-session-conditional-access-policy-0f474d5f.png" alt-text="Screenshot of the new conditional access policy with policy settings highlighted.":::
    
