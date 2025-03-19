This unit shows you how to set up an Azure NetApp Files account and create FSLogix profile containers in Azure Virtual Desktop. It assumes you have already created a host pool and an application group.

The instructions in this unit are specifically for Azure Virtual Desktop users.

To get started, you need to set up an Azure NetApp Files account.

1.  Sign in to the [Azure portal](https://portal.azure.com/). Make sure your account has contributor or administrator permissions.
2.  In the left side of the window, select **All services**. Enter **Azure NetApp Files** into the search box that appears at the top of the menu.
    
    :::image type="content" source="../media/azure-netapp-files-search-box-19817e40.png" alt-text="Screenshot of entering Azure NetApp File into the All services search box.":::
    
3.  Select **Azure NetApp Files** in the search results, then select **Create**.
4.  When the **New NetApp account** tab opens, enter the following values:
    
    
     -  For **Name**, enter your NetApp account name.
     -  For **Subscription**, select the subscription for the storage account you set up in step 4 from the drop-down menu.
     -  For **Resource group**, either select an existing resource group from the drop-down menu or create a new one by selecting **Create new**.
     -  For **Location**, select the region for your NetApp account from the drop-down menu. This region must be the same region as your session host VMs.
5.  When you're finished, select **Create** to create your NetApp account.

## Create a capacity pool

Next, create a new capacity pool:

1.  Go to the Azure NetApp Files menu and select your new account.
2.  In your account menu, select **Capacity pools** under Storage service.
3.  Select **Add pool**.
4.  When the **New capacity pool** tab opens, enter the following values:
    
    
     -  For **Name**, enter a name for the new capacity pool.
     -  For **Service level**, select your desired value from the drop-down menu. We recommend **Premium** for most environments.
     -  For **Size (TiB)**, enter the capacity pool size that best fits your needs.
5.  When you're finished, select **OK**.

## Join an Active Directory connection

After that, you need to join an Active Directory connection.

1.  Select **Active Directory connections** in the menu on the left side of the page, then select the **Join** button to open the **Join Active Directory** page.
    
    :::image type="content" source="../media/active-directory-connections-menu-2-a612de8e.png" alt-text="Screenshot of the Join Active Directory connections menu.":::
    
2.  Enter the following values in the **Join Active Directory** page to join a connection:
    
    
     -  For **Primary DNS**, enter the IP address of the DNS server in your environment that can resolve the domain name.
     -  For **Secondary DNS**, enter the IP address of the secondary DNS Server for the domain.
     -  For **AD DNS Domain Name**, enter your fully qualified domain name (FQDN).
     -  For **AD Site Name**, enter the Active Directory Site name that the domain controller discovery will be limited to. This should match the Site name in Active Directory Sites and Services for the Site created to represent the Azure virtual network environment. This Site must be reachable by Azure NetApp Files in Azure.
     -  For **SMB Server (Computer Account) Prefix**, enter the string you want to append to the computer account name.
     -  For **Organizational unit path**, this is the LDAP path for the organizational unit (OU) where SMB server machine accounts will be created. That is, OU=second level, OU=first level. If you are using Azure NetApp Files with Microsoft Entra Domain Services, the organizational unit path is OU=AADDC Computers when you configure Active Directory for your NetApp account.
     -  For **Credentials**, insert username and password:
        
        :::image type="content" source="../media/active-directory-connections-credentials-a6400b4d.png" alt-text="Screenshot of the Join Active Directory connections menu for username and password.":::
        
     -  Click **Join**, the Active Directory connection you created appears.
        
        :::image type="content" source="../media/active-directory-connections-show-dd72ba3e.png" alt-text="Screenshot displaying the Active Directory.":::
        

## Create a new volume

Next, you'll need to create a new volume.

1.  Select **Volumes**, then select **Add volume**.
2.  When the **Create a volume** tab opens, enter the following values:
    
    
     -  For **Volume name**, enter a name for the new volume.
     -  For **Capacity pool**, select the capacity pool you just created from the drop-down menu.
     -  For **Quota (GiB)**, enter the volume size appropriate for your environment.
     -  For **Virtual network**, select an existing virtual network that has connectivity to the domain controller from the drop-down menu.
     -  Under **Subnet**, select **Create new**. Keep in mind that this subnet will be delegated to Azure NetApp Files.
3.  Select **Next: Protocol &gt;&gt;** to open the Protocol tab and configure your volume access parameters.

## Configure volume access parameters

After you create the volume, configure the volume access parameters.

1.  Select **SMB** as the protocol type.
2.  Under Configuration in the **Active Directory** drop-down menu, select the same directory that you originally connected in [Join an Active Directory connection](/azure/virtual-desktop/create-fslogix-profile-container#join-an-active-directory-connection). Keep in mind that there's a limit of one Active Directory per subscription.
3.  In the **Share name** text box, enter the name of the share used by the session host pool and its users.
    
    It is recommended that you enable Continuous Availability on the SMB volume for use with FsLogix profile containers, so select **Enable Continuous Availability**. For more information see [Enable Continuous Availability on existing SMB volumes](/azure/azure-netapp-files/enable-continuous-availability-existing-smb).
4.  Select **Review + create** at the bottom of the page. This opens the validation page. After your volume is validated successfully, select **Create**.
5.  At this point, the new volume will start to deploy. Once deployment is complete, you can use the Azure NetApp Files share.
6.  To see the mount path, select **Go to resource** and look for it in the Overview tab.
    
    :::image type="content" source="../media/overview-mount-path-5e46b0e3.png" alt-text="Screenshot of the Overview screen with a red arrow pointing at the mount path.":::
    

## Configure FSLogix on session host Virtual Machines (VMs)

This section is based on [Create a profile container for a host pool using a file share](/azure/virtual-desktop/create-host-pools-user-profile).

1.  [Download the FSLogix agent .zip file](https://aka.ms/fslogix/download) while you're still remoted in the session host VM.
2.  Unzip the downloaded file.
3.  In the file, go to **x64** &gt; **Releases** and run **FSLogixAppsSetup.exe**. The installation menu will open.
4.  If you have a product key, enter it in the Product Key text box.
5.  Select the check box next to **I agree to the license terms and conditions**.
6.  Select **Install**.
7.  Navigate to **C:\\Program Files\\FSLogix\\Apps** to confirm the agent installed.
8.  From the Start menu, run **RegEdit** as administrator.
9.  Navigate to **Computer\\HKEY\_LOCAL\_MACHINE\\software\\FSLogix**.
10. Create a key named **Profiles**.
11. Create a value named **Enabled** with a **REG\_DWORD** type set to a data value of **1**.
12. Create a value named **VHDLocations** with a **Multi-String** type and set its data value to the URI for the Azure NetApp Files share.
13. Create a value named **DeleteLocalProfileWhenVHDShouldApply** with a DWORD value of 1 to avoid problems with existing local profiles before you sign in.
