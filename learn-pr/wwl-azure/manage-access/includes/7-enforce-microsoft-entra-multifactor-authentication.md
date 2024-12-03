Users can sign into Azure Virtual Desktop from anywhere using different devices and clients. However, there are certain measures you should take to help keep your environment and your users safe. Using Microsoft Entra multifactor authentication (MFA) with Azure Virtual Desktop prompts users during the sign-in process for another form of identification in addition to their username and password. You can enforce MFA for Azure Virtual Desktop using Conditional Access, and can also configure whether it applies to the web client, mobile apps, desktop clients, or all clients.

When a user connects to a remote session, they need to authenticate to the Azure Virtual Desktop service and the session host. If MFA is enabled, it's used when connecting to the Azure Virtual Desktop service and the user is prompted for their user account and a second form of authentication, in the same way as accessing other services. When a user starts a remote session, a username and password is required for the session host, but this is seamless to the user if single sign-on (SSO) is enabled. For more information, see [Authentication methods](/azure/virtual-desktop/authentication#authentication-methods).

Here's what you need to get started:

 -  Assign users a license that includes [Microsoft Entra ID P1 or P2](/azure/active-directory/authentication/concept-mfa-licensing).
 -  A [Microsoft Entra group](/azure/active-directory/fundamentals/active-directory-groups-create-azure-portal) with your Azure Virtual Desktop users assigned as group members.
 -  [Enable Microsoft Entra multifactor authentication](/azure/active-directory/authentication/tutorial-enable-azure-mfa).

## Create a Conditional Access policy

Here's how to create a Conditional Access policy that requires multifactor authentication when connecting to Azure Virtual Desktop:

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Conditional Access Administrator](/entra/identity/role-based-access-control/permissions-reference#conditional-access-administrator).
2.  Browse to **Protection &gt; Conditional Access &gt; Policies**.
3.  Select **New policy**.
4.  Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
5.  Under **Assignments &gt; Users**, select **0 users and groups selected**.
6.  Under the Include tab, select **Select users and groups** and check **Users and groups**, then under **Select**, select 0 users and groups selected.
7.  On the new pane that opens, search for and choose the group that contains your Azure Virtual Desktop users as group members, then select **Select**.
8.  Under **Assignments &gt; Target resources**, select **No target resources** selected.
9.  Under the **Include** tab, select **Select apps**, then under **Select**, select **None**.
10. On the new pane that opens, search for and select the necessary apps based on the resources you're trying to protect. Select the relevant tab for your scenario. When searching for an application name on Azure, use search terms that begin with the application name in order instead of keywords the application name contains out of order. For example, when you want to use Azure Virtual Desktop, you need to enter '*Azure Virtual*', in that order. If you enter '*virtual*' by itself, the search doesn't return the desired application.
    
    For Azure Virtual Desktop (based on Azure Resource Manager), you can configure MFA on these different apps:
    
    
     -  **Azure Virtual Desktop** (app ID 9cdead84-a844-4324-93f2-b2e6bb768d07), which applies when the user subscribes to Azure Virtual Desktop, authenticates to the Azure Virtual Desktop Gateway during a connection, and when diagnostics information is sent to the service from the user's local device.
     -  **Microsoft Remote Desktop** (app ID a4a365df-50f1-4397-bc59-1a1564b8bb9c) and Windows Cloud Login (app ID 270efc09-cd0d-444b-a71f-39af4910ec45). These apply when the user authenticates to the session host when [single sign-on](/azure/virtual-desktop/configure-single-sign-on) is enabled. It's recommended to match conditional access policies between these apps and the Azure Virtual Desktop app, except for the [sign-in frequency](/azure/virtual-desktop/set-up-mfa?tabs=avd#configure-sign-in-frequency).
11. Once you selected your apps, select **Select**.
    
    :::image type="content" source="../media/cloud-apps-enterprise-a59d779c.png" alt-text="A screenshot of the Conditional Access Cloud apps or actions page.":::
    
12. Under **Assignments &gt; Conditions**, select **0 conditions select.**
13. Under **Client apps**, select **Not configured**.
14. On the new pane that opens, for **Configure**, select **Yes**.
15. Select the client apps this policy applies to:
    
    
     -  Select **Browser** if you want the policy to apply to the web client.
     -  Select **Mobile apps** and desktop clients if you want to apply the policy to other clients.
     -  Select both check boxes if you want to apply the policy to all clients.
     -  Deselect values for legacy authentication clients.
    
    :::image type="content" source="../media/conditional-access-client-apps-257d3801.png" alt-text="A screenshot of the Conditional Access Client apps page.":::
    
16. Once you selected the client apps this policy applies to, select **Done**.
17. Under **Access controls &gt; Grant**, select **0 controls selected**.
18. On the new pane that opens, select **Grant access**.
19. Check **Require multifactor authentication**, and then select **Select**.
20. At the bottom of the page, set **Enable policy** to **On** and select **Create**.

> [!NOTE]
> When you use the web client to sign in to Azure Virtual Desktop through your browser, the log will list the client app ID as a85cf173-4192-42f8-81fa-777a763e6e2c (Azure Virtual Desktop client). This is because the client app is internally linked to the server app ID where the conditional access policy was set.
