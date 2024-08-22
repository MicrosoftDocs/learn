When you add session hosts to a host pool, first you'll need to generate a registration key. A registration key needs to be generated per host pool and it authorizes session hosts to join that host pool. It's only valid for the duration you specify. If an existing registration key has expired, you can also use these steps to generate a new key.

Here's how to generate a registration key using the Azure portal.<br>

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  In the search bar, type *Azure Virtual Desktop* and select the matching service entry.
3.  Select **Host pools**, then select the name of the host pool you want to generate a registration key for.
4.  On the host pool overview, select **Registration key**.
5.  Select **Generate new key,** then enter an expiration date and time and select **OK**. The registration key will be created.
6.  Select **Download** to download a text file containing the registration key, or copy the registration key to your clipboard to use later. You can also retrieve the registration key later by returning to the host pool overview.

## Create and register session hosts with the Azure Virtual Desktop service

You can create session hosts and register them to a host pool in a single end-to-end process with the Azure Virtual Desktop service using the Azure portal or an ARM template. You can find some example ARM templates in our [GitHub repo](https://github.com/Azure/RDS-Templates/tree/master/ARM-wvd-templates).

> [!IMPORTANT]
> If you want to create virtual machines using an alternative method outside of Azure Virtual Desktop, such as an automated pipeline, you'll need to register them separately as session hosts to a host pool. Skip to the section [Register session hosts to a host pool](/azure/virtual-desktop/add-session-hosts-host-pool?tabs=portal%2Cgui#register-session-hosts-to-a-host-pool).

Here's how to create session hosts and register them to a host pool using the Azure Virtual Desktop service in the Azure portal. Make sure you're generated a registration key first.

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  In the search bar, enter *Azure Virtual Desktop* and select the matching service entry.
3.  Select **Host pools**, then select the name of the host pool you want to add session hosts to.
4.  On the host pool overview, select **Session hosts**, then select **+ Add**.
5.  The **Basics** tab will be greyed out because you're using the existing host pool. Select **Next: Virtual Machines**.
6.  On the **Virtual machines** tab, expand one of the following sections and complete the information, depending on whether you want to create session hosts on Azure or Azure Stack HCI. For guidance on sizing session host virtual machines, see [Session host virtual machine sizing guidelines](/windows-server/remote/remote-desktop-services/virtual-machine-recs).<br>
    
    Once you've completed this tab, select **Next: Tags**.
7.  On the **Tags** tab, you can optionally enter any name/value pairs you need, then select **Next: Review + create**.
8.  On the **Review +** create tab, ensure validation passes and review the information that will be used during deployment. If validation doesn't pass, review the error message and check what you entered in each tab.
9.  Select **Create**. Once your deployment is complete, the session hosts should appear in the host pool.

> [!IMPORTANT]
> Once you've added session hosts with the Azure Virtual Desktop service, skip to the section [Post deployment](/azure/virtual-desktop/add-session-hosts-host-pool?tabs=portal%2Cgui#post-deployment) for some extra configuration you may need to do.

## Register session hosts to a host pool

If you created virtual machines using an alternative method outside of Azure Virtual Desktop, such as an automated pipeline, you'll need to register them separately as session hosts to a host pool. To register session hosts to a host pool, you need to install the Azure Virtual Desktop Agent and the Azure Virtual Desktop Agent Bootloader on each virtual machine and use the registration key you generated. You can register session hosts to a host pool using the agent installers' graphical user interface (GUI) or using msiexec from a command line. Once complete, four applications will be listed as installed applications:

 -  Remote Desktop Agent Boot Loader.
 -  Remote Desktop Services Infrastructure Agent.
 -  Remote Desktop Services Infrastructure Geneva Agent.
 -  Remote Desktop Services SxS Network Stack.

1.  Make sure the virtual machines you want to use as session hosts are joined to Microsoft Entra ID or an Active Directory domain (AD DS or Microsoft Entra Domain Services).
2.  If your virtual machines are running a Windows Server OS, you'll need to install the *Remote Desktop Session Host* role, then restart the virtual machine. For more information, see [Install roles, role services, and features by using the add Roles and Features Wizard](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features#install-roles-role-services-and-features-by-using-the-add-roles-and-features-wizard).
3.  Sign in to your virtual machine as an administrator.
4.  Download the Agent and the Agent Bootloader installation files using the following links.
    
    
     -  [Azure Virtual Desktop Agent](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv)
     -  [Azure Virtual Desktop Agent Bootloader](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH)
    
    > [!TIP]
    > The Azure Virtual Desktop Agent download link is for the latest production version in [non-validation environments](/azure/virtual-desktop/terminology#validation-environment). This download link is updated once the automatic production rollout is complete, so you might see a delay between a production version being released and the download link being updated. Once the Azure Virtual Desktop Agent is installed, it's updated automatically. For more information about the rollout of new versions of the agent, see [What's new in the Azure Virtual Desktop Agent](/azure/virtual-desktop/whats-new-agent#latest-available-versions).
5.  Run the **Microsoft.RDInfra.RDAgent.Installer-x64-&lt;version&gt;.msi** file to install the **Remote Desktop Services Infrastructure Agent**.
6.  Follow the prompts and when the installer prompts for the registration token, paste it into the text box, which will appear on a single line. Select **Next**, then complete the installation.
7.  Run the **Microsoft.RDInfra.RDAgentBootLoader.Installer-x64.msi** file to install the remaining components.
8.  Follow the prompts and complete the installation.
9.  After a short time, the virtual machines should now be listed as session hosts in the host pool. The status of the session hosts may initially show as **Unavailable** and if there's a newer agent version available, it will upgrade automatically.

### Licensing

To ensure your session hosts have licenses applied correctly, you'll need to do the following tasks:

 -  If you have the correct licenses to run Azure Virtual Desktop workloads, you can apply a Windows or Windows Server license to your session hosts as part of Azure Virtual Desktop and run them without paying for a separate license. This is automatically applied when creating session hosts with the Azure Virtual Desktop service, but you may have to apply the license separately if you create session hosts outside of Azure Virtual Desktop. For more information, see [Apply a Windows license to session host virtual machines](/azure/virtual-desktop/apply-windows-license).
 -  If your session hosts are running a Windows Server OS, you'll also need to issue them a Remote Desktop Services (RDS) Client Access License (CAL) from a Remote Desktop Licensing Server. For more information, see [License your RDS deployment with client access licenses (CALs)](/windows-server/remote/remote-desktop-services/rds-client-access-license).
 -  For session hosts on Azure Stack HCI, you must license and activate the virtual machines you use before you use them with Azure Virtual Desktop. For activating Windows 10 and Windows 11 Enterprise multi-session, and Windows Server 2022 Datacenter: Azure Edition, use [Azure verification for VMs](/azure-stack/hci/deploy/azure-verification). For all other OS images (such as Windows 10 and Windows 11 Enterprise, and other editions of Windows Server), you should continue to use existing activation methods. For more information, see [Activate Windows Server VMs on Azure Stack HCI](/azure-stack/hci/manage/vm-activate).
