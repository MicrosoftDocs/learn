## Enable user risk policy

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) using a Global administrator account.
2.  Open the portal menu and then select **Identity**.
3.  On the Identity menu, select **Protection**.
4.  On the Security blade, in the left navigation, select **Identity protection**.
5.  In the Identity protection blade, in the left navigation, select User risk policy.
    
    :::image type="content" source="../media/browse-identity-protection-77fc07bc.png" alt-text="Screenshot of the User risk policy page and highlighted browsing path.":::
    
6.  Under **Assignments**, select **All users** and review the available options. You can select from **All users** or **Select individuals and groups** if limiting your rollout. Additionally, you can choose to exclude users from the policy.
7.  Under **User risk**, select **Low and above**.
8.  In the User risk pane, select **High** and then select **Done**.
9.  Under **Controls**, then **Access**, and then select **Block access**.
10. In the Access pane, review the available options.
    
    > [!TIP]
    > Microsoft's recommendation is to Allow access and Require password change.
11. Select the **Require password change** check box and then select **Done**.
12. Under **Enforce Policy**, select **On** and then select **Save**.

## Enable sign-in risk policy

1.  On the Identity protection blade, in the left navigation, select **Sign-in risk policy**.
2.  As with the User risk policy, the Sign-in risk policy can be assigned to users and groups and allows you to exclude users from the policy.
3.  Under **Sign-in risk**, select **Medium and above**.
4.  In the Sign-in risk pane, select **High** and then select **Done**.
5.  Under **Controls**, then **Access**, and then select **Block access**.
6.  Select the **Require multifactor authentication** check box and then select **Done**.
7.  Under **Enforce Policy**, select **On** and then select **Save**.
