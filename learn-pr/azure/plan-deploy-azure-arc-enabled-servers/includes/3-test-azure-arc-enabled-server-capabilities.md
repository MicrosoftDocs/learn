As you prepare to deploy across Wide World Importers' thousands of machines, you're first interested in testing Azure Arc-enabled servers and its capabilities. While you can't install Azure Arc-enabled servers on an Azure virtual machine (VM) for production scenarios, it's possible to configure Azure Arc-enabled servers to run on an Azure VM for evaluation and testing purposes only. In this unit, we showcase how Azure VMs can be used to test Azure Arc-enabled servers functionality.

## Hypothetical environment description

For this Windows exercise, use a dedicated, disposable x64 Azure-cloud VM running Windows Server 2022 or Windows Server 2025. Confirm that the selected release is listed in the current supported operating systems. Azure Arc-enabled servers also supports Linux distributions; the cross-platform evaluation guide provides separate Linux instructions.

Before changing the VM, confirm the following evaluation prerequisites:

- You can sign in to the VM with a local administrator account.
- You've been granted rights to manage and delete the test Azure VM and its native extensions, such as **Virtual Machine Contributor** at the appropriate scope. Confirm that you or an authorized administrator can also remove any other disposable resources created for this lab.
- You've been assigned **Azure Connected Machine Resource Administrator** at the lab resource-group scope to register, manage, and later remove the Arc resource and its extensions. The narrower **Azure Connected Machine Onboarding** role is appropriate for registration-only production automation, not the full lab and cleanup.
- The account generating the script has Reader-equivalent access to the target resource group so that it appears in the portal's selection list.
- The required resource providers `Microsoft.HybridCompute`, `Microsoft.GuestConfiguration`, and `Microsoft.HybridConnectivity` are registered in the subscription. Ask an appropriately authorized subscription administrator to register them if necessary. If you evaluate Azure Update Manager or automatic extension upgrades, also ensure `Microsoft.Compute` is registered. Register `Microsoft.AzureArcData` if you plan to Arc-enable SQL Server instances.
- The VM can download the agent and reach the current required Azure endpoints. Review the network requirements rather than assuming that access to a single service endpoint is sufficient.

Connect to the test VM using Remote Desktop and sign in with the local administrator account. Open 64-bit Windows PowerShell as administrator before changing services, firewall rules, or machine environment variables. Use this elevated session for the preparation and onboarding steps.

> [!NOTE]
> An operating system's security-update lifecycle and Azure Arc agent support are different. Windows Server 2012 and Windows Server 2012 R2 extended security updates (ESUs) ended on October 13, 2026. New Arc agent versions for those operating systems stop in November 2026, with the final compatible release serviced for 12 months after release. Use a current supported Windows Server release for this new lab.

## Prepare an Azure VM for Azure Arc-enabled servers

Because your Azure VM is already registered and managed as an Azure resource, it's necessary to reconfigure the VM for evaluation. Follow the Azure VM evaluation procedure to set the test override, remove native VM extensions, disable the Azure VM Guest Agent, and block native Instance Metadata Service (IMDS) access. These changes provide a test environment for Azure Arc-enabled servers; they don't make production Arc onboarding of Azure VMs supported.

> [!WARNING]
> Use a dedicated disposable test VM, not a VM hosting a workload you depend on. Removing native VM extensions, disabling the Azure VM Guest Agent, and blocking IMDS access stops native guest-management features that depend on those components, including access to the Azure VM's managed identity through IMDS. The Azure VM resource and the Arc machine resource remain separate resources. This exercise applies only to an Azure-cloud evaluation VM, not an Azure Local VM.

Prepare the test VM by completing the following steps:

1. In the elevated 64-bit Windows PowerShell session on the test VM, set the evaluation override:

    ```powershell
    [System.Environment]::SetEnvironmentVariable(
        "MSFT_ARC_TEST",
        "true",
        [System.EnvironmentVariableTarget]::Machine
    )
    $env:MSFT_ARC_TEST = "true"
    ```

    The first command persists the setting for the machine. The second makes it available to the current PowerShell process and its child processes. Set both before installing the Connected Machine agent. This override is only for evaluating Azure Arc on a dedicated Azure VM.

1. Remove any native VM extensions on the Azure VM.

    In the Azure portal, navigate to your Azure VM resource. Under **Settings** in the left-hand pane, select **Extensions + applications**.

    If any extensions are installed on the VM, select each extension individually and then select **Uninstall**.

    Wait for all extensions to finish uninstalling before proceeding to the next step.

1. In the elevated Windows PowerShell session on the test VM, disable and stop the Azure VM Guest Agent:

    ```powershell
    Set-Service WindowsAzureGuestAgent -StartupType Disabled -Verbose
    Stop-Service WindowsAzureGuestAgent -Force -Verbose
    ```

1. In the same elevated session, block access to both IMDS addresses documented in the evaluation guide:

    ```powershell
    New-NetFirewallRule -Name BlockAzureIMDS `
        -DisplayName "Block access to Azure IMDS" -Enabled True -Profile Any `
        -Direction Outbound -Action Block `
        -RemoteAddress 169.254.169.254,169.254.169.253
    ```

    The evaluation guide identifies `169.254.169.254` for Azure IMDS and `169.254.169.253` for Azure Local IMDS. Including both documented addresses doesn't change this exercise into an Azure Local deployment.

## Generate and run the onboarding script

Use the Azure portal onboarding workflow to generate a Windows script for the prepared test VM:

1. Sign in to the Azure portal, search for **Azure Arc**, and select **Azure Arc**.

1. In **Azure Arc**, expand **Infrastructure** and select **Machines**.

1. Select **Onboard/Create**, then **Onboard existing machines**.

1. On **Basics**, select the target **Subscription** and **Resource group**.

1. Select the **Region** for the Arc resource metadata and choose **Windows** for **Operating system**.

1. For **Connectivity method**, select **Public endpoint** for this public-connectivity lab. Configure a proxy only if your environment requires it and meets the documented network requirements.

1. Under **Authentication**, select **Authenticate machines manually**, then select **Next**.

1. On **Tags**, enter the tags required for the exercise and select **Next**.

1. On **Download and run script**, review the settings and select **Download**. Save `OnboardingScript.ps1` to a known location; don't assume the browser saves it in your PowerShell working directory.

1. Copy the script to a known location on the prepared test VM. In the elevated 64-bit Windows PowerShell session used for preparation, change to that directory and run the script once:

    ```powershell
    .\OnboardingScript.ps1
    ```

    Complete the requested Azure sign-in with the account authorized for the target scope. Run the script on the test VM, not the administrator's workstation.

The script installs the Connected Machine agent and registers the machine using the selected Azure settings. Complete the verification steps before enabling additional services.

## Verify the connection

Complete the following checks before evaluating additional services:

1. On the test VM, inspect the agent with `azcmagent show`:

    ```powershell
    & "$env:ProgramFiles\AzureConnectedMachineAgent\azcmagent.exe" show
    ```

    This status command doesn't itself require elevation.

1. Confirm that the agent reports a connected state and the intended subscription, resource group, and resource identity.

1. In the Azure portal, open **Azure Arc** > **Infrastructure** > **Machines**, locate that same machine in the intended subscription and resource group, and verify that its status is **Connected**.

If installation, sign-in, or registration failed, or either check doesn't show the expected connection, use the Azure Arc onboarding troubleshooting guidance before continuing. Successful script invocation alone isn't proof of registration.

After verifying the connection, evaluate the capabilities needed for Wide World Importers, such as Microsoft Defender for Cloud, Azure Monitor, Azure Policy, and supported VM extensions. Each optional service has its own operating-system support, prerequisites, configuration, and possible charges. Arc registration alone doesn't automatically enable these services.

## Clean up after evaluation

Keep the test resources only while you need them; the VM and optional services can incur charges. After all capability testing is complete, perform the following cleanup steps:

1. Remove any extensions installed through the Arc machine resource while the server is still connected.

1. In an elevated Windows PowerShell session on this Azure-cloud test VM, disconnect the Arc agent:

    ```powershell
    & "$env:ProgramFiles\AzureConnectedMachineAgent\azcmagent.exe" disconnect
    ```

1. Complete the requested sign-in with an Azure account authorized to delete the Arc machine resource, such as the scoped **Azure Connected Machine Resource Administrator** account used for the lab. Confirm that the Arc resource has been removed.

1. Uninstall the Azure Connected Machine Agent using the documented Windows uninstall procedure.

1. Delete the disposable Azure VM and any other resources created solely for this exercise when you no longer need them. Don't delete shared workspaces, networks, or resource groups.

Deleting the Azure VM or uninstalling the agent isn't a substitute for disconnecting and cleaning up its separate Arc resource. These cleanup steps apply to this Azure-cloud evaluation VM. Don't reuse the disconnect procedure for an Arc-enabled Azure Local VM without following that platform's specific removal guidance, as explained in the agent removal documentation.
