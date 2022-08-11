To enable RDP Shortpath for managed networks, you need to enable the RDP Shortpath listener on the session host. You can enable RDP Shortpath on any number of session hosts used in your environment. However, there's no requirement to enable RDP Shortpath on all hosts in your host pool.

To enable the RDP Shortpath listener:

1.  Install administrative templates that add rules and settings for Azure Virtual Desktop. Download the [Azure Virtual Desktop policy templates file](https://aka.ms/avdgpo) (**AVDGPTemplate.cab**) and extract the contents of the .cab file and .zip archive.
2.  Copy the **terminalserver-avd.admx** file, then paste it into the *%windir%\\PolicyDefinitions* folder.
3.  Copy the `en-us\terminalserver-avd.adml`file, then paste it into the`%windir%\PolicyDefinitions\en-us` folder.
4.  To confirm the files copied correctly, open the Group Policy Editor and go to **Computer Configuration,** select **Administrative Templates,** select **Windows Components,** select **Remote Desktop Services,** select **Remote Desktop Session Host,** and select **Azure Virtual Desktop**.
5.  You should see one or more Azure Virtual Desktop policies.
    
    :::image type="content" source="../media/azure-virtual-desktop-group-policy-object-58b85147.png" alt-text="Screenshot showing Azure Desktop policies.":::
    

6.  Open the **Enable RDP Shortpath for managed networks** policy and set it to **Enabled**. If you enable this policy setting, you can also configure the port number that the Azure Virtual Desktop session host will use to listen for incoming connections. The default port is **3390**.
7.  Restart your session host to apply the changes.
