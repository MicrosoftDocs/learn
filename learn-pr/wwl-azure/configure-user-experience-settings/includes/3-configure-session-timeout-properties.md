Signing users out when they're inactive preserves resources and prevents access by unauthorized users. We recommend that timeouts balance user productivity and resource usage. For users that interact with stateless applications, consider more aggressive policies that turn off machines and preserve resources.

The timeout options for RDP are set on the servers in the Local Group Policy. ‎ ‎

1.  ‎To edit Group Policy settings, press the Windows button and type *group policy* or *gpedit.msc*. In the results that return, select **Edit group policy** to open Local Group Policy Editor.
2.  ‎Navigate to **Computer Configuration &gt; Administrative Templates &gt; Windows Components &gt; Remote Desktop Services &gt; Remote Desktop Session Host &gt; Session Time Limits**.
     -  Set time limit for disconnected sessions.
     -  Set time limit for active but idle Remote Desktop Services sessions.
     -  Set time limit for active Remote Desktop Services sessions.
     -  End Session when time limits are reached.

4.  Click **Enabled**.
5.  Select the desired time for logoff delay, and click **OK**.
6.  At a command prompt, type `gpupdate` and press **ENTER** to force the policy to refresh immediately.
