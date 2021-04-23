
TODO: add your topic sentences(s)


TODO: add your scenario sub-task

TODO: add your scenario image

In this unit, you create a host pool and  a VM that'll act as a session host. To avoid having to domain join the VM, you manually install the Windows Virtual Desktop agents to register the VM to the host pool. You'll then have a Windows Virtual Desktop deployment that you can use in the rest of the module exercises.

## Create a resource group

In Azure Cloud Shell, run the following command to create a resource group. Replace `EastUS` with the value of a location near you.

   ```powershell
    $resourceGroup = 'learn-firewall-rg'
    $location = 'EastUS'
    New-AzResourceGroup -Name $resourceGroup -Location $location
   ```

   This list shows some location values you can use:

   [!include[](../../../includes/azure-sandbox-regions-note.md)]

## Create a host pool for Windows Virtual Desktop

Let's go to the Azure portal to quickly create a host pool. 

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. Search for and select **Windows Virtual Desktop**.
1. Select **Create a host pool**.
1. Enter the following information into the **Basics** tab.

   |Field  |Value  |
   |---------|---------|
   |Subscription     |  Your subscription      |
   |Resource group     | learn-firewall-rg    |
   |Host pool name     |  learn-host-pool      |
   |Location    | Region near you       |
   |Host pool type     |  Pooled  |
   |Load balancing algorithm    | Breadth-first |
   |Max session limit    |2|
1. Select **Review + create** > **Create**.
<!-- These steps don't work without reinstalling Azure PowerShell module and resetting context so have to do this part in the portal.

Run the following command to create a host pool.

   ```powershell
    $hostPoolName = 'learn-host-pool'
    $workSpaceName = 'learn-workspace'
    $appGroupName = 'learn-app-group'

    New-AzWvdHostPool `
    -Name $hostPoolName `
    -ResourceGroupName $resourceGroup `
    -WorkspaceName $workSpaceName `
    -HostPoolType Pooled `
    -LoadBalancerType BreadthFirst `
    -Location $location `
    -DesktopAppGroupName $appGroupName 
   ```
-->
## Create a registration token for the host pool

Create a registration token to authorize a session host to join the host pool.

1. In Cloud Shell, run the following command to create a registration token that'll expire in 4 hours.

   ```powershell
    $hostPoolName = 'learn-host-pool' 
    New-AzWvdRegistrationInfo `
    -ResourceGroupName $resourceGroup `
    -HostPoolName $hostPoolName `
    -ExpirationTime $((get-date).ToUniversalTime().AddHours(4).ToString('yyyy-MM-ddTHH:mm:ss.fffffffZ'))
   ```

1. Run the following command to get the registration token.

   ```powershell
    (Get-AzWvdRegistrationInfo `
    -ResourceGroupName $resourceGroup `
    -HostPoolName $hostPoolName).token
   ```

1. Copy the token to a note app like Notepad.  

## Create a session host for the host pool

Create an Azure VM to act as a session host for the host pool.

1. Run the following command to set the user name and password for the administrator account on the VM. The password needs to be at least eight characters long and include a digit, an uppercase letter, a lowercase letter, and a special character. Write down the password because you'll need it later.

    ```powershell
    $cred = Get-Credential

    ```

1. Run the following command to create the VM using a Windows 10 image. (Check to see if host pool creates vNet & subnet)

    ```powershell
    New-Azvm `
    -Name 'learn-host-vm' `
    -Credential $cred `
    -ResourceGroupName $resourceGroup `
    -Size 'Standard_DS1_v2' `
    -VirtualNetworkName myVnet `
    -SubnetName mySubnet `
    -Image "MicrosoftWindowsDesktop:Windows-10:rs5-enterprise-standard:latest" 

    ```

   Wait a couple of minutes for the VM to be created.

## Connect to the VM by using a remote desktop session

<!--
1. Get the public IP address of the VM by running the following command.

    ```powershell
    Get-AzPublicIpAddress -ResourceGroupName $resourceGroup | Select "IpAddress"
    ```

1. Run the following command to create a remote desktop session from your local computer. Replace "publicIpAddress" with the public IP address of your VM.

    ```powershell
    mstsc /v:publicIpAddress
    ```
-->

1. In the Azure portal, search for and select **Virtual machines**.
1. Select **Connect** > **RDP**.
1. Select **Download RDP File**.
1. Open the RDP file from your browser.
1. Select **Connect**.
1. In the **Windows Security** window, select **More choices**, and then select **Use a different account**.
1. Enter the user name and the password you used when you created the VM, and then select **OK**.
1. If you're asked to connect despite certificate errors, select **Yes**.
1. In the **Windows Security** window, select **More choices**, and then select **Use a different account**.
1. Type in the username and password you used when you created the VM. Type the username as **localhost**\\*username*.
1. You may receive a certificate warning during the sign-in process. Click **Yes** or **Continue** to create the connection

## Register the virtual machine with host pool

Install the Windows Virtual Desktop agents to register the VM to the host pool.

### Install the  Windows Virtual Desktop Agent

First, install the  Windows Virtual Desktop Agent. You'll need the registration token for the host pool to complete the installation.

1. Copy the link to the [Windows Virtual Desktop Agent](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv).
1. Open a web browser session in the VM.
1. Paste the link into a web browser.
1. Select **Run** to install the Windows Virtual Desktop Agent.
1. When the installer asks you for the registration token, paste in the value you got after you created the token.
1. If you no longer have the token value, run the following command in your Azure PowerShell session.

   ```powershell
    (Get-AzWvdRegistrationInfo `
    -ResourceGroupName $resourceGroup `
    -HostPoolName $hostPoolName).Token
   ```

1. Complete the installation.

### Install the  Windows Virtual Desktop Agent Bootloader

Next, install the  Windows Virtual Desktop Agent Bootloader. 

1. Copy the link to the [Windows Virtual Desktop Agent Bootloader](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH).
1. Paste the link into a web browser session in the VM.
1. Select **Run** to install the Windows Virtual Desktop Agent Bootloader.
1. Complete the installation.

## Check your work

At this point, the virtual machine should be registered as a session host for the host pool. To verify it's registered, let's sign into the portal and check status of the VM in the host pool.

1. In the Azure portal, search for or select **Windows Virtual Desktop**.
1. Select **Host pools** > **learn-host-pool**.
1. In the center pane, under **Virtual machines**, select **Total machines**.
1. For **learn-vm-session-host**, review the **Status**.
1. If you successfully registered the VM to the host pool, the **Status** value is **Available**.
<!--TODO add screenshot-->


