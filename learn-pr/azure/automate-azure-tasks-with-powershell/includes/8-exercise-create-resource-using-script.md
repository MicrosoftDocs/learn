
In this exercise, you will continue with the example of  a company that makes Linux admin tools. Recall that you plan to use Linux VMs to let potential customers test your software. You have a resource group ready and now it is time to create the VMs.

Your company has paid for a booth at a big Linux trade show. You plan a demo area containing three terminals each connected to a separate Linux VM. At the end of each day, you want to delete the VMs and recreate them, so they start fresh every morning. Creating the VMs manually after work when you are tired would be error prone. You want to write a PowerShell script to automate the VM creation process.

## Write a Script that Creates Virtual Machines

Follow these steps to write the script:

1. Create a new text file named **ConferenceDailyReset.ps1**.

1. Capture the parameter in a variable:

    ```powershell
    param([string]$resourceGroup)
    ```

1. Authenticate with Azure using your credentials:

    ```powershell
    Connect-AzureRmAccount
    ```

1. Prompt for a username and password for the VM's admin account and capture the result in a variable:

    ```powershell
    $adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."
    ```

1. Create a loop that executes three times:

    ```powershell
    For ($i = 1; $i -le 3; $i++) {
    ```

1. Create a name for each VM and store it in a variable:

    ```powershell
    $vmName = "ConferenceDemo" + $i
    ```

1. Create a VM:

   ```powershell
   New-AzureRmVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Location "East US" 
   ```

1. Close the body of the loop:

    ```powershell
    }
    ```

1. Save the file.

The completed script should look like this:

    ```powershell
    param([string]$resourceGroup)

    $adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."

    Connect-AzureRmAccount

    For ($i = 1; $i -le 3; $i++)
    {
        $vmName = "ConferenceDemo" + $i

        New-AzureRmVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Location "East US" -Image UbuntuLTS
    }
    ```

## Execute the Script

Launch PowerShell and change to the directory where you saved the script file. To run the script, execute the following command:

    ```powershell
    .\ConferenceDailyReset.ps1 TrialsResourceGroup
    ```

The script may take a few minutes to complete. When it is finished, verify that it ran successfully:

1. In a browser, sign into the Azure portal.
1. In the navigation on the left, click **Resource Groups**.
1. In the list of resource groups, click **TrialsResourceGroup**. In the list of resources, you should see the newly created VMs and their associated resources.

## Summary
You wrote a script that automated the creation of three VMs in the resource group indicated by a script parameter. The script is short and simple but automates a process that would take a long time to complete manually with the portal.