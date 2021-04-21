<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: none

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
TODO: add your topic sentences(s)

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
TODO: add your scenario sub-task

TODO: add your scenario image

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
TODO: describe the end-state

<!-- 4. Chunked steps -------------------------------------------------------------------------------------

    Goal: List the steps they'll do to complete the exercise.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading describing the goal of the chunk
        2. An introductory paragraph describing the goal of the chunk at a high level
        3. Numbered steps (target 7 steps or fewer in each chunk)

    Example:
        Heading:
            "Use a template for your Azure logic app"
        Introduction:
             "When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch."
        Steps:
             "1. In the left navigation bar, select Resource groups.
              2. Select the existing Resource group [sandbox resource group name].
              3. Select the ShoeTracker logic app.
              4. Scroll down to the Templates section and select Blank Logic App."
-->


## Create a resource group

Run the following command to create a resource group. Replace `EastUS` with the value of a location near you.

   ```powershell
    $resourceGroup = 'learn-firewall-rg'
    $location = 'EastUS'
    New-AzResourceGroup -Name $resourceGroup -Location $location
   ```

   This list shows some location values you can use:

   [!include[](../../../includes/azure-sandbox-regions-note.md)]

## Create a host pool for Windows Virtual Desktop

Run the following command to create a host pool.

   ```powershell
    $hostPoolName = 'learn-host-pool'
    $workspaceName = 'learn-workspace'
    $appGroupName = 'learn-app-group'

    New-AzWvdHostPool `
    -Name $hostPoolName `
    -ResourceGroupName $resourceGroup `
    -WorkspaceName $workspaceName `
    -HostPoolType Pooled `
    -LoadBalancerType BreadthFirst `
    -Location $location `
    -DesktopAppGroupName $appGroupName 
   ```

## Create a registration token for the host pool

Create a registration token to authorize a session host to join the host pool.

1. Run the following command to create a registration token that'll expire in 4 hours.

   ```powershell
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
    -Name 'learn-vm-session-host' `
    -Credential $cred `
    -ResourceGroupName $resourceGroup `
    -Size Standard_DS1_v2 `
    -VirtualNetworkName myVnet `
    -SubnetName mySubnet `
    -Image "MicrosoftWindowsDesktop:Windows-10:rs5-enterprise-standard:latest" 

    ```

   Wait a couple of minutes for the VM to be created.

## Connect to the VM by using a remote desktop session


1. Get the public IP address of the VM by running the following command.

    ```powershell
    Get-AzPublicIpAddress -ResourceGroupName "myResourceGroup" | Select "IpAddress"
    ```

1. Run the following command to create a remote desktop session from your local computer. Replace "publicIpAddress" with the public IP address of your VM.

    ```powershell
    mstsc /v:publicIpAddress
    ```

1. In the **Windows Security** window, select **More choices**, and then select **Use a different account**.
1. Type in the username and password you used when you created the VM. Type the username as **localhost**\\*username*.
1. You may receive a certificate warning during the sign-in process. Click **Yes** or **Continue** to create the connection

## Register the virtual machine with host pool

Install the Windows Virtual Desktop agents to register the VM to the host pool.

### Install the  Windows Virtual Desktop Agent

First, install the  Windows Virtual Desktop Agent. You'll need the registration token for the host pool to complete the installation.

1. Copy the link to the [Windows Virtual Desktop Agent](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv).
1. Paste the link into a web browser session in the VM.
1. Download and install the Windows Virtual Desktop Agent.
1. When the installer asks you for the registration token, paste in the value you got after you created the token.
1. If you no longer have the token value, rerun the following command in your Azure PowerShell session.

   ```powershell
    (Get-AzWvdRegistrationInfo `
    -ResourceGroupName $resourceGroup `
    -HostPoolName $hostPoolName).Token
   ```

1. Complete the installation.

### Install the  Windows Virtual Desktop Agent Bootloader

Next, install the  Windows Virtual Desktop Agent Bootloader. 

1. Copy the link to the [Windows Virtual Desktop Agent Bootloader](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrHand).
1. Paste the link into a web browser session in the VM.
1. Download and install the Windows Virtual Desktop Agent Bootloader.

## Check your work

At this point, the virtual machine should be registered as a session host for the host pool. To verify it's registered, let's sign into the portal and check status of the VM in the host pool.

1. Sign into the Azure portal using the same account you used to create the host pool and VM.
1. Search for or select **Windows Virtual Desktop**.
1. Select **Host pools** > **learn-host-pool**.
1. In the center pane, under **Virtual machines**, select **Total machines**.
1. For **learn-vm-session-host**, review the **Status**.
1. If you sucessfully registered the VM to the host pool, the **Status** value is **Available**.
<!--TODO add screenshot-->


