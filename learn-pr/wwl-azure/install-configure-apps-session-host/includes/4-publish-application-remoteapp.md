You can customize the feed so the RemoteApp and remote desktop resources appear in a recognizable way for your users.

## Customize the display name for a RemoteApp or desktop

You can change the display name for a published RemoteApp or desktop to make it easier for users to identify what to connect to.

Here's how to customize the display name for a published RemoteApp or desktop using the Azure portal.

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  Search for **Azure Virtual Desktop**.
3.  Under Services, select **Azure Virtual Desktop**.
4.  On the Azure Virtual Desktop page, select **Application groups** on the left side of the screen, then select the name of the application group you want to edit.
5.  Select **Applications** in the menu on the left side of the screen.
6.  Select the application you want to update, then enter a new **Display name**.
7.  Select **Save**. The application you edited should now display the updated name. Users see the new name once their client refreshes.

## Set a friendly name for an individual session host in a personal host pool

For session hosts in a personal host pool, you can change the display name for a desktop for each individual session host by setting its friendly name using PowerShell. By default, the session host friendly name is empty, so all users only see the same desktop display name. There isn't currently a way to set the session host friendly name in the Azure portal.

1.  Launch the [Azure Cloud Shell](/azure/cloud-shell/overview) in the Azure portal with the *PowerShell* terminal type, or run PowerShell on your local device.
    
    
     -  If you're using Cloud Shell, make sure your [Azure context is set to the subscription you want to use](/powershell/azure/context-persistence).
     -  If you're using PowerShell locally, first [Sign in with Azure PowerShell](/powershell/azure/authenticate-azureps), then make sure your [Azure context is set to the subscription you want to use](/powershell/azure/context-persistence).
        
        Run the following command in PowerShell to add or change a session host's friendly name:
        
        ```powershell
        $parameters = @{
        HostPoolName = 'HostPoolName'
        Name = 'SessionHostName'
        ResourceGroupName = 'ResourceGroupName'
        FriendlyName = 'SessionHostFriendlyName'
        }
        
        Update-AzWvdSessionHost @parameters
        ```
        
        To get the session host friendly name, run the following command in PowerShell:
        
        ```powershell
        $sessionHostParams = @{
        HostPoolName = 'HostPoolName'
        Name = 'SessionHostName'
        ResourceGroupName = 'ResourceGroupName'
        }
        
        Get-AzWvdSessionHost @sessionHostParams | FL Name, AssignedUser, FriendlyName
        ```
