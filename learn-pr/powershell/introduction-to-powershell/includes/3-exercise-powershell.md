In this unit, you use Azure Cloud Shell as a Linux terminal. You also can access Cloud Shell through the Azure portal or at [Cloud Shell sign-in](https://shell.azure.com). You don't need to install anything on your PC or laptop to use Cloud Shell. 

> [!NOTE]
> In this module, you're using the Azure Cloud Shell on the right-hand side of the screen, but in real-world situations, you can also use the integrated Terminal in Visual Studio Code by selecting **Terminal** > **New Terminal**, then selecting **Powershell** in the drop-down in the top-left of the Terminal window.

Before beginning this exercise, be sure to activate the sandbox.

1. Run the following command in Cloud Shell, and then press <kbd>Enter</kbd> to verify that your system is set up to use PowerShell. The `$PSVersionTable` verifies your installation.

   ```powershell
   $PSVersionTable
   ```

    Your output resembles the following table:

   ```output
    Name                           Value
    ----                           -----
    PSVersion                      7.3.6
    PSEdition                      Core
    GitCommitId                    7.3.6
    OS                             Linux 5.4.0-1058-azure #60~18.04.1-Ubuntu SMP Tue Aug 31 20:34:4…
    Platform                       Unix
    PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
    PSRemotingProtocolVersion      2.3
    SerializationVersion           1.1.0.1
    WSManStackVersion              3.0
   ```

   The output provides information about your PowerShell version, and your platform and edition.

   For information limited to your version of PowerShell, you can run a modified version of `$PSVersionTable`.

1. Run the following command in Cloud Shell, and then press <kbd>Enter</kbd>.

   ```powershell
   $PSVersionTable.PSVersion
   ```

    Your output now resembles the following table:

    ```output
    Major  Minor  Patch  PreReleaseLabel BuildLabel
    -----  -----  -----  --------------- ----------
    7      3      6  
    ```

    This output gives you more details about your version of PowerShell.

Running `$PSVersionTable` results in output that looks like a table, but is actually an object. For this reason, you can use a period (`.`) to access a specific property, such as `PSVersion`.
