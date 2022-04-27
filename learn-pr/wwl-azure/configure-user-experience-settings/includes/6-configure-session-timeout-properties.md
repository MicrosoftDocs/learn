Signing users out when they're inactive preserves resources and prevents access by unauthorized users. We recommend that timeouts balance user productivity and resource usage. For users that interact with stateless applications, consider more aggressive policies that turn off machines and preserve resources.

The timeout options for RDP are set on the servers in the Local Group Policy. ‎ ‎Configure session time limits listed below: ‎ ‎1. To edit Group Policy settings, press the Windows button and type *group policy* or *gpedit.msc*. In the results that return, click **Edit group policy** to open Local Group Policy Editor.

‎2. Navigate to **Computer Configuration &gt; Administrative Templates &gt; Windows Components &gt; Remote Desktop Services &gt; Remote Desktop Session Host &gt; Session Time Limits**.

:::image type="content" source="../media/group-policy-timeout-1-3f543666.png" alt-text="Screenshot of Session Time Limits.":::
‎ ‎3. In the right pane of the Local Group Policy Editor, double-click to configure:

 -  Set time limit for disconnected sessions.
 -  Set time limit for active but idle Remote Desktop Services sessions.
 -  Set time limit for active Remote Desktop Services sessions.
 -  End Session when time limits are reached.

For example the, **Set time limit for logoff of RemoteApp sessions** is seen in the graphic below.

:::image type="content" source="../media/group-policy-timeout-2-258f97f7.png" alt-text="Set time limit for logoff of RemoteApp sessions.":::


4.  Click **Enabled**.
5.  Select the desired time for logoff delay, and click **OK**.
6.  At a command prompt, type `gpupdate` and press **ENTER** to force the policy to refresh immediately.
