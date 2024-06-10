To onboard your on-premises machines by using the Azure portal, do this procedure.

1.  Select **Windows servers**.
    
    :::image type="content" source="../media/windows-servers-added-d15c1de0.png" alt-text="Displays a screenshot of the controls for selecting Windows Servers.":::
    
    
    When you add a Windows server, you need to get the information on the Agents management page and download the appropriate agent file (32 bit or 64 bit).
2.  Select the **Download Windows Agent** link that's applicable to your computer processor type to download the setup file.
3.  From the **Agents management** page, copy the **Workspace ID** and **Primary Key** values into Notepad.
4.  Copy the downloaded setup file to the target computer and run it.
5.  Follow the installation wizard (select **Next &gt; I Agree &gt; Next &gt; Next**).
6.  On the **Azure Log Analytics** page, paste the Workspace ID and Primary Key values that you copied into Notepad.
7.  If the computer should report to a Log Analytics workspace in the Azure Government cloud, select **Azure US Government** from the **Azure Cloud** dropdown list.
8.  If the computer needs to communicate through a proxy server to the Log Analytics service, select **Advanced**. Then provide the URL and port number of the proxy server.
9.  When you finish entering all of the configuration settings, select **Next**.
10. On the **Ready to Install** page, review the settings to be applied and select **Install**.
11. On the **Configuration completed successfully** page, select **Finish**.

When the process is complete, **Microsoft Monitoring agent** appears in Control Panel. You can review your configuration there and verify that the agent is connected.
